Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9035C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564E620B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JexySlcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E620B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbeGKLN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:13:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41912 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbeGKLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:13:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so14279777ljy.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d/6Bhob0E01aCQLv9egKXSvpXRfkiKaDp4MSoGFs+9o=;
        b=JexySlcPJxGHatbAf55Xr/Q0OYqEOA0yF0Gcwx1TRd4sk7C8OUwhFoErd8zyXVcGD0
         ExE9lfu3LtEiNpPHEproPKtcBm9s9cOOCt3M7KrzSLVKZaF9u4xxkg0kXz4Dj3Fn7pUQ
         zy9EgWn/jLZubxubc18Vu481c5tx8WypObJ8hp6VdkUWKgjemprex9ZNwnGXRjcKLEcF
         t908H4adFLDPauysgLpW4S1EUwHzkhBe0RKWmR/Ulfc6H5d+/JZpcRKDjlrJpbVERC2Z
         ol3xkmTRI3C+csEJtBC/6dQSnag67+Ci28aFFRwBtFnz8r5AEIsaJXO1AtkLHhZjCJDO
         XVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d/6Bhob0E01aCQLv9egKXSvpXRfkiKaDp4MSoGFs+9o=;
        b=gQgjaQ2Sbs4zHF2qwFWahJHAms7lNpLXwkx3JijU4fr9CAcMcADSqrqkdoCtNLh/ow
         p+ql0oPBMhfTOiFdOoOdh+KC90GviYszII2a57qjqDN45GzM1QbtbebPIh9M5ZV2KZhd
         dcLGhlDFOetyziQweDVFEiIQncM453RCTGP4RYtkWRUTNyuxg+gaCWXcIoBMi3LM2nan
         5Il/Vd5Job0Pky3uCqgJtlxUZTxdezRjIz2l8ikxQaMA89iHGPDltoYAKEsOjFYrMz46
         aGcBOcN8zTg8PwXC0MDySHC0+XEoR114TvUQuVM6QyNg58xzExXLGlDICBuzXw2fVA2n
         GrWw==
X-Gm-Message-State: APt69E15OBmlfLV9avQ5+92lpTAFcpMLQf8sGJzEAG/D5IHYvGac5eRe
        QsvCcmiZ+A+n1JDis4WoFjCZMsdZn0E=
X-Google-Smtp-Source: AAOMgpehhX69g3ixqwAI93TMR6jviAPXp1+A6wZauBJ6sHIsdXtXa5Fwrnz8ly+LInaVQpmMFPFXog==
X-Received: by 2002:a2e:2b0e:: with SMTP id q14-v6mr17671743lje.147.1531307409199;
        Wed, 11 Jul 2018 04:10:09 -0700 (PDT)
Received: from localhost.localdomain ([188.162.64.141])
        by smtp.gmail.com with ESMTPSA id s5-v6sm2981558ljh.9.2018.07.11.04.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 04:10:08 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        benchan@chromium.org, jnjoseph@google.com, rspringer@google.com,
        Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] staging: gasket: fix plain integer as NULL pointer warning
Date:   Wed, 11 Jul 2018 14:13:34 +0300
Message-Id: <20180711111334.15423-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix to remove sparse warnings:

  drivers/staging/gasket/gasket_page_table.c:884:40: warning: Using plain integer as NULL pointer
  drivers/staging/gasket/gasket_page_table.c:1743:57: warning: Using plain integer as NULL pointer
  drivers/staging/gasket/gasket_page_table.c:1768:57: warning: Using plain integer as NULL pointer

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/staging/gasket/gasket_page_table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index c5390a860f86..5d3d33cac12f 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -881,7 +881,7 @@ static int gasket_perform_mapping(
 			u64 off =
 				(u64)host_addr -
 				(u64)pg_tbl->coherent_pages[0].user_virt;
-			ptes[i].page = 0;
+			ptes[i].page = NULL;
 			ptes[i].offset = offset;
 			ptes[i].dma_addr = pg_tbl->coherent_pages[0].paddr +
 					   off + i * PAGE_SIZE;
@@ -1740,7 +1740,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 				  gasket_dev->coherent_buffer.virt_base,
 				  gasket_dev->coherent_buffer.phys_base);
 		gasket_dev->coherent_buffer.length_bytes = 0;
-		gasket_dev->coherent_buffer.virt_base = 0;
+		gasket_dev->coherent_buffer.virt_base = NULL;
 		gasket_dev->coherent_buffer.phys_base = 0;
 	}
 	return 0;
@@ -1765,7 +1765,7 @@ void gasket_free_coherent_memory_all(
 				  gasket_dev->coherent_buffer.virt_base,
 				  gasket_dev->coherent_buffer.phys_base);
 		gasket_dev->coherent_buffer.length_bytes = 0;
-		gasket_dev->coherent_buffer.virt_base = 0;
+		gasket_dev->coherent_buffer.virt_base = NULL;
 		gasket_dev->coherent_buffer.phys_base = 0;
 	}
 }
-- 
2.16.4

