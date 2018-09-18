Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B83ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2309021471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCE2/EOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2309021471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeIROwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46476 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id t19-v6so687532ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=NCE2/EOVIcgjQlUIRrZGWPk0zdUxPJDWRuuTOY8E4je42eXRGiBuJmomhE0RpVhzG5
         WzHemaoFD2Mdj4W5M6YIlfxwSuYufmoFSjlAHVHAyM1Xgktwtsn/FgGPM4942EPJ6o1/
         VpNjzO9ls8P+6PPjPCjLowWnr8eqzIPYh/OzF0jKFy2kLG28rA7wqu5dWUrQSbwh8rkO
         +bUWm1/8tnufGm6VBAHSHETsGrswlL+RamcNsmCTXR+7ckWm/1Hfc6OUJbMK2saXHInX
         pzVDhpHkkKzA7uRVpNDjsXkyF/g+t4DluVtUNTI9J98LMrBoAnCZWoj+KPsp9V9478VG
         ndeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KwSJ/ddsrLXBKVax3TPyV5fU4fUUHvzkXBSHRSHeQgk=;
        b=BH7xnb/nQLGMgCq9dX7INWfTxf3f7FqLHiBWE41jljnCS/3ZrwuyMRAmddT9jpmw9z
         xAbqHvqa5xxadGqv8uBV/KZ/N6YKhnY9wp2ctCHUy8Wro1zFPOC3SXEBTWNMMYA6agxL
         Qt45lu8Av03K/c+ET4jL+qy/3Rpyl3PcNutoP0ZT54yyoO28czRux/IaXcTwCL1kIV4v
         GVMT8rIgW8c9oM1PizGtNcavpDoU6Vpd2OzJO6SslKAPT7jvRZsfBmmPH+yQityiLuCL
         ifJTggakEiS5Wm2dh1zcmP7huJp76De8EsLiyEKoqBGwKW4uMX99+cBEjaGqJ0eSLvO3
         7nbg==
X-Gm-Message-State: APzg51AYX67YG1BddvtqUQKSFdeEh2MIt0ZCkwfGrrXaH2lk/vRDexw3
        n41fKlVV7O8+wkfantcQAOg=
X-Google-Smtp-Source: ANB0VdaC5UlAmZvymxIZjctzlwn5gE4+du8d4LjOKOZwm9cACtpl0QKVfeRXH1QdzrcVASZ4kG8CoA==
X-Received: by 2002:a17:902:a413:: with SMTP id p19-v6mr28506846plq.220.1537262455740;
        Tue, 18 Sep 2018 02:20:55 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:55 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH 4/5] RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
Date:   Tue, 18 Sep 2018 17:19:16 +0800
Message-Id: <609ae2448aab79dea99888bf5c72d1eb9877c7c3.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537260207.git.zongbox@gmail.com>
References: <cover.1537260207.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit, it need to use __umoddi3 by some drivers.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980..dc262fa 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -108,6 +108,7 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_UMODDI3
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.7.4

