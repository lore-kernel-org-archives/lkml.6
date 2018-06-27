Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66733C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDD1255CE
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqbE11P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDD1255CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966081AbeF0VxZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:53:25 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42828 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965789AbeF0VxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:53:23 -0400
Received: by mail-lf0-f67.google.com with SMTP id u202-v6so2643202lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=06QtmzGVSmKQGTJ8jMGHYnWBnYqopWkaYi73cz1FOdY=;
        b=OqbE11P9Fzi9Zhet8d/3XWywvuobFm0NJAWAuefLjWpVDBXS/QGCNyO7oWguqS3hS2
         a4DxBUWeDGTJ1037gVeWmEiboM1Z1ORdj0XuFhR9tJsgDv9j5VYNXlnPOPvAJ7U0oF1m
         f6Yg+hDR9S/gpg4EqiADrYvjoknuRfLLVJpu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=06QtmzGVSmKQGTJ8jMGHYnWBnYqopWkaYi73cz1FOdY=;
        b=AIq4uMTizrM8NNX6RrtyIQl1eW4aZbyt1YQDkMigj42ZGxS6FWaq28sJut6R7tE/AF
         5ZnRq/rSntoD/6d+lNhZYRZrpyNevyJbtgseq7dcLxkkm2NFbT1wLPPtZqqTEj0aycJ7
         yG+IC68yrQj09g9qEUjTUNyCyM0BOCzjBIDzIcNeC4leWiOSARguYjHeEjGV9zh4MPsv
         92nFUjZnKOo3tV9j3+TIt7Ux0Xx/gBNPI7H7a702YE8cQZxc8kqGebtyj5wWT2mimZiA
         LO8evjun34YFTG3NwFmBUmKzrqB+jLqVslb4cqyZ12fnO/z0MPzqG/OITHuV37Se6ZwH
         FruA==
X-Gm-Message-State: APt69E0uTYh0wvSM4OyhpCHfO0wMOQ65BGa13pko9WD5hMzCKYZaib5C
        Uul+mj/w8AkNrYel+It9zedWAQ==
X-Google-Smtp-Source: AAOMgpcUhsBmIpsryFuk8GsiTuKWrwXW8x0eNMawaMkkengiJrVgA8FImL7oWJ0f5eGl+cUDDOjl8Q==
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr5005637lfe.4.1530136402370;
        Wed, 27 Jun 2018 14:53:22 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id p5-v6sm635353lfc.19.2018.06.27.14.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 14:53:21 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] firmware: qcom: scm: add a dummy qcom_scm_assign_mem()
Date:   Wed, 27 Jun 2018 23:53:17 +0200
Message-Id: <20180627215319.1417-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy qcom_scm_assign_mem() to enable building drivers when
CONFIG_COMPILE_TEST=y && CONFIG_QCOM_SCM=n.

All other qcom_scm_* functions already have a dummy version.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 include/linux/qcom_scm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index da63d84e1e91..06996ad4f2bc 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -89,6 +89,10 @@ static inline int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 static inline int
 qcom_scm_pas_auth_and_reset(u32 peripheral) { return -ENODEV; }
 static inline int qcom_scm_pas_shutdown(u32 peripheral) { return -ENODEV; }
+static inline int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
+				      unsigned int *src,
+				      struct qcom_scm_vmperm *newvm,
+				      int dest_cnt) { return -ENODEV; }
 static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
-- 
2.17.1

