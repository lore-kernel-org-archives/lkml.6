Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49F8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4D21B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI/5R1YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbfBKPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:21:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42260 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390763AbfBKPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:21:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so5086181pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ita72m0qHksZNcDB6Zg6zw5cSMfZ8ZcJBs3jNlyZozo=;
        b=KI/5R1YGpvtTX4iijhHg4YkvRkCAlnKhcY2uD+qQaqWHB6hZH0VI4MsX/Nn8UaVTks
         yeKXtEM+UINne7hhjNibafyV9/o2a/JwdkA5DzlZDUT98lj1KAqSlHo7Xzk8zkboGnf5
         om1wHusrSXgPAtA6y3NWIB84ARN/TtqlM2lY+7+QdXgw2o6t+8O3buPr/NBJdGQ0z+dH
         ZMYlzQnLNBpwBt/Z/52s2+4cObU6Y3MmqW6fzes6ogs+lA5LV/GTbsGIVfI5JU9Q/ue+
         ax/k2lj3Vh+Cxb+QKphpW4UaOJBjXRXLsgThNhUbYcqvzLwHf8y14rl5EoSoYp94EWH2
         FT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ita72m0qHksZNcDB6Zg6zw5cSMfZ8ZcJBs3jNlyZozo=;
        b=E85vZEilxE15g/mmaZ9lSQCsZKH08leOB7GS3yY/3ikkNjSdoTFGiOOHhNrbMNJlcI
         la6KUhAbI/hdfJeRGIgBfIIUHzmlQODFZRJyJVexLECDxhgGEVpisMxg9vs6j5j4XQ+f
         8xkKQawWG+2rdS7z8iAuIJYm3/FeYiihtUW2VLXaVc0fMLwbJU5GeYywI/gLhAzsDpoo
         ggKgot9tZa4XF6cV+oq0P04JwGCxGM7/4i1DbOnQhaCRCEZ0c1SUQhsLFLksMyH5SNxl
         AwV2EhR7GsKhF+91kYg2sg/ShMfrIG133X3u6CZwwGIFLqL+Vwi4pjYqFcvXMi4eWXhB
         DcdQ==
X-Gm-Message-State: AHQUAuZUtNhXqV0YbL6/deovT/NcFIAK7ca9jeEvB2dmCZI1kdN5fzpK
        j3h+7o22SiH+8LqP9nGpxB/7x4fq
X-Google-Smtp-Source: AHgI3IZ/7g/LtJjwkp9x6N2Gprv5sqPWRyYaZZ2mMVN9mUpHt23Zze0nvcXh/0Uyg647ozkK55wwzQ==
X-Received: by 2002:a63:4b5e:: with SMTP id k30mr19908828pgl.212.1549898506113;
        Mon, 11 Feb 2019 07:21:46 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.40])
        by smtp.gmail.com with ESMTPSA id s14sm4078448pfe.171.2019.02.11.07.21.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 07:21:45 -0800 (PST)
Date:   Mon, 11 Feb 2019 20:56:02 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     arve@android.com, gregkh@linuxfoundation.org, tkjos@android.com,
        maco@android.com, christian@brauner.io
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: vsoc: Remove
 VSOC_WAIT_FOR_INCOMING_INTERRUPT
Message-ID: <20190211152602.GA5591@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in TODO list, Removed VSOC_WAIT_FOR_INCOMING_INTERRUPT
ioctl. This functionality has been superseded by the futex and is
there for legacy reasons.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/staging/android/uapi/vsoc_shm.h | 7 -------
 drivers/staging/android/vsoc.c          | 5 -----
 2 files changed, 12 deletions(-)

diff --git a/drivers/staging/android/uapi/vsoc_shm.h b/drivers/staging/android/uapi/vsoc_shm.h
index 6291fb2..69090cc 100644
--- a/drivers/staging/android/uapi/vsoc_shm.h
+++ b/drivers/staging/android/uapi/vsoc_shm.h
@@ -232,13 +232,6 @@ struct vsoc_shm_layout_descriptor {
 #define VSOC_MAYBE_SEND_INTERRUPT_TO_HOST _IO(0xF5, 2)
 
 /*
- * When this returns the guest will scan host_to_guest_signal_table to
- * check for new futexes to wake.
- */
-/* TODO(ghartman): Consider moving this to the bottom half */
-#define VSOC_WAIT_FOR_INCOMING_INTERRUPT _IO(0xF5, 3)
-
-/*
  * Guest HALs will use this to retrieve the region description after
  * opening their device node.
  */
diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571ab..a842ff7 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -592,11 +592,6 @@ static long vsoc_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case VSOC_SEND_INTERRUPT_TO_HOST:
 		writel(reg_num, vsoc_dev.regs + DOORBELL);
 		return 0;
-	case VSOC_WAIT_FOR_INCOMING_INTERRUPT:
-		wait_event_interruptible
-			(reg_data->interrupt_wait_queue,
-			 (atomic_read(reg_data->incoming_signalled) != 0));
-		break;
 
 	case VSOC_DESCRIBE_REGION:
 		return do_vsoc_describe_region
-- 
1.9.1

