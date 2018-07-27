Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37C820891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Ni8HjDNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37C820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbeG0Bgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:36:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44479 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731412AbeG0Bgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:36:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so1104514pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3HtTXyYvsoXmw6QEWn5VDf+kurGqzFcVFmbm1MXIsE=;
        b=Ni8HjDNqf8cubKkxprSCifTdL4MxV4jl9tGqyv249lhnebPk8PtwnSGJHaT7vhqnqP
         o3Me1PgMWkjsNjOie/jOQbG71Luts1IZT6E6dadubVmY7L8dM8+R5K9sIA+wDA+jPdv9
         A/q+URiLMvdOA/pXYmwRxIIv/Z0kYpNU1lJvb4A8yZwqQJIJYcHaXhfuYPVTjC5klZlx
         WnfuP5ZyG4lUn09bllxL2VNXWxnBPErCuBoiWXkVuTCxibGPzKajkaqlmuVx+ZENer2X
         nf8WPXCsHArbyr3JHAJ2p5vj2bDfsHhDZlNvrb9yx+D9a+MDXRuDRcalL5TwtrWfOOuP
         dvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3HtTXyYvsoXmw6QEWn5VDf+kurGqzFcVFmbm1MXIsE=;
        b=RRtQ/I8Y/sd4ixNYdi8e0T0CCTAD0fbg7GehMqAC7tGcZ8HpQJ3WgHrK9/eucFxC8r
         YD8v08WMAEvJXi/tpnsCObtI10wZZRJ8Z1VLFOeKcpc+qdBNqMMzl1qQavR0AXeLgoWv
         9uvBN2rwtNM5d5RtXfGqLsPrC7oy+PpUwPa0b2F1sZaDe4pgXBKDSGKUg55ZypaHZWu7
         jrCIFMkTer2GOLclijdV4ipqc4y3VjzYw27TQdbmugWc32ezExRUJwpUBVYy4PN77YUA
         w1Jjs3MJgyopgsdm+ztf5lpq8XkY8yHVUm8d6A574xc0WjML5yd7wxurSP0RFygIOOgj
         iXsQ==
X-Gm-Message-State: AOUpUlHgpn6uy7bb+n2HbdBN9m/5LhySdU0YupAxS7+ky6yXtuir9CLD
        FyfX7OWx1k6MfkqBJjz7zrxS7ASqC20=
X-Google-Smtp-Source: AAOMgpdwIYuQxI2KizQlyZNQcWKSYuLslx/+CtARc46klM9KmgT/XzR0KVf1Xb5q3jHp9jAydt2BuQ==
X-Received: by 2002:a65:4888:: with SMTP id n8-v6mr3900932pgs.149.1532650646937;
        Thu, 26 Jul 2018 17:17:26 -0700 (PDT)
Received: from sherryy2.mtv.corp.google.com ([2620:0:1000:1611:8e0a:214e:3e7b:4985])
        by smtp.gmail.com with ESMTPSA id q65-v6sm5345864pfj.127.2018.07.26.17.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 17:17:26 -0700 (PDT)
From:   Sherry Yang <sherryy@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     tkjos@google.com, maco@google.com,
        Sherry Yang <sherryy@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        devel@driverdev.osuosl.org (open list:ANDROID DRIVERS)
Subject: [PATCH 1/2] android: binder: Show extra_buffers_size in trace
Date:   Thu, 26 Jul 2018 17:17:17 -0700
Message-Id: <20180727001718.242587-2-sherryy@android.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180727001718.242587-1-sherryy@android.com>
References: <20180727001718.242587-1-sherryy@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra_buffers_size to the binder_transaction_alloc_buf tracepoint.

Acked-by: Arve Hjønnevåg <arve@android.com>
Signed-off-by: Sherry Yang <sherryy@android.com>
---
 drivers/android/binder_trace.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 76e3b9c8a8a2..588eb3ec3507 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -248,14 +248,17 @@ DECLARE_EVENT_CLASS(binder_buffer_class,
 		__field(int, debug_id)
 		__field(size_t, data_size)
 		__field(size_t, offsets_size)
+		__field(size_t, extra_buffers_size)
 	),
 	TP_fast_assign(
 		__entry->debug_id = buf->debug_id;
 		__entry->data_size = buf->data_size;
 		__entry->offsets_size = buf->offsets_size;
+		__entry->extra_buffers_size = buf->extra_buffers_size;
 	),
-	TP_printk("transaction=%d data_size=%zd offsets_size=%zd",
-		  __entry->debug_id, __entry->data_size, __entry->offsets_size)
+	TP_printk("transaction=%d data_size=%zd offsets_size=%zd extra_buffers_size=%zd",
+		  __entry->debug_id, __entry->data_size, __entry->offsets_size,
+		  __entry->extra_buffers_size)
 );
 
 DEFINE_EVENT(binder_buffer_class, binder_transaction_alloc_buf,
-- 
2.18.0.345.g5c9ce644c3-goog

