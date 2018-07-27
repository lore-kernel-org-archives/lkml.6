Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D11C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A8920893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWyj/zd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A8920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbeG0KER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:04:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43918 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbeG0KEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:04:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so1504622pfi.10;
        Fri, 27 Jul 2018 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ewDV6dedJ33kYqT8u9IK92Ungk2gWImAxEcOARmyGFI=;
        b=VWyj/zd6HN8aEdCC6RB8s/zVRlO/WU1JlxxLfasOVNNaz4JJmsv+nSLL8U0t7gRPJz
         e2IOIhh2o6RXMngSee013eTdiTerJ+4jBZ+vSDL3dkc5OMW8Z+mtYk9XjYrldboGsqz6
         zx+pcD2l0PL0U82eycu9bKEuzj6quB3stSw/fxfNCbkFUFyuBQOjc1yBcA8IQLTMxj1F
         zbCIpOnRz1q3XiQTEDVl56Hyj923DQ6UAYdVPksHKs13EM9uazbtfWR52P7mIcrqvj0h
         VKA5+OXpTUg073tJtDvP76Ixu21MzCkkfBNqhE4VF0JAwZ/bRqTMYuj/OsVPPy0ieZhl
         AAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ewDV6dedJ33kYqT8u9IK92Ungk2gWImAxEcOARmyGFI=;
        b=V3VE57Uxu0vLH6OC8FaWNQl6FxUtP6oXL9bJZw7QOOsyvgOYzfWQ46A7lh/vtqpzmG
         p7FQGbRXYh7h3y0EO9cx6Mj7kY+vqbfpyPGr5b4+dh6KbDsXsjieOo19hk6ETxn2fv9p
         z6JX/GjX1iM+IUgmLDZemX+bBWkb+ZA0jvLsClNqNbYF7Bzf86P46mjMbMYtqbNAYKof
         iB4xtFivUNBDeRKIIiIkgYa3z6VhyQSbYCn3SK9hwywZ3l/ykh76etxeTVNyEBUsaC3a
         VkMeINtNIOE43tlIoKC1oDTFoXOOgqOLTEFelNZ9JUPotTssDFXDE71t8ZtzV+KtXPlq
         oYdw==
X-Gm-Message-State: AOUpUlEHRiodxllW8VtseihjlXDTS48git9zaF/TvnxI6cdS0JqKR+r7
        867amAnGGkkD4REpntQRzhk=
X-Google-Smtp-Source: AAOMgpfezxuiDOL4EbCqceLzI7p7ILvLQa858GyqTovzlZBuixnq85nRq08Cq1WF4dFIA0gfArkTfg==
X-Received: by 2002:a62:df82:: with SMTP id d2-v6mr5692678pfl.189.1532681005047;
        Fri, 27 Jul 2018 01:43:25 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:8ca7:1cde:b1e6:2647])
        by smtp.gmail.com with ESMTPSA id e126-v6sm8107269pfg.31.2018.07.27.01.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 01:43:24 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     kvalo@qca.qualcomm.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] net: wireless: ath6kl: Replace GFP_ATOMIC with GFP_KERNEL in ath6kl_bmi_init()
Date:   Fri, 27 Jul 2018 16:43:18 +0800
Message-Id: <20180727084318.3345-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath6kl_bmi_init() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/bmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/bmi.c b/drivers/net/wireless/ath/ath6kl/bmi.c
index 334dbd834b3a..bde5a10d470c 100644
--- a/drivers/net/wireless/ath/ath6kl/bmi.c
+++ b/drivers/net/wireless/ath/ath6kl/bmi.c
@@ -534,7 +534,7 @@ int ath6kl_bmi_init(struct ath6kl *ar)
 	/* cmd + addr + len + data_size */
 	ar->bmi.max_cmd_size = ar->bmi.max_data_size + (sizeof(u32) * 3);
 
-	ar->bmi.cmd_buf = kzalloc(ar->bmi.max_cmd_size, GFP_ATOMIC);
+	ar->bmi.cmd_buf = kzalloc(ar->bmi.max_cmd_size, GFP_KERNEL);
 	if (!ar->bmi.cmd_buf)
 		return -ENOMEM;
 
-- 
2.17.0

