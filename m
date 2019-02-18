Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD987C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867F721773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550517535;
	bh=AIz5w6ZrFSR+8siQtIIJos8b1wGfQR7Iaz3jNTdiMSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ygLj+Np59LI2JSwDNBpyQGz40xZkgntaMwJLZa6+FWkVrjdYogUfgVx/TC9tQuI0r
	 +9gCCCw0f1ipJ3f/vtkwlznmDxawCKH8FwmsimWsxdNNsDi3KH/2iGjQlMM6J7cyLz
	 NcnF7qey0HWrpZUWT8vrT5LIgSvhho9uUdCiW88s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfBRTSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:18:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36075 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfBRTSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:18:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id v62so21286815otb.3;
        Mon, 18 Feb 2019 11:18:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W39jONSIIz31Rzrkgl43XEJB24YV1hoz4JWOKqmfsso=;
        b=KgnOrjfUTKC4mIU2tmKUXzXoUMM/q46D4HTTsVFtE6WOb1iaVsrby23REwkHIjLb88
         1LwvKeRaHQVqeFMiFl1aRMyaS3jx7ih87GEX/gvSwrBck8nJO5hMtvHCx+xDYBs1SoWA
         tKecGqodXRez6G5vJPx8F1L6FWHmpgVzyXXwglmoeL6yXwgJ7x3Q629WANWxL6fCoS2e
         79miEUtTE/MNb7IQZ78yzKUpxBAjU7GiHdy996tpo2EoBRdVBfLbvbeiMbstJZhPOJ3b
         axiYEbmLjNwSlsNNh9cj5YLsTRsL5qzbUkk/iCo83uovypfybNPNDmIP5uwUcEfZOPSG
         +o1g==
X-Gm-Message-State: AHQUAubkS5C+0zMarhKXnzPZeG44vfwoEVDgvxqNGnv1HSJpHd3F8rIm
        BNdF2E1nv9ZjRFEq0z3IMg==
X-Google-Smtp-Source: AHgI3IbrncYXFohfXd9UO/3rZ6er3ITdPJ+fMz8wI3bHu1+YclYIfrH69k9t9fI1EI/ibFKGMaXNNA==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr15592887oto.125.1550517531722;
        Mon, 18 Feb 2019 11:18:51 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a62sm11226982otb.72.2019.02.18.11.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:18:50 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:18:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, mark.rutland@arm.com, xc-racer2@live.ca,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: input: Add binding for bma150 sensor
Message-ID: <20190218191850.GA31221@bogus>
References: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
 <20190202151806.9064-2-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190202151806.9064-2-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2019 at 04:18:02PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Add device tree bindings for Bosch BMA150 Accelerometer Sensor
> 
> Changes from v1:
>  - Add properties for all of bma150_cfg
>  - Correct IRQ type in example
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  .../bindings/input/bosch,bma150.txt           | 38 +++++++++++++++++++
>  include/dt-bindings/input/bma150.h            | 22 +++++++++++
>  include/linux/bma150.h                        | 13 +------
>  3 files changed, 62 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
>  create mode 100644 include/dt-bindings/input/bma150.h
> 
> diff --git a/Documentation/devicetree/bindings/input/bosch,bma150.txt b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> new file mode 100644
> index 000000000000..f644d132f79c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/bosch,bma150.txt
> @@ -0,0 +1,38 @@
> +* Bosch BMA150 Accelerometer Sensor
> +
> +Also works for the SMB380 and BMA023 accelerometers
> +
> +Required properties:
> +- compatible : Should be "bosch,bma150"
> +- reg : The I2C address of the sensor
> +
> +Optional properties:
> +- interrupt-parent : should be the phandle for the interrupt controller

This is implied and can be dropped.

> +- interrupts : Interrupt mapping for IRQ.  If not present device will be polled

> +- any-motion-int : bool for if the any motion interrupt should be enabled
> +- hg-int : bool for if the high-G interrupt should be enabled
> +- lg-int : bool for if the low-G interrupt should be enabled
> +- any-motion-cfg : array of integers for any motion duration and threshold
> +- hg-cfg : array of integers for high-G hysterisis, duration, and threshold
> +- lg-cfg : array of integers for low-G hysterisis, duration, and threshold
> +- range : configuration of range, one of BMA150_RANGE_* as defined in [1]
> +- bandwidth : refresh rate of device, one of BMA150_BW_* as defined in [1]

These all need vendor prefixes if they stay.

What determines all this configuration? It seems like a user may want to 
change at run-time in which case sysfs would be more appropriate.

I don't recall seeing other accelerometers with these, but seems these 
could apply to other accelerometers. In which case, they should be 
common.

> +
> +Example:
> +
> +bma150@38 {

accelerometer@38

> +	compatible = "bosch,bma150";
> +	reg = <0x38>;
> +	interrupt-parent = <&gph0>;
> +	interrupts = <1 IRQ_TYPE_EDGE_RISING>;
> +	any-motion-int;
> +	hg-int;
> +	lg-int;
> +	any-motion-cfg = <0 0>;
> +	hg-cfg = <0 150 160>;
> +	lg-cfg = <0 150 20>;
> +	range = <BMA150_RANGE_2G>;
> +	bandwidth = <BMA150_BW_50HZ>;
> +};
> +
> +[1] include/dt-bindings/input/bma150.h
> diff --git a/include/dt-bindings/input/bma150.h b/include/dt-bindings/input/bma150.h
> new file mode 100644
> index 000000000000..fb38ca787f0f
> --- /dev/null
> +++ b/include/dt-bindings/input/bma150.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides bindings for the BMA150 accelerometer
> + */
> +#ifndef _DT_BINDINGS_INPUT_BMA150_H
> +#define _DT_BINDINGS_INPUT_BMA150_H
> +
> +/* Range */
> +#define BMA150_RANGE_2G		0
> +#define BMA150_RANGE_4G		1
> +#define BMA150_RANGE_8G		2
> +
> +/* Refresh rate */
> +#define BMA150_BW_25HZ		0
> +#define BMA150_BW_50HZ		1
> +#define BMA150_BW_100HZ		2
> +#define BMA150_BW_190HZ		3
> +#define BMA150_BW_375HZ		4
> +#define BMA150_BW_750HZ		5
> +#define BMA150_BW_1500HZ	6
> +
> +#endif /* _DT_BINDINGS_INPUT_BMA150_H */
> diff --git a/include/linux/bma150.h b/include/linux/bma150.h
> index 97ade7cdc870..b85266a9c35c 100644
> --- a/include/linux/bma150.h
> +++ b/include/linux/bma150.h
> @@ -20,19 +20,10 @@
>  #ifndef _BMA150_H_
>  #define _BMA150_H_
>  
> -#define BMA150_DRIVER		"bma150"
> +#include <dt-bindings/input/bma150.h>
>  
> -#define BMA150_RANGE_2G		0
> -#define BMA150_RANGE_4G		1
> -#define BMA150_RANGE_8G		2
> +#define BMA150_DRIVER		"bma150"
>  
> -#define BMA150_BW_25HZ		0
> -#define BMA150_BW_50HZ		1
> -#define BMA150_BW_100HZ		2
> -#define BMA150_BW_190HZ		3
> -#define BMA150_BW_375HZ		4
> -#define BMA150_BW_750HZ		5
> -#define BMA150_BW_1500HZ	6
>  
>  struct bma150_cfg {
>  	bool any_motion_int;		/* Set to enable any-motion interrupt */
> -- 
> 2.17.1
> 
