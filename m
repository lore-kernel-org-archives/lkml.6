Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA171214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864439;
	bh=5eQX+6//2bCVhu5x8PeRK++MBHorhGN14Tf383i1qL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=otQpVRwlTO6N3MsbxT7t7AV1JxnV/H4VdPbo5dJNmQPp7ErfTeSkpZYy++CzTLJS4
	 MgWOOr68eJi5W743aGydZVMzCpVAHaBzrV/b5Jp69bNmXPxMQKzlLBFB8T7/oHE9ga
	 BZcd/Ayloa44UTj1Ao+4Q1LXHrJ/DnUr6WwSvzb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeLZWj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:39:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbeLZWiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:38:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E541C2054F;
        Wed, 26 Dec 2018 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863903;
        bh=5eQX+6//2bCVhu5x8PeRK++MBHorhGN14Tf383i1qL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDAqNkPlQxtRri4eIv5Ol38OZZ37FQGMvGnZHRlJTveVwFfoakfpOFjDkdW2ZMeSd
         k6k8hph50WWKDdxT2GUKg5MX6/Rre7pQXBhTfQmD0SSIzlMLgS1Q/ZPfpKOR2x1Ilt
         1Jt5EPd32VjUEdP5+aZ5ygTCEHbioWZFFpAV28fs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 87/97] virtio: fix test build after uio.h change
Date:   Wed, 26 Dec 2018 17:35:47 -0500
Message-Id: <20181226223557.149329-87-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>

[ Upstream commit c5c08bed843c2b2c048c16d1296d7631d7c1620e ]

Fixes: d38499530e5 ("fs: decouple READ and WRITE from the block layer ops")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

