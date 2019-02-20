Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CDE2190B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfBTNBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:01:08 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:34492 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbfBTNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:00:59 -0500
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id f10x1z0033XaVaC0110xuU; Wed, 20 Feb 2019 14:00:57 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRUf-0001TS-2A; Wed, 20 Feb 2019 14:00:57 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRUf-0000Do-0H; Wed, 20 Feb 2019 14:00:57 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, Baoquan He <bhe@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] iommu: Document iommu_ops.is_attach_deferred()
Date:   Wed, 20 Feb 2019 14:00:53 +0100
Message-Id: <20190220130053.784-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190220130053.784-1-geert+renesas@glider.be>
References: <20190220130053.784-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing kerneldoc for iommu_ops.is_attach_deferred().

Fixes: e01d1913b0d08171 ("iommu: Add is_attach_deferred call-back to iommu-ops")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3ed5d372b090af54..ffbbc7e39ceeba3e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -184,6 +184,8 @@ struct iommu_resv_region {
  * @domain_window_enable: Configure and enable a particular window for a domain
  * @domain_window_disable: Disable a particular window for a domain
  * @of_xlate: add OF master IDs to iommu grouping
+ * @is_attach_deferred: Check if domain attach should be deferred from iommu
+ *                      driver init to device driver init (default no)
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  */
 struct iommu_ops {
-- 
2.17.1

