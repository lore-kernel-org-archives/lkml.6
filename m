Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69DC2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69DC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeK1FQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:16:33 -0500
Received: from muru.com ([72.249.23.125]:55378 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeK1FQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:16:33 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EFE978030;
        Tue, 27 Nov 2018 18:17:50 +0000 (UTC)
Date:   Tue, 27 Nov 2018 10:17:46 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Belisko Marek <marek.belisko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Message-ID: <20181127181746.GU53235@atomide.com>
References: <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
 <20181126102541.GC10878@ulmo>
 <20181126193212.GN53235@atomide.com>
 <149b3b6b-e52e-4942-151b-6df4358f5a7a@nvidia.com>
 <20181127175538.GS53235@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127175538.GS53235@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181127 17:55]:
> The only option that works for omap5 at palmas end is if
> PALMAS_POLARITY_CTRL_INT_POLARITY is cleared. Setting the SoC internal
> pulls does not make a difference, so I suspect there is either some
> unknown pull-up/pull-down configuration register in palmas, or there
> is an external pull resistor.

Remuxing the palmas interrupt to gpio_wk16 instead of sys_nirq1
makes the palmas interrupt work just fine configured with active-low
or active-high with the internal pulls. So palmas.c is doing the
right thing, and the issue configuring palmas interrupt active-high
with sys_nirq1 on omap5 is somewhere between omap wkupegen and GIC.

Regards,

Tony
