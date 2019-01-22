Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AD3218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548149099;
	bh=QXPAkgMHZkQNBVp1VLTRTqu8UgNRjOdkWgyJv2fmUsc=;
	h=Subject:To:From:Date:List-ID:From;
	b=xPNhrqNqoD7tSFcvJXsBcDkBj/sFEa3zfYJcYGiQCv2qGDIJta7JsZr6AKUScf0J8
	 9EESR+hggJK/RmpoQmVhiMDBLRELS1NI+Xsk2JPG4hXY7nwzQT72+0+BnGLWUZ4wqE
	 TU+HJQGhvxICGNtqLQwToYZXHIW3fxbOBKRxHKQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfAVJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfAVJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:24:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33107218D9;
        Tue, 22 Jan 2019 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548149095;
        bh=QXPAkgMHZkQNBVp1VLTRTqu8UgNRjOdkWgyJv2fmUsc=;
        h=Subject:To:From:Date:From;
        b=PSkBiFUDzq6gNkzOR0YjpU7Gu50cpeWX+Yedjv6LLNp49gEOqIyioE8Iizzn+ojTv
         nQzob//5rA/BJeKyuDUiuvo4mr26P5hYohYHq2PLNB7EnjHWiFNw2E8Z+Phw3vJDIT
         gA/KxqOzYsSp6TnBosEGT40ArmvQcycExQmFT7pU=
Subject: patch "tools/firmware/ihex2fw: Replace explicit alignment with ALIGN" added to driver-core-testing
To:     andrew.smirnov@gmail.com, akpm@linux-foundation.org,
        cphealy@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org,
        kyle@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 22 Jan 2019 10:24:42 +0100
Message-ID: <1548149082157142@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    tools/firmware/ihex2fw: Replace explicit alignment with ALIGN

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 925f8d4aad5ca1bf18987a3cdcb0e176bddddcf1 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 20 Dec 2018 23:28:41 -0800
Subject: tools/firmware/ihex2fw: Replace explicit alignment with ALIGN

(X + 3) & ~3 is the same as ALIGN(X, 4), so replace all of the
instances of the formwer in the code with the latter. While at it,
introduce a helper variable 'record_size' to avoid duplicating length
calculatin code. No functional change intended.

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
 tools/firmware/ihex2fw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/firmware/ihex2fw.c b/tools/firmware/ihex2fw.c
index e081cef730d8..8925b60e51f5 100644
--- a/tools/firmware/ihex2fw.c
+++ b/tools/firmware/ihex2fw.c
@@ -135,6 +135,7 @@ int main(int argc, char **argv)
 static int process_ihex(uint8_t *data, ssize_t size)
 {
 	struct ihex_binrec *record;
+	size_t record_size;
 	uint32_t offset = 0;
 	uint32_t data32;
 	uint8_t type, crc = 0, crcbyte = 0;
@@ -161,12 +162,13 @@ static int process_ihex(uint8_t *data, ssize_t size)
 		len <<= 8;
 		len += hex(data + i, &crc); i += 2;
 	}
-	record = malloc((sizeof (*record) + len + 3) & ~3);
+	record_size = ALIGN(sizeof(*record) + len, 4);
+	record = malloc(record_size);
 	if (!record) {
 		fprintf(stderr, "out of memory for records\n");
 		return -ENOMEM;
 	}
-	memset(record, 0, (sizeof(*record) + len + 3) & ~3);
+	memset(record, 0, record_size);
 	record->len = len;
 
 	/* now check if we have enough data to read everything */
-- 
2.20.1


