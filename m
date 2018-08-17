Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318D3208A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318D3208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeHQQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:18:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35956 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeHQQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:18:05 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NldpLbnlu5Aa; Fri, 17 Aug 2018 15:14:25 +0200 (CEST)
Received: from nazgul.tnic (95-42-132-194.ip.btc-net.bg [95.42.132.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63DC91EC0253;
        Fri, 17 Aug 2018 15:14:25 +0200 (CEST)
Date:   Fri, 17 Aug 2018 15:14:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: Re: [PATCH] EDAC: Add missing MEM_LRDDR4 entry in edac_mem_types[]
Message-ID: <20180817131443.GB13594@nazgul.tnic>
References: <20180810141426.8918-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180810141426.8918-1-tiwai@suse.de>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 04:14:26PM +0200, Takashi Iwai wrote:
> The edac_mem_types[] array misses MEM_LRDDR4 entry, and it leads to
> NULL dereference when accessed via sysfs or such.
> 
> Fixes: 1e8096bb2031 ("EDAC: Add LRDDR4 DRAM type")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/edac/edac_mc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 3bb82e511eca..7d3edd713932 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -215,6 +215,7 @@ const char * const edac_mem_types[] = {
>  	[MEM_LRDDR3]	= "Load-Reduced-DDR3-RAM",
>  	[MEM_DDR4]	= "Unbuffered-DDR4",
>  	[MEM_RDDR4]	= "Registered-DDR4",
> +	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
>  	[MEM_NVDIMM]	= "Non-volatile-RAM",
>  };
>  EXPORT_SYMBOL_GPL(edac_mem_types);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
