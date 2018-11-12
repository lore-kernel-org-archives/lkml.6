Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9334E208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzrSRQ+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9334E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbeKLON2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:13:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbeKLON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:13:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so7758941wrr.0;
        Sun, 11 Nov 2018 20:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
        b=VzrSRQ+JM8AQLv7s6XcDBlE0ZdMcRcFn+6R+TNTqMLem6BSiFRB3dsOATP099IGwpd
         ujEP/GRork6e1NAWzbnuRxVWZlTp4B/TA1/FsIBQ152QWUAbp1Z2iJpWUmkG6G3pcNVp
         3D4bZk3y4+eGJM1qVcwn9yq7zT/LunSQnwxjx7/CvV4cp++6YMRnPfWGXpaFozbhxDB0
         xil5IcRk1ThTK9AnTHYQm1HWfxj3mAuAJihoW5G1NBvfVqzcMYi79X6YkAtryz5UweP0
         fVc37qOiSTUvs6rpobcLPxKINjBBLEPgoKVeOTEwZHBu0C0YQLSY0epaeHqSXAHbW2Ys
         RE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=02S7gP8CBtLu/d2vn+LP1VB7jEPtnklyU3WqzRNVQTc=;
        b=mtwAb8NWIL6ouOu5I4/ZMZPYBNbvlYddPs+NG61QZSMp/LrCjrNicwMwc2+fdAraKQ
         pPKqgyAjKoqxTaoRBgO/pbWyTkV5S+LbFmeqlXmdhdFmMf1nCt+HIhy+XaYCLdhZ5Okl
         PvE2baf8LBvEmtDBVIYe/pgqEdMBJJSqb8HL4NbD8xhmXPJCZBsRe9iF02GUbeBzditQ
         fPqNprngyJDQJMdlhYmBpJl7V0nrO28j1TbI/cyPetPz6cetqMH3x7BWVggtJJQtDa4x
         xLu3sWk+yGBu6IcTLWlUgL4JSa7dhoMpI8CjzZGwhKe4Ra0M83m5a+qOHy4KayCRkBx6
         v1Gg==
X-Gm-Message-State: AGRZ1gIshVYw7CK7r1iuwseiICmwKSJOuX5IfvPI3KATWkWuxlO2g4TQ
        NGEDCW5rELuLsaLxJXPfLk0=
X-Google-Smtp-Source: AJdET5dqo97oNvVhbeHeAC8ILm3BUif2kLLNwLcv0IBPSdLDjvuMRio/jZQQxfkfSCWQWlB8F0MuNQ==
X-Received: by 2002:adf:df0a:: with SMTP id y10-v6mr14821319wrl.127.1541996524481;
        Sun, 11 Nov 2018 20:22:04 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j189-v6sm26136436wmf.18.2018.11.11.20.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:22:03 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:22:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 02/17] x86: Add support for ZSTD-compressed kernel
Message-ID: <20181112042200.GA96061@gmail.com>
References: <20181109185953.xwyelyqnygbskkxk@angband.pl>
 <20181109190304.8573-1-kilobyte@angband.pl>
 <20181109190304.8573-2-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109190304.8573-2-kilobyte@angband.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Adam Borowski <kilobyte@angband.pl> wrote:

> From: Nick Terrell <terrelln@fb.com>
> 
> Integrates the ZSTD decompression code to the x86 pre-boot code.
> 
> Zstandard requires slightly more memory during the kernel decompression
> on x86 (192 KB vs 64 KB), and the memory usage is independent of the
> window size.
> 
> Zstandard requires memory proportional to the window size used during
> compression for decompressing the ramdisk image, since streaming mode is
> used. Newer versions of zstd (1.3.2+) list the window size of a file
> with `zstd -lv <file>'. The absolute maximum amount of memory required
> is just over 8 MB.
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>
> ---
>  Documentation/x86/boot.txt        | 6 +++---
>  arch/x86/Kconfig                  | 1 +
>  arch/x86/boot/compressed/Makefile | 5 ++++-
>  arch/x86/boot/compressed/misc.c   | 4 ++++
>  arch/x86/boot/header.S            | 8 +++++++-
>  arch/x86/include/asm/boot.h       | 6 ++++--
>  6 files changed, 23 insertions(+), 7 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 4c881c850125..af2efb256527 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -526,8 +526,14 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
>  # the size-dependent part now grows so fast.
>  #
>  # extra_bytes = (uncompressed_size >> 8) + 65536
> +#
> +# ZSTD compressed data grows by at most 3 bytes per 128K, and only has a 22
> +# byte fixed overhead but has a maximum block size of 128K, so it needs a
> +# larger margin.
> +#
> +# extra_bytes = (uncompressed_size >> 8) + 131072
>  
> -#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 65536)
> +#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)

This change would also affect other decompressors, not just ZSTD, 
correct?

Might want to split this change out into a separate preparatory patch to 
allow it to be bisected to, or at least mention it in the changelog more 
explicitly?

Thanks,

	Ingo
