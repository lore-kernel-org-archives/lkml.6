Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB192C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E6320892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790521;
	bh=ZeudUdl0oezMJ8YAFGvXLiK9/O053acErKkZtP0o1io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fSr9Uu4giv7oh7E6tMjqeJx3zxfaaL+gkFd2c03fnbXTDpkK63JjdtfPoYKPE+zer
	 aSy5cBBJbNF0dLRCn5vJzuLrZdo9bRvIRNGvi1YkOJvXqfgx8GBiqfU+fFDrokIuje
	 jFE+R0FhwvlMHtKfFIvNqTcpBzwyKTAzdOXdGqqg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E6320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbeLNM2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbeLNMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0266221508;
        Fri, 14 Dec 2018 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789441;
        bh=ZeudUdl0oezMJ8YAFGvXLiK9/O053acErKkZtP0o1io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w75c3JMRAQmd5CVXaTKQGRvhUW9F65Xqlh4oSBqFrCKWiZ7U8+LHjSYGGEUhXms3l
         Xise9pX4n8MR7/mGR27hwVbgc+NXU0/hnBSvSlQhZmwS2flWq5qFsK2mIjR/szwZkf
         ylj7LaqYURNvdZ1O02pNLuxipcRoxik6mxo3hQKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srikanth Boddepalli <boddepalli.srikanth@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 66/89] xen: xlate_mmu: add missing header to fix W=1 warning
Date:   Fri, 14 Dec 2018 13:00:19 +0100
Message-Id: <20181214115732.933889660@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 23f1387b3ef7..e7df65d32c91 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -36,6 +36,7 @@
 #include <asm/xen/hypervisor.h>
 
 #include <xen/xen.h>
+#include <xen/xen-ops.h>
 #include <xen/page.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
-- 
2.19.1



