Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B3EC65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBE02084D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBE02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJFU4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:56:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeJFU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:56:31 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8n0v-0001s1-FA; Sat, 06 Oct 2018 15:53:01 +0200
Date:   Sat, 6 Oct 2018 15:53:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
cc:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] irqchip updates for 4.20
In-Reply-To: <20181005112956.70943-1-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.21.1810061547480.5454@nanos.tec.linutronix.de>
References: <20181005112956.70943-1-marc.zyngier@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On Fri, 5 Oct 2018, Marc Zyngier wrote:
> Here's the set of irqchip updates for 4.20. On the menu this time,
> support for the Marvell SEI and Cirrus Logic Madera interrupt
> controllers, support for kexec on GICv3 system, as well as a few
> fixes and cleanups.
> 
> Note that the GICv3/kexec stuff depends on some EFI updates. The whole
> branch is thus based on tip/efi/irqchip which Ingo has created for
> this purpose.
> 
> Please pull,

Done, but

> Richard Fitzgerald (1):
>       irqchip: Add driver for Cirrus Logic Madera codecs

This one breaks the build because MADERA_IRQ is selected by MFD_MADERA, but
the updates to the header file are not yet upstream. It works against next
but not standalone. Breaks allyes/allmod/randconfig builds

So this commit needs to go through MFD along with the other related
changes. I zapped it from irq/core already.

Thanks,

	tglx

