Return-Path: <cwahbong@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523846226; cv=none;
        d=google.com; s=arc-20160816;
        b=DWIuO3tMyNVF3f40bDue5JTIaunPkfF+WDRsVR9yj2jV4vFIu6OWn91Xua80iurpaN
         a1sQj6JCBKNYiObq21/vifWJnsWDQm9EPrYsXMryKbZQmHzyD0FdkfhU4ooczF1VAXsG
         e1Fe3z8x9r7xwQLGG/cELeuv+mCPeuemgrTU51B7i9B7uPRSEZQo0mGSg4sMND3d7Zmm
         3RMeRPOuWdpE1CMgj0hkWvU1cP2aS36QzU+e678swI9Er3yVjMB5ug8HDtScFkVgjd2h
         3TBI2rHthnmolIDRHYTVpQT/x39qK2bTTxtIvX/ihYOSMB8WcMKfhwhF7UuEZEMyecyb
         dGVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=a/AnC9AGzqEErG867KM9kzIrxYL1xB2M/dfFGn4cgWA=;
        b=yLC+43fYQD2AsY16775/OWu06I8+Bjv1uDp2Soz21Z6KFuQeYN5R42NdmwdiYCSLIK
         SguRevTG+RKkTo8oAIEnh17O6CcQv/cPQ20ZIJtb4Lx+h0S6zU3GPUNHDiLMSMMl37/H
         Cou2BTzRh0BtLxgpnHv8IKnAPib5Xf+P2zUSh9wY0dlA4UpW9tKD5EQhvaFGNKLumN8o
         SWw/QewPmbU3/mWDF9Yt7Q5hLrzxsgl4SXHffMNAuJZASlcnhgDbRmUmKEiPrpe2QfCV
         601bdfSKd2tBbtgKHcQn/o9Z185w30/GoPSivxZk4V0ZCigEiKXvsOQcD+2RBcoZ2mbq
         UI2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jIRv9KmR;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jIRv9KmR;
       spf=pass (google.com: domain of cwahbong@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cwahbong@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx49EI2Pl9XNAfg09OJ33ntk04UVIuVL4Hgl73Rh6G3x6qVJLFqjmRLo8KDCuBSE4XvPJsatUlA==
From: Ahbong Chang <cwahbong@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ahbong Chang <cwahbong@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Todd Poynor <toddpoynor@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>
Subject: [PATCH] trace: add missing forward declaration
Date: Mon, 16 Apr 2018 10:36:25 +0800
Message-Id: <20180416023626.139915-1-cwahbong@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597868580333311001?=
X-GMAIL-MSGID: =?utf-8?q?1597868580333311001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Without this forward declaration compile may fail if this header is
included only for registering other probe event without struct
pool_workqueue.

Signed-off-by: Ahbong Chang <cwahbong@google.com>
Reviewed-by: Todd Poynor <toddpoynor@google.com>
---
 include/trace/events/workqueue.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/workqueue.h b/include/trace/events/workqueue.h
index 2f057a494d93..9a761bc6a251 100644
--- a/include/trace/events/workqueue.h
+++ b/include/trace/events/workqueue.h
@@ -25,6 +25,8 @@ DECLARE_EVENT_CLASS(workqueue_work,
 	TP_printk("work struct %p", __entry->work)
 );
 
+struct pool_workqueue;
+
 /**
  * workqueue_queue_work - called when a work gets queued
  * @req_cpu:	the requested cpu
-- 
2.17.0.484.g0c8726318c-goog
