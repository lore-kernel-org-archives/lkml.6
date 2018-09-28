Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC8C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70A32073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COASzK69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70A32073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI2CDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:03:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36014 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbeI2CDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:03:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id e26-v6so7936656qtq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1S3ijS/vlKACz0xD9uTGub0QMY2h2n3OgRzQwD6BjQ0=;
        b=COASzK69ijwi56If2EH8U9rjQzSG8zJj/oY0lm4XzLY5+t2o1cXcqR9tJyjkrPCEWf
         Awg1S+Je4PexU23+zKqr8PQX2VMvOE1XA0TlRVVaY2+Z2svIjXi+onqpgQ7ehuMFujHM
         HcLloyEjkGKIaeKQ/7pU6BB/NTYiksJYW6OEmW0ZOanikyfaz3sI5owkl8xBHLCksYmI
         Zz9iRPIvl31BmBqjnZWBLWGdpyuzaf73lolChpDLJ5qJk1yikYB1BTiCZeX8ckoxZirg
         oabrttrgOkQzQDLocQT3SJpEammTW+NG9/NEtgtVjmo3lT8zJ+KbHFiPsH5W95kBSl7Q
         jFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1S3ijS/vlKACz0xD9uTGub0QMY2h2n3OgRzQwD6BjQ0=;
        b=Z7ydmPCEiZM1cPNx2awWsBXx7QY0zZooRcrILXZIBVG95UnYmrc33WcEF3ViKxjkt+
         VrabL+kH1HtrtJhx1q+T3fnVnJdzujekKtdDvv0mAaCB4c5LVTA0Q4hKMemvS082HvW1
         IFTW+lHnB94lFjerg8ogRJsiuO9fHn5rGdWW5VNJYIExCV5FbE64JztWL9yKVZYifjTv
         JwQOuFXmNIoujaJHCQ0T5ZWLZ8IegyoK89rVCkKBIRPMe3BfuLHTRq2rXNU/viBHPvxK
         rJzuwoRPoQErZlR5weIJK9cwuxSaVl3G52AdnRWoiDCshqLJYFcSqWXv+pr1JvJ8QG0e
         4NSA==
X-Gm-Message-State: ABuFfoh9oQCD2jpYqIKUcYzslC/N28sCuckwyoen0+qDP1u2LWzNxrwa
        uB2/AwiOR2pr53Y0jUA3jWI=
X-Google-Smtp-Source: ACcGV60klQ8upwtPa/DaqpNTRc5Ob1+k2lKRACBlDzEnNNfHQLvBr+rQq71eNA2i6VEVkGzCi+UCow==
X-Received: by 2002:ac8:28e4:: with SMTP id j33-v6mr70131qtj.57.1538163486704;
        Fri, 28 Sep 2018 12:38:06 -0700 (PDT)
Received: from yosemite.fios-router.home (pool-108-16-81-143.phlapa.fios.verizon.net. [108.16.81.143])
        by smtp.gmail.com with ESMTPSA id s73-v6sm4064556qkl.65.2018.09.28.12.38.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 12:38:06 -0700 (PDT)
From:   Jeff loughlin <loughlinjd@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pombredanne@nexb.com, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jeff Loughlin <loughlinjd@gmail.com>
Subject: [PATCH] x86: init: Remove raw kernel pointer from printk
Date:   Fri, 28 Sep 2018 15:37:40 -0400
Message-Id: <1538163460-17173-1-git-send-email-loughlinjd@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Loughlin <loughlinjd@gmail.com>

    printk message in set_real_mode_mem() contains a raw kernel pointer, which printk rightly changes to (ptrval).
    This is useless in the dmesg log and should be removed.

    Signed-off-by: Jeff Loughlin <loughlinjd@gmail.com>
---
 arch/x86/realmode/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index d101058..d76a138 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
 	void *base = __va(mem);
 
 	real_mode_header = (struct real_mode_header *) base;
-	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
-	       base, (unsigned long long)mem, size);
+	printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
+	       (unsigned long long)mem, size);
 }
 
 void __init reserve_real_mode(void)
-- 
2.1.4

