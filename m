Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05173C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04DF20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04DF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeGIKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:16:12 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51016 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeGIKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:16:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id E26AE2737C;
        Mon,  9 Jul 2018 06:16:06 -0400 (EDT)
Date:   Mon, 9 Jul 2018 20:17:29 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 09/12] nubus: use for_each_if
In-Reply-To: <20180709083650.23549-9-daniel.vetter@ffwll.ch>
Message-ID: <alpine.LNX.2.21.1807092017030.8@nippy.intranet>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709083650.23549-9-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018, Daniel Vetter wrote:

> Avoids the inverted check compared to the open-coded version.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: linux-m68k@lists.linux-m68k.org

Acked-by: Finn Thain <fthain@telegraphics.com.au>

> ---
>  include/linux/nubus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nubus.h b/include/linux/nubus.h
> index eba50b057f6f..17fd07578ef7 100644
> --- a/include/linux/nubus.h
> +++ b/include/linux/nubus.h
> @@ -127,7 +127,7 @@ struct nubus_rsrc *nubus_next_rsrc_or_null(struct nubus_rsrc *from);
>  	for (f = nubus_first_rsrc_or_null(); f; f = nubus_next_rsrc_or_null(f))
>  
>  #define for_each_board_func_rsrc(b, f) \
> -	for_each_func_rsrc(f) if (f->board != b) {} else
> +	for_each_func_rsrc(f) for_each_if (f->board == b)
>  
>  /* These are somewhat more NuBus-specific.  They all return 0 for
>     success and -1 for failure, as you'd expect. */
> 
