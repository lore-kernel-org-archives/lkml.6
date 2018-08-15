Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D944DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE3D214EE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3D214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeHOSum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:50:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32918 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeHOSum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:50:42 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wziyr_iWQIcD; Wed, 15 Aug 2018 17:57:42 +0200 (CEST)
Received: from nazgul.tnic (95-42-132-194.ip.btc-net.bg [95.42.132.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51F991EC0104;
        Wed, 15 Aug 2018 17:57:40 +0200 (CEST)
Date:   Wed, 15 Aug 2018 17:57:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Tim Small <tim@buttersideup.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: i82443bxgx: Fix invalid memory type assignment
Message-ID: <20180815155752.GC28669@nazgul.tnic>
References: <20180810141520.8993-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810141520.8993-1-tiwai@suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:15:20PM +0200, Takashi Iwai wrote:
> The i82443bxgx_edac driver assigns an invalid negative value when an
> unknown DRAM type is detected.  Drop the unnecessary '-' that brings
> misbehavior.
> 
> Fixes: 5a2c675c8919 ("drivers/edac: new i82443bxgz MC driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/edac/i82443bxgx_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/i82443bxgx_edac.c b/drivers/edac/i82443bxgx_edac.c
> index a2ca929e2168..1638f288fa47 100644
> --- a/drivers/edac/i82443bxgx_edac.c
> +++ b/drivers/edac/i82443bxgx_edac.c
> @@ -273,7 +273,7 @@ static int i82443bxgx_edacmc_probe1(struct pci_dev *pdev, int dev_idx)
>  		break;
>  	default:
>  		edac_dbg(0, "Unknown/reserved DRAM type value in DRAMC register!\n");
> -		mtype = -MEM_UNKNOWN;
> +		mtype = MEM_UNKNOWN;
>  	}
>  
>  	if ((mtype == MEM_SDR) || (mtype == MEM_RDR))
> -- 

Is this something you caught by inspection or you really have hw that
loads that driver...

Wikipedia says 440BX chipset is pentium II and III which, if so, would
drop its priority considerably. CC:stable would be not needed either, TBH.

Thx.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
