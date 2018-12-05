Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB00C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C7A20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039566;
	bh=CaM/Lsx+HKemRur+HpUTe6HCbSMGEFJSQpL0RJqlgo4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t26otU9NF3tN4wn2IWQPMyYtIptzlIBSn8qBS4P1J2rBwl5hG/jZrDs5zWU74lBLI
	 qqAQkdpVAnm/HFSIfc0tBMaA2wC4kyuGhlC43ys0xYAtMGPzXCEz8bVOVsl0UI5nH5
	 MBbnmAmtoheXJBgf2INQWBwtjAsSi0M92+Ilyp8U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C7A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeLETwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:52:44 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44279 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728772AbeLETvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:51:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id f18so19781739otl.11;
        Wed, 05 Dec 2018 11:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPG48+BHkPOoLEArL9+pShkufe1g9loOUtNtC/iMJ6U=;
        b=gk7nWRzUeulVBwQFdK1kmZT2CrNPYqdiF4RLUNEQMDgcFJzGXeTKnLm+BSo/fS+BPu
         LMsqzyM9m+7TXGoz/p44x1g8DIDBn4mtd+6lu1FSblxxOloQE+5X0jd4j7W4C9/peTge
         an8w/3t5MK/FIOqDwsIIrGJi5l0Hb1Ok74uEgKzO6WF8bDrbp8EEcuJJhj2cKx0foTJY
         s5fH2F3yiNMuq18cTlmWzxI0HfNJSGjD198BWJN1PaX5xABLghlz/ORrcU4cm7kfNM4w
         ZPLm7HzuMVneszp0DR2L7T7L0NFPSCew7Kkm5vYaQkJIeXkqU0FNaKN3iREPnBoJgH6h
         QvPw==
X-Gm-Message-State: AA+aEWa8EAKjeMJhQYd6bVs3NK16GNCcKozN9cWmKImVWBkGbzNfyr5x
        dy6Y51BzZxyawg5QlbdqjIqQdqU=
X-Google-Smtp-Source: AFSGD/Xc8OIRmd4dkQH/FjRfjmRB+sE8C8oX13ZL74lqrkOR+KCm30hgliWm3EImKFf58i+LPeSkUA==
X-Received: by 2002:a9d:18f:: with SMTP id e15mr17158595ote.84.1544039473605;
        Wed, 05 Dec 2018 11:51:13 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:51:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH] pinctrl: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:36 -0600
Message-Id: <20181205195050.4759-20-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index ee6ee2338606..de0477bb469d 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1071,7 +1071,7 @@ samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			continue;
 		bank = d->pin_banks;
 		for (i = 0; i < d->nr_banks; ++i, ++bank) {
-			if (!strcmp(bank->name, np->name)) {
+			if (of_node_name_eq(np, bank->name)) {
 				bank->of_node = np;
 				break;
 			}
-- 
2.19.1

