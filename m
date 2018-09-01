Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AFDC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2512083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 10:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3Fw3YsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2512083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeIAOMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:12:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36161 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeIAOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:12:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so6554832plb.3;
        Sat, 01 Sep 2018 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=j9cDap1HW/F+JokRW7P2bqq7Yy5kZvZQGSg9p1J42uI=;
        b=L3Fw3YsJXC/n8P2PW3PjBrwoStt1x6fgHVkM0F9Av6hiSoVwuQqOyEJ0IL9SoDBBK/
         0m6k00MSvwjjaTRSXpnxT8JfmP/cz2Uw91NtyF+qdzja/Y7sdd080n5S8NgwAieEPxxL
         ZipZun4XnU5y0PO2RW1zmk5VuVeuwRGPnZAmMt7zoUXYVXEZyYzEG8SH09AJkREbkQJh
         bcBS696OtWvGKFc6TZltqENRU7ZrtiWQTn1mtoJQJUqs3bKlLoG+ur4hLAgwMtIEnFDY
         VQbvWy6F82P32u5ZIptCv1X1yU27vT5sAB5+NPKH8lARMVwqKZbQbyVqiMQSirShv7xw
         6CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j9cDap1HW/F+JokRW7P2bqq7Yy5kZvZQGSg9p1J42uI=;
        b=abf+tW2px/UDKUtU5pjRgQQKx7zHb4uxNLvsxBceL0MXDZH4DtenFpfttrDnKPZUEf
         izxt3PudHJglmi4PN2CGuhc5pos0wxDrC2xbDC1yNV5/Gg5zCIZj4poeXZfqn1Nf+M4K
         AF4DTT1y0cxjj5qZufhQVzBFr2e8x7rOa+rCUa5VZLa7oHIb2FiO1jDA3Cfxzsaajilf
         1/qpJHIYumJortDo4BxPoohIidcW8pDQ9WQKZo1zfnMiBya/BcT/0CQnTubjVOslIT14
         6Z7yQ0LDPKtW+oD/MkAnTdssGZ/O5lzzqNocHE/QXhhjqswXitPoRaAgq/Tld9iPMR1b
         f3HQ==
X-Gm-Message-State: APzg51Bk/OMXxqyaWNuNyx9mwxxUmJwhd7TKHKz9xPtKGrajxl6BrFjW
        YBS/Fq9yzqN+hnOgCcPErhQ=
X-Google-Smtp-Source: ANB0Vdb++XgYWX0KBLy1cz93Yrq7wza61arVnHsaHBg4guGBpSyF8csykSBCThxrzvlPQQekrGkKxg==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr19135616plq.6.1535796036964;
        Sat, 01 Sep 2018 03:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:2913:cd09:aee0:380])
        by smtp.gmail.com with ESMTPSA id x3-v6sm14413798pgv.61.2018.09.01.03.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 03:00:36 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     davem@davemloft.net, ktkhai@virtuozzo.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, dvlasenk@redhat.com, xiyou.wangcong@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: scm: Fix a possible sleep-in-atomic-context bug in scm_fp_copy()
Date:   Sat,  1 Sep 2018 18:00:26 +0800
Message-Id: <20180901100026.16956-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] kmalloc(GFP_KERNEL)
net/core/scm.c, 85: kmalloc in scm_fp_copy
net/core/scm.c, 161: scm_fp_copy in __scm_send
./include/net/scm.h, 88: __scm_send in scm_send
net/unix/af_unix.c, 1600: scm_send in maybe_init_creds
net/unix/af_unix.c, 1983: maybe_init_creds in unix_stream_sendpage
net/unix/af_unix.c, 1973: spin_lock in unix_stream_sendpage

To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 net/core/scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index b1ff8a441748..49548f81c45b 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -82,7 +82,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 	if (!fpl)
 	{
-		fpl = kmalloc(sizeof(struct scm_fp_list), GFP_KERNEL);
+		fpl = kmalloc(sizeof(struct scm_fp_list), GFP_ATOMIC);
 		if (!fpl)
 			return -ENOMEM;
 		*fplp = fpl;
-- 
2.17.0

