Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00368C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDA0F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA0F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbeKCDh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:37:28 -0400
Received: from smtp-1.orcon.net.nz ([60.234.4.34]:51519 "EHLO
        smtp-1.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCDh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:37:28 -0400
Received: from [121.99.228.40] (port=9980 helo=tower)
        by smtp-1.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <mcree@orcon.net.nz>)
        id 1gIeBy-0007fD-Uv; Sat, 03 Nov 2018 07:29:11 +1300
Date:   Sat, 3 Nov 2018 07:29:05 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        parri.andrea@gmail.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jrdr.linux@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
Subject: Re: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
Message-ID: <20181102182905.3klrdw4dxapeoiib@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        parri.andrea@gmail.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, jrdr.linux@gmail.com,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabyasachi.linux@gmail.com
References: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:56:37PM +0530, Brajeswar Ghosh wrote:
> Remove asm/xchg.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  arch/alpha/include/asm/cmpxchg.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index 6c7c39452471..bcbdac0744f9 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -36,7 +36,6 @@
>  #undef ____cmpxchg
>  #define ____xchg(type, args...)		__xchg ##type(args)
>  #define ____cmpxchg(type, args...)	__cmpxchg ##type(args)
> -#include <asm/xchg.h>

It's amazing the number of times we get a patch to remove that.

Instead of just automatically removing a second include of a
header file, why don't you take a closer look to see what it
actually does?

Cheers,
Michael.
