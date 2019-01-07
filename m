Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6393C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375E2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sk1f9Rtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfAGUk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:40:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53090 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfAGUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:40:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07KeF4h047209;
        Mon, 7 Jan 2019 14:40:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546893615;
        bh=ziT63+nUiH8LgSYJMHq+gvz9CaymI4zBXAyM7b16/O8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Sk1f9Rtv9N7Qq6q9DG3hCfrjBwr5/LYHfFE4AXmafa5CCSVLRXe9y3Tl/Oa+jj2RA
         iNHE5C5BK/kt5Uqrz1aY4P26Wis1xpSXI1XIRmAKqEmJKVUYkIlztWHITMulfcxdgc
         ktC2HKRYEdwleIoSVWiNnUZrpPRB1ufRZlJyiKbc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07KeFu1092595
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 14:40:15 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 14:40:15 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 14:40:15 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07KeFSP025667;
        Mon, 7 Jan 2019 14:40:15 -0600
Date:   Mon, 7 Jan 2019 14:40:15 -0600
From:   Bin Liu <b-liu@ti.com>
To:     <min.guo@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/4] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20190107204015.GF25910@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, min.guo@mediatek.com,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-2-git-send-email-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1545896066-897-2-git-send-email-min.guo@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 27, 2018 at 03:34:23PM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt      | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,musb.txt b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> new file mode 100644
> index 0000000..e899c9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,musb.txt
> @@ -0,0 +1,49 @@
> +MediaTek musb DRC/OTG controller

s/DRC/DRD/

> +-------------------------------------------
> +
> +Required properties:

[snip]

> +Example:
> +
> +usb2: usb@11200000 {
> +	compatible = "mediatek,mt2701-musb";

s/;/,/

> +		"mediatek,mtk-musb";

Regards,
-Bin.
