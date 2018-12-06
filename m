Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB34C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7B20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE7B20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLFQTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:19:48 -0500
Received: from 8bytes.org ([81.169.241.247]:52194 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbeLFQTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:19:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CC8AF239; Thu,  6 Dec 2018 17:19:45 +0100 (CET)
Date:   Thu, 6 Dec 2018 17:19:45 +0100
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Message-ID: <20181206161945.GK16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-4-joro@8bytes.org>
 <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
tFrom:  Joerg Roedel <joro@8bytes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
From:   Joerg Roedel <joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 06:49:26PM +0000, Robin Murphy wrote:
> 	if (ops && dev->bus && !dev->iommu_group)
> 
> What I can't quite remember just now is whether it's actually valid to get
> here with err == 0 but dev->iommu_fwspec->ops == NULL, so it *might* be OK
> to use "!err" instead of "ops" to make things slightly more obvious - I'll
> work through the flow tomorrow to double-check.

Yeah, adding an err == 0 check seems to be the best option here, so that
iommu-drivers don't get confused when we try to add a device that is not
managed by an iommu.


Regards,

	Joerg
