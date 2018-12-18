Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B279C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26009217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545152621;
	bh=yMByLnbTs572AUCg1FGnvOxRCEM8PeAKFlDMq0heK7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zxT3hxnGwIUzXCuWjQBOU2BxhGFtuOCi8hIWZLLdacryMASBswyAByVIlyVik21Sf
	 4I7PhdgJyBcN3ueqKXS7aEMBKIX2vqR+Q5FetkHS1Bqt340IgbQPes2Xne8dP2JSuF
	 sWmrSXP4uQ/AzjrAvqZ1OoBGTeYvqbwAJS1UUPJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeLRRDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:03:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37093 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:03:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so2543344oia.4;
        Tue, 18 Dec 2018 09:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ta9uqWuRF9HSrsEjvZP6GAVGaMXo88p/gAL5HC+mQXo=;
        b=hIDJDvVKXp2845n+jFdVVWsNKIZviVZL7HCc/ibrXOQQNhgrzjT+/J0sIL6gCV79W+
         tSuzLad+f0CpKSvNuZoIgniy4BvVDu+dj/gbyIDeBXQV7t5NOV8LHk+0H4uxDpbDEBkR
         9czUe/VhL+Ea7qrLXhlGpCf0fY69v2CFqBJWq34AdKKbSbYirjf8WUYBDmM3RU3g9CWQ
         pBJi3kKlbufzUeTe9uQgiBqk72sHbA2JRF1pWFF2sQyo94m2RqXgzKPpL3i2zorAPlkD
         5wNatZPeRJuqR4nwe0VLB+29MPNbfhu3lfi5hvF/XApnu4X4EGT/NcnsjRbh4m8cs7wN
         C0mw==
X-Gm-Message-State: AA+aEWbZb5hJH5mR/AcpPkahbNTuiWIgIYcftIvsT12kW3cObH29u3uF
        2TuDHg2vM/eXVqBHUXASgQ==
X-Google-Smtp-Source: AFSGD/WGnzZJl3xNK+uN6pH5BGDBuW/hYTBBahT9cml5Bl8vQ4LiheKqVB0L4yvzLWaSv7bIkay5bw==
X-Received: by 2002:aca:6c4:: with SMTP id 187mr6746120oig.290.1545152618881;
        Tue, 18 Dec 2018 09:03:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm3102765otk.51.2018.12.18.09.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 09:03:38 -0800 (PST)
Date:   Tue, 18 Dec 2018 11:03:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jacky Bai <ping.bai@nxp.com>
Cc:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 1/2] Doc: bindings: Add binding doc for nxp system
 counter timer
Message-ID: <20181218170337.GA3394@bogus>
References: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544592770-19996-1-git-send-email-ping.bai@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 05:28:23AM +0000, Jacky Bai wrote:
> Add the binding doc for nxp system counter timer module.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> change v1->v2
>  - remove the blank line at EOF
> ---
>  .../devicetree/bindings/timer/nxp,sysctr_timer.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt b/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
> new file mode 100644
> index 0000000..21f1527
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr_timer.txt
> @@ -0,0 +1,26 @@
> +NXP System Counter Module(sys_ctr)
> +
> +The system counter(sys_ctr) is a programmable system counter which provides
> +a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for use in
> +applications where the counter is always powered and support multiple,
> +unrelated clocks.
> +
> +Required properties:
> +
> +- compatible :      should be "nxp,sysctr-timer"

Only 1 version? Should be SoC specific.

> +- reg :             Specifies the base physical address and size of the comapre

s/comapre/compare/

> +                    frame and the counter control, read & compare.
> +- interrupts :      should be the compare frames' interrupt
> +- clock-frequency : Specifies the counter clock frequency.
> +
> +Example:
> +
> +	system_counter: timer@306a0000 {
> +		compatible = "nxp,sysctr-timer";
> +		reg = <0x0 0x306a0000 0x0 0x10000>, /* system-counter-rd base */
> +		      <0x0 0x306b0000 0x0 0x10000>, /* system-counter-cmp base */
> +		      <0x0 0x306c0000 0x0 0x10000>; /* system-counter-ctrl base */

Are these really 64K in length? That wastes virtual space which can be 
important on 32-bit systems.

> +		clock-frequency = <8000000>;
> +		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 1.9.1
> 
