Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D215C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C083208A6
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 14:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrNnHEGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C083208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755287AbeFQOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 10:36:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33860 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753206AbeFQOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 10:36:52 -0400
Received: by mail-lf0-f68.google.com with SMTP id o9-v6so20963134lfk.1;
        Sun, 17 Jun 2018 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=HY1gMUcEt/5Z0ien+rGTNNg2u40OltYZ0FZ27yIRsw8=;
        b=WrNnHEGndGrTUpSvTsWsbyOPg6IFtn7ZVC51A246erCoCzwf27IMFBnpRwuwQ4Zb4x
         df5AwllbBXbtWpfGWAB/xjnxJfxh1qR4e7cOhxOaXClgw/Gkr1UAaaQ9Lx+NRXoO+IfK
         bZcsvCM0IKRck5NUBqIVSBcTg+4HlncsyTGhAyAQuhZx+BaPufPGk/Pts38rM0p4rCGn
         yqo3W0NJq3oMJzHIQX+oMx9Fe45Y2IHbPzEy31U1+/fSRX5Pxzs6bT37aHNejkZNP74/
         2wgfGQUHd/D58wuk7ba8WwshpqB4JMjtJelf/WPaRzr37944Aej3047MMVhDZeNlo9QY
         uCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=HY1gMUcEt/5Z0ien+rGTNNg2u40OltYZ0FZ27yIRsw8=;
        b=mGstDBNBCABzqqetoNDksfV6vM6+sUtvbfy/ag9Z88ztEJB+6GZ6HiqJUu5hjOIiU/
         mgIJoXvOxNT9EM0KCRJUIhkZJK6MmNRUbOsew1PlBfbyq0UWDjZn1NjtKoFz3oy4YthV
         lcF/E4xdoATKcuFk/harBe09d+UEeTSbg3OmTp+ss79dwk+Kuv23nj+w+APs+X6VuZ2O
         z4lM0vK8TlMPg8QLiR+6Zd0Hq+2rJFG75ZpbGB8iC5DEvCKhUIGV4cIzoSDkTgT61XcC
         7L2NDrNL6McRHd1RpuDc+4sQVsDCNl1LMreESjC+8KtFGv1NY7CFscK/qzFYl7pJJUDX
         pyeg==
X-Gm-Message-State: APt69E2s5M9dlbuzuzQAUinEwZuAjZTWPl3V2EiD/JUJ3ERN8hGzKjcW
        ujSYeF8RttrO5yCKOK2IwZ8=
X-Google-Smtp-Source: ADUXVKKQLU8hCup7VkDyqC37R9L5NSypZ7y8xIjPobj+mS1s5lZN+qTVS6C0cXmd/K5fqjfpKDMruw==
X-Received: by 2002:a2e:878f:: with SMTP id n15-v6mr5770957lji.69.1529246211127;
        Sun, 17 Jun 2018 07:36:51 -0700 (PDT)
Received: from linux-2y6e.local ([92.243.181.209])
        by smtp.gmail.com with ESMTPSA id l19-v6sm2381120lfk.30.2018.06.17.07.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 07:36:50 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, isely@pobox.com,
        bhumirks@gmail.com, colin.king@canonical.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH 1/2] Add TRACE_EVENTs in pwc_isoc_handler()
Date:   Sun, 17 Jun 2018 17:36:24 +0300
Message-Id: <20180617143625.32133-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.0-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/media/usb/pwc/pwc-if.c |  7 +++++++
 include/trace/events/pwc.h     | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/trace/events/pwc.h

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 54b036d39c5b..5775d1f60668 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -57,6 +57,9 @@
    - Pham Thanh Nam: webcam snapshot button as an event input device
 */
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pwc.h>
+
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/mm.h>
@@ -260,6 +263,8 @@ static void pwc_isoc_handler(struct urb *urb)
 	int i, fst, flen;
 	unsigned char *iso_buf = NULL;
 
+	trace_pwc_handler_enter(urb);
+
 	if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
 	    urb->status == -ESHUTDOWN) {
 		PWC_DEBUG_OPEN("URB (%p) unlinked %ssynchronously.\n",
@@ -347,6 +352,8 @@ static void pwc_isoc_handler(struct urb *urb)
 		pdev->vlast_packet_size = flen;
 	}
 
+	trace_pwc_handler_exit(urb);
+
 handler_end:
 	i = usb_submit_urb(urb, GFP_ATOMIC);
 	if (i != 0)
diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
new file mode 100644
index 000000000000..b13d2118bb7a
--- /dev/null
+++ b/include/trace/events/pwc.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(_TRACE_PWC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PWC_H
+
+#include <linux/usb.h>
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pwc
+
+TRACE_EVENT(pwc_handler_enter,
+	TP_PROTO(struct urb *urb),
+	TP_ARGS(urb),
+	TP_STRUCT__entry(
+		__field(struct urb*, urb)
+		__field(int, urb__status)
+		__field(u32, urb__actual_length)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+		__entry->urb__status = urb->status;
+		__entry->urb__actual_length = urb->actual_length;
+	),
+	TP_printk("urb=%p (status=%d actual_length=%u)",
+		__entry->urb,
+		__entry->urb__status,
+		__entry->urb__actual_length)
+);
+
+TRACE_EVENT(pwc_handler_exit,
+	TP_PROTO(struct urb *urb),
+	TP_ARGS(urb),
+	TP_STRUCT__entry(
+		__field(struct urb*, urb)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+	),
+	TP_printk("urb=%p", __entry->urb)
+);
+
+#endif /* _TRACE_PWC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.16.0-rc1

