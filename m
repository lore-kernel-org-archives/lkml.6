Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A265CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 13:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E15820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeGYO5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 10:57:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729086AbeGYO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 10:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89E9F81663C5;
        Wed, 25 Jul 2018 13:45:31 +0000 (UTC)
Received: from redhat.com (ovpn-121-228.rdu2.redhat.com [10.10.121.228])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5B025111DCEE;
        Wed, 25 Jul 2018 13:45:28 +0000 (UTC)
Date:   Wed, 25 Jul 2018 16:45:27 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     khandual@linux.vnet.ibm.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] tools/virtio: add kmalloc_array stub
Message-ID: <20180725134057.113423-2-mst@redhat.com>
References: <20180725134057.113423-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725134057.113423-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 13:45:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 25 Jul 2018 13:45:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 6da2ec56059 ("treewide: kmalloc() -> kmalloc_array()")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/kernel.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fca8381bbe04..fb22bccfbc8a 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -52,6 +52,11 @@ static inline void *kmalloc(size_t s, gfp_t gfp)
 		return __kmalloc_fake;
 	return malloc(s);
 }
+static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
+{
+	return kmalloc(n * s, gfp);
+}
+
 static inline void *kzalloc(size_t s, gfp_t gfp)
 {
 	void *p = kmalloc(s, gfp);
-- 
MST

