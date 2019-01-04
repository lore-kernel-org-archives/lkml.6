Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8DCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ACE217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cw8UQ6cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfADBFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:05:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44271 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfADBFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:05:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so16716408pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dQs/81kQ9sItWsv3uUT9nCDzmSJ/uuIEXVPfmClASLU=;
        b=Cw8UQ6cnu5g1abxfqKbazN/+omtklQOyWhiI/0SMyZMjA9a6Givw3pbz7UBk6U7if7
         Rjr8JuGoMx27sJVU1MOlhl2h63z9DNx/G+4WRNhtPyCr2qFlkxY6pQHtAiqeyU7trmcZ
         TfLO35t3Ay+uoJUUzwmHOIbQtifgTNyF5itgDJM0gElthJrrJIUVXBIZKMYdM2R1nHm9
         fCYx6oe78gyW76p3ia/qRr/uBmwuidLY6gfaFb/tJWWQZoNJQjMByLmRRGpbvoN/rXmT
         xXuPLEXQJlpxZPMErSw85JFC80i3mgF89sxi+Qy3Ou79vzM8uPXpKKia72lKgdkQf0j4
         HuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dQs/81kQ9sItWsv3uUT9nCDzmSJ/uuIEXVPfmClASLU=;
        b=pKsNWRMgoaibJ9WV1wSwv0/gXpZ+CBo5sBvlcD2mbXw/5KHe+LWMnHliO2tna6wSpJ
         SDYCaYRVmFoMUBWAaXh0PXyG02WfjFCyRdJfpDSjy8QFrals+ZVjH3D0yAST1zVwmhtv
         gKtcJRvLwYGAO532nD8VH6lSDbP50nDh+Y8q7WNO5KN8GUUe3r8qOjrIDYaAKcW9KK6a
         yLqcfqArhaxBV/SxYmZX6steF9l4nDOLuotwm2L7bjg/+hUB9rjE+trX3n8iz9HnOR5q
         lzBHft8uW7rNjxS+MbihdRXUR0JiaB+7k+MfaCcuIImSOPiAVWm2MbFVNgqo1vbOcTVY
         5eOA==
X-Gm-Message-State: AA+aEWaHlKwDMs8qySd+/96UmoLna79dUTcE9WmdVpyN1JxD++CPNCN/
        UuWJ4TN1OGOFuQ15uZY3k6GcNw==
X-Google-Smtp-Source: AFSGD/WqUrM/q+Etuc5TSYeJgKye4qIO6I3bDYFmE5Q9QD5tNspTEa6JXfQD8okAH/O5nnNnbX5lcw==
X-Received: by 2002:a62:938f:: with SMTP id r15mr50006567pfk.27.1546563929841;
        Thu, 03 Jan 2019 17:05:29 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v191sm130370820pgb.77.2019.01.03.17.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 17:05:29 -0800 (PST)
Date:   Thu, 03 Jan 2019 17:05:29 -0800 (PST)
X-Google-Original-Date: Thu, 03 Jan 2019 16:45:44 PST (-0800)
Subject:     Re: [PATCH] riscv: remove redundant kernel-space generic-y
In-Reply-To: <1544969471-14224-1-git-send-email-yamada.masahiro@socionext.com>
CC:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        yamada.masahiro@socionext.com, alankao@andestech.com,
        deepa.kernel@gmail.com, linux-kernel@vger.kernel.org,
        Jim Wilson <jimw@sifive.com>, geert@linux-m68k.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     yamada.masahiro@socionext.com
Message-ID: <mhng-029a5523-f3c5-4e90-b679-4e10f1ba4c0f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2018 06:11:11 PST (-0800), yamada.masahiro@socionext.com wrote:
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
>       dma-mapping.h
>       module.h
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/riscv/include/asm/Kbuild | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 6a646d9..f7068f3 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,5 +1,4 @@
>  generic-y += bugs.h
> -generic-y += cacheflush.h
>  generic-y += checksum.h
>  generic-y += compat.h
>  generic-y += cputime.h
> @@ -7,18 +6,12 @@ generic-y += device.h
>  generic-y += div64.h
>  generic-y += dma.h
>  generic-y += dma-contiguous.h
> -generic-y += dma-mapping.h
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
> @@ -27,34 +20,15 @@ generic-y += kvm_para.h
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

Thanks.  These just sort of collected there because I hadn't trimmed them.  Is 
there a script that checks these?
