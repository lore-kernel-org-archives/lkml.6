Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAB5C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1EB22445
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 03:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bi/1byKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1EB22445
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932917AbeGGDtY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 23:49:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932790AbeGGDtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 23:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Cc:Subject:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8MONiul9GC57jM6VNfiBP3eG87PQRJPfnGTWHZhtA+A=; b=Bi/1byKOQYgl5msfT/CEcB194
        3RcXkwrHdDSQgARGL0RCFXpPBpppa5AnBrtg43Btx3NsI1IrlrkVsv7wTEqh4Sk8KHHwXe4MTgRVw
        spAajmQgc6PVoE7TaY4BGjaYjss9m71nlH3yPRBcwLw8C9r5ZtbuHT+PtY8xOZUtaU6rUsKP3cFQ9
        xikA+hZ+W7bvJAVRPwDZmhf0mWr0OswmOT12nrTi64cCF9PxfDE+LWTdAXg12OCV7uB3QScQaF7QO
        lviTvZ9UwJv2WAEMc2tyyJ1ECFxOL5teLVzHZzuKLBq8Ew7C7vF7WHzWUFekrxu42mQ4GAfVIzxFL
        amm6DB37A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbeDr-0008AT-07; Sat, 07 Jul 2018 03:49:23 +0000
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        axboe <axboe@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] block/DAC960.c: fix defined but not used build warnings
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <880681dd-f72f-6687-d2cc-59116acd5216@infradead.org>
Date:   Fri, 6 Jul 2018 20:49:19 -0700
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

Fix build warnings in DAC960.c when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../drivers/block/DAC960.c:6429:12: warning: 'dac960_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6449:12: warning: 'dac960_initial_status_proc_show' defined but not used [-Wunused-function]
../drivers/block/DAC960.c:6456:12: warning: 'dac960_current_status_proc_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 drivers/block/DAC960.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-next-20180706.orig/drivers/block/DAC960.c
+++ linux-next-20180706/drivers/block/DAC960.c
@@ -21,6 +21,7 @@
 #define DAC960_DriverDate			"21 Aug 2007"
 
 
+#include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
@@ -6426,7 +6427,7 @@ static bool DAC960_V2_ExecuteUserCommand
   return true;
 }
 
-static int dac960_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_proc_show(struct seq_file *m, void *v)
 {
   unsigned char *StatusMessage = "OK\n";
   int ControllerNumber;
@@ -6446,14 +6447,16 @@ static int dac960_proc_show(struct seq_f
   return 0;
 }
 
-static int dac960_initial_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_initial_status_proc_show(struct seq_file *m,
+							  void *v)
 {
 	DAC960_Controller_T *Controller = (DAC960_Controller_T *)m->private;
 	seq_printf(m, "%.*s", Controller->InitialStatusLength, Controller->CombinedStatusBuffer);
 	return 0;
 }
 
-static int dac960_current_status_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused dac960_current_status_proc_show(struct seq_file *m,
+							  void *v)
 {
   DAC960_Controller_T *Controller = (DAC960_Controller_T *) m->private;
   unsigned char *StatusMessage =


