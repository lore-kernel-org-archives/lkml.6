Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0298C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CD72063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 10:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfAKKXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 05:23:32 -0500
Received: from 8bytes.org ([81.169.241.247]:56836 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfAKKXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 05:23:31 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4B7F743A; Fri, 11 Jan 2019 11:23:30 +0100 (CET)
Date:   Fri, 11 Jan 2019 11:23:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Message-ID: <20190111102328.hm6y4chellntpnhl@8bytes.org>
References: <20181211150513.15161-1-joro@8bytes.org>
 <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
 <20181211150513.15161-4-joro@8bytes.org>
 <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
 <20181219143451.GY16835@8bytes.org>
 <CAMuHMdXr5tVuWf4dJzBLRfdqpMCMBSg-+t35nb=Rmh9PM=abJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXr5tVuWf4dJzBLRfdqpMCMBSg-+t35nb=Rmh9PM=abJg@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Geert,

On Thu, Dec 20, 2018 at 04:42:17PM +0100, Geert Uytterhoeven wrote:
> > -       return ops->add_device(dev);
> > +       if (ops)
> 
> Is this sufficient? The old code checked for ops->add_device != NULL,
> too.

Robin brought up that all iommu-ops implementations support the
add_device call-back, so we can remove that check and make the call-back
mandatory for new implementations too.

Regards,

	Joerg
