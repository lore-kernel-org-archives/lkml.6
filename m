Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2A2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfBDU0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:26:08 -0500
Received: from muru.com ([72.249.23.125]:37606 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfBDU0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:26:08 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C6214808C;
        Mon,  4 Feb 2019 20:26:16 +0000 (UTC)
Date:   Mon, 4 Feb 2019 12:26:04 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH] config: arm: omap2: remove PROVE_LOCKING from defconfig
Message-ID: <20190204202604.GP5720@atomide.com>
References: <CGME20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af@eucas1p2.samsung.com>
 <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
 <20181108165958.GK56134@atomide.com>
 <21ce2c61-0b20-41f2-4d12-3c5b1c4b7925@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ce2c61-0b20-41f2-4d12-3c5b1c4b7925@partner.samsung.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukasz Luba <l.luba@partner.samsung.com> [181113 10:22]:
> Hi Tony,
> 
> On 11/8/18 5:59 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lukasz Luba <l.luba@partner.samsung.com> [181009 08:36]:
> >> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
> >> bus transactions.
> >>
> >> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
> >> The overhead can be measures using hackbench which will speed up
> >> by x3 times (11sec -> 3.4sec).
> >> When you check transaction on cache or buses, the results are way higher
> >> than normal for the same hackbench test:
> >> L1d cache invalidations: 26mln vs 4mln
> >> L2u cache invalidations: 42mln vs 12mln
> >> bus cyc/access: 30cyc/access vs. 20cyc/access
> >> context switch is x3 times cheaper
> >>
> >> Enable this option only when you have some locking issue to investigate.
> > 
> > I'm all for this, but this disables also other less intrusive
> > debug options. It used to be that we'd get locking issues merged
> > into drivers and I think that's how it originally got enabled.
> That's common reason for a few defconfigs in mainline.

Actually looks like this does not change the DEBUG
related options.. I must have done something wrong
earlier, sorry. So applying into omap-for-v5.1/defconfig.

> > So we should take a look which ones we can or want to keep.
> > Or just disable CONFIG_DEBUG completely.
> Ideally, the CI should try a few 'types' of configs,
> generated based on the 'defconfig'. Some 'smart' script might
> cut the debug options for an image for performance regression tests.
> > 
> > For distros, that's multi_v7_defconfig nowadays for most part
> > so I think most people using omap2plus_defconfig are developers
> > working on various devices.

Yes I think that's the case.

Regards,

Tony
