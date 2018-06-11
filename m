Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FjQJERoIHlu9DwAAmS7hNA
	; Mon, 11 Jun 2018 05:26:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24B3D607BB; Mon, 11 Jun 2018 05:26:50 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBw14oOf"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A777C60791;
	Mon, 11 Jun 2018 05:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A777C60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932270AbeFKF0r (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753866AbeFKF0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:26:45 -0400
Received: from dragon (unknown [104.237.91.91])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B4C2087E;
        Mon, 11 Jun 2018 05:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528694805;
        bh=WSSzxG5lKeMx/kZPUOLbaNaoIiIumlwByMQfIx0Wqew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CBw14oOfwguEACAo4kWXnwbpHgHtfPnDFMUV1cs5+j6VCjUbm1/XvVczfXou755zN
         GVrbIPcVKt8aVGT2MvmnCUtBuZhEbPiTJ4AetcOYr1NAyAeKEOSixQwNbVWWVzT1KW
         ehTKMk3nas6pfFjRVATN+2a1Z9iWYoGVikv7JiDY=
Date: Mon, 11 Jun 2018 13:26:09 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
Message-ID: <20180611052608.GB16091@dragon>
References: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 10:19:23PM +0300, Nikita Yushchenko wrote:
> This adds rave-sp powerbutton and backlight devices to RDU1 device tree.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 0c99ac04ad08..98cc107098e0 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -581,6 +581,14 @@
>  		watchdog {
>  			compatible = "zii,rave-sp-watchdog";
>  		};
> +
> +		backlight {
> +			compatible = "zii,rave-sp-backlight";
> +		};
> +
> +		pwrbutton {
> +			compatible = "zii,rave-sp-pwrbutton";
> +		};

Where are these compatibles documented?

Shawn

>  	};
>  };
>  
> -- 
> 2.11.0
> 
