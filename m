Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28CEC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F562098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBgqdJDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F562098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeJLXiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:38:08 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:34680 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeJLXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:38:07 -0400
Received: by mail-io1-f74.google.com with SMTP id y3-v6so11543542iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LLVAB5Kqmz4yZ4RhY2EdQgSCcNoSfajLzXN70pZd2Qc=;
        b=EBgqdJDZzrkTS6aVfLNS/jmQ99SDsXiQeT3jBN5Vr+0fFXSrmlLDwpvUsOl3p4//xc
         ln+QQuODND25MnZKFFQSszgexGtb+bxsMe3HIhUSoU7qSI6dhLd4r+2jvc/g/QytCIbT
         ufH1CyNKH/NA/Tgsz6fC0dNOdJKZzCLb3VBA8cmCKIq1Kq86tUpzfUBTqr2D7vJ1/yxa
         sDYQV7YPpApuZKxQPDydjJcuJp1xUgfuSpkqWoOO6oqaxGu0BN7qVIyiIAlPtFrtmmEd
         p8xK8MzIHO3f45DlUMyQg0mN92O00JW0Ka6grr4UhExQev56XN+C9KR4ji4gwBFdY70N
         wtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LLVAB5Kqmz4yZ4RhY2EdQgSCcNoSfajLzXN70pZd2Qc=;
        b=ltG/S3xmG5lDL4jaWUw4hx+UxNmqqEpfq8koS3EtbNpFrsKCdtNmWS1XkS1a9/tQA2
         eNRWqHSBqDa2ovcvCmrZarLp8ziZ2GJHkfa/yEkJlVLrJEL/43qCnSqaVcYjIPCJA5Fc
         veXCgZAM2Y1xXY5uThmkV6YeKDVXYeqAyGsewRXUv5VJIy15z43EKgq52FC9VnZ2EmRA
         0fYVxFyZmmlKz5CceYOBXn21hrmqNY32eiDc8GsEJ42/Izvu7aX9GFcmQXFipbjUN6sL
         ns7IFp8mPW5oSdwCyVCIyE3Cx5g3LdNiLnUNO0DLApKE6vmqMg6VKqDreOUJ71aklUeX
         Q93g==
X-Gm-Message-State: ABuFfoh7hpKos22x0rpLPo3e5lAnFJVjqLQp6dQcJCv0yTgz64rlf+xf
        ZmK7EufQLCqtEj14aKrWYawQgi89tZvh
X-Google-Smtp-Source: ACcGV6042mMiow83oS8b92DD5cTHYOf9eGCu/hN0kld1xwJP1h83tRyfGp7uxz6pMtz27/Kkn/9bBFQ/WZgl
X-Received: by 2002:a24:7445:: with SMTP id o66-v6mr5454201itc.20.1539360297166;
 Fri, 12 Oct 2018 09:04:57 -0700 (PDT)
Date:   Fri, 12 Oct 2018 10:04:45 -0600
In-Reply-To: <20181012160448.79018-1-zwisler@google.com>
Message-Id: <20181012160448.79018-2-zwisler@google.com>
Mime-Version: 1.0
References: <20181012160448.79018-1-zwisler@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 1/4] gsmi: Fix bug in append_to_eventlog sysfs handler
From:   Ross Zwisler <zwisler@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Duncan Laurie <dlaurie@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        linux-kernel@vger.kernel.org, Furquan Shaikh <furquan@google.com>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@chromium.org>

The sysfs handler should return the number of bytes consumed, which in the
case of a successful write is the entire buffer.  Also fix a bug where
param.data_len was being set to (count - (2 * sizeof(u32))) instead of just
(count - sizeof(u32)).  The latter is correct because we skip over the
leading u32 which is our param.type, but we were also incorrectly
subtracting sizeof(u32) on the line where we were actually setting
param.data_len:

	param.data_len = count - sizeof(u32);

This meant that for our example event.kernel_software_watchdog with total
length 10 bytes, param.data_len was just 2 prior to this change.

To test, successfully append an event to the log with gsmi sysfs.
This sample event is for a "Kernel Software Watchdog"

> xxd -g 1 event.kernel_software_watchdog
0000000: 01 00 00 00 ad de 06 00 00 00

> cat event.kernel_software_watchdog > /sys/firmware/gsmi/append_to_eventlog

> mosys eventlog list | tail -1
14 | 2012-06-25 10:14:14 | Kernl Event | Software Watchdog

Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
Reviewed-by: Stefan Reinauer <reinauer@chromium.org>
Signed-off-by: Furquan Shaikh <furquan@google.com>
Tested-by: Furquan Shaikh <furquan@chromium.org>
Reviewed-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Justin TerAvest <teravest@chromium.org>
[zwisler: updated changelog for 2nd bug fix and upstream]
Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 drivers/firmware/google/gsmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index c8f169bf2e27..62337be07afc 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -480,11 +480,10 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 	if (count < sizeof(u32))
 		return -EINVAL;
 	param.type = *(u32 *)buf;
-	count -= sizeof(u32);
 	buf += sizeof(u32);
 
 	/* The remaining buffer is the data payload */
-	if (count > gsmi_dev.data_buf->length)
+	if ((count - sizeof(u32)) > gsmi_dev.data_buf->length)
 		return -EINVAL;
 	param.data_len = count - sizeof(u32);
 
@@ -504,7 +503,7 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
-	return rc;
+	return (rc == 0) ? count : rc;
 
 }
 
-- 
2.19.0.605.g01d371f741-goog

