Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA878C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04F321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfAXIEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:04:33 -0500
Received: from 8bytes.org ([81.169.241.247]:59410 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfAXIEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:04:33 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E11033C8; Thu, 24 Jan 2019 09:04:31 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:04:31 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Message-ID: <20190124080431.GG32526@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
 <20190122104454.nke2knuyqiswfh5w@8bytes.org>
 <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
 <20190123075658.GE32526@8bytes.org>
 <54a1da19-54dd-30cc-191b-7fe5dc4a58fa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a1da19-54dd-30cc-191b-7fe5dc4a58fa@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Thu, Jan 24, 2019 at 03:25:19AM +0000, Suthikulpanit, Suravee wrote:
> Actually, I just noticed that device_flush_dte() has already handled flushing the DTE
> for alias device as well. Please see the link below.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/iommu/amd_iommu.c#L1219
> 
> So, we don't need to call device_flush_dte() for alias device in do_detach().

You are right, I missed that.

Thanks,

	Joerg
