Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF9DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05031218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfBAKEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:46 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51744 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfBAKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:36 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 45e00ada303defac; Fri, 1 Feb 2019 11:04:33 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] ACPI: EC: Declare boot_ec as static
Date:   Fri, 01 Feb 2019 10:57:01 +0100
Message-ID: <3257902.HcCiuEjYcT@aspire.rjw.lan>
In-Reply-To: <2804781.zocuRj5ZkX@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <2804781.zocuRj5ZkX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The boot_ec variable is not used outside of the file it is defined
in, so declare it as static.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/ec.c
===================================================================
--- linux-pm.orig/drivers/acpi/ec.c
+++ linux-pm/drivers/acpi/ec.c
@@ -186,8 +186,10 @@ static void advance_transaction(struct a
 static void acpi_ec_event_handler(struct work_struct *work);
 static void acpi_ec_event_processor(struct work_struct *work);
 
-struct acpi_ec *boot_ec, *first_ec;
+struct acpi_ec *first_ec;
 EXPORT_SYMBOL(first_ec);
+
+static struct acpi_ec *boot_ec;
 static bool boot_ec_is_ecdt = false;
 static struct workqueue_struct *ec_query_wq;
 

