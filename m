Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5790E20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH7WOGyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5790E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeIHADv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:03:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35990 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:03:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id v26-v6so13132017ljj.3;
        Fri, 07 Sep 2018 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fiSXZ5eqSPgdJjD50E/ZwJ7lpkclOGU9P+fStImj3/c=;
        b=SH7WOGyFtPFQd7I5m4as3CP14CNHtF1xa8YrmJofUFPMGabFY/igwMivZi7t+/bzwq
         ltXmSQtIgTXLKI4XXboWVTh3No7RSMbRPSDvOFpxeAjmIUq96cAhffvzwjlQPkydWruQ
         A+kefXok1eSVh0By5NV8KhIjkjUvnBMYhEXVBitKTMRCIUglwX2ZKnPW9iHInHHkjyo/
         CQEd3ThQHxo4FeQ7xs0PSTqGeDPV4rPeko3v3ca6d9sd2KnQPDv5+wSqETwWCC+uv15J
         8C0HukSRm8obJRa5zIKuwKMHbr1CqwQkUA7NRqqoAO64N7pwMBKncGbjAfI+24qIsey8
         FDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fiSXZ5eqSPgdJjD50E/ZwJ7lpkclOGU9P+fStImj3/c=;
        b=Z9C42bNvHpRuIjbEwJCsaTLiZOaYtCo+/CObyswYjGesekhd0NTZizCoj010LsJoBp
         e8N+k+UD/iGe5SocTRcKFCkg4wUJq0kyRjBzB6z5LW975vi3NSaoVUi5NlCj46q9ww6/
         3ZpAs6Iz/tJZTcddbi9pr+b/HyTKmzXkxx9tvvNO4JIRUY3dLAqjrCqdVEs0aJJBOapT
         hrMeMZPISkEbxfqPCKeNSfQSB90rimaYHZKnKBncofwjPfFCc7NINXnwD6FHyp4j7wld
         /5W70VIXMrVlHPEzzALeh/yuq40BWKJysfAwyOevleOS7o4n2iV4MLldpPRRekLSPTIv
         obLg==
X-Gm-Message-State: APzg51AzwuK5G9527MJWQO+XC2S9Q0PbSca5Xu8cOKKYu4tTQT2fmkVU
        vr/NPXoaD/1jKizhHfI3CqI=
X-Google-Smtp-Source: ANB0VdZbgk4NrnppFmJUIm3v8dl2UR3LgdttTdzpX1oomksrXiC+kdwBZ2gEerB6Yr/CuflFXkv7qA==
X-Received: by 2002:a2e:9b04:: with SMTP id u4-v6mr5693723lji.78.1536348088152;
        Fri, 07 Sep 2018 12:21:28 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id f9-v6sm1417748ljf.9.2018.09.07.12.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:21:27 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
Date:   Fri,  7 Sep 2018 22:21:19 +0300
Message-Id: <20180907192119.4931-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a hint to the compiler.
If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG().

The optimization is disabled, in case CONFIG_PROFILE_ANNOTATED_BRANCHES
is turned on.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..bf47584eab2a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -183,7 +183,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
 #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
+#endif
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.17.1

