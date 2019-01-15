Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D48C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91EC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jx8Xwuax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfAOOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:37:48 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40684 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfAOOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:37:48 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEbj5G109206;
        Tue, 15 Jan 2019 08:37:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547563065;
        bh=FQceNvW9q7O9tBpyTdgvcl7LsaJHbBc8PAP+ckzOx2c=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Jx8Xwuaxu2C2zNMlzcdnAOBKWsGkiVu0liYCW+8EAEfGNhytB0RnDfdJ5nc/gJG9t
         MKbpbMVnHiamVKTdMF12FqHjq1DVY3keTGsScCcn15uxTxe98V228NCot0vgsHP4fK
         SmBbKZ0YeGPJtJ6Gr7i+ZWQB86ZF3072TsudObtI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEbjLr033438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:37:45 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:37:44 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:37:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEbiDC007687;
        Tue, 15 Jan 2019 08:37:44 -0600
Date:   Tue, 15 Jan 2019 08:37:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-am654-base-board: enable USB1
Message-ID: <20190115143712.hb2ogjcjxwokkioa@kahuna>
References: <1547200861-17795-1-git-send-email-rogerq@ti.com>
 <1547200861-17795-4-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547200861-17795-4-git-send-email-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:01-20190111, Roger Quadros wrote:
> Add pinmux for USB1 and enable it as a dual role port.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index e41fc3a..c4f7b29 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -69,6 +69,12 @@
>  			AM65X_IOPAD(0x01bc, PIN_OUTPUT, 0) /* (AG13) SPI0_CS0 */
>  		>;
>  	};
> +
> +	usb1_pins_default: usb1_pins_default {
> +		pinctrl-single,pins = <
> +			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0) /* (AC8) USB1_DRVVBUS */
> +		>;
> +	};
>  };
>  
>  &main_pmx1 {
> @@ -163,3 +169,17 @@
>  		#size-cells= <1>;
>  	};
>  };
> +
> +&dwc3_1 {
> +	status = "okay";
> +};
> +
> +&usb1_phy {
> +	status = "okay";
> +};

NAK -> we dont do status = "okay" in ARMV8.

> +
> +&usb1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb1_pins_default>;
> +	dr_mode = "otg";
> +};
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

-- 
Regards,
Nishanth Menon
