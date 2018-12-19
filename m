Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F421C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493872184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Iy3ZuDM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeLSLX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:23:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57384 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbeLSLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:23:27 -0500
Received: from zn.tnic (p200300EC2BD1DB008D03BCFA6A977107.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:db00:8d03:bcfa:6a97:7107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D92A1EC0BDC;
        Wed, 19 Dec 2018 12:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545218605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JZ6YDTTIM6+DwLrZLtnfLuGka428PlTwBhmXtiLZvYs=;
        b=Iy3ZuDM/z6v2buOAJ6Vn4U9kTGbLK0tFET+O3Qe/G5LSvPY2tfXTM1EGydTUOkIvkaj8B4
        LunihaEsK9x6qP+/0MMq9Whe4IKeK55dq4DJb+oQaZ/w/FwqBu0yjZetLJuw43lubQNvx/
        7XcPzlRjbP4w82+QyBtyg9V9zzwU/GM=
Date:   Wed, 19 Dec 2018 12:23:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     York Sun <york.sun@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnout.vandecappelle@essensium.com,
        matthew.weber@rockwellcollins.com
Subject: Re: [PATCH] EDAC: Add mention of LS1021A inside comments of
 fsl_ddr_edac driver
Message-ID: <20181219112319.GC18479@zn.tnic>
References: <20181219104323.10324-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219104323.10324-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 11:43:23AM +0100, Patrick Havelange wrote:
> The Freescale ddr driver also works on the LS1021A board.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
>  drivers/edac/fsl_ddr_edac.c | 4 ++--
>  drivers/edac/fsl_ddr_edac.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
> index efc8276d1d9c..5c11f3637651 100644
> --- a/drivers/edac/fsl_ddr_edac.c
> +++ b/drivers/edac/fsl_ddr_edac.c
> @@ -2,8 +2,8 @@
>   * Freescale Memory Controller kernel module
>   *
>   * Support Power-based SoCs including MPC85xx, MPC86xx, MPC83xx and
> - * ARM-based Layerscape SoCs including LS2xxx. Originally split
> - * out from mpc85xx_edac EDAC driver.
> + * ARM-based Layerscape SoCs including LS2xxx and LS1021A. Originally
> + * split out from mpc85xx_edac EDAC driver.
>   *
>   * Parts Copyrighted (c) 2013 by Freescale Semiconductor, Inc.
>   *
> diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
> index 4ccee292eff1..589b9b4a5e8a 100644
> --- a/drivers/edac/fsl_ddr_edac.h
> +++ b/drivers/edac/fsl_ddr_edac.h
> @@ -2,8 +2,8 @@
>   * Freescale Memory Controller kernel module
>   *
>   * Support  Power-based SoCs including MPC85xx, MPC86xx, MPC83xx and
> - * ARM-based Layerscape SoCs including LS2xxx. Originally split
> - * out from mpc85xx_edac EDAC driver.
> + * ARM-based Layerscape SoCs including LS2xxx and LS1021A. Originally
> + * split out from mpc85xx_edac EDAC driver.
>   *
>   * Author: Dave Jiang <djiang@mvista.com>
>   *
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
