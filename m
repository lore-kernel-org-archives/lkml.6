Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC00C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4356420867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D7KNYzAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4356420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIESSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:18:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57122 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeIESSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:18:41 -0400
Received: from avalon.localnet (unknown [IPv6:2a02:a03f:4407:cd00:1953:677d:5909:a7be])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36D2284;
        Wed,  5 Sep 2018 15:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536155301;
        bh=/MBxFADd6uHKDbrMWgVJoWSKtkYV16WyCy8p4B7hz9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7KNYzAmdLdIsDdQoBD3+qp/LBzNAtfeoXiSp/2FPR2TufiQ2veHCb6lQy1Tvn5HR
         CmJoyz7fy0u7QPODa7W9c5kyDCbd0k2nsC9TqZfEyU+LawzfrlEafrR02sYfe5mSSM
         HU2ZXU8yqNGq9WXCc+XeS0OhhJbXlV6X39c3/eKA=
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
Subject: Re: [PATCH 09/10] phy: Add Cadence D-PHY support
Date:   Wed, 05 Sep 2018 16:48:27 +0300
Message-ID: <1838745.9zNmGlpGXc@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <d50a5f0750647dcc09ef52411641b628161b362e.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com> <d50a5f0750647dcc09ef52411641b628161b362e.1536138624.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 5 September 2018 12:16:40 EEST Maxime Ripard wrote:
> Cadence has designed a D-PHY that can be used by the, currently in tree,
> DSI bridge (DRM), CSI Transceiver and CSI Receiver (v4l2) drivers.
> 
> Only the DSI driver has an ad-hoc driver for that phy at the moment, while
> the v4l2 drivers are completely missing any phy support. In order to make
> that phy support available to all these drivers, without having to
> duplicate that code three times, let's create a generic phy framework
> driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/phy/Kconfig             |   1 +-
>  drivers/phy/Makefile            |   1 +-
>  drivers/phy/cadence/Kconfig     |  13 +-
>  drivers/phy/cadence/Makefile    |   1 +-
>  drivers/phy/cadence/cdns-dphy.c | 499 +++++++++++++++++++++++++++++++++-

Should the DT bindings be split from Documentation/devicetree/bindings/
display/bridge/cdns,dsi.txt ?

>  5 files changed, 515 insertions(+)
>  create mode 100644 drivers/phy/cadence/Kconfig
>  create mode 100644 drivers/phy/cadence/Makefile
>  create mode 100644 drivers/phy/cadence/cdns-dphy.c

[snip]

-- 
Regards,

Laurent Pinchart



