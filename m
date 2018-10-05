Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8029DC65BA9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3843821486
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="EED73oS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3843821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJEP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:27:50 -0400
Received: from 8bytes.org ([81.169.241.247]:54366 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbeJEP1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:27:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 77A41338; Fri,  5 Oct 2018 10:30:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1538728210; bh=0o1jyqhpoYThXAIjJ/nA+4OqdRtmy8F9OhyuUHtWtVU=;
        h=Date:From:To:Cc:Subject:From;
        b=EED73oS2qeoWH9HYgKQw1CnZe5FO4wyOxo6v7kFsaiPbzx0imMHK/9auhs+jUbIVw
         z/iD0l/msuQbFc3MH3To/ihqMuwM/+3lrZYkse/rRxL/lOBpQKOoYFKLPeKX0QAuxy
         mThOfL9mlAfWSUqrVyAUu8NjElpSHDpuImSba87aCsH1VQ2QoKz5NEr8eQx3OGTUF+
         +hRWFJBkQ4XmOLGyCnFPEKLbQIDni2TjeTSPVVVS7wUViDvWb0Lfu/TaEbsQzCqgh9
         XKJi1Xo/WBcL+L3MVQbqnAmELAj6vhq4BaMCpR5CC8lXQI3pgDhgAwVdLbFINcmx5D
         B663w2mcsKtNg==
Date:   Fri, 5 Oct 2018 10:30:09 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v4.19-rc6
Message-ID: <20181005083005.ctclagex4fu73tvf@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.19-rc6

for you to fetch changes up to b3e9b515b08e407ab3a026dc2e4d935c48d05f69:

  iommu/amd: Clear memory encryption mask from physical address (2018-10-05 10:20:24 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v4.19-rc6

One important fix:

	- Fix a memory leak with AMD IOMMU when SME is active and a VM
	  has assigned devices. In that case the complete guest memory
	  will be leaked without this fix.

----------------------------------------------------------------
Singh, Brijesh (1):
      iommu/amd: Clear memory encryption mask from physical address

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg
