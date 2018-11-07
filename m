Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EE4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4C42081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YCrgETOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4C42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeKGVTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:19:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47269 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeKGVTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:19:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107114934euoutp01f09a13c47b91eeaeaadfe5a4fa149921~k1S-8Ies30795007950euoutp01C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 11:49:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107114934euoutp01f09a13c47b91eeaeaadfe5a4fa149921~k1S-8Ies30795007950euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541591374;
        bh=FqWPzx+CfArUOtfS+4xxOU+mhZCHBmNx/o9SoAykDOQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YCrgETOsOrgMxddPBoj6fq8o2hfTNXhEZO6StxWG+a5oGsejn98FTQ7bNnHcbQ60h
         u+9qUUydLqMfJQTSBtvc4hhiPVDAr4WoDvhf86TqEow64eF53TOinNdUqollhGI8B2
         7mO1lg6jphoWmQWqVIAVLC1ckMfWCk9hgV2gPR+4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107114933eucas1p178fc7e0d64cf8fd51c14b6dd654db55d~k1S-BM1Fx0573205732eucas1p1z;
        Wed,  7 Nov 2018 11:49:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.F6.04294.D41D2EB5; Wed,  7
        Nov 2018 11:49:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181107114932eucas1p259f19baf999a65b781cadd006f69add3~k1S_Su5w00374103741eucas1p2L;
        Wed,  7 Nov 2018 11:49:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107114932eusmtrp1f86b05f8189775f5219f76070058f744~k1S_GXjnc2677926779eusmtrp1t;
        Wed,  7 Nov 2018 11:49:32 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-35-5be2d14dcdd8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D7.B7.04128.C41D2EB5; Wed,  7
        Nov 2018 11:49:32 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181107114931eusmtip15e9ad2afc740ef801b8e2fe62bf28f1a~k1S9R1X5S1965519655eusmtip1Y;
        Wed,  7 Nov 2018 11:49:31 +0000 (GMT)
Subject: Re: [PATCH v6 6/6] drm/bridge: add PHY initialization in mhdp8546
 driver.
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Piotr Sroka <piotrs@cadence.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     rafalc@cadence.com, quentin.schulz@bootlin.com, jbergsagel@ti.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <df739067-b1a6-2eda-cb75-e008a0e02534@samsung.com>
Date:   Wed, 7 Nov 2018 12:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1539034953-11274-7-git-send-email-dkos@cadence.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa2xLYRj2nVvPZp3Tg+wNEjREJu7XLyEuccn5IyFbBBMcHHNZt+mxucdM
        RjvmssVl3XRkm84MseqmDTZVq5KhVF1mWt3EZVkEQ5aYWXcm9u95n8v3vk/ysSRfzAxiNyVv
        k/TJYpKWiaSq6tofj13kDSVMOGnkcc4jD4EzDa00LnI9onFjYBr2/fjCYHvQocKdoRYan83d
        i+8cblJh44kSFa5s8tP4maOQwd+CnSQ+/9VG4dIXXgKXma0IX6u5TeOS3CYSZ1w/w+CsWy4V
        bsxzoTkDhQpzBRLMFbuFCmMLITw7mkMIzZVeJBQY8mmhstzICNU/g7Rg9iwRAofdhGAt2SfY
        c28RgtvxWiV0mGooodpvJgX3y2pisWZF5Mz1UtKmdEk/ftaayI0FRVVE6n5+R637I5GBgtHZ
        KIIFbgpc+f2AzEaRLM+VIXjgeIqUoQ1BSe3nnuE7grd5ftW/yCfPN0IRLAjuhorJsMBzrQg8
        zjFh3J+LB0deDh02DeDu0VB7s44ICyS3ABpqGqgwZrhY6LC+YsJYzc0Cv6up20NxI+DtlbZu
        fiC3DAyBSz0eDXjym7uyLBvBzYWLGVOUJ4fCAVsBqeAYeN1c1H0ccEEWjnVkI+Xq+fDzvY9R
        cH/47L7e02YIPMw7Qil4H2Tm+0glbEBwv9jSE5gBd91eOryY7Dr6qmO8Qs+F0CErE6aBi4aX
        rRrlhmjIrTpNKrQaDAd5xT0cAvU2UsExUPrkB3McaU29ipl6tTH1amP6v/ccospRjJQm6xIl
        eVKytH2cLOrktOTEcetSdJWo6+s+/ONuu4Ecv9c6EccibZT6ie1dAk+L6fJOnRMBS2oHqHMu
        hRJ49Xpx5y5Jn7Jan5YkyU40mKW0MerdfYIJPJcobpO2SFKqpP+nEmzEoAzUd7nH7mqJOHb5
        uw/P7qx9M9rmO79BrXPaVd6ywvZVqZo1mx9vLbx8b6/dXOW78XzXoTEpAeMHSxZRMKf0V/qo
        xtDk+Czr/ZUNHyxT/fPax06/YMkcKddFBY10n7hJv9KiVn/tJ3aWls0bFjt5YaOv/tSFd3U2
        TfzIPcOX1ovIlBinpeSN4sTRpF4W/wJMvef0tgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURiAOfdju0qT6/w6jKQchSk4nZ9HMzEhOoVEVlYkZUMvKrqt7p2S
        RTWtICeGHz/SWTNJ+1xC0/wK08QcYmVmaSXmcv5IxEozI0rNNQP/PZznfV448DKktIWWMVka
        HcdrVDlykSvVv2QdC0ocnEgJsTWuRyUv+whUeHmGRjU9L2k0Nh6J3vz4KkJttnYxWp6YptH1
        8rPoabFdjIrK6sTIYh+m0VD7NRGasy2TqHb2EYXqRwYJdMfUCNDDzic0qiu3k0jfVClClzp6
        xGisogfEe2GzyQywyXwGm4umCTx0pYTAk5ZBgKsvV9HYcq9IhFsWbDQ29SXh8WIrgRvrzuO2
        8g4CW9s/iPGisZPCLcMmElvftRB73Y8oYnltro7bmKkVdNvkKUoUqlBGI0VoeLRCGRZ1NCY0
        Qh4cF5vO5WTlcXxw3HFFZnVNM3GiQHqqy/qZ0AObmwG4MJANh1N9c4QBuDJSth7A37M3Safw
        gY9rZlbZA/4ZNoicQ9MAzo3YKIfwYA/A9ooS2iE8WSsN27peAYcg2R1wtHOUchb9AJaOVood
        QsQGwMXG9yIHS9g4ONxjJxxMsZvgx4b5f+9e7GH4YqoBOGfcYV/V5MoihnFht8O7+nDnfn/4
        x/SadPIGeOFR9Sr7wA+TNUQpkBrX1MY1iXFNYlyT3ADUPeDJ5QrqDLUQqhBUaiFXk6FI06ot
        YOVomnt/NbUCw5f93YBlgHydZEvrpxQprcoT8tXdADKk3FNScn8iRSpJV+Wf5nhtKp+bwwnd
        IGLlb2WkzCtNu3KCGl2qMkIZhaKVUWFRYZFI7iMZCMk/ImUzVDoum+NOcPz/jmBcZHpA0mWC
        G272Oei/5+03z2cxI74e1Pipq7KkwjLv8ELz/ZPTfvOXJmutWtMbPjlvYP7cmMZrKWn9rsiC
        rXxApDSkdsHv2NCs/VZx12Zs+REQmBkUL5Z5v9j3MzvxdkJvwkXNd3HgoG9gWtDA80Nq992G
        /gduiSd3Jk/FooXK4H5XvZwSMlXKQJIXVH8BFrQkzEoDAAA=
X-CMS-MailID: 20181107114932eucas1p259f19baf999a65b781cadd006f69add3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181008214506epcas2p2cf110c14fcc340c42e1c6da4b03d8901
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008214506epcas2p2cf110c14fcc340c42e1c6da4b03d8901
References: <1539034953-11274-1-git-send-email-dkos@cadence.com>
        <CGME20181008214506epcas2p2cf110c14fcc340c42e1c6da4b03d8901@epcas2p2.samsung.com>
        <1539034953-11274-7-git-send-email-dkos@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.2018 23:42, Damian Kos wrote:
> This patch modifies the mhdp8546 driver to initialize sd0801 "Torrent" PHY.
>
> And removes the dbg_regs field from cdns_mhdp_device structure.
>
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  drivers/gpu/drm/bridge/cdns-mhdp.c    | 9 +++++++++
>  include/drm/bridge/cdns-mhdp-common.h | 1 -
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
> index 48ac5cf1e031..caaf3c17d74f 100644
> --- a/drivers/gpu/drm/bridge/cdns-mhdp.c
> +++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/phy/phy.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -1220,6 +1221,12 @@ static int mhdp_probe(struct platform_device *pdev)
>  	if (IS_ERR(mhdp->regs))
>  		return PTR_ERR(mhdp->regs);
>  
> +	mhdp->phy = devm_phy_get(&pdev->dev, "dpphy");


It is not documented in the bindings.


> +	if (IS_ERR(mhdp->phy)) {
> +		dev_err(&pdev->dev, "no PHY configured\n");


dev_err only if err != -EPROBE_DEFER


> +		return PTR_ERR(mhdp->phy);
> +	}
> +
>  	platform_set_drvdata(pdev, mhdp);
>  
>  	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
> @@ -1291,6 +1298,8 @@ static int mhdp_probe(struct platform_device *pdev)
>  			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
>  			   &codec_data, sizeof(codec_data));
>  
> +	phy_init(mhdp->phy);
> +


Beside this:

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


>  	/* Enable VIF clock for stream 0 */
>  	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
>  	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
> diff --git a/include/drm/bridge/cdns-mhdp-common.h b/include/drm/bridge/cdns-mhdp-common.h
> index d4711091ff2b..1e8a44138ce2 100644
> --- a/include/drm/bridge/cdns-mhdp-common.h
> +++ b/include/drm/bridge/cdns-mhdp-common.h
> @@ -553,7 +553,6 @@ struct cdns_mhdp_device {
>  	struct cdns_mhdp_sink	sink;
>  	struct cdns_mhdp_bridge	bridge;
>  	struct phy		*phy;
> -	void __iomem		*dbg_regs;
>  
>  	struct video_info	video_info;
>  	struct drm_display_mode	mode;


