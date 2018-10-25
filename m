Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B76ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AF420832
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rc9LyVGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AF420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeJYIsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:48:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38905 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYIsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:48:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1605512pfi.5;
        Wed, 24 Oct 2018 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kw3+/ZQAbHbio+pO1abPhFx6QqHQV0cICi6X1OfenZw=;
        b=rc9LyVGBK8HQRbX3CZZmvyecRFGDzIbpT+o9w4SJQVid8RaJbwB6pnWZerw7X5Gic6
         hSowhOJcpx0vd5PQyY/8TmqcaltPc+GdPtwMkzKn0UxtSypzz8v1o4sgJ0/EDEwbowhj
         Tw0y4VULySDB3chzQu5WgoGqFWrHrDRkxB7Pj1KGy1IFHzxhmf9/LsrLbMcxbroFc6kb
         lvQk31myp/DGANfFCt2tncwynSTcDdSOW0ZAb5I0gly/QxXjtJoXVComVCnqLdtfcmlU
         rrJcxNfvPTJbQkTFUo63xumar9lvQluD2PtZ5Ob2vkCAj7E5Q9M8Au8rKB6GEfL4cxwc
         jXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kw3+/ZQAbHbio+pO1abPhFx6QqHQV0cICi6X1OfenZw=;
        b=ja+Ev6Hb4TzWAn2+l/8HF+FY34euavI05W72DTmpuZdUG5YrwUgDDJhZwvMJeH+TaP
         hUbmxydMsQ81cXIrKL0di7XzdgZb3b5/c517hm5xCDKijsNG0BQLSxIY8sL6PHSRYdCr
         bRnaV5tb8gjA8hld/XeBj8qqiriMIW64jEW3pibm4uXbio2Pipyq+4MOC9VLbaWWpg0T
         WWZIrvdkyBBtyMAllBE9PjCyCKLLkWSjQUN+oywtO+w9M5Of4VY8g/vYB2CqFSAwP5IL
         9NMXt29wSILtfDH1KbyAcIxhnX/8Hy0p3ATUSLcYoriD9jH6zPNXxNGK6H9XHalzblRv
         yIng==
X-Gm-Message-State: AGRZ1gLlJ27Fvd5YmM/RwKj5eDo0B2BgEYZfkgovq9uuAcbv9EKubSz8
        bbnBHE2boLKjkHh+F7n6cuhlPQymnu4=
X-Google-Smtp-Source: AJdET5ezueNMdKNl9mn4ZC0C4neoeQGNBOltM36hS2hoxfAL2BxyDhz+OQbqZ2gwQpZmZj2Gx1pfmw==
X-Received: by 2002:a63:5816:: with SMTP id m22-v6mr4456370pgb.332.1540426673646;
        Wed, 24 Oct 2018 17:17:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z87-v6sm11615707pfl.58.2018.10.24.17.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:17:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), arnd@arndb.de
Subject: [PATCH v3 1/3] of/fdt: Absorb ARM64's __early_init_dt_declare_initrd()
Date:   Wed, 24 Oct 2018 17:17:40 -0700
Message-Id: <20181025001742.6510-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025001742.6510-1-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM64 is the only architecture that requires a re-definition of
__early_init_dt_declare_initrd(), absorb its custom implemention in
drivers/of/fdt.c.

Suggested-by: Rob Herring <robh@kernel.org.
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/fdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..7d316f008f22 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -896,9 +896,14 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
+#if IS_ENABLED(CONFIG_ARM64)
+	initrd_start = start;
+	initrd_end = end;
+#else
 	initrd_start = (unsigned long)__va(start);
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
+#endif
 }
 #endif
 
-- 
2.17.1

