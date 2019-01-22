Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EC020870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfAVK5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:57:50 -0500
Received: from 8bytes.org ([81.169.241.247]:58784 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAVK5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:57:49 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B2CD653D; Tue, 22 Jan 2019 11:57:48 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:57:47 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: amd: call free_iova_fast with pfn in map_sg
Message-ID: <20190122105747.qnelpj6xx6gp5dh7@8bytes.org>
References: <20190117192902.15158-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117192902.15158-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 12:29:02PM -0700, Jerry Snitselaar wrote:
> In the error path of map_sg, free_iova_fast is being called with
> address instead of the pfn. This results in a bad value getting into
> the rcache, and can result in hitting a BUG_ON when
> iova_magazine_free_pfns is called.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>

Applied, thanks.
