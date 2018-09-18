Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688EDECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10952146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrCNnLuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10952146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbeISA6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:58:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35234 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISA6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:58:54 -0400
Received: by mail-io1-f66.google.com with SMTP id w11-v6so2550107iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zerx1DhXH5VV8wl2RW7sSuDTHSwhq8vP1K50Cl3D5no=;
        b=YrCNnLufWhSE5pbt3kKRCalFVD+R/yoBi2ujFyOq4s73jEgYDOsemNCqaOMNRdjfj8
         WFhGxpNb92QnQfZA1Dj6ftibLn/Z7kv4Ct9zU3LQboUPHrH//+D/qkMK9iqunEhWYTd4
         W8E+p3jUOyiNh4EbF76ICciDSe3Mll7lNm1MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zerx1DhXH5VV8wl2RW7sSuDTHSwhq8vP1K50Cl3D5no=;
        b=nyjMv6N5yCla6mckrUQdyrcekOwn92ApfmsVbzRAzRqalynsFXXVHc0HNnSZucTp+N
         LEiOl8htBQs5v8OLx+J6an2EKpEPW+/RhswW5gbpKnlfscZSbArAs356gviMw/ZlxIat
         c7VUkBzP3Bt0SO2WkJbUxaOMIikPt6Ce3Dx0Fu3bV217cLPGeExxABbAM2GQXEZjxWNq
         AjG18ogGfyInEuZLUtozaKfmt4vACHbaSWhCt9IVSWn/8GhW/uRUiX6sexHSIsdyZjAD
         s9PG61oR9XRaZuYfdahjHZy4a54vCQeOUtB0fyMFYWbR8b2ziKZznRYNpjNXhMbtuC39
         sDZQ==
X-Gm-Message-State: APzg51DZJJTu+jGwGulnda94qMNshDj16JNUSScgobcSn0LdLJ2yUSyz
        eynJZpQe26UNtyrD2/hBfHDSTrZyvHus47qK7UrYiw==
X-Google-Smtp-Source: ANB0VdYogPkzWXxs1pB/qDGT6l+dvqZNMF6OuqeQsGtGYGB9ua18tQY5ATua3kHbXCfaJKWnX7s1LMheOekvL0KPNA4=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr25943729iof.304.1537298692533;
 Tue, 18 Sep 2018 12:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180831191326.25106-1-afd@ti.com>
In-Reply-To: <20180831191326.25106-1-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:24:38 -0700
Message-ID: <CACRpkdZCKPnr4d+2oDHc50U7Z=yw-m9R=X=973Rm+dkvwYrD6w@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpio: davinci: Remove unused member of davinci_gpio_controller
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:13 PM Andrew F. Davis <afd@ti.com> wrote:

> This was added as part of the patch in the fixes below, but was
> not needed or used, remove this here.
>
> Fixes: 8e11047b8f3c ("gpio: davinci: Add support for multiple GPIO controllers")
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Patch applied.

Yours,
Linus Walleij
