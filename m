Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D49C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7454D213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 01:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M579aGeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJDINJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 04:13:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37071 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 04:13:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so7319157wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN26LeuauJ/Fpag6lGAeXwG7RYdYUHIeI3mtcnucjGo=;
        b=M579aGeZQwJwcrPmJyIJ+6Ka7rdE8lE/AzRomDIEfIZaSqwOKVuOtoK9NWa78ZiJXu
         0bZHDfTV8HxOZceaKrqv1fNaF9QG7u/04qVYk4pV84F9CZtQKh3s1M6gehzpUR4RwAnS
         sk8ZFKIf8A33N3WnMGSefWlZbgsRHhletn2d3YzhzFaHU6C1rQSQ1dSbfh+DG1fw8lqy
         aZfE1RM64vOjHTbyNg3GNsNs/kjid9JidT8RrDSOkDg75jIl3P7rsEuXtY32xEGYO8Uh
         gyRbltGAfKOaXtLGQFqj7gg7UCT8NjkbFv5+C9Ljlb4qMhzQNRJgvUtcJmOieR4fm9eT
         HO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XN26LeuauJ/Fpag6lGAeXwG7RYdYUHIeI3mtcnucjGo=;
        b=qlb00N/W61Lwi5oTrpj7i2RhHUHMCxqp5okgBFsmdjtBdWvDgfRbLR8N78Vconekit
         GI4wKstYLbGqeqwFNZxI+3qGRm1GxMJBCCiAGOYkrXFfNOm+AXSxyy3ba/34Zhx943NE
         2Gp4aqx7/H5mf6hD1myUEekQ+/lMtdKAdnAxSHy4yrE0FUvzLaXv7G3zLALlz49sOdfT
         nsL+dZ2zPOuf5FFRBg97tTwbmPMf9Bgj2UnQpXvtU5fPox4V5Wb+9FlBdR3O3ZvPedwc
         NxRC9r4six/HPqeyS2SB8vyuLrMH98I+KYfqF7ag6fetOGyNCuaC4xERzLQ3HPASk5eF
         hTBg==
X-Gm-Message-State: ABuFfoiwSg8ZM5PkN+PPy5TaUbmH+xY7+op3e1jNQ9gAZfvJT3ESTM8m
        L0+5UGGKKFFLIpd0tAyvxmU=
X-Google-Smtp-Source: ACcGV61eVYzFqYBr7qYrFo9hlnnhZQRAZBAwtWQ/Rp0oguUxpHcC6dSLG+CV8kJzv2TWuDccUXF8eg==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr2969603wmf.117.1538616134470;
        Wed, 03 Oct 2018 18:22:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k63-v6sm3756802wmd.46.2018.10.03.18.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 18:22:13 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtlwifi: Remove unnecessary parentheses
Date:   Wed,  3 Oct 2018 18:21:25 -0700
Message-Id: <20181004012125.21782-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c:558:33: warning:
equality comparison with extraneous parentheses [-Wparentheses-equality]
                } else if ((is_enable_la_mode == 1)) {
                            ~~~~~~~~~~~~~~~~~~^~~~
drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c:558:33: note: remove
extraneous parentheses around the comparison to silence this warning
                } else if ((is_enable_la_mode == 1)) {
                           ~                  ^   ~
drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c:558:33: note: use '='
to turn this equality comparison into an assignment
                } else if ((is_enable_la_mode == 1)) {
                                              ^~
                                              =
1 warning generated.

Link: https://github.com/ClangBuiltLinux/linux/issues/172
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c b/drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c
index 42020101380a..d6cea73fa185 100644
--- a/drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c
+++ b/drivers/staging/rtlwifi/phydm/phydm_adc_sampling.c
@@ -555,7 +555,7 @@ void phydm_lamode_trigger_setting(void *dm_void, char input[][16], u32 *_used,
 				output + used, out_len - used,
 				"{En} {0:BB,1:BB_MAC,2:RF0,3:RF1,4:MAC}\n {BB:dbg_port[bit],BB_MAC:0-ok/1-fail/2-cca,MAC:ref} {DMA type} {TrigTime}\n {polling_time/ref_mask} {dbg_port} {0:P_Edge, 1:N_Edge} {SpRate:0-80M,1-40M,2-20M} {Capture num}\n");
 			/**/
-		} else if ((is_enable_la_mode == 1)) {
+		} else if (is_enable_la_mode == 1) {
 			PHYDM_SSCANF(input[2], DCMD_DECIMAL, &var1[1]);
 
 			trig_mode = (u8)var1[1];
-- 
2.19.0

