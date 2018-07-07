Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68416C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D636208A4
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 15:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZZ1CdvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D636208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGGPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 11:25:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeGGPZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NOUy7QE3X1v40J9zfeddLx14I+ESm9ryf3SOQOfJs9g=; b=jZZ1CdvS3wOydetZ5tgvLq+M5
        LrPMuhwV5Sf+V+Hm3iLFXRDMnaq9CstEhXHjd5j/FMZkDVR1x8IhWM4u6OmT9PQaG055qBvBatQ1+
        J6x6CTl3mM0jvx3xjy2vL4gOhdKc48H+kJl7O0I23b38SbPZ00d76Z1c68F00K0iqvysZcJiv/6JQ
        uKzeS/bmxErVx4jxsO6FehmKo6wymMja0yWHXcmfdS/XlozrvCyjCuG3zHP5ThVm3DxWhAESVxBwE
        5xAqLdY61WwEfslpdD544YTATCGws6WW4uCHMYK7TXkfEqt+fCpRq6PVgcgTExVtnEiyY96FmhL2/
        2lJiIG90w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbp54-0007b1-Lu; Sat, 07 Jul 2018 15:25:02 +0000
To:     ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] acpi/button.c: fix defined but not used warning
Message-ID: <2e91930f-c762-532b-6607-223385078edb@infradead.org>
Date:   Sat, 7 Jul 2018 08:25:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a build warning in the ACPI button driver when CONFIG_PROC_FS
is not enabled by marking the unused function as __maybe_unused.

../drivers/acpi/button.c:252:12: warning: 'acpi_button_state_seq_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/button.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20180706.orig/drivers/acpi/button.c
+++ linux-next-20180706/drivers/acpi/button.c
@@ -21,6 +21,7 @@
 
 #define pr_fmt(fmt) "ACPI: button: " fmt
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -249,7 +250,8 @@ static int acpi_lid_notify_state(struct
 	return ret;
 }
 
-static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused acpi_button_state_seq_show(struct seq_file *seq,
+						     void *offset)
 {
 	struct acpi_device *device = seq->private;
 	int state;

