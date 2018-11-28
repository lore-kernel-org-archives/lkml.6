Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B36C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD6520832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 08:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD6520832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeK1Tog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 14:44:36 -0500
Received: from 8bytes.org ([81.169.241.247]:50632 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbeK1Tof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 14:44:35 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DEE2F3FF; Wed, 28 Nov 2018 09:43:43 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] Driver message cleanups
Date:   Wed, 28 Nov 2018 09:43:39 +0100
Message-Id: <20181128084342.16363-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are a couple of patches to clean up the message
printing in the AMD IOMMU driver a bit. The patches switch
the driver to use pr_fmt() instead of inconsistently open
coding the 'AMD-Vi' prefix in error messages. Furhter the
Event log messages are fixed and contain no newline anymore.
The addresses in the event log messages got rid of the
leading 0s to make the messages shorter.

Regards,

	Joerg

Joerg Roedel (3):
  iommu/amd: Use pr_fmt()
  iommu/amd: Fix line-break in error log reporting
  iommu/amd: Remove leading 0s in error log messages

 drivers/iommu/amd_iommu.c      | 62 ++++++++++++++++----------------
 drivers/iommu/amd_iommu_init.c | 64 ++++++++++++++++++----------------
 drivers/iommu/amd_iommu_v2.c   |  2 ++
 3 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.17.1

