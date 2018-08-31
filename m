Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A94C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1952077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhGWiPPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1952077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHaXd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:33:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35206 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeHaXd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:33:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id q13-v6so10823731lfc.2;
        Fri, 31 Aug 2018 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5/CScGUK/Mr/UvAEUIS935zNUFcvU/PgjkXaci5Uekk=;
        b=HhGWiPPMJgpFiqMO+fQrCNSVWE7ShaRYglCH0i/Msr5wjwza77u/WN00S+4527r3XL
         c0mKOy11+qySiPtKMXcvDGNImG6pd7QlXykiA2pw1km/5OphFvQiwW9eqn4/yPjxm8mT
         Mp9lMcHMW2AE5OcaVGo/hrxLk7ePO8DMbI6SDPIFvTn/LuAXg34Buhed6qr7lcg0uHgJ
         ipH3azySPbRP6V8df0yCV9VBF1heZxsIXcsDclO8X1Uxk2+/o/+eawmSi4K6YH9t6Pa/
         BRVmKBik1aXu49CWElMmKbCcSNvJ8++O2WUy+j5IDod/s2lIVmrnpHwSRJfbOQpR++VV
         pxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5/CScGUK/Mr/UvAEUIS935zNUFcvU/PgjkXaci5Uekk=;
        b=S04K8OgCj/Zz4lQxSiWRf/8azDZEkDQiL/5G6fXulj6ROgkcOgoCFBLTinUsRlnt9g
         1K1UrpUq4k411Tf5w2efAXaiaSIDhPblaT0Abw8tdkYbUjr5ZqWlC0/U/uyWIxuQpfRX
         LEcRiWu4GEs/sPl3L13Fm8VcLFXlRYtwnqZrXAbx/il7kq+XsE1Db5fVPW24MdyhfAS7
         tqnLSJOLJW15udPchgjH3+98/I+dc75xMhYDguTfL2MOOTIEcpyPd3+oVndrHSUi+T3W
         Fkqsf+RNAIxEwJGCJVaPAl/aA193e2h0TDkq3RkkYXyzsYOLgd6suoCyJU8PVDpvP7Yi
         tZsA==
X-Gm-Message-State: APzg51Ag4zKR7hbsiEWOh/3pvjJnqeuG6bwoZm5elIK4ZL0/ikR0LUuh
        sFwOWyN2e8ZE3vbq6mfOv54=
X-Google-Smtp-Source: ANB0VdbCO4+htvlBvlMCJeTPQv3WofpAorAX86oEdAw/3VOTk0YhiG/uJTfpUmd9n3MBG0PCWMjYXQ==
X-Received: by 2002:a19:5353:: with SMTP id h80-v6mr11939413lfb.9.1535743472242;
        Fri, 31 Aug 2018 12:24:32 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id h71-v6sm2034796lfg.64.2018.08.31.12.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 12:24:31 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Faisal Latif <faisal.latif@intel.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: nes: add unlikely() to assert()
Date:   Fri, 31 Aug 2018 22:24:18 +0300
Message-Id: <20180831192418.12346-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically the assert is expected to not fail.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Chien Tung <chien.tin.tung@intel.com>
Cc: Roland Dreier <rolandd@cisco.com>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org
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

