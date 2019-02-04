Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554D1C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302F52082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfBDSPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:15:23 -0500
Received: from muru.com ([72.249.23.125]:37578 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbfBDSPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:15:23 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2CC93808C;
        Mon,  4 Feb 2019 18:15:30 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:15:18 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        david@lechnology.com, nsekhar@ti.com, t-kristo@ti.com,
        nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com,
        woods.technical@gmail.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 04/14] irqchip: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Message-ID: <20190204181518.GN5720@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-5-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549290167-876-5-git-send-email-rogerq@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190204 14:23]:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.
> 
> The PRUSS INTC module is reference counted during the interrupt
> setup phase through the irqchip's irq_request_resources() and
> irq_release_resources() ops. This restricts the module from being
> removed as long as there are active interrupt users.
> 
> The PRUSS INTC can generate an interrupt to various processor
> subsystems on the SoC through a set of 64 possible PRU system
> events. These system events can be used by PRU client drivers
> or applications for event notifications/signalling between PRUs
> and MPU or other processors. An API, pruss_intc_trigger() is
> provided to MPU-side PRU client drivers/applications to be able
> to trigger an event/interrupt using IRQ numbers provided by the
> PRUSS-INTC irqdomain chip.

I suggest you send the binding patch and the interrupt
controller driver separately to the irqchip guys. Maybe
put the trigger function in to a separate patch that can
be reviewed and applied separately.

Regards,

Tony
