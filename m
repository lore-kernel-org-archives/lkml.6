Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9D8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BB020873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeLSXXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:23:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44054 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbeLSXXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:23:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A6314E93D;
        Wed, 19 Dec 2018 23:23:30 +0000 (UTC)
Received: from redhat.com (ovpn-120-164.rdu2.redhat.com [10.10.120.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id 145295D738;
        Wed, 19 Dec 2018 23:23:29 +0000 (UTC)
Date:   Wed, 19 Dec 2018 18:23:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: fix test build after uio.h change
Message-ID: <20181219232320.6791-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 19 Dec 2018 23:23:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: d38499530e5 ("fs: decouple READ and WRITE from the block layer ops")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fb22bccfbc8a..7ef45a4a3cba 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -23,6 +23,10 @@
 #define PAGE_MASK (~(PAGE_SIZE-1))
 #define PAGE_ALIGN(x) ((x + PAGE_SIZE - 1) & PAGE_MASK)
 
+/* generic data direction definitions */
+#define READ                    0
+#define WRITE                   1
+
 typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
-- 
MST
