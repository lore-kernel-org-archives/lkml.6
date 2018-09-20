Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714ACC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E72152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4Zi4P/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9E72152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbeITV0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:26:02 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51234 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732673AbeITV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:26:01 -0400
Received: by mail-it0-f67.google.com with SMTP id e14-v6so1990itf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a8bljSW7M6eWY2nh4ezNu6py5QBPu3Gm1QXMCi3xtYc=;
        b=Z4Zi4P/LYT7RFEpwdfQO6YIeTHi+01Cj7j+mT3YD46YeDNOWgVspWPlDtWgypvejvk
         mY/B9QTLrw5z1I9reCtBS0zlr6xINK7W0PRle86bJCVOZjY24OX5YILn716Sp9a4ZSj6
         O/bfOHYn1DWRAvjne5/hPw0UoPeHBy1oYHgik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a8bljSW7M6eWY2nh4ezNu6py5QBPu3Gm1QXMCi3xtYc=;
        b=Mm09gkr7zovPe4ecRr4K5jZFzelG9KYcS2R4NHy1b1aDR2nYbgChSK4RskZXOMVbZB
         v3ApWIKZ5KX7qYjLxrsSsnXTcVhq7/lgQS0B0H5JesT1RXJRms6/NOWFucBVCkj1/1+7
         6PaBunEqtZopwON0hsMoVF5Q5FpF6xy5WihjK3W8NRO5EZAocPholeLMX4buJz6hF0rZ
         2MPBCzHNR798ggfxphSMNeAJShlXuw3vSZxScnfZaUNF3m757DKzNmM/ls+PtyVI/Tmc
         3fdEUid6CINJi+Z1VcEsIs7GbzNmTMxdJJ1wHBVJyB9f17yvG+NXZJhYNxqzRq+exj0+
         8JCQ==
X-Gm-Message-State: APzg51BK8KR2bdNgVaHnII/bneBlphjlRNjo6KFnCXfqsEK4yduP60en
        ezvNVQEtlbwpoZVI6TTKUja64Z5Ywz4/pb710TsmEw==
X-Google-Smtp-Source: ANB0VdY2xQNJ75qr8LS5tZfRPogeAhSJlSefAnm2qEJp2zknwwu0Vlsx8z7BILy+8+SoXLJziykF0jugpBfj+R9BU2g=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2546049ite.123.1537458117564;
 Thu, 20 Sep 2018 08:41:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 08:41:57
 -0700 (PDT)
In-Reply-To: <20180918161646.19105-3-Jason@zx2c4.com>
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 20 Sep 2018 08:41:57 -0700
Message-ID: <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Arnd, Eric)

On 18 September 2018 at 09:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
...

> diff --git a/lib/zinc/Makefile b/lib/zinc/Makefile
> new file mode 100644
> index 000000000000..83dfd63988c0
> --- /dev/null
> +++ b/lib/zinc/Makefile
> @@ -0,0 +1,4 @@

Apologies for not spotting these before:

> +ccflags-y := -O3

-O3 optimization has been problematic in the past, at least on x86 but
I think on other architectures as well. Please stick with -O2.

> +ccflags-y += -Wframe-larger-than=$(if (CONFIG_KASAN),16384,8192)

There is no way we can support code in the kernel with that kind of
stack space requirements. I will let Arnd comment on what we typically
allow, since he deals with such issues on a regular basis.

> +ccflags-y += -D'pr_fmt(fmt)="zinc: " fmt'
> +ccflags-$(CONFIG_ZINC_DEBUG) += -DDEBUG
> --
> 2.19.0
>
