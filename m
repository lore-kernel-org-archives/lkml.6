Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA89C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E10821564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUP0hycl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E10821564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeHWWCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:02:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34807 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeHWWCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:02:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id u10-v6so1331176pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/3CjhislnGGqU2g8MmW8SwCvogvUhECLJdE3KndpOdQ=;
        b=CUP0hyclBxjARnYZIqgC1rZExSxHVaRJ6nBohdn0WryRFx2dOKG4+LEUy+BorSCeWS
         wWlwOeE043TYImeCxzPcvt91AOUviZJA0IhMwIakRH/hYxA9eqo5dceu5NwsaTLNAggt
         clhjlutkPz95ooj0QXlPuYiwK+UM6XJyKODIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/3CjhislnGGqU2g8MmW8SwCvogvUhECLJdE3KndpOdQ=;
        b=MtT7UC6LsUVxfF15jL2ZwNfJYpjqLlkKFOY+H0by2m2F27sdE6M0fT7NqDCeUuM3Ax
         35mjH4WVjsVSp0F/0hk5Sl2nWw1a2ISdT5FbqJwKXFj0nqPPy8aHyD3IptYNSUQ6InYk
         2OOwK7vO2jJNxxe2PJtKYoO9v+ggAZD6Jwvn1Htb9mN1Kl3qF97FGF4rFdP+HxnMkx2Y
         XioCDcOk7cDQRrAA9aWzARGMv//J/XDOt4DwH8jbDfdIjau+OjeFnSkvSDuQ7H04bGV2
         SBXrEl9jDAecBmQ0D5tKPFyhOEU0EQTMJC4D9t2P7jAlFoAz9Z8P1jm1S8h8HUPSsWeW
         C/lA==
X-Gm-Message-State: APzg51BYAm7i0hTJzlYNwpYIIMEWi9NKHLD/ildAcV3Z4bYZxRq5iOmQ
        ey10hfpLn8j+UosrMXXGfeIgAQ==
X-Google-Smtp-Source: ANB0VdZHj3KxyeDaWF/JYIT1EXJYxyf6nl7xIC92Uw6WS9AEZxQdlX6W45BI+cKoEDajQY/5s4wOLA==
X-Received: by 2002:a62:cc83:: with SMTP id j3-v6mr1231705pfk.255.1535049095292;
        Thu, 23 Aug 2018 11:31:35 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id p11-v6sm9054225pfj.72.2018.08.23.11.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:31:34 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
Date:   Thu, 23 Aug 2018 11:30:55 -0700
Message-Id: <20180823183057.247630-2-hcutts@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
In-Reply-To: <20180823183057.247630-1-hcutts@chromium.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This event code represents scroll reports from high-resolution wheels,
and will be used by future patches in this series. See the linux-input
"Reporting high-resolution scroll events" thread [0] for more details.

[0]: https://www.spinics.net/lists/linux-input/msg57380.html

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

 Documentation/input/event-codes.rst    | 11 ++++++++++-
 include/uapi/linux/input-event-codes.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873beb95..df024cb82829 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -190,7 +190,16 @@ A few EV_REL codes have special meanings:
 * REL_WHEEL, REL_HWHEEL:
 
   - These codes are used for vertical and horizontal scroll wheels,
-    respectively.
+    respectively. The value is the number of "notches" moved on the wheel, the
+    physical size of which varies by device. For high-resolution wheels (which
+    report multiple events for each notch of movement, or do not have notches)
+    this may be an approximation based on the high-resolution scroll events.
+
+* REL_WHEEL_HI_RES:
+
+  - If a vertical scroll wheel supports high-resolution scrolling, this code
+    will be emitted in addition to REL_WHEEL. The value is the (approximate)
+    distance travelled by the user's finger, in 256ths of a millimeter.
 
 EV_ABS
 ------
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 53fbae27b280..dad8d3890a3a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,6 +708,7 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+#define REL_WHEEL_HI_RES	0x0a
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
-- 
2.18.0.1017.ga543ac7ca45-goog

