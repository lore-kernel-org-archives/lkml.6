Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9B321720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 05:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="krAhMUNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLZF3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 00:29:45 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42088 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLZF3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 00:29:44 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id E5051C20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 05:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IGcRvcUjINrq for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 23:29:42 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id B6412C18
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:29:42 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id w68so18648999ith.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/2cdgkGNzVVZhg5qjv4crcTg9IkWEBlqvy7Bg6Avdxs=;
        b=krAhMUNcCABGtWFhPGJLs+dQS0Jx2tNZi0pbHEjKshbXFpoBNO5hrB4BGp9iBufhXm
         grWHDd1wTfwscwoKQnlSFsCnESsYKKPQhkZzVVDjlEbtFkbM3PB+GVYPYGdBu6k12SvW
         DKDcSJQFV5pxPM8KvyFwyFtHUHHeqgzPrAj8rVzCyJZpE9Z02Nmd4CVm7X2bZKlzvfuz
         QLbKsXfp995NhMTpRcYtntuOeV/DFSorbPcmw2sejW2Gg5R2VxmWVp9yHDU2YUkqg/bF
         5mHRtE0MQIuzIPQu+1JrOzaPLn7xm31pdoumEy3yHv/2maAxJBUh54B1ETmClmt9k2vx
         FVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/2cdgkGNzVVZhg5qjv4crcTg9IkWEBlqvy7Bg6Avdxs=;
        b=XVPUn/ZA4fQ5bWbK4r3JIrn3WfNnb/arxd83NFsz3RcoWtjI8MnEga0OQwoePT4x5O
         hLYljt63U7R7JaZpvx3iJs1HwO4fM3SwDfvli1ItaEOEbT4xaGQ24uciEP9i9Zj1E/IH
         MVmzimP1RBdSJ3lEujOpsQ+8ASJ2NBFKTg4bfUjokfb5qt95Lg94hqdn2hN3xsdrS5Bp
         8LgyVPer9syaUJnjasFcj5FInzwX5B3xZv4Yk6Ute3CwzclrmLAec30HGyTacCaTvctq
         xkO7iVQjgHOH57U3H4YGnB5dHQ0MRrz1R8+b4bm8HmwvjKHG6kd62OY0Iy39sv4v5wyF
         IF7A==
X-Gm-Message-State: AA+aEWbn2uRj9NAwEf3EQnhwR6iAff8pWmEgGu5dWmOtaeBwJ40u6gI+
        qqdapeiJlAdiOkv4WzBUnNvt887te372GutwMLKChr9EFCAdhwLeXnBXpC0JBYbQPNrsiIDvxhu
        QmhXSVw7onamx9f+Y8rkqKZctmbHU
X-Received: by 2002:a02:8cce:: with SMTP id n14mr12529463jal.125.1545802182061;
        Tue, 25 Dec 2018 21:29:42 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VFL6iRERAjTmlPipFPkcyPr/dMBURtZVcFUzUqc61/R/YuufmU0IZRvrkQ3s4gCJN7zjJxSg==
X-Received: by 2002:a02:8cce:: with SMTP id n14mr12529457jal.125.1545802181800;
        Tue, 25 Dec 2018 21:29:41 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id w24sm4662476ioc.11.2018.12.25.21.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 21:29:40 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: (memconsole) do not count numbers if read fails
Date:   Tue, 25 Dec 2018 23:29:11 -0600
Message-Id: <20181226052913.74614-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory_read_from_buffer() fails, the return value is a negative
error code, thus we shouldn't count it as the number of read bytes.

The fix checks the return value of memory_read_from_buffer, and count
the number only when it succeeds.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/firmware/google/memconsole-coreboot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/google/memconsole-coreboot.c
index b29e10757bfb..4e8a0ad110c1 100644
--- a/drivers/firmware/google/memconsole-coreboot.c
+++ b/drivers/firmware/google/memconsole-coreboot.c
@@ -55,6 +55,7 @@ static ssize_t memconsole_coreboot_read(char *buf, loff_t pos, size_t count)
 	} seg[2] = { {0}, {0} };
 	size_t done = 0;
 	int i;
+	int ret;
 
 	if (flags & OVERFLOW) {
 		if (cursor > size)	/* Shouldn't really happen, but... */
@@ -66,8 +67,10 @@ static ssize_t memconsole_coreboot_read(char *buf, loff_t pos, size_t count)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(seg) && count > done; i++) {
-		done += memory_read_from_buffer(buf + done, count - done, &pos,
+		ret = memory_read_from_buffer(buf + done, count - done, &pos,
 			cbmem_console->body + seg[i].phys, seg[i].len);
+		if (ret >= 0)
+			done += ret;
 		pos -= seg[i].len;
 	}
 	return done;
-- 
2.17.2 (Apple Git-113)

