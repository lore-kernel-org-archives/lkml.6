Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99DCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8997F20894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8997F20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeH1USZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:18:25 -0400
Received: from muru.com ([72.249.23.125]:54840 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeH1USZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:18:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 336BA8081;
        Tue, 28 Aug 2018 16:29:51 +0000 (UTC)
Date:   Tue, 28 Aug 2018 09:25:56 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>, nsekhar@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
Message-ID: <20180828162556.GQ7523@atomide.com>
References: <20180828102642.26482-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828102642.26482-1-kishon@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180828 10:31]:
> AM65 has two PCIe controllers and each PCIe controller has '2' address
> spaces one within the 4GB address space of the SoC and the other above
> the 4GB address space of the SoC in addition to the register space. The
> size of the address space above the 4GB SoC address space is 4GB. These
> address ranges will be used by CPU/DMA to access the PCIe address space.
> In order to represent the address space above the 4GB SoC address space
> and to represent the size of this address space as 4GB, change
> address-cells and size-cells of interconnect to 2.
...
>  		cbass_mcu: interconnect@28380000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;

Yup great, the interconnect instances that don't need above 4GB
address space should stay this way.

Acked-by: Tony Lindgren <tony@atomide.com>
