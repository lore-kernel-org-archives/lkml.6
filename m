Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5EBC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD432419C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6kr7Z73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD432419C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933191AbeFVMEn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:04:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39596 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbeFVMEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:04:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id t2-v6so8611483lfd.6;
        Fri, 22 Jun 2018 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pwyO2hqgjXvQ1ArP/eHWgSkTsTtLlQ59Bespivq+iLM=;
        b=H6kr7Z73KTS+UyP79d4OCoY2nVaYNKs4XdQ3Xp7GjmfAVqwOKRY2F9IwGONOg9PtF/
         31ihxd4Wsb3dJ9UqXYvnG3KQi1de4DwXPmBzWBnlPaEjdfQmos5VvVGtVk35xT1gHTlH
         tFvddAcben14xxkRSFeOQdF17R5VT5qRGZV9jGLNp4uzKv+tvu0PuTXBlLqHTLzcvV4z
         zb+/LG/QkU7KT/t343uscvRNsLy1BS1jLFPksn2uWDmyh65EihntdScFZVgr0byiD4YN
         HghIyTn90qmQI1PhWLp/S+rQNSQHvP6MwbxnFLkGYI4SS/p2xk20sNy0bXxm4kLipEjr
         O/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=pwyO2hqgjXvQ1ArP/eHWgSkTsTtLlQ59Bespivq+iLM=;
        b=r5R/N/IF/1P4eGp1ZSsRcQP8AeKIr0oQsv8MvM3TfUm1qkGk/MRTQFQ+BPn/DZ6k3D
         bkvobRVnqj7ADQSU7o1GZFx4b/jBhqdS3inNP9IwElkNrR3i7klZzqNelkxclHRIGTuG
         RQEj6MFOrl1NUEhcBgvv2wY/yEoveQXyVDCjBhPfmTNL+FC7XI5rZLXdn9wF6kIWPrqX
         gvqQEtZqC9SAqLstTYkzSZGw3Zbghfd+9fU/QMWp+1ZSn1bcunXkXCiRJL+qCTpd09LR
         ZdmCh77gThwB/lQSmUO1kuzTBGsm88xnJJT1RS4guEGkQFqQxmAN12lyvC+U49EvGx6k
         sthw==
X-Gm-Message-State: APt69E0PgV2acgjwEv6JqTHJQPc3W8YIPgLNXfOh61UVKIKWaVioknbq
        ohe7V0ImvaNlAHfwmCLdMqk=
X-Google-Smtp-Source: ADUXVKJdPkP7g1aqUe/7OFkV2DWqvl7a9+IjFrXMFor6rohtxuP8UVu7PAAIcpLYhDf3kKe+hBGtPA==
X-Received: by 2002:a2e:9789:: with SMTP id y9-v6mr1150046lji.52.1529669075589;
        Fri, 22 Jun 2018 05:04:35 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id a77-v6sm1433663lfb.37.2018.06.22.05.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 05:04:34 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>, rostedt@goodmis.org,
        mingo@redhat.com, isely@pobox.com, bhumirks@gmail.com,
        colin.king@canonical.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ezequiel@collabora.com,
        laurent.pinchart@ideasonboard.com
Subject: [PATCH v2 1/2] media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
Date:   Fri, 22 Jun 2018 15:04:18 +0300
Message-Id: <20180622120419.7675-2-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622120419.7675-1-matwey@sai.msu.ru>
References: <20180622120419.7675-1-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were reports that PWC-based webcams don't work at some
embedded ARM platforms. [1] Isochronous transfer handler seems to
work too long leading to the issues in MUSB USB host subsystem.
Also note, that urb->giveback() handlers are still called with
disabled interrupts. In order to be able to measure performance of
PWC driver, traces are introduced in URB handler section.

[1] https://www.spinics.net/lists/linux-usb/msg165735.html

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/media/usb/pwc/pwc-if.c |  7 +++++
 include/trace/events/pwc.h     | 64 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 include/trace/events/pwc.h

diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index 54b036d39c5b..72d2897a4b9f 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -76,6 +76,9 @@
 #include "pwc-dec23.h"
 #include "pwc-dec1.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pwc.h>
+
 /* Function prototypes and driver templates */
 
 /* hotplug device table support */
@@ -260,6 +263,8 @@ static void pwc_isoc_handler(struct urb *urb)
 	int i, fst, flen;
 	unsigned char *iso_buf = NULL;
 
+	trace_pwc_handler_enter(urb, pdev);
+
 	if (urb->status == -ENOENT || urb->status == -ECONNRESET ||
 	    urb->status == -ESHUTDOWN) {
 		PWC_DEBUG_OPEN("URB (%p) unlinked %ssynchronously.\n",
@@ -348,6 +353,8 @@ static void pwc_isoc_handler(struct urb *urb)
 	}
 
 handler_end:
+	trace_pwc_handler_exit(urb, pdev);
+
 	i = usb_submit_urb(urb, GFP_ATOMIC);
 	if (i != 0)
 		PWC_ERROR("Error (%d) re-submitting urb in pwc_isoc_handler.\n", i);
diff --git a/include/trace/events/pwc.h b/include/trace/events/pwc.h
new file mode 100644
index 000000000000..d5bcb1314d0e
--- /dev/null
+++ b/include/trace/events/pwc.h
@@ -0,0 +1,64 @@
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
+	TP_PROTO(struct urb *urb, struct pwc_device *pdev),
+	TP_ARGS(urb, pdev),
+	TP_STRUCT__entry(
+		__field(struct urb*, urb)
+		__field(int, urb__status)
+		__field(u32, urb__actual_length)
+		__field(char*, devpath)
+		__field(struct pwc_frame_buf*, fbuf)
+		__field(int, fbuf__filled)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+		__entry->urb__status = urb->status;
+		__entry->urb__actual_length = urb->actual_length;
+		__entry->devpath = pdev->udev->devpath;
+		__entry->fbuf = pdev->fill_buf;
+		__entry->fbuf__filled = pdev->fill_buf->filled;
+	),
+	TP_printk("devpath=%s (fbuf=%p filled=%d) urb=%p (status=%d actual_length=%u)",
+		__entry->devpath,
+		__entry->fbuf,
+		__entry->fbuf__filled,
+		__entry->urb,
+		__entry->urb__status,
+		__entry->urb__actual_length)
+);
+
+TRACE_EVENT(pwc_handler_exit,
+	TP_PROTO(struct urb *urb, struct pwc_device* pdev),
+	TP_ARGS(urb, pdev),
+	TP_STRUCT__entry(
+		__field(struct urb*, urb)
+		__field(char*, devpath)
+		__field(struct pwc_frame_buf*, fbuf)
+		__field(int, fbuf__filled)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+		__entry->devpath = pdev->udev->devpath;
+		__entry->fbuf = pdev->fill_buf;
+		__entry->fbuf__filled = pdev->fill_buf->filled;
+	),
+	TP_printk("devpath=%s (fbuf=%p filled=%d) urb=%p",
+		__entry->devpath,
+		__entry->fbuf,
+		__entry->fbuf__filled,
+		__entry->urb)
+);
+
+#endif /* _TRACE_PWC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.16.4

