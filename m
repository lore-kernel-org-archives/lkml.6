Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE77C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B41B21581
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5S+egAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41B21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJII7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 04:08:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41840 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 04:08:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id 23-v6so2178273qkh.8;
        Tue, 09 Oct 2018 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S/y2QgbBWQ1jkuNfRAfJafUQ0B5BUpKTSPeonJXg4yU=;
        b=A5S+egAEDwLKARBsSYBK1PTB6a9F0a8mzeHewhKP4vwPyGqz/qjrOl6SEsOXt+jiWQ
         r6n4rvuJz4q3cuUhpj+zAwcileb567/fhfbQDSCNoD1hxZGqzRW/Ly98nalAeao9H4jo
         SwPAyTi+SXK1TnbU5ts91ZQirOeWRMJoRwxiF9rmOsI0DjudZXlR1p7gCCFVFAQT6VrF
         yhlpB1wTD3U2FG9CP5vXFDdLSy9e2ANLmShggoYWdJrYz75Owlniq3j6sRNGRGmMky4i
         pjP4lV6Pj8O7Bbrp7O2weqcheRpEC8FzHeHWomwnPdwqv5ZcNUy1os6G+RsVeWnOYLi2
         wQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S/y2QgbBWQ1jkuNfRAfJafUQ0B5BUpKTSPeonJXg4yU=;
        b=fWeXSwpDr1JxbHzH5EPL8iqQ+U6stO3NOH3WmJfj+OgzkCzLwkzTIk+W2ZErsbZGlu
         5n0YMxAMh0p+r5pMO9L+U2BKKxiU1ffW7cLms0L2CmbUGcRKQ/hku993K8NBA4F6ZwpY
         yOfSdFqYlQWynolSKH17Vs1HgOxAarp6S1F1ll/CU+UC733PyXYlyLtM7Zw+PgbMmnws
         YS+OdnvN/+E0/WIzPeY65yR+0f42uEznBje6tYGpyyBJZzzu72d8RdZcKW8KMclvJq5L
         iGYUxzGjRl6qFBOhbSGdBzFYHvNH/OlKkBSU95keEq3mN3XDJCqv0KMZiDkWOio4tqtN
         +ylA==
X-Gm-Message-State: ABuFfohXma3+IAcofIhYgR7ZFtGB1QvqdIqV0qqeSp75pDfcONnZs9Z4
        uclfPkzc5SJxNbZOIAB7tiE=
X-Google-Smtp-Source: ACcGV60h8mCvNhFQIxqNR/4IbS7n5sARrfYWtto1+Z3radnKH1n1OV7Kz9J79wo/PSye2XYda61dDw==
X-Received: by 2002:a37:5003:: with SMTP id e3-v6mr13630512qkb.102.1539132564852;
        Tue, 09 Oct 2018 17:49:24 -0700 (PDT)
Received: from gfm-note (wifi-177-220-84-73.wifi.ic.unicamp.br. [177.220.84.73])
        by smtp.gmail.com with ESMTPSA id i27-v6sm12708827qti.57.2018.10.09.17.49.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 17:49:24 -0700 (PDT)
Date:   Tue, 9 Oct 2018 21:49:21 -0300
From:   Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Subject: [PATCH] media: vivid: Improve timestamping
Message-ID: <20181010004921.GA6532@gfm-note>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simulate a more precise timestamp by calculating it based on the
current framerate.

Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
---
 drivers/media/platform/vivid/vivid-core.h        |  1 +
 drivers/media/platform/vivid/vivid-kthread-cap.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vivid/vivid-core.h b/drivers/media/platform/vivid/vivid-core.h
index cd4c823..cbdadd8 100644
--- a/drivers/media/platform/vivid/vivid-core.h
+++ b/drivers/media/platform/vivid/vivid-core.h
@@ -384,6 +384,7 @@ struct vivid_dev {
 	/* thread for generating video capture stream */
 	struct task_struct		*kthread_vid_cap;
 	unsigned long			jiffies_vid_cap;
+	u64				cap_stream_start;
 	u32				cap_seq_offset;
 	u32				cap_seq_count;
 	bool				cap_seq_resync;
diff --git a/drivers/media/platform/vivid/vivid-kthread-cap.c b/drivers/media/platform/vivid/vivid-kthread-cap.c
index f06003b..0793b15 100644
--- a/drivers/media/platform/vivid/vivid-kthread-cap.c
+++ b/drivers/media/platform/vivid/vivid-kthread-cap.c
@@ -416,6 +416,7 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 	char str[100];
 	s32 gain;
 	bool is_loop = false;
+	u64 soe_time = 0;
 
 	if (dev->loop_video && dev->can_loop_video &&
 		((vivid_is_svid_cap(dev) &&
@@ -426,11 +427,11 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 
 	buf->vb.sequence = dev->vid_cap_seq_count;
 	/*
-	 * Take the timestamp now if the timestamp source is set to
-	 * "Start of Exposure".
+	 * Store the current time to calculate the delta if source is set to
+	 * "End of Frame".
 	 */
-	if (dev->tstamp_src_is_soe)
-		buf->vb.vb2_buf.timestamp = ktime_get_ns();
+	if (!dev->tstamp_src_is_soe)
+		soe_time = ktime_get_ns();
 	if (dev->field_cap == V4L2_FIELD_ALTERNATE) {
 		/*
 		 * 60 Hz standards start with the bottom field, 50 Hz standards
@@ -556,12 +557,18 @@ static void vivid_fillbuff(struct vivid_dev *dev, struct vivid_buffer *buf)
 	}
 
 	/*
-	 * If "End of Frame" is specified at the timestamp source, then take
-	 * the timestamp now.
+	 * If "End of Frame", then calculate the "exposition time" and add
+	 * it to the timestamp.
 	 */
 	if (!dev->tstamp_src_is_soe)
-		buf->vb.vb2_buf.timestamp = ktime_get_ns();
-	buf->vb.vb2_buf.timestamp += dev->time_wrap_offset;
+		soe_time = ktime_get_ns() - soe_time;
+	buf->vb.vb2_buf.timestamp = dev->timeperframe_vid_cap.numerator *
+				    1000000000 /
+				    dev->timeperframe_vid_cap.denominator *
+				    dev->vid_cap_seq_count +
+				    dev->cap_stream_start +
+				    soe_time +
+				    dev->time_wrap_offset;
 }
 
 /*
@@ -759,6 +766,7 @@ static int vivid_thread_vid_cap(void *data)
 	dev->cap_seq_count = 0;
 	dev->cap_seq_resync = false;
 	dev->jiffies_vid_cap = jiffies;
+	dev->cap_stream_start = ktime_get_ns();
 
 	for (;;) {
 		try_to_freeze();
-- 
1.9.1

