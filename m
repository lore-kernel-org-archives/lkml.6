Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBAAC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD9E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD9E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeGKN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:28:54 -0400
Received: from muru.com ([72.249.23.125]:51070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387804AbeGKN2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:28:54 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A92B809B;
        Wed, 11 Jul 2018 13:27:38 +0000 (UTC)
Date:   Wed, 11 Jul 2018 06:24:31 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates
 of BTB) for secondary cores
Message-ID: <20180711132431.GK99251@atomide.com>
References: <20180710194725.20339-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710194725.20339-1-nm@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [180710 12:50]:
> Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
> ICIALLU) when branch hardening is enabled for kernel.
> 
> On GP devices OMAP5/DRA7, there is no possibility to update secure
> side since "secure world" is ROM and there are no override mechanisms
> possible. On HS devices, appropriate PPA should do the workarounds as
> well.
> 
> However, the configuration is only done for secondary core, since it is
> expected that firmware/bootloader will have enabled the required
> configuration for the primary boot core (note: bootloaders typically
> will NOT enable secondary processors, since it has no need to do so).

Thanks for updating this. Seems like we should merge this into v4.18-rc
cycle as without this the already merged fixes are incomplete.
So if no objections, I'm planning to apply this tomorrow.

Regards,

Tony
