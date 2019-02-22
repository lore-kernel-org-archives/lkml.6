Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8951FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAB20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550879073;
	bh=m7Ornpsku7HeG15/RElbPkdeG8XvWAjGwQVizjmEUwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L6Di+qDPrjngU8nltpRRdMTH/5LcsK1QyK1P+xyzrT70wkcXQGEavWX3oUJiLENUZ
	 Dwy0YMhKo/XAHP732teDx3qN74WO97GGDsTCgkXcL5Bi1fmrENEnTYG4+KCbgBySD+
	 ufTWbKz7DFvpb8rhPwyKiFqPLnLyDu6mpBGDLhdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfBVXob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:44:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45414 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVXob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:44:31 -0500
Received: by mail-oi1-f193.google.com with SMTP id t82so3055382oie.12;
        Fri, 22 Feb 2019 15:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TsMu8Tc0IV0e0muIODVfZM/XsSXkFmUhOoNfZ/p2zng=;
        b=YFe6kVLpZWBK6PcOZrFsXT3XHr2C4WJxNJPzdQqr9Syrij3yYQjHGdwnLjuz+3r8rM
         m6NTXXM1pXacWFYnXwQPYIeHzQmQ4Sl5riXtHZuDC4IBENp99p1Xv3SyPLpL+xBxpV4w
         L9CC91QqYYhxpXMa/5fvgDifISh3HNaZ4+KH52F5Y8U1tNeXdjZKjHOIkYo1ZF/Z1tcF
         s2WugKPn9uUhApPIl8Da5rK25aOjvZXrtSuEK9WSwOy3UgaYeIzIFytEWQVE+HJZd3w6
         QtdU+eTRs+MCnfPT4kN8zt3JUWWQDdazl6N9KR+AyC+wTlHR4cXk16Z/mhYh6diNV1V4
         M0mA==
X-Gm-Message-State: AHQUAuansm1SthLlN6zdC71kH6bJi1fEMrSynzTGtjK9E5JHM7vOBH71
        368eykHWWoG8Gr1My9H2Og==
X-Google-Smtp-Source: AHgI3IaoEebKMVS5eyOUh7mTHzoNK33m8zVNkovRGt1f0X7257zf1G2hI/irS//xNro7MehjmN77lA==
X-Received: by 2002:aca:7290:: with SMTP id p138mr4075438oic.116.1550879070582;
        Fri, 22 Feb 2019 15:44:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m89sm1163009otc.7.2019.02.22.15.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:44:29 -0800 (PST)
Date:   Fri, 22 Feb 2019 17:44:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com, jslaby@suse.com,
        corbet@lwn.net, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] serial: core: add rs485-rts-delay-us devicetree
 property for RS485
Message-ID: <20190222234429.GA19985@bogus>
References: <20190221171758.10322-1-martin.kepplinger@ginzinger.com>
 <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221171758.10322-3-martin.kepplinger@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 06:17:52PM +0100, Martin Kepplinger wrote:
> struct serial_rs485 now optionally holds the rts delay values in
> microseconds. Users can set these delays in their devicetree descriptions,
> so this adds the microseconds-option with the "rs485-rts-delay-us" boolean
> property.

If it has a value, it's not boolean.

Should the old prop be deprecated?

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.txt |  1 +
>  drivers/tty/serial/serial_core.c                   | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
> index b92592dff6dd..77396c62b383 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.txt
> +++ b/Documentation/devicetree/bindings/serial/rs485.txt
> @@ -12,6 +12,7 @@ Optional properties:
>    * b is the delay between end of data sent and rts signal in milliseconds
>        it corresponds to the delay after sending data and actual release of the line.
>    If this property is not specified, <0 0> is assumed.
> +- rs485-rts-delay-us: the same as rs485-rts-delay, but in microseconds.
>  - rs485-rts-active-low: drive RTS low when sending (default is high).
>  - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
>    feature at boot time. It can be disabled later with proper ioctl.
