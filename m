Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AEC6778F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432A020852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6EV0zAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432A020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbeGXVyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:54:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38792 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:54:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so1126077pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XtfFhHEt3EkJlIqJNHyspIwd4qHNMEMPbZzoxZEnm8Q=;
        b=U6EV0zAk09lztZbCmB1YpV6hebvoKtacQFD8/fyZQVY15oPISV7pDf0Kn3MyCxiys6
         LxXfFoQd0oWquSyb9VA53xYlB+aCl8l9qo3SUPBCBkrqhUaQj2LC1Py/IhQySW6LeVWO
         zfgw7ZepVyFi2gSjLSfDVxxP2Kq7JLAICXG9HqNL4rFYOg2pQNmIB5YYm/ySXT2R+0ro
         Bh+CBYrsWYetL9PwytTu10ny1SZLnpB4gzR62wS9+Y9VdhyuhijVk2RZ9yDiGkxnU855
         ZD/8N0qFhKc8nXzom1DgjMrqDlMBVRZJ9TEla+HHyLm1xgV3T1tCtuZrKS2FO3p0O7+u
         MJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XtfFhHEt3EkJlIqJNHyspIwd4qHNMEMPbZzoxZEnm8Q=;
        b=KfPjjAOSKs+AwhLSKVwEhMrN9DYdX3wivIHjeRoOcfqqie77IwsVciXj3oOpqT1zAs
         5ORptjRa5S8IX/zZ6twfYoFNTUZ78YhHB7lFEc7ojT2pW1zU/o4XSb/xHrqOciXTabht
         7QRBY3InkktCin3hDA/S5cTS2pdJ3qj2c9Hec4wzTTDSh+YP1V6MwWEWOnPXDlD4K0F4
         KMWzhMIci+jwq7bVVlrAmK9hAHjlCoWkcy2gxGjV1fXBlZkfnOkD6LBgBs5Y6q5hNCw9
         28HXr3KHde08YeMVstOM8ILaNC7CImrNaDM2S2SZpnY+mRyOfVMKJNxwEbsHbtIA7p1w
         u6Ig==
X-Gm-Message-State: AOUpUlFQmq12xIoZSxkZE1K9CRrY0f2tmDXhzqcpzAI80Itx/T1qjeV+
        jFogssI0eVUVdIKZHfdBKyNjzV/E
X-Google-Smtp-Source: AAOMgpcytVyA6Yn96RapXHPOUq2lchg4rCiLPX02DwWt3a/6rXp4obaCnKFDuUpzQgs8igUFJDQCMA==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr17704332pgh.161.1532465196872;
        Tue, 24 Jul 2018 13:46:36 -0700 (PDT)
Received: from midway.home (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id t21-v6sm21536110pfi.73.2018.07.24.13.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Jul 2018 13:46:35 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ofer Levi <oferle@mellanox.com>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH 4/4] arc: fix mtm.c printk format warning
Date:   Tue, 24 Jul 2018 13:46:22 -0700
Message-Id: <20180724204622.2366-5-rd.dunlab@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180724204622.2366-1-rd.dunlab@gmail.com>
References: <20180724204622.2366-1-rd.dunlab@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warning in arch/arc/plat-eznps/mtm.c:

In file included from ../include/linux/printk.h:7,
                 from ../include/linux/kernel.h:14,
                 from ../include/linux/list.h:9,
                 from ../include/linux/smp.h:12,
                 from ../arch/arc/plat-eznps/mtm.c:17:
../arch/arc/plat-eznps/mtm.c: In function 'set_mtm_hs_ctr':
../include/linux/kern_levels.h:5:18: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long int' [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^~~~~~
../include/linux/kern_levels.h:11:18: note: in expansion of macro 'KERN_SOH'
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
../include/linux/printk.h:308:9: note: in expansion of macro 'KERN_ERR'
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
../arch/arc/plat-eznps/mtm.c:166:3: note: in expansion of macro 'pr_err'
   pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
   ^~~~~~
../arch/arc/plat-eznps/mtm.c:166:40: note: format string is defined here
   pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
                                       ~^
                                       %ld

The hs_ctr variable can just be int instead of long, so also change
kstrtol() to kstrtoint() and leave the format string as %d.

Also add 2 header files since they are used in mtm.c and we prefer
not to depend on accidental/indirect #includes.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Ofer Levi <oferle@mellanox.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/plat-eznps/mtm.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-next-20180723.orig/arch/arc/plat-eznps/mtm.c
+++ linux-next-20180723/arch/arc/plat-eznps/mtm.c
@@ -15,6 +15,8 @@
  */
 
 #include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <asm/arcregs.h>
@@ -157,10 +159,10 @@ void mtm_enable_core(unsigned int cpu)
 /* Verify and set the value of the mtm hs counter */
 static int __init set_mtm_hs_ctr(char *ctr_str)
 {
-	long hs_ctr;
+	int hs_ctr;
 	int ret;
 
-	ret = kstrtol(ctr_str, 0, &hs_ctr);
+	ret = kstrtoint(ctr_str, 0, &hs_ctr);
 
 	if (ret || hs_ctr > MT_HS_CNT_MAX || hs_ctr < MT_HS_CNT_MIN) {
 		pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
