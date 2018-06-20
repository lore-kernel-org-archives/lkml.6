Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EEEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE11D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tZQa6miW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE11D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeFTN75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:59:57 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54847 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeFTN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:59:55 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180620135953epoutp028670647687eef2bdbb199d99f492d859~54wz8PixH2243722437epoutp02k
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180620135953epoutp028670647687eef2bdbb199d99f492d859~54wz8PixH2243722437epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529503193;
        bh=GkBMksghbN2LkdLjaR7Yd4gPKncpAZHToJ0Kp8NFP68=;
        h=From:To:Cc:Subject:Date:References:From;
        b=tZQa6miWcgX3hB1pGMsEuaENs9CgGjnVpc14SCz0P7FqQmZdomdjq3S9wa5R3AMYx
         +S7e5NQnHNPH7yJ4oAxTxmohQ55Vk1awI1Ktiuxp0LJP+ITQ9F0aY9Jk+r2/3tSjgu
         DrXSsJXOcTLxYp/2r7dnBxj6OGhjsXUIxv49Hb7Y=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.196]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20180620135952epcas5p2e1e3d72cb98e621b73ec6380850b1049~54wzM79u42675226752epcas5p2o;
        Wed, 20 Jun 2018 13:59:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.FA.04408.8DD5A2B5; Wed, 20 Jun 2018 22:59:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y;
        Wed, 20 Jun 2018 13:59:51 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180620135951epsmtrp258f14e572e1b5d21b961560580aab7a4~54wyJJ5QP2657726577epsmtrp2m;
        Wed, 20 Jun 2018 13:59:51 +0000 (GMT)
X-AuditID: b6c32a4b-9a1ff70000001138-7b-5b2a5dd8ce18
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.27.03631.7DD5A2B5; Wed, 20 Jun 2018 22:59:51 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180620135949epsmtip189311d8fe3303ec393fd3b0bf9c5c7ad~54wwrUv0C1391813918epsmtip1j;
        Wed, 20 Jun 2018 13:59:49 +0000 (GMT)
From:   Namit Gupta <gupta.namit@samsung.com>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com,
        Namit Gupta <gupta.namit@samsung.com>
Subject: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Date:   Wed, 20 Jun 2018 19:26:19 +0530
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTURzm7O5xFRe3afVTe6xLEnM5t9n0GlpBUrMiDCPDIXbTg4/24t7N
        sj9CymoJlWkvrKwozKwQdOpStFppaWRYmEvQjAIhokLzQQ9s2zX663zfd77f9x0OP5JQvJZE
        kUVWB+asrJmWhopbn6hUcb6cWJO2c1TJDHRg5vGjFxKmtvyVmHnTfkXKjH5pETFzH6ckTJdr
        TMTcn/wo20gaH9SMyIzlXcMy42l3AzI2ugfFxsmm5RmSbJxSiNl8zCmxNc+WX2QtSKW3ZeZu
        yjUkanVxumQmiVZaWQtOpdO2Z8RtLjL7n0IrS1iz0y9lsDxPx69P4WxOB1YW2nhHKm3S6fQa
        nTZJo9f7T0POOr3Bb9mLCy88axDbfcsOtn1IKUP3FlegEBKotXDC9V5agUJJBdWBoLeqXySQ
        CQSNPdcIgUwjGL/SLvo34ntbN3/RiaDy93eJQH4g+DI3IA24pJQaWueqiQCOoLbAxMz3YAlB
        nUVQdWQmGBVOZcC3F8ckASymYqBlvH6+Yjn09lQHU4FySeHGz1lUgUhSTpXA+TsOwZMGIz3v
        kIDD4fMzt0zAUTD5tVMqzB5FUN/cjQRyDkH5eK1EcG2AMV+3LBBKUCpobI8PyAS1AE79+iQK
        yEDJwXVcIbhjwDP4VCbI0XD5tlaQjeAt8wZrFVQOTPWPiivR0pr/mdcRakCR2M5bCjBvsCdY
        8QENz1p4p7VAk2ezNKHgPsVu86Cm/u1eRJGIDpP7dseaFBK2hC+1eBGQBB0hX5jul+T5bOkh
        zNlyOacZ815k8P/ZWSJqUZ7Nv51WR67OoE9M1CZrDQlMoo5eIp8dokwKqoB14P0Y2zH3b05E
        hkSVodLsm30keNSVyXd3zDjiNCOlqzftsT3OCnPWPG9zceKEnWGy9KmtjD6sOWuVSVVd2ZvZ
        4irmqi4alqVET9Re8rjVf/ZND624ukurXpm8ri9cfX2qJKdO+tCuMttD4rPZ/OEz096thzPH
        utvWFOPIpMUfbvWdfNm0Y3JppEcZA7SYL2R1sQTHs38BTiOdeWUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSnO71WK1og/9TJS0u7k61OHjgNKvF
        vJbzLBaXd81hs7j3ZiuTxf/HX1kt9nU8YLJY+/kxuwOHx85Zd9k9WvbdYvfo27KK0WP9lqss
        Hp83yQWwRnHZpKTmZJalFunbJXBlTDu+iqXghmzF9oc2DYxrxLoYOTkkBEwkblxbxtzFyMUh
        JLCbUaLh3kJ2iIS0xMTmL8wQtrDEyn/P2SGKPjFKzL/SyQaSYBPQltj2fzJYkYiAt8TU678Y
        QYqYBaYySjy5uQUsISzgJ/FsYysTiM0ioCqx9fkKMJtXwF1i+t6nUBvkJE4em8w6gZFnASPD
        KkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4HDS0trBeOJE/CFGAQ5GJR7eG2Fa0UKs
        iWXFlbmHGCU4mJVEeAU9gUK8KYmVValF+fFFpTmpxYcYpTlYlMR55fOPRQoJpCeWpGanphak
        FsFkmTg4pRoYV65/vH7Ss8Z2laCvpywX+BsH+/GETvrpISl6ZJ1IjnZ01GfrKYv+rciPvxir
        LZjd9en14RW6XQ8vmV75u+fa7MfnLbw3RLlutdnrPNlbdim72etHhZG1ewz7BNgFJrAm1aja
        xN+X3x+c6/Oq7uGL16bTP88LLJrmWcEvUzCtcPsUDZYdf3VmKrEUZyQaajEXFScCAHLFR6Ij
        AgAA
Message-Id: <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
X-CMS-MailID: 20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the request is only for clearing logs, there is no need for
allocation/deallocation. Only the indexes need to be reset and returned.
Rest of the patch is mostly made up of changes because of indention.

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

