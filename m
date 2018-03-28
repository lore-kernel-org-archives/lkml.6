Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260006-2-18114645829640236827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enitsv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260005; b=cujh8uU5ebpzi6jGT351+fs+4jUALXCVHWIVSv+ynaeAxAx
    iM2LCaMokrg58xXqHFLYupATPtE1BizfxZjaFIkg4TrJJs4+7U29Z418oIPL57sy
    RrM9C4nOyRinQMYze8hV50fRbU1JDOloYtnwxsVeCPnyD/wLQl7rw/rojXyMk+FG
    RHXiowGlEGzJVNUypeEGzi1wOY+8kMrBXoP5Yl6nt+ng59aulP739vin04uh/xrE
    r4K5bxKuirasBhrztk7WSC9JGWyIy2fBy3ZEpxmq9lm5x3GnZdOsLhf7BftMX5Be
    MN7k3o3Z3SFbJpo52GUC05PYJ9FgiSQJ9lbF07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522260005; bh=5Oh3Z7iHzr51EAoDaxsyP9vUBj
    sotWSrP5ZZP7247dQ=; b=bwRzIHhScy6EOu9dKKfkz3TvJ8YYImO8UPiPq7jhNs
    Mt91rXt1udfK/sGjMXpGBbWPnWlY2QeabwekkiNzGE3gRae1wRsGZYEMx3gzzU1L
    9pUQ0upFXiM6LwauVSzM7hWNMKkDtR5pg7ILOBH9Mx/tGShNFau2PKcCkNB+2CiC
    93ZEMwE6zeOsAt0ZEIcF2RC1VCQi6FkxbjlaJv9fk8tQebqm9ulJpxOE22D8EWAr
    r5NXfdSCrh40BuuX9ofZgeLBeZG4KaHdmKfs6yBnr4TQ89COKtheyYVutOe6zNd4
    F3gnFL18bDVgnzV1c957Riqdhe7Bas5EejqhNxpQLHwA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=libc.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFXACFd/O1N5FLu6UD0JoA0KV9k/RhvAGs+vma8jjjoIMyZHAu82AncoQdwlr5gdoeuwneh0Jy8aHiXN9GU6rDjGxEF5GhFtMISYAfOjXh3D8H4LbcpO
    c+u0+G7qkop2JJyeGnI/6yOKqANijQNL/j7DRNpeZaofXkikNfqcfe2g9LFBx2LbzHLAN+KJ/dXmiD4tVnweOCko7LgZRgetzxt8+oC5PjZMjI6jFn4m22BQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=nAebDoNsAAAA:8 a=hAG5_4vcAAAA:8 a=2qT0yUM4dkCxwgfDf0MA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ego-_vB8GfJOOuXVi8J-:22
    a=8Bh8Pg2EFav9IBZ9i9Tn:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeC1SAC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:00:02 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:33490 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbeC1SAB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 14:00:01 -0400
Date: Wed, 28 Mar 2018 13:59:52 -0400
From: Rich Felker <dalias@libc.org>
To: Huacai Chen <chenhc@lemote.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V4 Resend] ZBOOT: fix stack protector in compressed boot
 phase
Message-ID: <20180328175952.GO1436@brightrain.aerifal.cx>
References: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522226933-29317-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 04:48:53PM +0800, Huacai Chen wrote:
> Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> stack checking always fails for decompress_kernel() itself. So remove
> __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> call decompress_kernel().
> 
> Original code comes from ARM but also used for MIPS and SH, so fix them
> together. If without this fix, compressed booting of these archs will
> fail because stack checking is enabled by default (>=4.16).
> 
> V1 -> V2: Fix build on ARM.
> V2 -> V3: Fix build on SuperH.
> V3 -> V4: Initialize __stack_chk_guard in C code as a constant.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/arm/boot/compressed/misc.c        | 9 +--------
>  arch/mips/boot/compressed/decompress.c | 9 +--------
>  arch/sh/boot/compressed/misc.c         | 9 +--------
>  3 files changed, 3 insertions(+), 24 deletions(-)
> 
> [...]
> 
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
> index 627ce8e..c15cac9 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -104,12 +104,7 @@ static void error(char *x)
>  	while(1);	/* Halt */
>  }
>  
> -unsigned long __stack_chk_guard;
> -
> -void __stack_chk_guard_setup(void)
> -{
> -	__stack_chk_guard = 0x000a0dff;
> -}
> +const unsigned long __stack_chk_guard = 0x000a0dff;
>  
>  void __stack_chk_fail(void)
>  {
> @@ -130,8 +125,6 @@ void decompress_kernel(void)
>  {
>  	unsigned long output_addr;
>  
> -	__stack_chk_guard_setup();
> -
>  #ifdef CONFIG_SUPERH64
>  	output_addr = (CONFIG_MEMORY_START + 0x2000);
>  #else
> -- 
> 2.7.0

LGTM.

Acked-by: Rich Felker <dalias@libc.org>

Rich
