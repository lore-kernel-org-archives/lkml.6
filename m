Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA9920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcOpq+zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA9920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeLEIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:06:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEIGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:06:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so18617831wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 00:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a6VDonw4av4hjUtnSBSuhI19+KE7SKuGQ2Y5YPedPEY=;
        b=gcOpq+zvoZWrh6ylR6Wl0B8LS0grXz7X/VR2LiwvI/6syP8QQCqIx8BqU6eQ9FMExb
         Y4YzSoVcur9GwmiVDCaJdbQFlO8c3TBlukHTWOXx0CJXJ4NfZu4eXU3Iky1dDQruGUYT
         WGXBdQY2Zmy7Pra/Y58jH4NfAmbFspJK9I7kixHgHyFQJVtTNy4J1ClMtripPUC//Haq
         IGq2HZhd6U4V80PQJA4cvjHnjmoMiQLPiKf4rACSYkDnNrCNMMYTUp2thHs/g7C5pTgy
         UO0AoqAHk9z005MQpz+prY3mG2T5lPQIM/5uZmtnDyo5j9tKJjbJeosPqJQBFOOGTAYm
         oavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6VDonw4av4hjUtnSBSuhI19+KE7SKuGQ2Y5YPedPEY=;
        b=Z7pamanSdEo57scy63gtKfjeD2wHk1Q0C574ZJI+EznKMbc6Vh1w+z9/J6HThorTvr
         e0ZRMfRegSF4IPVnYBnreMV5d04ZTM2TVzel6OPxxsdHKxwHn1b7CfclD++ibr2TFHVY
         b4ycFUc48tVjoimkF79HxfB/j5icZrUbqDoFiE5yfCpiS5XsAPH7Nodkdm64zFOt5xkw
         xlK/aW2+4fPHYN+o8pC9ijqgvEg8AItHlTN+S93FDZI95bjBm7TYdKePrH0PabX3by+5
         DrsvQL7BjEZ8Fs/2IfVMv/tzJAlDTDcq9i0fHhwbHDDnMWoiHsE28zdJ1LLXWBWd9G8k
         w9Mg==
X-Gm-Message-State: AA+aEWY6aOfjIQ+TAaUB9ZKAGovAST2txUAr/zysSQYko11wkW9MpK+x
        8ld5xRYVedasXHQIMQYnmCE=
X-Google-Smtp-Source: AFSGD/XHlADWM+krT9wUpaP6H69TrePZsTw12eQEeDomFxRu8PTo8M1udxGQiwSlWz0+Z2QwfijdOA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr19415285wre.94.1543997207251;
        Wed, 05 Dec 2018 00:06:47 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k15sm13371734wru.8.2018.12.05.00.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 00:06:46 -0800 (PST)
Date:   Wed, 5 Dec 2018 01:06:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
Message-ID: <20181205080645.GA11936@flashbox>
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> >
> > This flag is not supported by lld:
> >
> >     ld.lld: error: unknown argument: --pic-veneer
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Hi Nate,
> 
> Does this mean ld.lld is guaranteed to produce position independent
> veneers if you build kernels that are bigger than the typical range of
> a relative branch?
> 

Hi Ard,

Honestly, I'm not quite sure. I saw your commit that introduced this
flag and I wasn't quite sure what to make of it for lld. What
configuration would I use to verify and what would I check for?

Additionally, I have filed an LLVM bug for the lld developers to
check and see if this is a flag they should support:

https://bugs.llvm.org/show_bug.cgi?id=39886

Thanks for the quick reply,
Nathan

> > ---
> >  arch/arm/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index e2a0baf36766..4fab2aa29570 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -10,7 +10,7 @@
> >  #
> >  # Copyright (C) 1995-2001 by Russell King
> >
> > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> >  LDFLAGS_vmlinux        += --be8
> >  KBUILD_LDFLAGS_MODULE  += --be8
> > --
> > 2.20.0.rc1
> >
