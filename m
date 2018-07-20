Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CDD20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="m0gcJNJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CDD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeGTMov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:44:51 -0400
Received: from 8bytes.org ([81.169.241.247]:59204 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbeGTMou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:44:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EB70D2DE; Fri, 20 Jul 2018 13:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532087814; bh=HPD95rEbpXg8KFpirsxuolH5+jPXZ+7OdmSZOZacxBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m0gcJNJHJfqxZ8uW5y1x+dV9T4jnPp+/ayjaZyQpwPUI3aKw4OIbtF7Wu8T6+0I5Z
         n08cw4Nznnw2A5bcNgZClPo/hKd8tcRv8NYmTgpgYbgudz7wKPX074nd3DarDvUzGv
         1XqeHxd/eme/E+Aj81am2X9Mo/aLTywroDx3FsyGKAr9uZDQjrQsWUB1Qv/xL3konq
         kXrAQEe4RnAKZpZ9RXhoaj8AfSr66+XZhCd+rGkv2sxQnbqN9BznrZ2ulWGDenrNHI
         8tD8j9U0UCV2Db9Z9F0WgTurqrnchlFmqs9yqRI20VxMXQrBvnPSrQu7xsbIGHBcwg
         OklXCy/CuX3eQ==
Date:   Fri, 20 Jul 2018 13:56:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Revert "iommu/vt-d: Clean up pasid quirk for
 pre-production devices"
Message-ID: <20180720115652.tswu2sohy6snj4hl@8bytes.org>
References: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531031001-5783-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 02:23:21PM +0800, Lu Baolu wrote:
> This reverts commit ab96746aaa344fb720a198245a837e266fad3b62.
> 
> The commit ab96746aaa34 ("iommu/vt-d: Clean up pasid quirk for
> pre-production devices") triggers ECS mode on some platforms
> which have broken ECS support. As the result, graphic device
> will be inoperable on boot.
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107017
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 32 ++++++++++++++++++++++++++++++--
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 31 insertions(+), 2 deletions(-)

Applied to iommu/fixes.

