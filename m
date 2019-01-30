Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EC3C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C189720989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877918;
	bh=iP674ZRwjYY+vhP/tNNMNsve6/TewiWz92Acrg/R/eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FYbiJTo+NSuZv2CqhmUBG7dUdk4+dneKfSIqGflI3DATDUSBZjzllORZsaulWGKev
	 xPeUxPbs9oAZ/nulJvpi1qh1KIY8gvFj9mO5sB/z2MjJmHbDtIb/+uNWubgLB9eF0E
	 F0Vhceju0fnf+MdpRVuxz1x7XmvklfgmMT4lU5dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfA3Tv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:51:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42391 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbfA3Tv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so679107otk.9;
        Wed, 30 Jan 2019 11:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=accF2Dx2QsBd1NpKNNaf3Vid/ud9NW3DD+P3HmP/5iA=;
        b=h0/yf8vUzwtI/0gH1ePt5bl/wzBU2ZvUTCBp7oWe1nJ+r9L+1jOttnbY+KM2sYxI6o
         yi13HDPctDK02ek9ZaWjq1THziRAJFr9RRIrqgFEkqFT//PVAhHWrHspqcR+WolWWDrJ
         8F4Tii19Zbpi7rEZJL6pCDH0O8qne7Ryt6AHZ1ptQn5cIVpzQZPRW4TWKLvRrhkWDGST
         V2gtUFsVJE8UWQrEE77Iw/yXWunAjCWErlRVp3Be8HKHkZqDxkCePyvvDuhinRuFXGtm
         xEvfVIrl2x94UwsCx6VigN2XYuMOEziQSr5NXUHYKjFMuD+5EhrSWv4JcbA+ZE+cvirt
         1FIw==
X-Gm-Message-State: AJcUukcKGRG5hkcHOliTXYlM1ktk4mCruD1HjydvQ2wZ3wPgksJjLudm
        GvxifyvNrgfDCZwgEpboug==
X-Google-Smtp-Source: ALg8bN5+IIsrksM1hq67TY+8wPShDXAX29kvp3VrZ/GiKRydnWDhiD9rDuRfl3WilzIm1gJjH9pQFw==
X-Received: by 2002:a05:6830:1649:: with SMTP id h9mr22194277otr.292.1548877915586;
        Wed, 30 Jan 2019 11:51:55 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u136sm1044689oie.38.2019.01.30.11.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:51:54 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:51:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     lee.jones@linaro.org, blaws05@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mfd: max77620: add documentation for backup
 battery charging
Message-ID: <20190130195154.GA30939@bogus>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190129085531.32364-3-markz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129085531.32364-3-markz@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:55:29PM +0800, Mark Zhang wrote:
> Adding documentation for 3 new backup battery charging dts
> properties:
> - maxim,backup-battery-charging-current
> - maxim,backup-battery-charging-voltage
> - maxim,backup-battery-output-resister
> 
> Signed-off-by: Mark Zhang <markz@nvidia.com>
> ---
>  .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> index 9c16d51cc15b..484b17e4fba5 100644
> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -122,6 +122,26 @@ For DT binding details of different sub modules like GPIO, pincontrol,
>  regulator, power, please refer respective device-tree binding document
>  under their respective sub-system directories.
>  
> +Backup Battery:
> +==============
> +This sub-node configure charging backup battery of the device. Device has
> +support of charging the backup battery. The subnode name is "backup-battery".
> +The property for backup-battery child nodes as:
> +Presence of this child node will enable the backup battery charging.
> +
> +Optional properties:
> +	-maxim,backup-battery-charging-current: Charging current setting.
> +			The device supports 50/100/200/400/600/800uA.
> +			If this property is unavailable then it will
> +			charge with 50uA.
> +	-maxim,backup-battery-charging-voltage: Charging Voltage Limit Setting.
> +			Device supports 2500000/3000000/3300000/350000uV.
> +			Default will be set to 2500mV. The voltage will be roundoff
> +			to nearest lower side if other than above is configured.
> +	-maxim,backup-battery-output-resister: Output resistor on Ohm.
> +			Device supports 100/1000/3000/6000 Ohms.
> +			Default will be set to 1000 Ohm.

These need property unit suffixes as defined in property-units.txt. The 
names are kind of long, so perhaps shorten them a bit.

> +
>  Example:
>  --------
>  #include <dt-bindings/mfd/max77620.h>
> -- 
> 2.19.2
> 
