Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE3321B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfBOUCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:02:53 -0500
Received: from muru.com ([72.249.23.125]:39058 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfBOUCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:02:52 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 84EC580C0;
        Fri, 15 Feb 2019 20:03:01 +0000 (UTC)
Date:   Fri, 15 Feb 2019 12:02:44 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Message-ID: <20190215200244.GA15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
> The following add driver patches for porting TI's am335x and am437x
> devices to the sdhci-omap driver.
> 
> This involves adding external DMA support to sdhci (first 3 patches from
> Chunyan) plus some miscellaneous patches to take care of deviations of
> the controllers from the sdhci model.

Good to see this happening :)

I think am437x should have also the ADMA as it's mostly
omap4 based? See the old omap4 ADMA series at [0] below.

Are you seeing any improvment in SDIO card read/write speeds
between external DMA and ADM BTW?

Regards,

Tony

[0] https://linux-omap.vger.kernel.narkive.com/H4EbLW96/patch-0-4-omap4-hsmmc-adding-adma-support
