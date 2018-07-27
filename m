Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AC3C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAB120883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW6SgVkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAB120883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbeG0Ejs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:39:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbeG0Ejs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:39:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id p23-v6so2359674pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 20:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to;
        bh=ExX/0UskqZFk3iQZvd/sNSWWHFk6XFzds/iQ/J3r5Mk=;
        b=tW6SgVkddcAtrN8SndB7dsZuIoe2IHdm9MS5y3u3YcOoG8Hc6qTeZ+LO5/H8Qs9rG6
         UAm0M07Ebs/rpovN26smwecKpefKYTc7WBUrvoJt2E2/s7j6J6qQc8TQGoaVJsj1O47v
         /7UgZV6Z5JxlgD+F5PdFkUqhysRC9im6wjjL1XSkoupnoV8f6tVQ+d/ZWik2gCK5S2Tw
         lrq6SeK+jtMs86aDzvt0YWg2ANRMLnU3erJGv/sLwZpufgZlmNvi7N879O1nhRQKy6US
         msUaWQ34www9JaMaNcTlL0HUxbpV1CRfg9b0X72mT49rJTICLBrsPwUwMj2XQ0Nyc1o7
         MShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to;
        bh=ExX/0UskqZFk3iQZvd/sNSWWHFk6XFzds/iQ/J3r5Mk=;
        b=ma5D0UG3HD9QlaSt6lCaDCM5HOXJwDvqlX9i78SRWIRbHnM6JXaqvGXG8SfUd8oE/b
         NPHWFYht7GFRynLZvza79Yqm2xGXi+j2ijibkPpujEvm/kFTCxrLyH6Ru8/+w+EvpbVk
         6TGWIKP9+rXSXghY+6Iu87lFiIFuOgLfgNlkNMYeb5fpwwefqLIUdzkBxZL5B7XvwLHM
         h/hqS/B1FAXJUM9/kZHm1xt4p9G2u3WUQrwljzfNBRN3zy1hYplyUuuy+Gqj3u7Yhti5
         v8MDF9KeTxZgD+ZYh3weJgnlOx4eUGV3KHzJZINSCw/njavfNTV0Z3YjGZkEi7bbYYxM
         wV5g==
X-Gm-Message-State: AOUpUlFocvl8GZ1SEHTz1ybKNosXoK2K82P1MfZx/zL7Ec5IggIg8cA/
        qSSym+ajqMW6Pus8KDF+myw=
X-Google-Smtp-Source: AAOMgpfO4u+o8y2wyF9hJoKvq/Bplj5efmEZPte9zr49RyH9970FFSf9C0/kigZtnqIULieZi3wW6A==
X-Received: by 2002:a62:bd4:: with SMTP id 81-v6mr4797311pfl.67.1532661602421;
        Thu, 26 Jul 2018 20:20:02 -0700 (PDT)
Received: from localhost (static-50-53-52-16.bvtn.or.frontiernet.net. [50.53.52.16])
        by smtp.gmail.com with ESMTPSA id z90-v6sm5743882pfk.85.2018.07.26.20.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:20:01 -0700 (PDT)
Date:   Thu, 26 Jul 2018 20:16:35 -0700
From:   rd_dunlab <rd.dunlab@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: [PATCH 4/4 v2] arc: fix printk warning in arc/plat-eznps/mtm.c
Message-ID: <1532661395133@infradead.org>
In-Reply-To: <15326613951079@infradead.org>
X-Mailer: gregkh_patchbomb
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
Cc: linux-snps-arc@lists.infradead.org
Cc: Elad Kanfi <eladkan@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Ofer Levi <oferle@mellanox.com>
---
v2: no change

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


-- 

