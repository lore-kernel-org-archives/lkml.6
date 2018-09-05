Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC41C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274F92075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sqLr+Scq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274F92075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIESQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:16:46 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57084 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeIESQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:16:46 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EDD284;
        Wed,  5 Sep 2018 15:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536155186;
        bh=73asuGuOXoGPsFX51dOnZg9kNMDSRB0pzgq/YQb5z6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqLr+ScqdIrFZs4zTViW84AsDwL13PD966QwvVbpZRyImLIE33tljP8m5zzby1RbH
         EJRCMZLEvMPsuju14+3Xg2PQngWIvmAgztZ6OGcBKSaIKe7FH/zxl141gK5d10B8f9
         QtJEizNdmqV2wQ4lOfRQvpX5Vns3D0/yjZcukS2o=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Witos <kwitos@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: Re: [PATCH 01/10] phy: Add MIPI D-PHY mode
Date:   Wed, 05 Sep 2018 16:46:33 +0300
Message-ID: <2567966.N4s79vZLWV@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <00e3d5da1ca3c03ba60350c1cf78ab44693ff493.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <00e3d5da1ca3c03ba60350c1cf78ab44693ff493.1536138624.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 5 September 2018 12:16:32 EEST Maxime Ripard wrote:
> MIPI D-PHY is a MIPI standard meant mostly for display and cameras in
> embedded systems. Add a mode for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 9713aebdd348..9cba7fe16c23 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -40,6 +40,7 @@ enum phy_mode {
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
> +	PHY_MODE_MIPI_DPHY,
>  };
> 
>  /**

-- 
Regards,

Laurent Pinchart



