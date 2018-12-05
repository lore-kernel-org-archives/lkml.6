Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A225AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6679720989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUrxOADk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6679720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbeLEJyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:54:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbeLEJx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:53:57 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB2F20989;
        Wed,  5 Dec 2018 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003637;
        bh=MFFhmJZPw4CtVNE/KkrQRLbIYTJ8mir4+O7hC+/13lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUrxOADkBHNIl5IMHJMFJfHXqPbqWGdesy65kUU4qwbq/iEjDGmhwvrwe74V/cPvm
         0zL3tFycLZF9GBN8hiAO7jwg0Lo7aAKYKcm+QCGfxx1YeoSZHsuTAqJ6ns3cjOj6w6
         Xe/rz0qeWla2psM7a+jwCIVeNyHkfTKXCE2HJBLY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Srikanth Boddepalli <boddepalli.srikanth@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 25/33] xen: xlate_mmu: add missing header to fix 'W=1' warning
Date:   Wed,  5 Dec 2018 04:51:23 -0500
Message-Id: <20181205095131.7685-25-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Boddepalli <boddepalli.srikanth@gmail.com>

[ Upstream commit 72791ac854fea36034fa7976b748fde585008e78 ]

Add a missing header otherwise compiler warns about missed prototype:

drivers/xen/xlate_mmu.c:183:5: warning: no previous prototype for 'xen_xlate_unmap_gfn_range?' [-Wmissing-prototypes]
  int xen_xlate_unmap_gfn_range(struct vm_area_struct *vma,
      ^~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xlate_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index 5063c5e796b7..84a1fab0dd6b 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -34,6 +34,7 @@
 #include <asm/xen/hypervisor.h>
 
 #include <xen/xen.h>
+#include <xen/xen-ops.h>
 #include <xen/page.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
-- 
2.17.1

