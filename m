Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62921C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3200721934
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548403157;
	bh=XEdOUr4foyYIuf8ypEQ2xl735KBPwg+q81Wm59AyAVQ=;
	h=Subject:To:From:Date:List-ID:From;
	b=uH/dfh7yd9uAiQ5D/sJbm5LYIUs+WxjDHyM34T40zoiSSKtla9XotJtY1n0EGkhNj
	 xHqr9WfMDio8V8m94KOmqogylsVlCsWycMBi384aqzyYhIdQwBaOnApCL8EM1G6qx0
	 mVNIsy8NWVzqbxLaoVG+S2HlgX+PfkzB+o7MH1Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfAYH7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfAYH7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:59:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F29A2192D;
        Fri, 25 Jan 2019 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548403153;
        bh=XEdOUr4foyYIuf8ypEQ2xl735KBPwg+q81Wm59AyAVQ=;
        h=Subject:To:From:Date:From;
        b=z1ZT65rnbrsvczYsxRWggELnB3eOoiaNxSs8dMOYRyLx1xjSsWMjroQe4Kq/LMGIL
         Hx70Fcaut+UKDJgRoKH0b/E6nei06S/yk0GI1rDRALUUF3yz0xqvgAGimFhWQnZokl
         rQoLILZlIpRlpP/yF4f1Yj0kLGeX6hhwPgCCLnkM=
Subject: patch "ihex: Share code between ihex_validate_fw() and ihex_next_binrec()" added to driver-core-next
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 25 Jan 2019 08:58:41 +0100
Message-ID: <154840312118213@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    ihex: Share code between ihex_validate_fw() and ihex_next_binrec()

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 8092e79204e7884f4bee3584ecfe6cf4a124d129 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 20 Dec 2018 23:28:37 -0800
Subject: ihex: Share code between ihex_validate_fw() and ihex_next_binrec()

Convert both ihex_validate_fw() and ihex_next_binrec() to use a helper
function to calculate next record offest. This way we only have one
place implementing next record offset calculation logic. No functional
change intended.

Cc: Chris Healy <cphealy@gmail.com>
Cc: Kyle McMartin <kyle@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/ihex.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/ihex.h b/include/linux/ihex.h
index 75c194391869..9c701521176b 100644
--- a/include/linux/ihex.h
+++ b/include/linux/ihex.h
@@ -23,29 +23,34 @@ struct ihex_binrec {
 
 /* Find the next record, taking into account the 4-byte alignment */
 static inline const struct ihex_binrec *
-ihex_next_binrec(const struct ihex_binrec *rec)
+__ihex_next_binrec(const struct ihex_binrec *rec)
 {
 	int next = ((be16_to_cpu(rec->len) + 5) & ~3) - 2;
 	rec = (void *)&rec->data[next];
 
+	return rec;
+}
+
+static inline const struct ihex_binrec *
+ihex_next_binrec(const struct ihex_binrec *rec)
+{
+	rec = __ihex_next_binrec(rec);
+
 	return be16_to_cpu(rec->len) ? rec : NULL;
 }
 
 /* Check that ihex_next_binrec() won't take us off the end of the image... */
 static inline int ihex_validate_fw(const struct firmware *fw)
 {
-	const struct ihex_binrec *rec;
-	size_t ofs = 0;
+	const struct ihex_binrec *end, *rec;
 
-	while (ofs <= fw->size - sizeof(*rec)) {
-		rec = (void *)&fw->data[ofs];
+	rec = (const void *)fw->data;
+	end = (const void *)&fw->data[fw->size - sizeof(*end)];
 
+	for (; rec <= end; rec = __ihex_next_binrec(rec)) {
 		/* Zero length marks end of records */
 		if (!be16_to_cpu(rec->len))
 			return 0;
-
-		/* Point to next record... */
-		ofs += (sizeof(*rec) + be16_to_cpu(rec->len) + 3) & ~3;
 	}
 	return -EINVAL;
 }
-- 
2.20.1


