Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97287C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C0A208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jWVi/olm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C0A208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeH0Xij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:38:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43130 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeH0Xih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:38:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so52390plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YTTmwKLGeR4XonCav68BtUxFcLBZiwhISDalkn2irs4=;
        b=jWVi/olmzo98/rW+l+fvlskDpT60QRfE/oFfiVcSNS3fGr6I/65wHNBnagCuoP1YWn
         IEoMGh5FFsO55CYkpvz+8AEnCSNMvEtzMy1gL67oVOh9Bm71QD1GqwytKkQDKs7oDBCc
         UfILxv9+Q1SXuHNbqKdJJiYoUsMvSzfuYKFGea5+b3x+y2DKfuTsoLxz6bOaFUvEY45k
         CDQLnzweX6Riw1gunEsUJUqmFk63zoMN5ZyDqWe7a+4LLC0MtWeGiRro6WPUqEVCZziU
         fkKKOy/p2/RNqzwMa2Q31ELG9yD/T1bzd0nb79O6DUHtyEdaB+ce+Hfa6wy78NDQ62rO
         VErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YTTmwKLGeR4XonCav68BtUxFcLBZiwhISDalkn2irs4=;
        b=sFcAZdzwRn1BEk6IKqS8EdIf5PoixtGScaYSgEU+gOniBSsTY1PLH5jzTbQBjmEK/J
         ZCDLg5jC+C2r1lUngT5jRvTbyM9uXfnzdVFWyME0n6k/Fju9nZh0xX9sX7cw5ERAbp2v
         Z92/0Yi7i+upluXhWZcGoR9FyRab99W50vHiuJg5zFfMNqZDyLmC3O2sZT5QrXOoV0BB
         YN3uhS6kbdZRhsm3rV5cSOO/nidSmwfopM9UJJRlr2siUK0OzcjciwIyg2BAeROa7QrR
         b7pL5gsubp7kPJplX3mPqWh/mpalK/gD9WGg4C0OhWzSSQdRrfzjtU30czrKK5J8HuCj
         ASvg==
X-Gm-Message-State: APzg51AMktTic9xw087vxEGGddQqaenU2pcK+ugBkGaZKxG8Xm/nsj0H
        mKp4yjt8EFuNaCAe1FxzoEvHIDcxRy4=
X-Google-Smtp-Source: ANB0VdarmudXOh6lAkGLYQAzK0lf2o3z1LP8TUHEvibQqq5jR5wzXxAdUlXJIoR3KTYtqlbdYim1Uw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr14436645pln.261.1535399435311;
        Mon, 27 Aug 2018 12:50:35 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 3-v6sm166133pfq.10.2018.08.27.12.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:50:34 -0700 (PDT)
Date:   Mon, 27 Aug 2018 12:50:34 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 12:49:01 PDT (-0700)
Subject:     Re: [PATCH v2 01/17] asm: simd context helper API
In-Reply-To: <20180824213849.23647-2-Jason@zx2c4.com>
CC:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Jason@zx2c4.com, luto@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, sneves@dei.uc.pt,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Jason@zx2c4.com
Message-ID: <mhng-7989f094-cc42-4d36-9db5-a6e6a7747048@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 14:38:33 PDT (-0700), Jason@zx2c4.com wrote:
> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
> FPU/SIMD functions over a number of calls, because FPU restoration is
> quite expensive. This adds a simple header for carrying out this pattern:
>
>     simd_context_t simd_context = simd_get();
>     while ((item = get_item_from_queue()) != NULL) {
>         encrypt_item(item, simd_context);
>         simd_context = simd_relax(simd_context);
>     }
>     simd_put(simd_context);
>
> The relaxation step ensures that we don't trample over preemption, and
> the get/put API should be a familiar paradigm in the kernel.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Samuel Neves <sneves@dei.uc.pt>
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/alpha/include/asm/Kbuild      |  5 ++--
>  arch/arc/include/asm/Kbuild        |  1 +
>  arch/arm/include/asm/simd.h        | 42 ++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/simd.h      | 37 +++++++++++++++++++++-----
>  arch/c6x/include/asm/Kbuild        |  3 ++-
>  arch/h8300/include/asm/Kbuild      |  3 ++-
>  arch/hexagon/include/asm/Kbuild    |  1 +
>  arch/ia64/include/asm/Kbuild       |  1 +
>  arch/m68k/include/asm/Kbuild       |  1 +
>  arch/microblaze/include/asm/Kbuild |  1 +
>  arch/mips/include/asm/Kbuild       |  1 +
>  arch/nds32/include/asm/Kbuild      |  7 ++---
>  arch/nios2/include/asm/Kbuild      |  1 +
>  arch/openrisc/include/asm/Kbuild   |  7 ++---
>  arch/parisc/include/asm/Kbuild     |  1 +
>  arch/powerpc/include/asm/Kbuild    |  3 ++-
>  arch/riscv/include/asm/Kbuild      |  3 ++-
>  arch/s390/include/asm/Kbuild       |  3 ++-
>  arch/sh/include/asm/Kbuild         |  1 +
>  arch/sparc/include/asm/Kbuild      |  1 +
>  arch/um/include/asm/Kbuild         |  3 ++-
>  arch/unicore32/include/asm/Kbuild  |  1 +
>  arch/x86/include/asm/simd.h        | 30 ++++++++++++++++++++-
>  arch/xtensa/include/asm/Kbuild     |  1 +
>  include/asm-generic/simd.h         | 15 +++++++++++
>  include/linux/simd.h               | 28 ++++++++++++++++++++
>  26 files changed, 180 insertions(+), 21 deletions(-)
>  create mode 100644 arch/arm/include/asm/simd.h
>  create mode 100644 include/linux/simd.h

...

> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 576ffdca06ba..8d3e7aef3234 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -4,9 +4,9 @@ generic-y += checksum.h
>  generic-y += cputime.h
>  generic-y += device.h
>  generic-y += div64.h
> -generic-y += dma.h
>  generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
> +generic-y += dma.h
>  generic-y += emergency-restart.h
>  generic-y += errno.h
>  generic-y += exec.h

If this is the canonical ordering and doing so makes your life easier then I'm 
OK taking this as a separate patch into the RISC-V tree, but if not then feel 
free to roll something like this up into your next patch set.

> @@ -45,6 +45,7 @@ generic-y += setup.h
>  generic-y += shmbuf.h
>  generic-y += shmparam.h
>  generic-y += signal.h
> +generic-y += simd.h
>  generic-y += socket.h
>  generic-y += sockios.h
>  generic-y += stat.h

Either way, this looks fine for as far as the RISC-V stuff goes as it's pretty 
much a NOP.  As long as it stays a NOP then feel free to add a 

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

as far as the RISC-V parts are conceded.  It looks like there's a lot of other 
issues, though, so it's not much of a review :)
