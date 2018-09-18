Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6609ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8147B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXU6r9jq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8147B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeIROwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41651 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so697723plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xILCKLGDFjBBorarrUyjhtvIupooeyobvhfedOgKiyw=;
        b=gXU6r9jq+mgxuOyh9lDBQt3Zhd8facKPvApToJyUk1jV2XTmUmfCg1tOXhZDHuLVoq
         Fzq5THadxEB8N83djiBm4eFmPxBfTOO306dD2v6oaD9gcd52BKFzp6OM9TXp+rf6fXkx
         qOk3o4mLznpKTl+Tb0+lJ/izUnvi/1DA6VPgW0E/pAxpJwsTZSXNeLI0hURJSPK8YUDU
         mdncvVA0/y/g1JmIAY3QedoD+XWbX8+u2m9+UQXNMwYYEUADL2Kil6lldUXBGh92akFX
         A4THuKXjZqPMWJUQ7sCvUmHFxHd+ryShjK75GuaaTNQbmJ2o9ctrTE0yXKBv8dcI57Nr
         zsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xILCKLGDFjBBorarrUyjhtvIupooeyobvhfedOgKiyw=;
        b=ZkuzQ7zKlIhl3f+O9dLj0S6kmOSAG2t1pI3IPGrvB7nvXJf7DGwUsb+0pK/pgzBhBL
         ovyDryc6p3QSxbLhiwZHDnEsAmftx3b+AsncWBIlw0/ocu3yr3+lYYbM9hjdj8rRHhIL
         3bc5X8cJrEKd3y3hzbDXBP1crCQy92V9LotK+1tdW1WGpN4VfW54Yj5pQbUYAjopo/YH
         Kf5aeK5DcGtpByoKqvuyrnhX6dwln4Pns5cIHUkpVKgFPouMQgYu0al5o+OX5hHXa37G
         AMFiG3yK0SjGfte9TIpkDbBfHX+YhZj7Q2OC91M2UG7BpfhVsQ3k7+2IkNGR7HW9o1EF
         OZyQ==
X-Gm-Message-State: APzg51DAB3QBnlk8W5azVKYSWmNpNDEf3xEezY1gJApKn8Uw0q+D7xPv
        SR7zirTkopwlHnv9ZBIdcZg=
X-Google-Smtp-Source: ANB0VdYPh8orBrRHvTjxnPG9IpN7Z9+e24nVxl4pogD/ajXymN+ev4UTvzuVJ7vbjAPHQxaPXD9GMA==
X-Received: by 2002:a17:902:ac8f:: with SMTP id h15-v6mr28426243plr.161.1537262452083;
        Tue, 18 Sep 2018 02:20:52 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:51 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH 2/5] RISC-V: Use swiotlb on RV64 only
Date:   Tue, 18 Sep 2018 17:19:14 +0800
Message-Id: <b9b943c21725db9822a787a1e985010012fc33b2.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537260207.git.zongbox@gmail.com>
References: <cover.1537260207.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports swiotlb.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index aee6031..872a280 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -227,7 +227,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_bootmem();
 	paging_init();
 	unflatten_device_tree();
+
+#ifdef CONFIG_64bit
 	swiotlb_init(1);
+#endif
 
 #ifdef CONFIG_SMP
 	setup_smp();
-- 
2.7.4

