Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7AAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E9F21564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 18:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RGjaQ5tL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E9F21564
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeHWWCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:02:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42444 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeHWWCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:02:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3224376pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJQ6YBPrl6gFzj3eIjWskmozE9vOcWXWtBqmjfcrGkQ=;
        b=RGjaQ5tLfnGsUPEwJrlWAQkGwTNt3A9J/X0xjQchjRoro5cTXEpg/Mo91DW6h+oAaS
         cQ9/ORH0yKcO+SOPsPlTG3Bkq1ff2Z9NwjOS84vllSacRlXDBdUtL7VEbJExjFb+wkAg
         aWTq/hfEqmxyu3Y1KsbVDFq6eku8mJVJ57/CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJQ6YBPrl6gFzj3eIjWskmozE9vOcWXWtBqmjfcrGkQ=;
        b=VRbG3jaMBPq0fU0SM6hRctAraYF+ivsH+hwJF/RSYSlfaH1/1hlK8re6iJ06mf7DC8
         iFcENCXDlNm/w/NI7PXkj2ctTEnAxKyzXlX4BpCdpWGQvgg4M60EKZv6GXwSK3DyefBk
         Vo+YyRqm+f9W6aac4MEsf8k/48lRfMcVh6nmuiEHZJdpylm16Jca9hk9qq/n3RwuETIk
         vQ38f0mzOtN9z8kTgIumXlU8Vkzc12/T4HJSM7glogPJ+v89vO/vhY/azizJDJ5ugUpO
         4d0QunYnMyEjH4/1xmfz+B5DY3whWFPc9vijhbRv/LgjFu32mGC3ti/IL31tVOJgZje1
         OuBw==
X-Gm-Message-State: AOUpUlEF/kJMIhWOfJqcejJ5HgwsRub60SRjVd2T14bO+ZuVVuQHmfSx
        7GUQdYsGczrFPdRZQtcLxD72rA==
X-Google-Smtp-Source: AA+uWPx9ijcMfS+e12cI5pn3/hhJoWw+m1hPY00RFGYKm05aVzPiXmGps/eWVee6oH0hHgKWhxmgRg==
X-Received: by 2002:a63:5143:: with SMTP id r3-v6mr57569888pgl.11.1535049102962;
        Thu, 23 Aug 2018 11:31:42 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id p11-v6sm9054225pfj.72.2018.08.23.11.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 11:31:42 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 2/3] Create a utility class for counting scroll events
Date:   Thu, 23 Aug 2018 11:30:56 -0700
Message-Id: <20180823183057.247630-3-hcutts@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
In-Reply-To: <20180823183057.247630-1-hcutts@chromium.org>
References: <20180823183057.247630-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid code duplication, this class counts high-resolution scroll
movements and emits the legacy low-resolution events when appropriate.
Drivers should create one instance for each scroll wheel that they
need to handle.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

 drivers/hid/hid-input.c | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     | 28 ++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4e94ea3e280a..4ee23b297472 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1826,3 +1826,47 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
+/**
+ * hid_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
+ *                                      events given a high-resolution wheel
+ *                                      movement.
+ * @counter: a hid_scroll_counter struct describing the wheel.
+ * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
+ *                units.
+ *
+ * Given a high-resolution movement, this function converts the movement into
+ * 256ths of a millimeter and emits high-resolution scroll events for the input
+ * device. It also uses the multiplier from &struct hid_scroll_counter to emit
+ * low-resolution scroll events when appropriate for backwards-compatibility
+ * with userspace input libraries.
+ */
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value)
+{
+	int low_res_scroll_amount;
+	/* Some wheels often rest 7/8ths of a notch from the previous notch
+	 * after slow movement, so we want the threshold for low-res events in
+	 * between the notches (e.g. after 4/8ths) as opposed to on the notches
+	 * themselves (8/8ths).
+	 */
+	int threshold = counter->resolution_multiplier / 2;
+
+	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
+			 hi_res_value * counter->mm256_per_hi_res_unit);
+
+	counter->remainder += hi_res_value;
+	if (abs(counter->remainder) >= threshold) {
+		/* Add (or subtract) 1 because we want to trigger when half-way
+		 * to the next notch (i.e. scroll 1 notch after a 1/2 notch
+		 * movement, 2 notches after a 1 1/2 notch movement, etc.).
+		 */
+		low_res_scroll_amount =
+			counter->remainder / counter->resolution_multiplier
+			+ (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL,
+				 low_res_scroll_amount);
+		counter->remainder -=
+			low_res_scroll_amount * counter->resolution_multiplier;
+	}
+}
+EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 834e6461a690..b7bc0b2faf4f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1138,6 +1138,34 @@ static inline u32 hid_report_len(struct hid_report *report)
 int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
+
+/**
+ * struct hid_scroll_counter - Utility class for processing high-resolution
+ *                             scroll events.
+ * @dev: the input device for which events should be reported.
+ * @mm256_per_hi_res_unit: the amount moved by the user's finger for each
+ *                         high-resolution unit reported by the mouse, in 256ths
+ *                         of a millimetre.
+ * @resolution_multiplier: the wheel's resolution in high-resolution mode as a
+ *                         multiple of its lower resolution. For example, if
+ *                         moving the wheel by one "notch" would result in a
+ *                         value of 1 in low-resolution mode but 8 in
+ *                         high-resolution, the multiplier is 8.
+ * @remainder: counts the number of high-resolution units moved since the last
+ *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
+ *             only be used by class methods.
+ */
+struct hid_scroll_counter {
+	struct input_dev *dev;
+	int mm256_per_hi_res_unit;
+	int resolution_multiplier;
+
+	int remainder;
+};
+
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value);
+
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
-- 
2.18.0.1017.ga543ac7ca45-goog

