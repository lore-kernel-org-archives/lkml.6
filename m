Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60871C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7A20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 22:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oss-tech.org header.i=@oss-tech.org header.b="WDKs6yvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flsaS0nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oss-tech.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeG2AXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:23:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52907 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730656AbeG2AXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:23:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5329D21221;
        Sat, 28 Jul 2018 18:55:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 Jul 2018 18:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oss-tech.org; h=
        cc:date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=wQb34RlKYZMSrte68M+dkbDjE0brx5ohEE+/NuwWJ
        dg=; b=WDKs6yvTqYvYO6IHArblLqxgGe3Kmd9OORPMdDWv5QSgqFgz3VqL5OYmS
        xZ1n7KcHbHKp7VJTAEj7+gTcq2+EzUbOZGgalgkJoRN0bftFzfoqdm73pP2RyVux
        A8AaN7EoFlnCXVPbhTVj9VzWOzcMRDkHS+BMe13umj/SgS36ML9RK1gJ61FAh6Go
        2m1VFd/4VIOiw2QOIpDW8/QWTnt7h98yGPIEmPY88pg3mrlZPoZJA083I5RlyJl8
        kfqzv+iLq8iGU8YGQMrWT9JemOxLXMpZQf93dpPwQbjAlMkEcYg1Bg5Olk18yt0t
        vz4LL6JK0ciOk/WlL6tnRnoo2m2sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wQb34RlKYZMSrte68
        M+dkbDjE0brx5ohEE+/NuwWJdg=; b=flsaS0nW2GX+7HrpVsQQmED6XF5rJ8u5g
        tOtWTd31pMLODRe9EsrHpUeQp86w1RL34icASdpYF84XhUeHksSUjyApensXpVCN
        fXIM27euKY29v8J28rdFX9ASMAtfL3wVfDi5aBvNX3ojViGn7asVjBX0LCuDx/dF
        /YV3O1Pc8b/OFvjzoNrwZdLv70ialLbO1G0Xnby3V320UiqDZns5rN9CHL+Txv1k
        3JJLO7VkJBCPbZUyvN1+H3eg8DjZJ0eiCZ4S4EISven3Gz44XRlnYjAt2wMUg4qz
        +IRcHlqAPJ6h05P/aifk3gPr87P+q0GqNdXEodp+Sp/sj49Lg+iGw==
X-ME-Proxy: <xmx:ZPRcW1mmFUZYE23b8rHZk7ZCDLsotYPdAQfgWudW8OF6oaoiZL9MeA>
    <xmx:ZPRcW7zo52GIfy1QQpIQehXA96pCfOOv7MA6J75AsdTduZyxhSML7A>
    <xmx:ZPRcW6p2L65vjefjv2pmgvRodVMLjBdTJQuN6iYdo4hJz6rjAFXaDA>
    <xmx:ZPRcW65GWJ7fkbkalEXatg2C__SfZAb78sUW7xCjcy4JYIMGpjJlCg>
    <xmx:ZPRcWxdIwrJ-IOZstDsTlg24_BnE_MHQntJYBobSxY3zlhVck-lOhw>
    <xmx:ZfRcWwo-qu-OLIJNkJ_y50YHh6C7DxzCGQovdocxrh6XqqdvMvjjAA>
X-ME-Sender: <xms:ZPRcW4ZkT0dv1zthvNW15vbKEXT8JtlwAuBJWs2IFoAeScMMAt_MMw>
From:   Dmitriy Cherkasov <dmitriy@oss-tech.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>
Subject: [PATCH] staging: gasket: use NULL instead of 0 for null pointer
Date:   Sat, 28 Jul 2018 22:55:24 +0000
Message-Id: <1532818524-5217-1-git-send-email-dmitriy@oss-tech.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparse warning: Using plain integer as NULL pointer

Signed-off-by: Dmitriy Cherkasov <dmitriy@oss-tech.org>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 9f81161..8fbfd58 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1689,7 +1689,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 
 	if (gasket_dev->page_table[index]->coherent_pages) {
 		kfree(gasket_dev->page_table[index]->coherent_pages);
-		gasket_dev->page_table[index]->coherent_pages = 0;
+		gasket_dev->page_table[index]->coherent_pages = NULL;
 	}
 	gasket_dev->page_table[index]->num_coherent_pages = 0;
 	return -ENOMEM;
-- 
1.9.1

