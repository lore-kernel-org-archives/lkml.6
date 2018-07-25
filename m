Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E55C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3024E20833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ln0eyIrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3024E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeGZBNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36041 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbeGZBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so6317270pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eIz2LDT3jNvOV+6SjD3rQhz1JXwGXwb08hD64XrvRP4=;
        b=ln0eyIrIZj6RZhlG4r7vuHKAJ58xktXZ6ANYV+nvwes2yRxDFoGPIii+k26dgf3KW5
         pT5IF1ayFzjqRrnI0CUjdYYTxSLSNrH8i2AvvpF1J9duD4OQfU5NB1Qe8pOgGpEstxca
         ZInMRUls8SwZ7UQzGZ7aEtPHasBNXgLborqYaq3xcA4dTSULDSbsa8sAOBrRTsfgJofY
         FUmJadfe6M60tSHxmUi77W3nFblA5PrtcWkfvuMNrt/zk0iXPYmEDNN3h3JkqHR66+4G
         jYvdtvEeDTaYjfJiLUzd/VRoamjkb3jxbbh3O8Tu/Mo5JCBoWhmqRTqe/2x6xVwoWCIg
         j4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eIz2LDT3jNvOV+6SjD3rQhz1JXwGXwb08hD64XrvRP4=;
        b=FuF4DWCZGc6nYuZzDbZNAX0mo3anOKd6ktZzrgCoJ6HMmMUn1ajZ8CbjeOi1tBMYlO
         gZSNBR2SkU6Itz5+yAmQYwir8ydCUMnpdIvzEXFlDo3MocUhdrwfvtnZf0/Rdojek05s
         ByKLG9AWCdYa4Maw/PHUWOua30XHW+hJTxqYUDkoZ45pUSTG/CnqS+CRJByoD1ACZB0V
         riSuGjOZjP9Bd2gvh7XusKtrnlqR++v8IBOsp6JzA5eR09k4kJ9GbZT5afOID/B42d0x
         CcFtcscnWKM883SQrSgFYwGpo4wBLmxQyxD9x9T1FUv41mKGZXtxai3gKEkh8ROTOv4M
         fWoA==
X-Gm-Message-State: AOUpUlFAoozWBnYoMGBaXExtE0nh40v6s/fFw5HxRao/s/Ym2qXjPQZx
        q7NRshzTTjsz6yVNohX5VtR5kDwlx9Y=
X-Google-Smtp-Source: AAOMgpeJxn5s+2QROoPSSiqA06mQjcWeQYJBh0Hw08ByAaG2Bj8RP0CxFbmvdVx6pR3NOy/k03sY8Q==
X-Received: by 2002:aa7:850b:: with SMTP id v11-v6mr23846859pfn.165.1532563175628;
        Wed, 25 Jul 2018 16:59:35 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:35 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 7/9] proc/kcore: optimize multiple page reads
Date:   Wed, 25 Jul 2018 16:59:18 -0700
Message-Id: <c9e919ab66d4064451bb7b613bfead17d8986c88.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1532563124.git.osandov@fb.com>
References: <cover.1532563124.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The current code does a full search of the segment list every time for
every page. This is wasteful, since it's almost certain that the next
page will be in the same segment. Instead, check if the previous segment
covers the current page before doing the list search.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 808ef9afd084..758c14e46a44 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -428,10 +428,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
+	m = NULL;
 	while (buflen) {
-		list_for_each_entry(m, &kclist_head, list) {
-			if (start >= m->addr && start < (m->addr+m->size))
-				break;
+		/*
+		 * If this is the first iteration or the address is not within
+		 * the previous entry, search for a matching entry.
+		 */
+		if (!m || start < m->addr || start >= m->addr + m->size) {
+			list_for_each_entry(m, &kclist_head, list) {
+				if (start >= m->addr &&
+				    start < m->addr + m->size)
+					break;
+			}
 		}
 
 		if (&m->list == &kclist_head) {
-- 
2.18.0

