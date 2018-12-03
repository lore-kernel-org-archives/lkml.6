Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA942145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Gjkf05Mp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA942145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLCU0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:26:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39013 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLCU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:26:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so7039299pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BukpeEkq5crAUpya2s8N6BcR6cPLMKkJ4rB3e7CFbds=;
        b=Gjkf05Mp4mPfOwLuaylxH6uJ5o2+1P6YJf7ejnDjNIIohI+h5hfIp/AsTbs2wZjNVv
         3ueQ/8yXSB9vRoGr2dUYf5Fl9m4oFVJ4cTt+shqtttkqrw9fG5traFSquwcTufMpYRu+
         GQgiqd99taRh0pjQXw9n3JUaE5qrofk0Er9lmBwjJMn5xYEH9sWK7eQVDn05EKn2m7T9
         pCjmXV+1WzuZ+7iPANc/nYjRxIiRWcbynv22GwMpLgTzPYRIzHioNPP3xGpaXXnXNwl9
         EhSMbcBVNgxaRwhCl25kSrxDEy1W/AsJaUlwylZ/EGVC3e0UJxJxQB+tmhBQQfT35r1p
         KEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BukpeEkq5crAUpya2s8N6BcR6cPLMKkJ4rB3e7CFbds=;
        b=NKkRv0XGnR2oj0iM5PlojeK5u4X8cDbOoit/rdPUW9Tk0KyhvqxigsGdVb/SjcNEPg
         WB1i4/Rg1IZYaJCvejuHwUJiQFZjL3azCsj93Yf2jvJADjkytt9sd31qQfvwuPI26ebR
         5lzX3mLWT9Gqsf1AwRt1w6AWNpwOgWw6IghtW7oclCQw8XjybbgbwNqI1UzV2HfuEoWk
         XgD9MVq5nS7dDMD0OBCE2tv2N3ouEJvx9mJBa2Z3L3ZpGqiTTo8B8IbOoD61d2RBIT4m
         diV/k9ZEX5S2GjXE2vW/wlCpth3+jDQFPe/1+I1VwVqwKtpcmwxYJIRa0hG8t53iltV/
         KeQw==
X-Gm-Message-State: AA+aEWYegfTB+wYqtBCgEe537SHr82e2Ohpil8682Y5iTG7QbHtbCUo8
        yTzG2h7CA88rZpS+C2Fub3L+2w==
X-Google-Smtp-Source: AFSGD/X5sXmsPFuMa+nrNLgcZOMUU6dRAmGv9W6GRXpaWRTN5QU42wEtpEzedrCzuiR91IjlmSPeWA==
X-Received: by 2002:a17:902:33c2:: with SMTP id b60mr17243105plc.211.1543868770114;
        Mon, 03 Dec 2018 12:26:10 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id q7sm16562725pgp.40.2018.12.03.12.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 12:26:09 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH] binder: fix kerneldoc header for struct binder_buffer
Date:   Mon,  3 Dec 2018 12:24:55 -0800
Message-Id: <20181203202457.228972-2-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203202457.228972-1-tkjos@google.com>
References: <20181203202457.228972-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the incomplete kerneldoc header for struct binder_buffer.

Change-Id: If3ca10cf6d90f605a0c078e4cdce28f02a475877
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder_alloc.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index fb3238c74c8a8..c0aadbbf7f193 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -30,16 +30,16 @@ struct binder_transaction;
  * struct binder_buffer - buffer used for binder transactions
  * @entry:              entry alloc->buffers
  * @rb_node:            node for allocated_buffers/free_buffers rb trees
- * @free:               true if buffer is free
- * @allow_user_free:    describe the second member of struct blah,
- * @async_transaction:  describe the second member of struct blah,
- * @debug_id:           describe the second member of struct blah,
- * @transaction:        describe the second member of struct blah,
- * @target_node:        describe the second member of struct blah,
- * @data_size:          describe the second member of struct blah,
- * @offsets_size:       describe the second member of struct blah,
- * @extra_buffers_size: describe the second member of struct blah,
- * @data:i              describe the second member of struct blah,
+ * @free:               %true if buffer is free
+ * @allow_user_free:    %true if user is allowed to free buffer
+ * @async_transaction:  %true if buffer is in use for an async txn
+ * @debug_id:           unique ID for debugging
+ * @transaction:        pointer to associated struct binder_transaction
+ * @target_node:        struct binder_node associated with this buffer
+ * @data_size:          size of @transaction data
+ * @offsets_size:       size of array of offsets
+ * @extra_buffers_size: size of space for other objects (like sg lists)
+ * @data:               pointer to base of buffer space
  *
  * Bookkeeping structure for binder transaction buffers
  */
-- 
2.20.0.rc1.387.gf8505762e3-goog

