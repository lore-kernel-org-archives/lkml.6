Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9FC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B6820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfA3F6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:58:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfA3F6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:58:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E60B3CD263;
        Wed, 30 Jan 2019 05:58:04 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 691B16266C;
        Wed, 30 Jan 2019 05:57:59 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, Jason Wang <jasowang@redhat.com>,
        peterx@redhat.com, Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 0/2] Some MMU notifier cleanups for Intel/AMD IOMMU
Date:   Wed, 30 Jan 2019 13:57:56 +0800
Message-Id: <20190130055758.3994-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 30 Jan 2019 05:58:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently when I'm reading the mmu notifiers I noticed that both
Intel/AMD IOMMU drivers seem to have redundancies in using the MMU
notifiers.  It can also be seen as a follow up of commit 8301da53fbc1
("iommu/amd: Remove change_pte mmu_notifier call-back", 2014-07-30).

I don't have hardwares to test them, but they compile well.

Please have a look, thanks.

Peter Xu (2):
  iommu/vt-d: Remove change_pte notifier
  iommu/amd: Remove clear_flush_young notifier

 drivers/iommu/amd_iommu_v2.c | 24 ------------------------
 drivers/iommu/intel-svm.c    |  9 ---------
 2 files changed, 33 deletions(-)

-- 
2.17.1

