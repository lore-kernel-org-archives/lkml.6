Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70174C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F3220839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tR+CaNIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F3220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHaCjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42136 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeHaCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id z11-v6so8464880lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q56VukZ+Sga17WWh8ncPPU4lAB5QE76VRPyAgia69Z0=;
        b=tR+CaNIplzB08nvwUds7+YDPOUiPb7zmlbUF6VRJAjfDa1PS3aMUUZsqE3SB+yREvd
         TgRB+QRq7wl64LI/L0Ks27FAymfULPa+zrRKKY2zX18m2kFGCB5dlQMISt+wkBaIfBKs
         K50mHB8Ea3wC+g2HmcLK74/dj06OQRcembUNHhohztCfQn8gxs7fq6JB56kQ3BQ6KuZS
         YcAhm65CkDRYMLQ7VM+E2Wtdv7f4PJ4BxEeYrgX+oHwXWjPcqaS1NdUEEvzqLmaFj8Jz
         9JypJj6vTSCIBgEwdXfzdJkSns9jzxMVIxZE+5KD//yupxi7c7IwQUEjXH2Sj3q09/7M
         MHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q56VukZ+Sga17WWh8ncPPU4lAB5QE76VRPyAgia69Z0=;
        b=QM+t+o7R4ZkPxfj4abV9H3iqf2Td3yPBb3u6J8YOcaaw0LznYroNvKAmIpIer0CnBE
         OW/dTfzQRWzJPwOYevcZgy2J2CRONAQjreJt28IRU10v2kETxIhWZjRnKXzjbqSOZmJB
         5NP+X/dTc8g/NEN0CYDvSOV0+tNF78HCsnOh4VdYWbzNAaFNldwGTr93Ae4zL6ooE/4e
         Pc07HBwhz25Qy7vc+9pIbUVBr3FpV+c1LYsaPpiZxu7LlfKBdr2N7kbDqaOFMs/NpbYb
         xVSF7My6xCEDZGQgKZ2KPuGTmMlcUPSyxozZ5xapxA9BG5KIVbEOFGGjlrXSfAdAmKGo
         +jdg==
X-Gm-Message-State: APzg51B7a7IEWwtQRHgFKQR3S0yvsCSuUKQtPO07n2KjNJDa8cer1Kqq
        J/HrVEwJvcyMZOEuO3LLug2YbBc5nq0=
X-Google-Smtp-Source: ANB0VdaXuoc7fH6hviLl05a6IKAU5CPjYDLrNM4nxrkwpOzGQ3oneFDFHusdl5whHlm672cXbZ2ugQ==
X-Received: by 2002:ac2:4242:: with SMTP id m2-v6mr9228089lfl.40.1535668515687;
        Thu, 30 Aug 2018 15:35:15 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:15 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 01/23] infiniband: nes: add unlikely() to assert()
Date:   Fri, 31 Aug 2018 01:34:07 +0300
Message-Id: <20180830223429.30051-2-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically the assert is expected to not fail.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Chien Tung <chien.tin.tung@intel.com>
Cc: Roland Dreier <rolandd@cisco.com>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 drivers/infiniband/hw/nes/nes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/nes/nes.h b/drivers/infiniband/hw/nes/nes.h
index bedaa02749fb..d2d0098f38e0 100644
--- a/drivers/infiniband/hw/nes/nes.h
+++ b/drivers/infiniband/hw/nes/nes.h
@@ -151,7 +151,7 @@ do { \
 
 #define assert(expr) \
 do { \
-	if (!(expr)) { \
+	if (unlikely(!(expr))) { \
 		printk(KERN_ERR PFX "Assertion failed! %s, %s, %s, line %d\n", \
 			   #expr, __FILE__, __func__, __LINE__); \
 	} \
-- 
2.17.1

