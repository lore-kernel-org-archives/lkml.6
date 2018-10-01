Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4436208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPN59a0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4436208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbeJBAt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:49:28 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55894 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:49:28 -0400
Received: by mail-it1-f195.google.com with SMTP id c23-v6so12623947itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QELbuZHYnQhQQpEc9T+Te+KfwjDxdQ+mpo96DKxuvEs=;
        b=bPN59a0ntUXJ/1qKuGETU/cce7SLmNp++sCQyALxcr1eXTT2OOa2P5l4Kd7tBx4gg3
         w762D5p3XcfzMK829hRNGebvNrBA69cQ+1uo4s2PawhOtaKOWYOrlqpNVv1HfUYaCklE
         nJf6mapMOVSE7C+1g7LqsKkQqrvwRFMxhhQoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QELbuZHYnQhQQpEc9T+Te+KfwjDxdQ+mpo96DKxuvEs=;
        b=hlbiphpg8G8niMMk3ahZkMGIVwnt+U743vUvCNYo9NvccmV10w4v81rKgHj97YW4Lb
         gCXt/hm+jc+6icpWPAb0IfmvFI8Kbl7JrWop0Dwy3BmptH2l2JMbJq9Ye743L6KYvLCT
         GaUFIGswYyh7SzEzWioiZJRmvP4N9m/biN7xH1AUzU6DWVLKr5p/jZ/U+GQTJsCxv9KE
         YY9Aq+lCHkAgYafYmp6rt2lmIh6B75Ke+ynSHzgI43xlYr0PDtHIUff4rXsySqFM6QLw
         FINcZfIess07UslYf+9XAfDVCFawDCimkmr7gj2s/wlGnE//rjUYfgme9Y719S2MzaSH
         UjRw==
X-Gm-Message-State: ABuFfohd0w7jtTCicKIpi5heSQjFdr6gXYBmK0de6WY+rqnkcrQcaHd/
        xr9bcMDBL0USBkAqw7X/0IyYiWiJitalgCZksRAnTw==
X-Google-Smtp-Source: ACcGV608vTZo7NfB9SbkuIuykmrJecW+pe5oA0eX6hSDP12CwrrFyWic2R7mREQulb4JV6gg7F5Diymy9tWdm1SfgaA=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr7190820itc.123.1538417427684;
 Mon, 01 Oct 2018 11:10:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:d907:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 11:10:26 -0700 (PDT)
In-Reply-To: <20181001175622.GT30658@n2100.armlinux.org.uk>
References: <20180930024904.14240-1-Jason@zx2c4.com> <20181001175622.GT30658@n2100.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 1 Oct 2018 20:10:26 +0200
Message-ID: <CAKv+Gu9Z5AnT07_N0MCBMNKO7fd_42DS0qFGP-gubD9DxLiYDA@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 19:56, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Sun, Sep 30, 2018 at 04:49:04AM +0200, Jason A. Donenfeld wrote:
>> Per the discussion about half-way down in [1], the kernel doesn't
>> actually support the ARMv3 ISA, but selects it for some ARMv4 ISA
>> hardware that benefits from ARMv3 code generation.
>
> The issue is to do with the half-word stores in the ARMv4 ISA, which
> need to be avoided on StrongARM RiscPC - the bus from the processor
> card (which was designed for ARM610 and ARM710) does not support
> anything except 8-bit and 32-bit accesses, so the 16-bit load/store
> instructions don't work correctly.
>
> Obviously, the reason for having the compiler use ARMv3 is to avoid
> those instructions which we have no other way to prevent - however,
> the use of ARMv3 with the assembler ensures that ldrh/strh are not
> accidentally used.
>
> We could argue that the ARMv3 assembly files are now stable, so the
> chances of ldrh/strh being introduced is low, which would make this
> change tolerable, but the commit message needs to spell out that
> we lose this protection.
>
>> Such a consideration,
>> then, only applies to the compiler but not to the assembler. This commit
>> passes -march=armv4 to the assembler in those cases, so that code
>> written for ARMv4 will continue to compile and run fine, without needing
>> module-specific asflags-y overrides.
>
> Note that "code written for ARMv4" will not be usable on this platform
> if it makes use of ldrh/strh, so depending on which instructions the
> assembler is complaining about, it could very well be a real "you're
> doing something wrong" case.
>
> The side effect of this patch is that such cases will now be hidden
> rather than evaluated on a case-by-case basis.
>

Thanks for the insight.

So Arnd's suggestion to switch to armv3-m would actually be feasible
then? The code in question does not use ldrh only umull, and so it
should build with armv3m as well. And we will even generate some
better code for RiscPC if we apply it to both the cflags and the
asflags.
