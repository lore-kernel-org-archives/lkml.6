Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B69C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4889F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLFPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:47:11 -0500
Received: from 8bytes.org ([81.169.241.247]:52174 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLFPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:47:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A7B8D209; Thu,  6 Dec 2018 16:47:09 +0100 (CET)
Date:   Thu, 6 Dec 2018 16:47:09 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 2/4] iommu: Consolitate ->add/remove_device() calls
Message-ID: <20181206154709.GJ16835@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-3-joro@8bytes.org>
 <3ca13757-edf8-95cb-6316-73d202f97dbf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ca13757-edf8-95cb-6316-73d202f97dbf@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 06:20:50PM +0000, Robin Murphy wrote:
> Is there any good reason to let .add_device/.remove_device be optional
> still? Everyone's implemented them for a while now, and on a practical level
> I don't really see how else we could expect devices to be taken in and out
> of their appropriate groups correctly.

There is probably no reason anymore to keep add_device/remove_device
option. I'll check the users and remove the pointer checks if possible.


Regards,

	Joerg
