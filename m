Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D889DECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9520854
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vM9lfvbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF9520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeGNXBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:01:23 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39037 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbeGNXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:01:22 -0400
Received: by mail-qk0-f193.google.com with SMTP id b5-v6so16920487qkg.6;
        Sat, 14 Jul 2018 15:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=i4nJanCEFfNN8OzNVDIpNaJr661azqsAjvATH0xfuWY=;
        b=vM9lfvbgkGYimSHdgmvrmNCM5BO+YqBqXW8jswH0d1A4ElzxWDDteNKStZTWV4aZkV
         ukowSAKdFJgGOyJcT54wLRfwIGDz9E/+2u51yFgpHC3eW+CdciLN1If+sX0h6H4ylk6R
         4MvgNGm/R4JF/wDo9z8YwtnyU7CU1twrQsYgfas2pRAwRr7PlnrPxQ2i4q3y8LTk52Vj
         BA7qsHq0pvqkyKOM2NHMS+O2t6YEaKRLKziiHS4Uf2oZYycR2dfmt+LuBZpQTejU/yaT
         k4pdyVl0ZfcoW3gOD79fQlzJicNWDYP+eQRCpR9aVCaoTOr/fy7RUbvCf6DZjT15A1TM
         7TmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=i4nJanCEFfNN8OzNVDIpNaJr661azqsAjvATH0xfuWY=;
        b=Q3Z8OWHXsT2nPbI6Me3xvAmjHbfPec45G35nf/NiQVAD4VH+nHwpSG6R3ktg2yN1cj
         IHXpSPD7Zkz0YZbN95TFAU93Vlc9DO51OGrg/STQMqcHK2geTtGeXICUaH5Ve5rf+Zt5
         REO3BdfEafgJphN17cds7+AyuONY0L7isQ9BoW59iijx9eA9EPdrnOBkxkTly8GvKoZj
         KQrt2PfmCF0yXn9yqQW7P2DXg3drSTzz4B0tz2KzOnjswocPLPU2KzzTANzQb9hA/J2C
         AC5lv4c4o935onWW3WAerIzm69Cy82J9f+74qHe46PIp6ShfLJde7fkQmYxB6SSf+SRT
         cROw==
X-Gm-Message-State: AOUpUlHAf4TGlchEihEWGhyj55uuxcQ0Ote0baGJKFH695R05JrLZB91
        3koIbHSYCHcrpgcGTp8cJKF7zQ==
X-Google-Smtp-Source: AAOMgpd7YojVDryNOg1+adjdDq8TKw+46yDZFhHYsFriMDTZiVsnpO9A4nHM5b+vBLV0Ce+dpCH7sA==
X-Received: by 2002:a37:d60f:: with SMTP id t15-v6mr9811629qki.316.1531608046965;
        Sat, 14 Jul 2018 15:40:46 -0700 (PDT)
Received: from localhost.localdomain ([38.82.195.110])
        by smtp.gmail.com with ESMTPSA id h38-v6sm5634190qtc.5.2018.07.14.15.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 15:40:46 -0700 (PDT)
From:   Lucas Magasweran <lucas.magasweran@ieee.org>
To:     linux-acpi@vger.kernel.org
Cc:     Alexey Starikovskiy <astarikovskiy@suse.de>,
        Lucas Rangit Magasweran <lucas.magasweran@ieee.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: battery: remove redundant old_present check on insertion
Date:   Sat, 14 Jul 2018 15:40:18 -0700
Message-Id: <1531608019-5785-1-git-send-email-lucas.magasweran@ieee.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>

On removal battery_present changes from 1 to 0 after calling
acpi_battery_get_statu() and battery->update_time is set to 0
before returning.

On insertion battery_present changes from 0 to 1 after calling
acpi_battery_get_status() and acpi_battery_get_info() is called
because battery->update_time is 0.

The old_present condition is therefore redundant.

This was added in the commit below when there was a path without
sysfs that would skip getting the newly inserted battery info.

commit 50b178512b7d ("Newly inserted battery might differ from one
just removed, so update of battery info fields is required.")

Signed-off-by: Lucas Rangit Magasweran <lucas.magasweran@ieee.org>
---
 drivers/acpi/battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f88bc9f..c280e8e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -918,10 +918,11 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 
 static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 {
-	int result, old_present = acpi_battery_present(battery);
-	result = acpi_battery_get_status(battery);
+	int result = acpi_battery_get_status(battery);
+
 	if (result)
 		return result;
+
 	if (!acpi_battery_present(battery)) {
 		sysfs_remove_battery(battery);
 		battery->update_time = 0;
@@ -931,8 +932,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 	if (resume)
 		return 0;
 
-	if (!battery->update_time ||
-	    old_present != acpi_battery_present(battery)) {
+	if (!battery->update_time) {
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
-- 
2.7.4

