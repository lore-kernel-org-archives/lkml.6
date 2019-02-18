Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A4217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbfBRQZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:25:21 -0500
Received: from muru.com ([72.249.23.125]:39292 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731987AbfBRQZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:25:21 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B2E7C80E4;
        Mon, 18 Feb 2019 16:25:30 +0000 (UTC)
Date:   Mon, 18 Feb 2019 08:25:17 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Message-ID: <20190218162517.GG15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215200244.GA15711@atomide.com>
 <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190218 13:46]:
> Hi Tony,
> 
> On 16/02/19 1:32 AM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
> >> The following add driver patches for porting TI's am335x and am437x
> >> devices to the sdhci-omap driver.
> >>
> >> This involves adding external DMA support to sdhci (first 3 patches from
> >> Chunyan) plus some miscellaneous patches to take care of deviations of
> >> the controllers from the sdhci model.
> > 
> > Good to see this happening :)
> > 
> > I think am437x should have also the ADMA as it's mostly
> > omap4 based? See the old omap4 ADMA series at [0] below.
> > 
> > Are you seeing any improvment in SDIO card read/write speeds
> > between external DMA and ADM BTW
> 
> am437 is using dmaengine even in the old omap_hsmmc driver. I haven't
> tried to enable ADMA in am437x.

Right, it's probably safest to keep it that way at least initially
to avoid changing multiple things at once. Then ADMA can be
configured later on if needed.

Regards,

Tony
