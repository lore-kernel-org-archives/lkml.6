Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966A420836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eiLlyZpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966A420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeFTKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:21:18 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57830 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTKVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:21:15 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180620102112epoutp0249f76ea053ff3f6f24dffd579d1e97c8~51x4eaIKL2706827068epoutp02Y
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:21:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180620102112epoutp0249f76ea053ff3f6f24dffd579d1e97c8~51x4eaIKL2706827068epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529490072;
        bh=8d1truYQ6IidyeEnvkyg+PcVINYHfEI9To84kpQN7xk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eiLlyZpGkNvVS96a5pWKFYI4kjOTT6MbTlcFzZg3VaZkzIseA/V8yHnAe0xmoDWTa
         h72PqpTmnfTudG6Qo4MWJI0EdyZv5cU7N9Q3OKuVl/1wEKMDlCoW+pXSpwwYeWcLRT
         /7TtbVdrLezydaJu1WF4yEvzGat0J6eeTU0IM3M0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.197]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180620102112epcas5p38b33375940929fa937596513e0b26425~51x4Fka6v2159521595epcas5p3Z;
        Wed, 20 Jun 2018 10:21:12 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.5F.04408.89A2A2B5; Wed, 20 Jun 2018 19:21:12 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b~51x3osnzY2939929399epcas5p4V;
        Wed, 20 Jun 2018 10:21:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180620102111epsmtrp2e977c940850f8cfc22305275b9c7e042~51x3nREcm2227022270epsmtrp2r;
        Wed, 20 Jun 2018 10:21:11 +0000 (GMT)
X-AuditID: b6c32a4b-989ff70000001138-98-5b2a2a9814f5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.C0.03632.79A2A2B5; Wed, 20 Jun 2018 19:21:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180620102109epsmtip12620b8b1546d3c57000af46f4a3ae927~51x1nARqu2699026990epsmtip1c;
        Wed, 20 Jun 2018 10:21:09 +0000 (GMT)
From:   Namit Gupta <gupta.namit@samsung.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com,
        Namit Gupta <gupta.namit@samsung.com>
Subject: [PATCH 1/1] remove unnecessary calls of kmalloc and kfree from
 syslog.
Date:   Wed, 20 Jun 2018 15:46:24 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmlu4MLa1og67nohYXd6daHDxwmtVi
        Xst5FovLu+awWdx7s5XJ4v/jr6wW+zoeMFms/fyY3YHDY+esu+weLftusXv0bVnF6LF+y1UW
        j8+b5AJYo1JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
        c4BOUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKkUbGhrpGRqY6xkZAWnTWCsjU6CShNSM
        q62rmAp+qVTM//2DvYFxh3QXIyeHhICJxMq565m6GLk4hAR2M0o8PbmJFcL5xCjx5sFsKOcb
        o0THw09ADgdYy8VPuRDxvYwSf5/sZAUZJSTwhVFixuRQEJtNQFti2//JzCC2iIC7xKfvH9hA
        GpgFJjJKTGr6zgSSEBYIlLjW1cQGYrMIqEosXL+VBeImOYmTxyaDbZYQmMAmsfHhCbAiXoEy
        iSsbfjNBFLlIvH3zEMoWlnh1fAs7hC0l8fndXjaI5mZGiRWbjzJCOFMYJVqez2OFqLKXeHDj
        KDvIP8wCmhLrd+mDhJkF+CR6fz9hgniTV6KjTQiiWlVix9Uj7BBhaYnZyw0gwh4Svy6dAKsW
        EoiV+H3CaQKjzCyEkQsYGVcxSqYWFOempxabFhjnpZbrFSfmFpfmpesl5+duYgQnJy3vHYyb
        zvkcYhTgYFTi4WVg1owWYk0sK67MPcQowcGsJMLLcEojWog3JbGyKrUoP76oNCe1+BCjKTDM
        JjJLiSbnAxNnXkm8oamRmZmBpYGpsYWZoZI474/rAtFCAumJJanZqakFqUUwfUwcnFINjKEL
        43/UzjpiduPlssqEXA6H3NCeuPYpu/iWap96cHSblKqYQ+YvnV8f8+V2K03w/Mm42pyZ02Ab
        j26sn+fZ+9vLP4stvqeio+9qeTSmqWLawZmLcsvY/N5t0jAVrVqy/eDy7X0n3xemGSxx7ms8
        ybFfenK0Q9i1b5OOFDF/28WkdGxa9doV0kosxRmJhlrMRcWJAHzUtu5kAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJTne6lla0wcuvuhYXd6daHDxwmtVi
        Xst5FovLu+awWdx7s5XJ4v/jr6wW+zoeMFms/fyY3YHDY+esu+weLftusXv0bVnF6LF+y1UW
        j8+b5AJYo7hsUlJzMstSi/TtErgyrrauYir4pVIx//cP9gbGHdJdjBwcEgImEhc/5XYxcnEI
        CexmlHi7dSdLFyMnUFxaYmLzF2YIW1hi5b/n7CC2kMAnRomf1ytBbDYBbYlt/yeD1YgIeEtM
        vf6LEWQQs8BURoknN7cwgywQFvCXOP9cD6SGRUBVYuH6rWDzeQXcJO7tvMEOMV9O4uSxyawT
        GHkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDiUtzR2Ml5fEH2IU4GBU4uFl
        YNaMFmJNLCuuzD3EKMHBrCTCy3BKI1qINyWxsiq1KD++qDQntfgQozQHi5I479O8Y5FCAumJ
        JanZqakFqUUwWSYOTqkGxsxKTq0Nzy/E3v3neitpQ/Dj8sUnHKv8p8vk3bA1M73K630hUCZ/
        6cYaDaNr26snPXhiVJrq8Tf2S+m5t8b55mv77rWFRl89mV96Ju37K65V3tfPdO/Q2PH3vY6G
        q6W6t9/mnecKp8e97fqwZzpzR7DFaqPwymU57+32BjSyyUy3YDTcXl91XYmlOCPRUIu5qDgR
        ANpIFjkhAgAA
Message-Id: <20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b~51x3osnzY2939929399epcas5p4V@epcas5p4.samsung.com>
X-CMS-MailID: 20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b
References: <CGME20180620102111epcas5p43b88ec3765ff3b088a8ec1c9e97dd71b@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below are the actual changes, rest all other visible changes are because of indentation.
==========================================================================================
@@ -1348,16 +1348,23 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 {
    char *text;
    int len = 0;
+   u64 next_seq;
+   u64 seq;
+   u32 idx;
+
+	if (!buf) {
+		if (clear) {
+			logbuf_lock_irq();
+			clear_seq = log_next_seq;
+			clear_idx = log_next_idx;
+			logbuf_unlock_irq();
+		}
+		return 0;
+	}
+
 
    text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
    if (!text)
            return -ENOMEM;
 
    logbuf_lock_irq();
-   if (buf) {
-      u64 next_seq;
-      u64 seq;
-      u32 idx;
 
    /*
     * Find first record that fits, including all following records,
@@ -1414,7 +1421,6 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
                    idx = log_first_idx;
            }
    }
-   }
 
    if (clear) {
            clear_seq = log_next_seq;
==========================================================================================

Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>

---
 kernel/printk/printk.c | 111 ++++++++++++++++++++++++++-----------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 512f7c2..53952ce 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1348,71 +1348,80 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 {
 	char *text;
 	int len = 0;
+	u64 next_seq;
+	u64 seq;
+	u32 idx;
+
+	if (!buf) {
+		if (clear) {
+			logbuf_lock_irq();
+			clear_seq = log_next_seq;
+			clear_idx = log_next_idx;
+			logbuf_unlock_irq();
+		}
+		return 0;
+	}
+
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
 	logbuf_lock_irq();
-	if (buf) {
-		u64 next_seq;
-		u64 seq;
-		u32 idx;
 
-		/*
-		 * Find first record that fits, including all following records,
-		 * into the user-provided buffer for this dump.
-		 */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-
-			len += msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+	/*
+	 * Find first record that fits, including all following records,
+	 * into the user-provided buffer for this dump.
+	 */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-		/* move first record forward until length fits into the buffer */
-		seq = clear_seq;
-		idx = clear_idx;
-		while (len > size && seq < log_next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
+		len += msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-			len -= msg_print_text(msg, true, NULL, 0);
-			idx = log_next(idx);
-			seq++;
-		}
+	/* move first record forward until length fits into the buffer */
+	seq = clear_seq;
+	idx = clear_idx;
+	while (len > size && seq < log_next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
 
-		/* last message fitting into this dump */
-		next_seq = log_next_seq;
+		len -= msg_print_text(msg, true, NULL, 0);
+		idx = log_next(idx);
+		seq++;
+	}
 
-		len = 0;
-		while (len >= 0 && seq < next_seq) {
-			struct printk_log *msg = log_from_idx(idx);
-			int textlen;
+	/* last message fitting into this dump */
+	next_seq = log_next_seq;
 
-			textlen = msg_print_text(msg, true, text,
-						 LOG_LINE_MAX + PREFIX_MAX);
-			if (textlen < 0) {
-				len = textlen;
-				break;
-			}
-			idx = log_next(idx);
-			seq++;
+	len = 0;
+	while (len >= 0 && seq < next_seq) {
+		struct printk_log *msg = log_from_idx(idx);
+		int textlen;
 
-			logbuf_unlock_irq();
-			if (copy_to_user(buf + len, text, textlen))
-				len = -EFAULT;
-			else
-				len += textlen;
-			logbuf_lock_irq();
+		textlen = msg_print_text(msg, true, text,
+				LOG_LINE_MAX + PREFIX_MAX);
+		if (textlen < 0) {
+			len = textlen;
+			break;
+		}
+		idx = log_next(idx);
+		seq++;
 
-			if (seq < log_first_seq) {
-				/* messages are gone, move to next one */
-				seq = log_first_seq;
-				idx = log_first_idx;
-			}
+		logbuf_unlock_irq();
+		if (copy_to_user(buf + len, text, textlen))
+			len = -EFAULT;
+		else
+			len += textlen;
+		logbuf_lock_irq();
+
+		if (seq < log_first_seq) {
+			/* messages are gone, move to next one */
+			seq = log_first_seq;
+			idx = log_first_idx;
 		}
 	}
 
-- 
1.9.1

