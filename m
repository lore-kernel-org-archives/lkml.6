Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C198C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F800223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPsfwfpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F800223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbeKOWds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:33:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51217 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKOWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:33:47 -0500
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so18619389wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 04:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5rr5ownL5CW+DNyoqNB3JtKLGxnY8DWp0sReQqHAlqQ=;
        b=pPsfwfpoq1EqCUOWcMecL1+yocpmfE1sqZ2GGZdRCUYLz2P3UXhzKtElKiRulNfG5L
         jYlaYOWMFaEuDaw3uo/4wvMGS0OZ8pgyf5eKED/UWLs896b2pFlIMjSUbkWAudp7fDNi
         QX+CCdyBoAubD4SlVNqQJtW/eic5rQlCwFS/2TAFM6KAbQ1SLn8R6ueJjroSzXp1EEC7
         Fs1GYCDTLNqD3Ok7boLh1FQPrJ+s8+HkL4Q6Yv/iGU6bg91xu61/fvV8Y7oSBcGeWcZ3
         3w+Oun0wskz+6e+hqYIVkr6yrGoBCDe2J9CM4DOsYd8moIcS5roD5w40M+H2Fm14rzJm
         tBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5rr5ownL5CW+DNyoqNB3JtKLGxnY8DWp0sReQqHAlqQ=;
        b=IVwjHVgORDLj3Tk8hBMJiMkggCfulIUY0SlKbwnANBlmYA8mu17hEiINxa8Zu9iz30
         anXn5WIAedHG2B0gShFx2oqykZqkexMwLKZBMI1WIPeEmp6Qq1HhTuu4WKO4X7nh42R0
         iK10oeAs25If19At9sPd+qmW9aO2pp7tLNmQXwaLRtPP/MFdB7YCM3UPAbqud8hbx/7P
         lpjgaDtb0/vUDNcczx6y9HsQztX1c5LM3zIyP5vStrGSYlhT5zEwYdO8lpzfLXKvp4Hb
         RkOWIJGM6hz8PpJOfr33KnLyJgxKz7WXa2394QOIPy4vuhSlZcwsw8tN++ekVfY479d9
         cT2g==
X-Gm-Message-State: AGRZ1gJ413URrIHhT3mLEbOqOV9ZyWCyKW6G4zadd3H3IMVBBbRr1+dJ
        ILC1lsrCklbkluMEj1AgYO0=
X-Google-Smtp-Source: AJdET5eLD8B8y1G4BpEmUnIIyLM4u/im/jDmsTfC1SBNvUEy9gvUqun94qTnfTpJ3NcXdj9cmC3vOw==
X-Received: by 2002:a1c:34d1:: with SMTP id b200-v6mr5088354wma.115.1542284767395;
        Thu, 15 Nov 2018 04:26:07 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id r1sm28151375wrx.15.2018.11.15.04.26.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 04:26:06 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] udf: fix dvd mounting error
Date:   Thu, 15 Nov 2018 12:26:00 +0000
Message-Id: <20181115122600.15821-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DVDs are failing to mount with the error:

[  632.305370] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[  632.305372] UDF-fs: Scanning with blocksize 512 failed
[  632.307837] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[  632.307839] UDF-fs: Scanning with blocksize 1024 failed
[  632.309320] UDF-fs: incorrect dstring lengths (32/32)
[  632.309361] UDF-fs: Scanning with blocksize 2048 failed
[  632.309530] UDF-fs: warning (device loop0): udf_load_vrs: No VRS found
[  632.309531] UDF-fs: Scanning with blocksize 4096 failed

This particular DVD used to work with v4.4 kernels, and has stopped
working after updating the kernel to v4.14. Did a git bisect and that
pointed to:
c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")

This patch effectively reverts c26f6c615788 and removes the length
check that it introduced. And after this patch:

[   61.767204] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[   61.767206] UDF-fs: Scanning with blocksize 512 failed
[   61.770011] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[   61.770026] UDF-fs: Scanning with blocksize 1024 failed
[   61.773006] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[   61.773007] UDF-fs: Scanning with blocksize 512 failed
[   61.774401] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
[   61.774402] UDF-fs: Scanning with blocksize 1024 failed
[   61.775045] UDF-fs: INFO Mounting volume 'TOUR_2017_THANKSGIVING_25_DISC ',
			timestamp 2018/01/30 05:57 (1000)

The DVD is available at:
https://www.amazon.co.jp/Live-%E3%80%8CMr-Children-DOME-STADIUM-Thanksgiving/dp/B079B5W6KC

Cc: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

I dont't think this is the correct fix but has solved the problem for
now. I have the iso image of the DVD for testing, and if there is a better
solution I can test.

 fs/udf/unicode.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/udf/unicode.c b/fs/udf/unicode.c
index 45234791fec2..9f80c56178a5 100644
--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -356,14 +356,8 @@ int udf_dstrCS0toChar(struct super_block *sb, uint8_t *utf_o, int o_len,
 {
 	int s_len = 0;
 
-	if (i_len > 0) {
+	if (i_len > 0)
 		s_len = ocu_i[i_len - 1];
-		if (s_len >= i_len) {
-			pr_err("incorrect dstring lengths (%d/%d)\n",
-			       s_len, i_len);
-			return -EINVAL;
-		}
-	}
 
 	return udf_name_from_CS0(sb, utf_o, o_len, ocu_i, s_len, 0);
 }
-- 
2.11.0

