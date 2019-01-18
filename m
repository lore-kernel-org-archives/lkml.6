Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049902086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547799331;
	bh=L5T+VUoRVK9QGkhtMHE1r7Lp9r2F5Vdf7brc3Ah+kLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yIhYJcQRQRj36f0hwZVSsfbJfIYdUnTCE3+Vjm/e4EIy/u+9KC50JE9v4bZ0yyvWZ
	 jxJ7Y27gDj1BMi7w/0wQMDeQvElTTeHLp98tgYT7RvMCpgzQhAiWpZ3Chq1E+Y3D/d
	 wN9oKUfIfpK1g012PfbXGPcxhu7mZ/KYxFdr7/Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfARIP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:15:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfARIP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:15:27 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C382086D;
        Fri, 18 Jan 2019 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547799327;
        bh=L5T+VUoRVK9QGkhtMHE1r7Lp9r2F5Vdf7brc3Ah+kLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBrLoI71wOr5l5G2dA82MZnrl1ntosfb+Npf08AnZNJko/btTHDchck2tlpR4DH9y
         hmQXPxtFOG1+hpsfgXlRl9T8xyMHFEMBKpCPX5ZfcWx72V73A7JhvPqa36YkcNWCC3
         FRqMfy3aa44+FDvg805ZelNeHFTMPcyVe2zTXpoo=
Date:   Fri, 18 Jan 2019 09:15:17 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] memory: jz4780-nemc: Reduce size of const array
Message-ID: <20190118091518.467087b8@bbrezillon>
In-Reply-To: <20190117224550.18043-3-paul@crapouillou.net>
References: <20190117224550.18043-1-paul@crapouillou.net>
        <20190117224550.18043-3-paul@crapouillou.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2019 19:45:49 -0300
Paul Cercueil <paul@crapouillou.net> wrote:

> The maximum value found in that array is 15, there's no need to store
> these values as uint32_t, a uint8_t is enough.

Is it really worth the additional cast you add in the code?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/memory/jz4780-nemc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index bcf06adefc96..ef3f20e46590 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -161,7 +161,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  	 * Conversion of tBP and tAW cycle counts to values supported by the
>  	 * hardware (round up to the next supported value).
>  	 */
> -	static const uint32_t convert_tBP_tAW[] = {
> +	static const u8 convert_tBP_tAW[] = {
>  		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
>  
>  		/* 11 - 12 -> 12 cycles */
> @@ -232,7 +232,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  			return false;
>  		}
>  
> -		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
> +		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TBP_SHIFT;
>  	}
>  
>  	if (of_property_read_u32(node, "ingenic,nemc-tAW", &val) == 0) {
> @@ -244,7 +244,7 @@ static bool jz4780_nemc_configure_bank(struct jz4780_nemc *nemc,
>  			return false;
>  		}
>  
> -		smcr |= convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
> +		smcr |= (u32)convert_tBP_tAW[cycles] << NEMC_SMCR_TAW_SHIFT;
>  	}
>  
>  	if (of_property_read_u32(node, "ingenic,nemc-tSTRV", &val) == 0) {

