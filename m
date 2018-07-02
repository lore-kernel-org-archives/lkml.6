Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E401C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC894246E9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLap2syq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC894246E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753673AbeGBX7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:59:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34201 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753205AbeGBX7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:59:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id y5-v6so80636pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=evF58zRqCwWmnT0aAXmXG229hKCPXbUldLYrasJlK64=;
        b=vLap2syqO4FsG96RkVXeOg5lt5nVFjrUEqsAcg6mcJZ/QtWg6ikCdtmFn5t7ykC5tz
         wF6DLG1E8N0WMg9P3/7Bx5y4mJRD15x/cNoKM5yc2EEtJ9cXK+rWySa1ZQHvxhExsN2J
         wB1DpxRwjsT+I6G5Lfrv9KNEmimf0uv6q4j8YclCaWWEkQXCO+sSQEczXvy/JSFA8qRY
         iWWtpl3wuBsXAqpt8W0qc5gQsj9tlwRBVktosrgfrDpDlLzljjRra60i3dFYHs7i/6Aa
         96YbezbhD5Etyx2E1xEdLxen6UKme0wQinnsSvLnu6wPcjh1zil1IlgCF573k9TKkHrw
         DbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=evF58zRqCwWmnT0aAXmXG229hKCPXbUldLYrasJlK64=;
        b=IYVPwLzcxvE2lBbReI4rELf3SO9PAaZv4ZBU0Onofu9WvJy8N7kPRxOE6BXwzC4By1
         3SWvUfMCnyA1hB06dMU8WTvttOu08KE86v6OS3JKaOSTQK98kbqmiMNvAfKmMxyjVHYB
         UFDZCK71Ud+t/RbNxcczISS5aH2pFFIhk1qw8irT6W/peW/MySetkin3Y0gGwt1nhYkF
         IM+K2HaUA7kYdfHeKGBUs7NQzN8SI0pH1PByHJz2Vadx2rgRAJmkVGEhO1DeKtb9d9y1
         LlSK2rFc2mvzshdoxOTy9/nuzkzP5iRbGRscwOj1crqhvi5hkKb5r0JHGtdC5L4qO62O
         5dzA==
X-Gm-Message-State: APt69E2OvbLnY7mO61xzbkd3eT5LKGfLIG/ckiD5WatwCT3YvvLl/8yg
        ngqITzdRmqTFNLuEY93S6OQFnwdg1Hk=
X-Google-Smtp-Source: ADUXVKLCCFkRMFToziG57JFfysAsSkPpn+2va/df6lVD5YynjZQcQLhoPNN3ciYpGKk0tGG7Ru6fbg==
X-Received: by 2002:a65:611a:: with SMTP id z26-v6mr23326154pgu.61.1530575985725;
        Mon, 02 Jul 2018 16:59:45 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1611:7129:1142:3149:848c])
        by smtp.gmail.com with ESMTPSA id k15-v6sm25011486pfi.37.2018.07.02.16.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 16:59:44 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org
Subject: [PATCH] HID: debug: check length before copy_to_user()
Date:   Mon,  2 Jul 2018 16:59:37 -0700
Message-Id: <20180702235937.111619-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If our length is greater than the size of the buffer, we
overflow the buffer

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Cc: stable@vger.kernel.org
---
 drivers/hid/hid-debug.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 8469b6964ff64..b48100236df89 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1154,6 +1154,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			goto out;
 		if (list->tail > list->head) {
 			len = list->tail - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1163,6 +1165,8 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			list->head += len;
 		} else {
 			len = HID_DEBUG_BUFSIZE - list->head;
+			if (len > count)
+				len = count;
 
 			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
 				ret = -EFAULT;
@@ -1170,7 +1174,9 @@ static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
 			}
 			list->head = 0;
 			ret += len;
-			goto copy_rest;
+			count -= len;
+			if (count > 0)
+				goto copy_rest;
 		}
 
 	}
-- 
2.18.0.399.gad0ab374a1-goog

