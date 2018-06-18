Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D8F20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D8F20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966087AbeFRJ2s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:28:48 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36343 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935941AbeFRJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:28:45 -0400
Received: by mail-ua0-f195.google.com with SMTP id c23-v6so10239361uan.3;
        Mon, 18 Jun 2018 02:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SosZ0YsLsULH5E4e9xd0UrKl0hgJTpXULyo0IONNOkc=;
        b=SlAiyjZib/H0GyBKksVtfqwHnNVxDJiaVYoMZDPeKh233dt2/opyRKN8aKyx7gPmhd
         sWeGLXqDAT/XBrjkgPhu/cE00ssBuzh3joSF2ylUzy2iyxrTZrk/QsTlZZK6AQeEpSeC
         HYDa+emJPCopUcA740cb+w/GTwRM3t410GzstaBCeENVMPbM2faX/iVV0kdjeEMixUiT
         TiXuqHpLX1XmNrrzKE+xBHIlDuex0t76Q8aaZl7FCWxK8xu23haaH8d3O9Ud/KG398xp
         9A8BL7f/RSLfas9AFxNIEgki3SkemDUMxb2VMZNuqUHrZaJhzJs0MsZy1dGlYeEYQsI9
         +0cg==
X-Gm-Message-State: APt69E2Viu6Kua7ZEfHyjs5D4QCYyHAgkRpUZmGAPPYe11Y6x/L+SdYt
        W5i43+2Y+g3IYUfDBpa621Tqo9k1ZDSNTATvZ4YZog==
X-Google-Smtp-Source: ADUXVKL0WXPSR4IcUugCMsp58d4eyGzYHedZjIpWbcZqvLbc+xGbNj8smVSZlY69MLA+Hp3UA6pYu7Hu1VbXa2k8yZs=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr7783867uaa.33.1529314123676;
 Mon, 18 Jun 2018 02:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180618091729.11091-1-geert@linux-m68k.org>
In-Reply-To: <20180618091729.11091-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jun 2018 11:28:32 +0200
Message-ID: <CAMuHMdULmiArTvYsEqnyg5SB6PqjZnNANLAyYcqqYeYmHKJ5Dw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.18-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:18 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.18-rc1[1] compared to v4.17[2].
>
> Summarized:
>   - build errors: +11/-1

> [1] http://kisskb.ellerman.id.au/kisskb/head/ce397d215ccd07b8ae3f71db689aedb85d56ab40/ (233 out of 244 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/29dcea88779c856c7dc92040a0c01233263101d4/ (all 244 configs)

> 11 error regressions:
>   + /kisskb/src/drivers/ata/pata_ali.c: error: implicit declaration of function 'pci_domain_nr' [-Werror=implicit-function-declaration]:  => 469:38

sparc64/sparc-allmodconfig

>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid':  => 1413:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_nopanic':  => 1377:15
>   + /kisskb/src/mm/memblock.c: error: redefinition of 'memblock_virt_alloc_try_nid_raw':  => 1340:15

ia64/ia64-defconfig
mips/bigsur_defconfig
mips/cavium_octeon_defconfig
mips/ip22_defconfig
mips/ip27_defconfig
mips/ip32_defconfig
mips/malta_defconfig
mips/mips-allmodconfig
mips/mips-allnoconfig
mips/mips-defconfig
mipsel/mips-allmodconfig
mipsel/mips-allnoconfig
mipsel/mips-defconfig

>   + error: ".radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: ".radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: ".radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__flush_pwc_lpid" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__flush_tlb_lpid_page" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A
>   + error: "radix__local_flush_tlb_lpid_guest" [arch/powerpc/kvm/kvm-hv.ko] undefined!:  => N/A

powerpc/ppc64_defconfig+NO_RADIX
ppc64le/powernv_defconfig+NO_RADIX (what's in a name ;-)

>   + {standard input}: Error: offset to unaligned destination:  => 2268, 2316, 1691, 1362, 1455, 1598, 2502, 1645, 1988, 1927, 1409, 2615, 1548, 2409, 1268, 2363, 1314, 1208, 1785, 2034, 2222, 2661, 1880, 2552, 1161, 2082, 1833, 2455, 2176, 2129, 1501, 1738

sh4/sh-randconfig (doesn't seem to be a new issue, seen before on v4.12-rc3)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
