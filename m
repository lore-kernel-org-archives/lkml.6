Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064E1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436020844
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548878039;
	bh=eti9CeJAmWpw5OvvVyvDa3+VHxSwGAN1fDk3DR1H75E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0X83oVA5tKQHlLUVPuZkZc6Qw+4fDPTtz3EklFejJLHQg4xqB6u/EkgzaEtZtjdDz
	 TXcmNSEIr94HfTRospUxBBn2aZJKPcMJw7TS7XQ5nKfwtdoYUB1c6N78CiFIav4Ned
	 pjXmqpn4FObWpHf7HFx7WuhM99OaBSTCJHVSX+4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfA3Tx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:53:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43811 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3Tx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:53:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so667858oie.10;
        Wed, 30 Jan 2019 11:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=luO45oTOWLznaLwqm9yVxe7pJFQCo4Ni5EhYDjDDZo4=;
        b=BDT/RR1sXOB8baOJ1xi0798asKr4R3NIsNmyNMQrLvg9KZ+JsPeutAtV9MFxlXrtPe
         hjTvx7yz0Gtvx9u+mdFgGeNTnveNxzFjrRVc43sF/aLzMNoGYcRgtApTCywL3MdfWjaT
         3HFKQfnx4+8b+qjJPaNT0KV3gUS3ROlLm5szrlqu7Ne4WyHtb6ql206MxKXfwTaZXD6H
         SFnLdx8Ewel9f454P8C6atYBj81Q+pRt8xX+UTUvBM9JO6dXs1+O08rlS+CUd19tuodX
         bTjkvo2vwxZA2cPtLGoJ6vPiR0PtevE14hGW34gDpAPFAjTpHxwIj3nWcxsVt6sXsVsC
         SmsA==
X-Gm-Message-State: AHQUAuY2SbfWPrT1UkrWm9RJQOTz+H7FX3fj8DZWOFhuhNFizHKOLbVw
        XeBvNUJc2UBt786He3wvRg==
X-Google-Smtp-Source: AHgI3IbpedcSYbsEqtIjTDOqlk68rPUdh6kaOFqTSW58BTXcFUgezC8N80bJoFXFuZ78ENeWVcc68A==
X-Received: by 2002:aca:1918:: with SMTP id l24mr1473331oii.236.1548878036874;
        Wed, 30 Jan 2019 11:53:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 127sm1052663oid.36.2019.01.30.11.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:53:56 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:53:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Zhang <markz@nvidia.com>
Cc:     lee.jones@linaro.org, blaws05@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mfd: max77620: add documentation for low battery
 monitoring
Message-ID: <20190130195355.GA1652@bogus>
References: <20190129085531.32364-1-markz@nvidia.com>
 <20190129085531.32364-5-markz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129085531.32364-5-markz@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 04:55:31PM +0800, Mark Zhang wrote:
> Adding documentation for low battery monitor properties:
> - maxim,low-battery-dac-enable
> - maxim,low-battery-dac-disable
> - maxim,low-battery-shutdown-enable
> - maxim,low-battery-shutdown-disable
> - maxim,low-battery-reset-enable
> - maxim,low-battery-reset-disable
> 
> Signed-off-by: Mark Zhang <markz@nvidia.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77620.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documentation/devicetree/bindings/mfd/max77620.txt
> index 484b17e4fba5..5fed0a463b80 100644
> --- a/Documentation/devicetree/bindings/mfd/max77620.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77620.txt
> @@ -142,6 +142,20 @@ Optional properties:
>  			Device supports 100/1000/3000/6000 Ohms.
>  			Default will be set to 1000 Ohm.
>  
> +Low-Battery Monitor:
> +==================
> +This sub-node configure low battery monitor configuration registers. Device has
> +support for low-battery monitor configuration through child DT node
> +"low-battery-monitor".
> +
> +Optional properties:
> +	- maxim,low-battery-dac-enable: Enable low battery DAC.
> +	- maxim,low-battery-dac-disable: Disable low battery DAC.
> +	- maxim,low-battery-shutdown-enable: Enable low battery shutdown.
> +	- maxim,low-battery-shutdown-disable: Disable low battery shutdown.
> +	- maxim,low-battery-reset-enable: Enable low battery reset.
> +	- maxim,low-battery-reset-disable: Disable low battery reset.

Do you really need 3 states with the 3rd being prop not present.

Rob
