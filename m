Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFA1C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71DB20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFxE2G7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71DB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbeLGQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:58:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36374 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:58:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so4473313wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LG+xdE8cAyZIMnsWAyv9dzMqDLVlxJCaMghhmOwkSZc=;
        b=BFxE2G7PbWDGYTa53Q3MxaSGZTN8dt6QiyPsYIWPmRN/miQzyKNossGcJq/RNtx9M3
         a+e8c4YnLrL8HkMYBCE37mUsw9dmUYWdr8y7XVBZqG1PtAvbYvkTqrUqJwAgiI5oLx6N
         JUyV89H2QpzyYcrcc7x+ajsxxmwpW4WJATLfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LG+xdE8cAyZIMnsWAyv9dzMqDLVlxJCaMghhmOwkSZc=;
        b=nWZw9TYc6qyciV8Uiq15niVJRX+wpc8fnfgwhEsR+9nHKRLeGaUbkGvORAp9AG3SdP
         Z+J3cajhqicZTLIMoKy0j5FlPxyRiQpgJPLQ4udzAfO/kim9NJWmZb0QOrp86X/ea3ti
         1QTmi85nsft2z4DrcM7T8smugN4ejUcn5Z2Fp7x17HhN7Vio+V4/NyJS5XUoH7HMTidx
         x3xutZz5/CAWxog9rOZSdl8iuhl/ZVarp6HdNGa+8Zzwfsy4gWvWrgLD1TR56nVyGT4k
         KZJ1WGnrP5jbqzej4hsi7ED8noPrOq9/Vmmivm9swgnUS60sIaqFpwgE+rSu1f4TfRnK
         eAsA==
X-Gm-Message-State: AA+aEWbVDBBVel4w4UeqIiJa8OunSqCrzPJ+c2QVNp+SCmq1rdyYDoNx
        2mczZhlY3yUcnCEbRALCZGKoe267XUJYkYRtF6NwA6ve
X-Google-Smtp-Source: AFSGD/X6xycuka6NIiecsuapaFftb1weC2gn4SKj58KqhfzROLBA6dlnQ7fPNWUoJg4C1tqJ8k0rp9jrse8fWe8j5JA=
X-Received: by 2002:a5d:6988:: with SMTP id g8mr2358486wru.33.1544201908016;
 Fri, 07 Dec 2018 08:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-9-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-9-arnd@arndb.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 7 Dec 2018 08:58:14 -0800
Message-ID: <CALAqxLVwaY2yQ5cP2qBVVyWB8pyD8BNoSEe-Lra2LPPi3CjO-w@mail.gmail.com>
Subject: Re: [PATCH 8/8] timekeeping: remove obsolete time accessors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> There are no more remaining users of these deprecated wrappers, so
> let's remove them before new users have a chance to make it in.
>
> See Documentation/core-api/timekeeping.rst for replacements when
> porting old drivers that contain calls to this function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/timekeeping.h   | 14 --------------
>  include/linux/timekeeping32.h |  9 ---------
>  2 files changed, 23 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>
