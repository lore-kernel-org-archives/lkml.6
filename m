Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1475733-1520897394-2-16759127969377057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520897393; b=SpqFxyizWPBpImkuMeD+bu0o1FCcr5cclc/n2SxRg6a7htN
    GSntoGQ58hhINW3n6Z4hluIFZMeOFpyj4snujMYihRN3NlUl2oy+BnGH3wsFr3wD
    OCTV8cEayw9lLSbW9GuODcRQj/j29kimWHxQulnxROwT7aXXAV5LhIMSVxqVYEs5
    SB/hCXSp52krpWqZSSRYQPS5xwv2LNqMCEgWSVmkN4J3oANy58uXVE32Wyv3gcYs
    J4r7VhITUqTxnFeKu6i8JE04r9Ty6i3UGGgYEm3krDAYFNhlhfMeJv0BWPzPPfsh
    981oYE2N2LL1CENPatKaeFBVcMt6F5gBoi7A2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520897393; bh=41ERyf7rkIL7EM2y6+sUbCT3K+MqokPOEIoA2HzeGHw=; b=J
    5CLJT52yZaxVN6x7sZCDBm7Fxv3dsoQPYQX5L77P6zvU4gZATeY3t92cNAcBsurd
    eENwpYUeIHTrfSRbscFQ2voi03EFboPutERrFKabpNg97n6gU3RzTNAGZOOQ46EN
    phnsnBFd8HLJefTdgczjXSnVR224gD2dqO9Gn691IodKyPWe0KVw6xXfG5AHveym
    gSGflVBftGUeE3zp+wyIB7B5jKkLI4aBI3rtDB4RxehwjHVLDLbTExLg6H0tukvI
    hglT/YpusSGYD2Ivo+Y+2x27OjDR+erj/K9m1vCe4q6Qzt032T/L/Tiur+DjtWxO
    +1QWStfVTYGl6QQb5y9YQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeCLX3i (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 19:29:38 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56541 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932303AbeCLX3i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 19:29:38 -0400
Message-ID: <1520897374.23626.82.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 13/36] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 12 Mar 2018 23:29:34 +0000
In-Reply-To: <20180310001807.970379538@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
         <20180310001807.970379538@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Adam Ford <aford173@gmail.com>
> 
> commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.
> 
> The pinmuxing was missing for I2C1 which was causing intermittent issues
> with the PMIC which is connected to I2C1.  The bootloader did not quite
> configure the I2C1 either, so when running at 2.6MHz, it was generating
> errors at time.
> 
> This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz
> 
> Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
> DM3730 devkit")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> +++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
> @@ -90,6 +90,8 @@
>  };
>  
>  &i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
>  	clock-frequency = <2600000>;
>  
>  	twl: twl@48 {
> @@ -146,6 +148,12 @@
>  			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
>  		>;
>  	};
> +	i2c1_pins: pinmux_i2c1_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
> +			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
> +		>;
> +	};

This is being added under &omap3_pmx_core2, but upstream it was added
under &omap3_pmx_core.  Does that matter?

Ben.

>  };
>  
>  #include "twl4030.dtsi"
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
