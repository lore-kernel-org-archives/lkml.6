Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153EBC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5167222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090432;
	bh=AwnvFJ5lQw1T3XpLJa2QC+USSPca5jx6hi09RGW5/MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WmS+6+FdK91pmbwdqgO7VneKN+PI8aF8+7dtfXfN/2YbIIx7NeT0U2EZsPX1HR2kj
	 wFmp5jF+uikgHwyH2xgaOfnBboEU3QN4/hkfAPMKLgBo03VRkZnFfhKn+Ae5EeIXBr
	 7Qe6/fbq3IA6tVSgAyeZneaKTNdUdU7+K1T1icXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbfBMUkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:40:32 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38870 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfBMUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:40:31 -0500
Received: by mail-ot1-f67.google.com with SMTP id m1so6679455otf.5;
        Wed, 13 Feb 2019 12:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TQCmFVh7Tf8A1zsUWhrcyFMJXEj/kwdqYS8gaLBDDSc=;
        b=YlXD5nusrDAgLBB2y2cAUPVCeiN5AaiMflwCojIid0XdB2LzKhKVha6dJRerPoRnM+
         LISbQ/RocIga9cV9AQYDXth9lFAA6gtoffmrfj6LsG4gO27uZEBkKf5SH5n7G/n/EQNZ
         Gts2NzHe+zhMBDMdJQn6PMvBG1vzaPIs/emrHI2gz6+f1qtaEb9QpAX4+O3ytHMmgPgy
         7qcc5pTYwkNBNO5RwCfySgoj3GPznC4tMUUxuTQaK7DPicScbgc0/5gVL1mq2p4lAZTU
         sEDkBUdSL6i3UNPsCbcZsGCBMNUU2Z+x6yIUyYioxfZLn49aX6cunsr9HZM1m9Ips7Cb
         spYQ==
X-Gm-Message-State: AHQUAub5+c9FyZS/jtTSbjNlAoMTwsfI7jY+fbeMnWrqVBivoCqaDGXs
        1gQaAQMqv/9QW16WCUutHg==
X-Google-Smtp-Source: AHgI3IZG0LHaxabLDRsEU9UeCQEGHEoY1poG7lMssDJzvqEgLQhT8FNOv5iqsXNv9RhUgSXx3KCPGg==
X-Received: by 2002:a05:6830:1292:: with SMTP id z18mr11015otp.161.1550090430244;
        Wed, 13 Feb 2019 12:40:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x19sm125148otp.10.2019.02.13.12.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:40:29 -0800 (PST)
Date:   Wed, 13 Feb 2019 14:40:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, marc.zyngier@arm.com,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
Message-ID: <20190213204023.GA21941@bogus>
References: <20190212074237.2875-1-lokeshvutla@ti.com>
 <20190212074237.2875-6-lokeshvutla@ti.com>
 <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213152620.GS5720@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:26:20AM -0800, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190213 04:26]:
> > Hi Tony,
> > 
> > On 12/02/19 9:52 PM, Tony Lindgren wrote:
> > > Hi,
> > > 
> > > * Lokesh Vutla <lokeshvutla@ti.com> [190212 07:43]:
> > >> +Example:
> > >> +--------
> > >> +The following example demonstrates both interrupt router node and the consumer
> > >> +node(main gpio) on the AM654 SoC:
> > >> +
> > >> +main_intr: interrupt-controller0 {
> > >> +	compatible = "ti,sci-intr";
> > >> +	interrupt-controller;
> > >> +	interrupt-parent = <&gic500>;
> > >> +	#interrupt-cells = <4>;
> > >> +	ti,sci = <&dmsc>;
> > >> +	ti,sci-dst-id = <56>;
> > >> +	ti,sci-rm-range-girq = <0x1>;
> > >> +};
> > > 
> > > Can you describe a bit what the "ti,sci-dst-id" is above?
> > > 
> > > These IDs seem to be listed at at [0] below, but is it really a property
> > > of the hardware? Or is it some enumeration of SoC devices in the firmware?
> > 
> > This is the way that sysfw describes the hardware. In this case it is GIC and it
> > is identified by this ID.
> 
> If this ID is an enumeration in the sysfw rather than an actual
> hardware property it should not be in the device tree. If so,
> the device driver should request the id from the sysfw based
> on a name. That is, if no struct device or device phandle can
> be used.
> 
> The problem with using enumeration in the dts is that it
> requires maintaining the dts, driver(s) and possibly firmware
> in sync. And that might change between SoCs variants when new
> devices get added and removed.

IOW, don't repeat h/w designers mistakes and make your firmware 
discoverable. We have DT only for what is not discoverable.

Rob
