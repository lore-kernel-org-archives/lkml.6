Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523DBC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FD82173B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ZzO0zEOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLXRb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 12:31:27 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53230 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLXRb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 12:31:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 2C374A32
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 17:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S_UzVj4OSfBu for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 11:31:25 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id EE16D9D7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 11:31:24 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id o22so14064288iob.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VogpZLKGcdtzjiwy/A1aoTh8PgvkJkwEH/PscX0RUmk=;
        b=ZzO0zEOOPziRmaa9PYpI/GcY9J7wfaW0kmN34EnLr/J8l15BAHXlo/0V6jWvUzFJ4Z
         QS/D0RvMUW6etWgy2tn2Gev+RevvM76z4oXbF2fuFH5VmSEwtTbfGuC7cjsN+0NAlAxE
         QRBSTvUnO5gz+qmnDI/+8S1+xYUG7RelOQmDctzGkG4n8AIFxCMnq34b4SMhdBmMOGLj
         nZBuofoEEQRFrCKapNWldf9Jjnwrg1FrGzMt+wd5LiyisQ6zJBsMxoWZFF9L2GBw3oFP
         1QliL7jgwjz4gyLEgaDaDfmsyasgMszCa4zm8GupR0zt+PMQMOmpKcyiBc9U3gApo7cn
         sEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VogpZLKGcdtzjiwy/A1aoTh8PgvkJkwEH/PscX0RUmk=;
        b=jC3pOGNlc/xi8BfWBZ8q0Heqvd/P0HiLGUHQAoW0ufL7ILERHwxTQi6XBcmtA0Ru3i
         de2HfXVyKeid25XGjvSMG6BsC2JKwj0gkusUE3SmFgXtbhYLM5lALdiwmoQxanG2IrK1
         XimWy2pejKSjjPi7l+wnvR9CSHHouxJdCuldDSSks3cWJP1yZE2//sEeU6X2HTPhOkAo
         9wCay5vUan/TT9QMOP39ih32D5Pd9GhwZUoopaIRAELx5h/BABMzuuwH6Y90qwVIinzx
         66hh0F+y4Oxr+OcLFm0ttyRaVDEpGisdTkTg6vpd6q3nwBELZNdW1Slt5rMZfcju32jJ
         OVsw==
X-Gm-Message-State: AJcUukctmhcTr/yHPKoK058gsLGUOwkYDkm2wwse/oZPc3+bbBT5FEXM
        h/zMGfEpJHQGcgLnUh+ZMs7sn0MLM6wvzr4Z6rO9hSS6doWG5KmFXYXkj6UCx3MW69uJazRFZUM
        lgTOGF7wokpchOlWvA1Qycm6SJvCe
X-Received: by 2002:a6b:b902:: with SMTP id j2mr9507522iof.220.1545672684583;
        Mon, 24 Dec 2018 09:31:24 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4wpPf1jKmefHfjdwsn5NUc8qJBdD9SNHk7xKFo01Zfrjlv0eeW3oH08zN0NcobpfYQNMfQSw==
X-Received: by 2002:a6b:b902:: with SMTP id j2mr9507495iof.220.1545672684015;
        Mon, 24 Dec 2018 09:31:24 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id a16sm14353355ioh.48.2018.12.24.09.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 09:31:23 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc/ics932s401: Add a missing check to i2c_smbus_read_word_data
Date:   Mon, 24 Dec 2018 11:31:13 -0600
Message-Id: <20181224173113.19366-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ics932s401_update_device may fail reading in i2c_smbus_read_word_data
due to error in i2c_smbus_xfer. The fix checks the status and defaults
the register to 0.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/misc/ics932s401.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 81a0541ef3ac..294fb2f66bfe 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -146,6 +146,8 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
 	 */
 	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
 		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
+		if (temp < 0)
+			data->regs[regs_to_copy[i]] = 0;
 		data->regs[regs_to_copy[i]] = temp >> 8;
 	}
 
-- 
2.17.1

