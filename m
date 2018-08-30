Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34695C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316320839
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGCXi5cE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeHaCjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:39:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44711 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeHaCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:39:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so8438697lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FrUqEq2JKy8qRPHa8wbsVnHqP3RMPAUfUZg4dPLD8Qg=;
        b=JGCXi5cEa5kT8eBkV8QVflm0TN/RuVTvt3cEtVmG04LkMQJmqb+o2zHQD/EDkeKaJG
         UQ4cETNUEI5VKVsAPB/BPKw36w7wBTFwLx3QXASODWdpZEXfWqQwWs41lIzv/hZINXLT
         H61Mvse7s/l3VNFX/KsBLsbq4DkEZbKun8W3TbwpJCwdJrEgGuL2CNr+h1HVPdWjkxAI
         8mAWreRBJei08SgbdmzmsVRs8H/tO5l9XU7hBF3rzoX0N1YcLbsFGhnQEqUH7EFz3PfN
         Ju/YY+qa6YWBD+lg/IGKupHp2dRKxs304gRka5GCKUogy4ASzx2DiDkQdPolzCLuQ2hr
         xXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FrUqEq2JKy8qRPHa8wbsVnHqP3RMPAUfUZg4dPLD8Qg=;
        b=ELZOCKPsR315EBibHbjmt4TFabsvRl37hv0X5LqgL09RPzz8THQ+TIeP4ssCsrQBCu
         SypFwMJRiGb/Xq5xUcFa/DcDyBQISDyYiVJxNqcWFTnIKrHLiuFXndcxiWvySz6ytnm/
         nXIYiHzwQvyH3Le3PNDA1poH4xDUn9dA9hQMEHXuDQWI48nm5tEjH28sLojiAdkIrFqa
         yyAszxeiXnSRdqr1VwICwzbpzWdmnUmoXA205na5NbpqVApVNg1qzSmI/89EFY39ppWX
         cxsQ1Gcj6LuNWbVD8mfiE3O2SrX7hhXQopYzFVeQCSdxj3kuWNpUbaVHSnm2HidAqNER
         6D2g==
X-Gm-Message-State: APzg51BmJ5hcgL6aHIlXTBZlDfwB0ThSXZe3HUMGClMAgElvZllAIPbg
        sRfFKpb1B21hWTejTzf0wNjGUzto8zU=
X-Google-Smtp-Source: ANB0Vdb3lm1GrrbseWpWf4QxGVbyYbC5gaAEtw237cqRX3Jp1RnOAodZrthuNoH7VDQ329Vuf5TNxA==
X-Received: by 2002:a19:a345:: with SMTP id m66-v6mr2792163lfe.23.1535668518813;
        Thu, 30 Aug 2018 15:35:18 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:18 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        huangdaode <huangdaode@hisilicon.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>
Subject: [PATCH 02/23] ethernet: hnae: add unlikely() to assert()
Date:   Fri, 31 Aug 2018 01:34:08 +0300
Message-Id: <20180830223429.30051-3-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assert() condition is likely to be true.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: huangdaode <huangdaode@hisilicon.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
Cc: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index cad52bd331f7..431a3cf8cd2f 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -47,7 +47,7 @@
 #ifndef assert
 #define assert(expr) \
 do { \
-	if (!(expr)) { \
+	if (unlikely(!(expr))) { \
 		pr_err("Assertion failed! %s, %s, %s, line %d\n", \
 			   #expr, __FILE__, __func__, __LINE__); \
 	} \
-- 
2.17.1

