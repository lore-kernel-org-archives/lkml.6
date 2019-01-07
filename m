Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7623C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D932087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 20:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XHovI7u5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfAGUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 15:11:27 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50112 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbfAGUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 15:11:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07KBKrO061451;
        Mon, 7 Jan 2019 14:11:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546891880;
        bh=trZi1rH169tVNcr6CKTWDgZR9JLWMo41ni/puwD7xnw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XHovI7u5/0FsjuN6eGCmbviH4IOVp7CvlslXYNjk0K/TO8M+8TRbEXO0u1qzd01sY
         vXPhokI7luJtBndsqAKrCLI1M+8jjIeQ9NLHrra+PJD2QaonqaeXMZdiJNzMureDv3
         4AFMBTnWtb1ZPAAOLCffYx5YQXvpAfwrxu0W195M=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07KBKUA088437
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 14:11:20 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 14:11:19 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 14:11:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07KBJgh015988;
        Mon, 7 Jan 2019 14:11:19 -0600
Date:   Mon, 7 Jan 2019 14:11:19 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <od@zcrc.me>
Subject: Re: [PATCH 4/4] usb: musb: jz4740: Drop dependency on
 USB_OTG_BLACKLIST_HUB
Message-ID: <20190107201119.GD25910@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
References: <20181213144555.24031-1-paul@crapouillou.net>
 <20181213144555.24031-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181213144555.24031-4-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please use the following subject instead.

	usb: musb: Kconfig: Drop dependency on USB_OTG_BLACKLIST_HUB for jz4740

Regards,
-Bin.

On Thu, Dec 13, 2018 at 03:45:55PM +0100, Paul Cercueil wrote:
> The USB IP in the JZ4740 SoC does not support host mode, only gadget
> mode.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/musb/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 6f5b0ed6a507..a884179bc3c0 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -113,7 +113,6 @@ config USB_MUSB_JZ4740
>  	depends on NOP_USB_XCEIV
>  	depends on MIPS || COMPILE_TEST
>  	depends on USB_MUSB_GADGET
> -	depends on USB_OTG_BLACKLIST_HUB
>  
>  config USB_MUSB_AM335X_CHILD
>  	tristate
> -- 
> 2.11.0
> 
