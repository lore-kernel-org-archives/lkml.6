Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4676BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120EB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcfmXQsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391139AbfAOWc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:32:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34144 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfAOWc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:32:27 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so3371511lfc.1;
        Tue, 15 Jan 2019 14:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MSL9XvRFCbIaYSh0EywSeV1qVzEujvVvIX8KXeRVyb8=;
        b=AcfmXQsGPRl7Nmy816Qvv7exM/tfqoxcp61AzhiSTucAtoxP3m2qKUgNNQmHYyME7Y
         gfp8pDptAR5APWAzoDDufQYCFDpxMHtjixWrihX98C3JTCS3m3+aU7wXevW6UH/5g8+j
         xitCw3MZfWzFxxaQB/hkdvYP8yvAYGXjUObqY9hp+qQ/3w7GJ2brjc2BOcfEsJdlbNci
         mEEWPkKks/RV4mE8X5jDwe/vyyYvBqg9297m4uNQnmyu5UvNJMIqxQJ/1Pvgr1j3C3hI
         VVk86zftHExFqab1NPmyWaBhy1w78U6/TT2P1tVS1OoPhgWmKU6zITp2FoByEvOoTq9E
         a+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MSL9XvRFCbIaYSh0EywSeV1qVzEujvVvIX8KXeRVyb8=;
        b=gZMFgljyGd0LX0Df5KPDOTYbna2zb5Ja8kmjGdDT2UrZ5+l3z5muj1VkUQu3a5IAiX
         tqdR9S+mau/vv28x5lL/Iq+82gBOJFiGfyYERAZ3JaJO1tINHvfJmMlgeHXtTa9o/Iy/
         J/Rgam7bxVpLng5NPqY7sywYVht3R2L+CYPC9c9eddU4LZARqrZOPKqAgJG0Y3A+XQWV
         fp1FGFG9Jjm72hh4p/zj8Vn3TH++mR0MT1Bh6MuEzErzKY9xLmXWax27/L/ApedY10ab
         4PiwXcL0qPDdGHBJ8AuFNZrRQO1R/qbykVCxsPqrCcCIWgLwQyeqTnJ1b5lmAvpQXvwv
         iDXQ==
X-Gm-Message-State: AJcUukduyLqRz8dbfvwnKuRuQe1AJgdv8NQOVDVV76zX0ZD0z/6lb5rF
        6GJWvvjSsuzitEkcRi2MS6IzMYyJDpzONIDA/EE=
X-Google-Smtp-Source: ALg8bN5VEVel/H0InG5QY/lVqrGD4DqH1BpBocPWR2aFiwAnjDeju+U/LBCoB5W/X1Keb1/SKfSUiAnYm9Ry+fyWRSQ=
X-Received: by 2002:a19:945b:: with SMTP id w88mr4207199lfd.15.1547591545209;
 Tue, 15 Jan 2019 14:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20181229183514.24644-1-deepa.kernel@gmail.com>
 <CAK8P3a1YG0+iMBiNy-g7KCusX3myV0tsuCEg1YLWW0cXrjk7PA@mail.gmail.com> <20190115.132928.900198180655535613.davem@davemloft.net>
In-Reply-To: <20190115.132928.900198180655535613.davem@davemloft.net>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 15 Jan 2019 14:32:13 -0800
Message-ID: <CAKdAkRQdO14OP7SgE=D4x5RG7=cjDoCAOmtnCcWw_DrToeEmhA@mail.gmail.com>
Subject: Re: [PATCH] input_event: Provide override for sparc64
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 1:29 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 15 Jan 2019 22:19:27 +0100
>
> > The correct check appears to be
> >
> > #if defined(__sparc__) && defined(__arch64__)
>
> That is correct.

OK. Deepa, could you please send me a fixup as I already pushed out
the original patch?

Thanks.

-- 
Dmitry
