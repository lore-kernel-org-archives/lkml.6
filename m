Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CAEECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C94820844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 12:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsUb4ug4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C94820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeGPMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:50:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51638 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGPMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:50:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so14996387wmc.1;
        Mon, 16 Jul 2018 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8NAgkPM1O3BFqJRMzJrHJ/hQ87vwY+ENQ2KoNyDwS4=;
        b=QsUb4ug491BNC4IYpImeKw28Sh1YcmeSH9ySQ0AvAbaC0xzZ4F+2w4Z3hggSQ2A+J2
         UlI05XOrD7DJYwxNuGYKTd+o4vNOgQqI+cnamWDoEYMW/FyNsjTOAaXi4+yfObDm84ah
         abA/SK39Zs4KOAFFVI4ViUwDlcmdN24EKjENA63yCXP5H6aHDDlPw09NGB7MYdlkdu8a
         6uYXbDJaP7z3fMuZVyNoyFoydpStbvgKF+rK98cDSKgIR7Z5pB6H89560x1WvE/Yx/DF
         9FW93s6L6jiwYKG1E5KskQUmt1BaTiooA6r+Eb54pBrj2WhTrJdSfEef1TSWCZXPhywu
         73Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8NAgkPM1O3BFqJRMzJrHJ/hQ87vwY+ENQ2KoNyDwS4=;
        b=qJwUqj9Xhgy3AX8M+qKj4NkFZG7hN8xOBzsotApIFgec3+VzO7v/rI+E4Ow+0VM+RP
         wIQBLeKEg92+wjoAPrfF98nNcZWX/w2AGfGGirIbUmrkHVya+pu1Pj22sTvU6LAn0Xm3
         tP7P8j/ojacPzKllKSDDkbsKCYjiVW+Cxz88G6lCI9aFOCaG/9Lam5McNohUN4IdHOVY
         ijiX0H4faVcTAFsApssIX2W8fOYs0ReMqUsRyGg1GZc0crCe/L3Q6I0r/nO0ExmFcCpC
         Rl/6IPKFwhu1d8E3+D8mM33LmhdrODS6EcOuyhfyJo94aEjHEjBh/j6l2lEc/o650ip4
         pFsw==
X-Gm-Message-State: AOUpUlHh9Q2TiCR8ILg/RRDqYmBPJnn3WvOfHBE6sfTS+SpeK5kBjymH
        bTLOVClrr9jFJy6wue2Kqnc=
X-Google-Smtp-Source: AAOMgpeXS45NRoKZEgJvaF8UJjfkgk+5DjRVUIeQXwNE3VovZv1VDQiu18B6kUoNwzhfYul6IrZz+w==
X-Received: by 2002:a1c:1802:: with SMTP id 2-v6mr9288175wmy.81.1531743793178;
        Mon, 16 Jul 2018 05:23:13 -0700 (PDT)
Received: from localhost (ohdikc.static.otenet.gr. [80.107.51.104])
        by smtp.gmail.com with ESMTPSA id o4-v6sm15625692wmo.20.2018.07.16.05.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 05:23:12 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:21:25 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>,
        linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] Input: hilkbd - Add casts to HP9000/300 I/O accessors
Message-ID: <20180716122125.m5ycmj7xh2mmufnf@penguin>
References: <20180709093040.23597-1-geert@linux-m68k.org>
 <20180709093040.23597-4-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709093040.23597-4-geert@linux-m68k.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 11:30:38AM +0200, Geert Uytterhoeven wrote:
> Internally, hilkbd uses "unsigned long" I/O addresses everywhere.
> This works fine as:
>   - On PA-RISC, hilkbd uses the gsc_{read,write}b() I/O accessors, which
>     take "unsigned long" addresses,
>   - On m68k, hilkbd uses {read,write}b(), which are currently mapped to
>     {in,out}_8(), and convert the passed addresses to pointers
>     internally.
> 
> However, the asm-generic version of {read,write}b() does not perform
> such conversions, and requires passing pointers instead.  Hence add
> casts to prepare for switching m68k to the asm-generic version.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> This is a dependency for "m68k/io: Switch mmu variant to
> <asm-generic/io.h>".
> 
> v2:
>   - No changes.
> ---
>  drivers/input/keyboard/hilkbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
> index a4e404aaf64bdb82..5c7afdec192c139b 100644
> --- a/drivers/input/keyboard/hilkbd.c
> +++ b/drivers/input/keyboard/hilkbd.c
> @@ -57,8 +57,8 @@ MODULE_LICENSE("GPL v2");
>   #define HIL_DATA		0x1
>   #define HIL_CMD		0x3
>   #define HIL_IRQ		2
> - #define hil_readb(p)		readb(p)
> - #define hil_writeb(v,p)	writeb((v),(p))
> + #define hil_readb(p)		readb((const volatile void __iomem *)(p))
> + #define hil_writeb(v, p)	writeb((v), (volatile void __iomem *)(p))
>  
>  #else
>  #error "HIL is not supported on this platform"
> -- 
> 2.17.1
> 

-- 
Dmitry
