Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F422CC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFB8222AE
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NMb79ZOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfAFB5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 20:57:45 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:18030 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAFB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 20:57:44 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x061vWLd016462;
        Sun, 6 Jan 2019 10:57:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x061vWLd016462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546739853;
        bh=Ci+cXksoanD9GGaO2bNjRFHAELAMOrzQailOkPVHQYE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NMb79ZOQRE/ukbnmEjDrJGA5tvivz2hGgHOaTgGfdgMT52BZ6MlaAr9OOu6gp/trS
         WRvlISuskTt/C9w/iDminFk/VmuJ9K+4j7Xp/WpUFRpd9QfK1vzbMR5QAeZcE/reH/
         JKKT7xjyR2AjKkSxK7daBO5QkIdGziiuUIo+2zrcX7Pu/9ITZX4x4iiWvBJBp/ogV6
         8/ZxSB0AwO1YKYucspCQrCKcY1jBhBoaL1g5l7VH3ibFUGPMPch9IcmjPm97i9eEma
         aL5xyOpb5aKSxeaSWgIpHUpNGrB3jfSmAjh4fdN0Wp8MEDNtY9uvQkqSkHTti5ld5z
         I9NT5bgUv2GDw==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id n7so13162661uao.7;
        Sat, 05 Jan 2019 17:57:32 -0800 (PST)
X-Gm-Message-State: AJcUukc+N4MuEvi3ULeenybOwVhVTO8lk/f09zO4uX+O0dFfTCKh/czt
        Xo6SDDMHybH0bOW+AY1Fo/Qc1bVGNA2w0+Vu8tI=
X-Google-Smtp-Source: ALg8bN6cT+r8bP+L/JY/qMkSv+NJJcFADhHCF/8lIgeiq0xHTMpVWWCrVYA9xZ/dikGtlkLGbnhtFyZaG0ON7Y1HgiA=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr20163513uaj.42.1546739851430;
 Sat, 05 Jan 2019 17:57:31 -0800 (PST)
MIME-Version: 1.0
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Jan 2019 10:56:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNATS79a=vBdjvy18oE4XNOvCTPWwh3=BN4fV2No+VUV3oQ@mail.gmail.com>
Message-ID: <CAK7LNATS79a=vBdjvy18oE4XNOvCTPWwh3=BN4fV2No+VUV3oQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] riscv: remove redundant kernel-space generic-y
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 10:32 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> This commit removes redundant generic-y defines in
> arch/riscv/include/asm/Kbuild.
>
> [1] It is redundant to define the same generic-y in both
>     arch/$(ARCH)/include/asm/Kbuild and
>     arch/$(ARCH)/include/uapi/asm/Kbuild.
>
>     Remove the following generic-y:
>
>       errno.h
>       fcntl.h
>       ioctl.h
>       ioctls.h
>       ipcbuf.h
>       mman.h
>       msgbuf.h
>       param.h
>       poll.h
>       posix_types.h
>       resource.h
>       sembuf.h
>       setup.h
>       shmbuf.h
>       signal.h
>       socket.h
>       sockios.h
>       stat.h
>       statfs.h
>       swab.h
>       termbits.h
>       termios.h
>       types.h
>
> [2] It is redundant to define generic-y when arch-specific
>     implementation exists in arch/$(ARCH)/include/asm/*.h
>
>     Remove the following generic-y:
>
>       cacheflush.h
>       module.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Changes in v2:
>   - rebase on Linus' tree


Patch 1-4, applied to linux-kbuild.



>  arch/riscv/include/asm/Kbuild | 25 -------------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 6a646d9..cccd12c 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,5 +1,4 @@
>  generic-y += bugs.h
> -generic-y += cacheflush.h
>  generic-y += checksum.h
>  generic-y += compat.h
>  generic-y += cputime.h
> @@ -9,16 +8,11 @@ generic-y += dma.h
>  generic-y += dma-contiguous.h
>  generic-y += dma-mapping.h
>  generic-y += emergency-restart.h
> -generic-y += errno.h
>  generic-y += exec.h
>  generic-y += fb.h
> -generic-y += fcntl.h
>  generic-y += hardirq.h
>  generic-y += hash.h
>  generic-y += hw_irq.h
> -generic-y += ioctl.h
> -generic-y += ioctls.h
> -generic-y += ipcbuf.h
>  generic-y += irq_regs.h
>  generic-y += irq_work.h
>  generic-y += kdebug.h
> @@ -27,34 +21,15 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += mman.h
> -generic-y += module.h
> -generic-y += msgbuf.h
>  generic-y += mutex.h
> -generic-y += param.h
>  generic-y += percpu.h
> -generic-y += poll.h
> -generic-y += posix_types.h
>  generic-y += preempt.h
> -generic-y += resource.h
>  generic-y += scatterlist.h
>  generic-y += sections.h
> -generic-y += sembuf.h
>  generic-y += serial.h
> -generic-y += setup.h
> -generic-y += shmbuf.h
>  generic-y += shmparam.h
> -generic-y += signal.h
> -generic-y += socket.h
> -generic-y += sockios.h
> -generic-y += stat.h
> -generic-y += statfs.h
> -generic-y += swab.h
> -generic-y += termbits.h
> -generic-y += termios.h
>  generic-y += topology.h
>  generic-y += trace_clock.h
> -generic-y += types.h
>  generic-y += unaligned.h
>  generic-y += user.h
>  generic-y += vga.h
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
