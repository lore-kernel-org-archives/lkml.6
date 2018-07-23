Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F9CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3119220874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn07Y9nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3119220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbeGWJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:17:46 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44128 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387913AbeGWJRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:17:46 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so14827044ioh.11;
        Mon, 23 Jul 2018 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4SUSVghtR8cJSSEtC6Yyuq7vsCKy6nQKkr2feOCLezA=;
        b=Dn07Y9nViRkCIsibiYwPIzk5/vyVX+lDLVLcoDZ2awl8sxuPK9aoc94wfc6Gty5ABG
         ebBYwb+fJzFsPuJwnLO0CXyg1iA3cieatqBRgMFQbHZtGcTGn5KUL+6jjsm/ItzdfO1C
         DFMHuMzs2RqWsnOAPi0aPBmmNaJYrG17YZsMzH7Ep6S964x7bDWD6rnXObuEm2j6YBtv
         ERjS7GiVHOrXOiRvirN6O+3FoNdm55XZb3Ir+6P5XWujVh62N6xrooGtqtWLApPK2JTH
         zyJvv7P7RCI+la46oUO4RGk/PzlHHjvTChjzbXzpqIHROCauUmVngRJ01IFx95OVbGL+
         FETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4SUSVghtR8cJSSEtC6Yyuq7vsCKy6nQKkr2feOCLezA=;
        b=IR9ax3vwnxaxO90RZLW6KFMvpW1Vf3Ny/vmf51qeSfjFLHEVrf3AMkJlWb37trMagA
         DbX0f427j66Utsfg/vSm7tvpuO6BX/Oi5/alI3c7hsbc5nLvTSFw8UWMQxWQk29ORTnG
         bV+TYTB4TVPGbgvahBd7R+i2MB5DSbjsvbO99yzFsWfBFBHz20CLp38fT1zFaBSbVaIB
         Zue9C/qQiG/SF9u+ri6rV2jZxfDmDSKAfdU0H05z9ku3a4oXpy6062M+lAX8zee56JgH
         knMKMqsndIopigVXNAFD7Vfg7OyDtJIaUjilNzjUuLTAUnXdUM3/i/iH41R9Rdp1LTXd
         txeg==
X-Gm-Message-State: AOUpUlGq0VtXEXhl+RVI9Ympb0WHY9p+0Hj79MhFqnN7oii9VgyIXOpS
        eGSWDi944k1kw0RsCxpvO7I=
X-Google-Smtp-Source: AAOMgpcVKkK0nuHmodiDMdtuVhv5XE5p0Be7yI+RlLI2bzTuH8QZBSBuFKdhj0VedVYInJWqEYA/3Q==
X-Received: by 2002:a6b:760c:: with SMTP id g12-v6mr7451856iom.276.1532333865076;
        Mon, 23 Jul 2018 01:17:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:c122:f95a:1d53:1f82])
        by smtp.gmail.com with ESMTPSA id r139-v6sm3006555ita.14.2018.07.23.01.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 01:17:44 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] crypto: cavium: nitrox: Replace GFP_ATOMIC with GFP_KERNEL in crypto_alloc_context()
Date:   Mon, 23 Jul 2018 16:14:26 +0800
Message-Id: <20180723081426.31780-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_alloc_context() is only called by nitrox_skcipher_init(), which is
never called in atomic context.

crypto_alloc_context() calls dma_pool_alloc() with GFP_ATOMIC,
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/crypto/cavium/nitrox/nitrox_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_lib.c b/drivers/crypto/cavium/nitrox/nitrox_lib.c
index 4fdc921ba611..ebe267379ac9 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_lib.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_lib.c
@@ -148,7 +148,7 @@ void *crypto_alloc_context(struct nitrox_device *ndev)
 	void *vaddr;
 	dma_addr_t dma;
 
-	vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_ATOMIC | __GFP_ZERO), &dma);
+	vaddr = dma_pool_alloc(ndev->ctx_pool, (GFP_KERNEL | __GFP_ZERO), &dma);
 	if (!vaddr)
 		return NULL;
 
-- 
2.17.0

