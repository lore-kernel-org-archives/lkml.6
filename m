Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6314C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778292082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778292082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeIDTkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:40:05 -0400
Received: from muru.com ([72.249.23.125]:55220 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbeIDTkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:40:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 35D5080E1;
        Tue,  4 Sep 2018 15:18:32 +0000 (UTC)
Date:   Tue, 4 Sep 2018 08:14:26 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
Message-ID: <20180904151426.GA5662@atomide.com>
References: <20180903095235.13853-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903095235.13853-1-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [180903 09:56]:
> AM65 has two PCIe controllers and each PCIe controller has '2' address
> spaces one within the 4GB address space of the SoC and the other above
> the 4GB address space of the SoC (cbass_main) in addition to the
> register space. The size of the address space above the 4GB SoC address
> space is 4GB. These address ranges will be used by CPU/DMA to access
> the PCIe address space. In order to represent the address space above
> the 4GB SoC address space and to represent the size of this address
> space as 4GB, change address-cells and size-cells of interconnect to 2.
> 
> Since OSPI has similar need in MCU Domain Memory Map, change
> address-cells and size-cells of cbass_mcu interconnect also to 2.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v1:
> Changed address-cells and size-cells of cbass_mcu to "2" since OSPI has
> a region of size 4GB above the 4GB space.


Acked-by: Tony Lindgren <tony@atomide.com>
