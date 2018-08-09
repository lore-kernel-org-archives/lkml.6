Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464B9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9801204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlKnTk/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9801204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbeHIL5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:57:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45421 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeHIL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:57:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id w16-v6so3931174ljh.12;
        Thu, 09 Aug 2018 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MsxQtKicMps7iX/z+bV6JkZUSlwCqI8LP9gK89aqXLs=;
        b=rlKnTk/KdPygpmQk4eReSMLixi5k6bVUrahCi8beRsr76NDSkCravm9dDCUADXmZ8J
         zp94NU+CpPqfslbR52bjfsChYzJSJ8FjZOkPRmsgoyPvqH2sUbxdG4gXaKf3MjTLdnut
         IRMIWQPOUoIEIVSixZ0x306YawyFuZ9b9ecZg9VE7jhn2qTKAebtj9naw2hGp6FbNpEz
         jskdqxtis80cta6NsRsWIZjW3egrFAfRFBwHK501cywA7Sm9TY4gQvV6lEi3WAAEzj/d
         NL8P51B4LLs0xaPe7gBF2YeDYv7AagfUX7UwK6adsO7ZnEooPqW9TYdTz4JWmt9q9OAK
         AZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MsxQtKicMps7iX/z+bV6JkZUSlwCqI8LP9gK89aqXLs=;
        b=cvWwsLeN1VW0trBOOZjFa02zvHzfuw+xR93SzkzzW4pgrNbYCQ+7koTjs45vdHqqxU
         9pW22M0l9jlFRs3AYKKLmXyr5adNdqluYzDXd8cQLyBH2GgJIxTDg2nymfSvy9vUR26w
         8SkI1/nL3Mi8B1yx6+XxOgEgvt8LylQSO2r+pHZCTYkTUJmLAFC94BjlYenMA3wH6bGu
         MlNnp7ov/tRXMOeCbCFhSxYDWh23cOq8PYklgMTEZErbTXoKP7gnXXKMIuNlwUXzKMEv
         U6r84PZ3Rkcy/eSawFqe9ev+b+7bGImeprhQT7cTx5qiz5D6s5VzQm1BYlsx6AZXpLxN
         X6Yg==
X-Gm-Message-State: AOUpUlFr8vXnifOs5FIYrvQ7emmmoBUBQ9SI3Naw+UEZM3rc8gerHmPF
        905+7TdrCAbxtQ7Bd1/kqbLr1/X4UTs=
X-Google-Smtp-Source: AA+uWPx40Xg5R7NOyNxS+eN5+6hn9xE363p/4LieQHWNZ+ybN9m194qOQI52nUWFinl6sL2j6zF5DQ==
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr1099459ljd.104.1533807210035;
        Thu, 09 Aug 2018 02:33:30 -0700 (PDT)
Received: from alpha.sai.msu.ru ([93.180.21.1])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1070721ljg.62.2018.08.09.02.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:33:29 -0700 (PDT)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>, tfiga@chromium.org,
        laurent.pinchart@ideasonboard.com, stern@rowland.harvard.edu,
        ezequiel@collabora.com, hdegoede@redhat.com, hverkuil@xs4all.nl,
        mchehab@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        isely@pobox.com, bhumirks@gmail.com, colin.king@canonical.com,
        kieran.bingham@ideasonboard.com, keiichiw@chromium.org
Subject: [PATCH v3 1/2] media: usb: pwc: Introduce TRACE_EVENTs for pwc_isoc_handler()
Date:   Thu,  9 Aug 2018 12:33:06 +0300
Message-Id: <20180809093307.6001-2-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180809093307.6001-1-matwey@sai.msu.ru>
References: <20180809093307.6001-1-matwey@sai.msu.ru>
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
index 000000000000..71ba98770537
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
+		__field(const char*, name)
+		__field(struct pwc_frame_buf*, fbuf)
+		__field(int, fbuf__filled)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+		__entry->urb__status = urb->status;
+		__entry->urb__actual_length = urb->actual_length;
+		__entry->name = pdev->v4l2_dev.name;
+		__entry->fbuf = pdev->fill_buf;
+		__entry->fbuf__filled = (pdev->fill_buf ? pdev->fill_buf->filled : 0);
+	),
+	TP_printk("dev=%s (fbuf=%p filled=%d) urb=%p (status=%d actual_length=%u)",
+		__entry->name,
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
+		__field(const char*, name)
+		__field(struct pwc_frame_buf*, fbuf)
+		__field(int, fbuf__filled)
+	),
+	TP_fast_assign(
+		__entry->urb = urb;
+		__entry->name = pdev->v4l2_dev.name;
+		__entry->fbuf = pdev->fill_buf;
+		__entry->fbuf__filled = pdev->fill_buf->filled;
+	),
+	TP_printk(" dev=%s (fbuf=%p filled=%d) urb=%p",
+		__entry->name,
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

