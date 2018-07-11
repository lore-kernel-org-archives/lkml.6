Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3AEC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F620875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+dZ6YOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388637AbeGKObK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:31:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33523 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388121AbeGKObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:31:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id t21-v6so19546832lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WnVuEeNFIX1rmZRQG2ESbrdp54U0BvrkhXRpC5K7bXo=;
        b=M+dZ6YOJYSymvNzS9QRDEdYQEqcRfTYEsVmh8t1+QsIYPBRtDawG9eqzUVdg/4xYxD
         SIbIwl/dOCZMPNeyHpCfPGWaC2Lq0Sh82UQFPQLL5qw10QtDkZv47AWlX2ZCIr6MfqN1
         mpB+1YyHTsB5nkqTmesyg/TVSoKNg+AfbmX9TyNIWn8M7D+rbCiQ6Q2upFBgMk7G5qv0
         a29nv0fyCdmiKdMtmDOir0RvRHMqzIcWqkMvAiBFD8CLX2UDjJUUGUqd/dLE63NB2bxC
         hcG/whDPBab2ZnIZXodmkOeSdQ83d1yHFRlAyDl6wzUHUqYlMaPaaVA+o5TsbmLQ4zZv
         EvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WnVuEeNFIX1rmZRQG2ESbrdp54U0BvrkhXRpC5K7bXo=;
        b=iOQSpJKr3HcHoW8z49MyxzO7gtzkHKPVYY6CrqK6vDI1uOgExQg/SCIdJO4HSPkFzn
         Er69Ik4Eh+Ib44Do1RbchskD6F6oZEPYEr015h6L8k08e4EkAU8QOMw0CkRpi4LaghRI
         VZOuNDyZj81F5MtB5DK53gdYOJZbzpPE/GWdRby3r82OFlwIyjIDXtxP5w6QBZSZ4gI+
         og94SSFJJvAE1KFYIN6euZhskbfS/LRlvrSFHpv06JNebVDCnZ5IHBCR1Q390KycCZpm
         RAwNAnB9Rrhip+cR/ADLSo3TZCn4CeKpx+nXw4rv+ixN/zvt/ujD2q9fpXdsVxlvPVF5
         ufzw==
X-Gm-Message-State: APt69E0X5+oZdjoyqMBYY8Z8ecVRdCJhdR2gWojWWQ4qg7j3gahKp3uK
        LT1EKJCoMpK8iKiiZbjEZZTQ+VZECthhu2vHoM4=
X-Google-Smtp-Source: AAOMgpehT3wDwU/mcoHx8t7BvBkYCrJ5GCjC/74NiL7AxlAYinqzV5cctWz3Soxs8XRtxVFTpy5p82W2QQ0x8Y/obf0=
X-Received: by 2002:a2e:5bc8:: with SMTP id m69-v6mr19101091lje.115.1531319192523;
 Wed, 11 Jul 2018 07:26:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 07:26:31
 -0700 (PDT)
In-Reply-To: <20180711150449.4152333c@bbrezillon>
References: <20180711122709.358159-1-arnd@arndb.de> <20180711150449.4152333c@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 16:26:31 +0200
X-Google-Sender-Auth: cL03MWSZqc-jq7BYe_pguMFtjF8
Message-ID: <CAK8P3a1M4v1hMduAX3y39DEjBiT=70xm-+qJ8CPLZHQwKOzJ1g@mail.gmail.com>
Subject: Re: [PATCH] nand: ranw: qcom_nand: stop using phys_to_dma()
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 3:04 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Wed, 11 Jul 2018 14:26:58 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Compile-testing this driver on x86 caused a link error:
>>
>> ERROR: "__phys_to_dma" [drivers/mtd/nand/raw/qcom_nandc.ko] undefined!
>>
>> The problem here is that the driver attempts to convert the physical
>> address into the DMA controller as a dma_addr_t and calls phys_to_dma()
>> to do the conversion.
>>
>> However, there is no generic way to convert a phys_addr_t into a dma_addr_t
>> for anything other than RAM (which should use the dma-mapping API instead).
>> The only correct use of phys_to_dma() instead is inside of the dma-mapping
>> implementation.
>
> Should we use dma_map_resource() to do the phys_addr_t to dma_addr_t
> conversion?

I had not seen that interface before, but yes, that does seem like the best
way to do it here.

       Arnd
