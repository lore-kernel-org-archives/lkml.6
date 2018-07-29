Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF0C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F236E20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1UcfC/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F236E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbeG2U0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 16:26:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2U0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 16:26:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so10392597wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4x7RuylqcI+40EpLni4YbXnwf4Sk8Q6oFoguQTRWis=;
        b=X1UcfC/MYqsCsalDDkHZUnGlyngAVKY6aOdK/PcIeuc119jrF3bzZjlTmtnwiGM6DL
         R9MeK6xeAdeHV5C96MjkkPdwNNESFYHUnaolYUdVKlvBdG7jRZOiyKMnZikvT6NuOVcj
         QfbcuNZ8bdgeSiUk3yUpcxzPfZebuOVx9UjyD3DhZlhTdg6I2UegKmYKjVrZ8cA3kGen
         dWvRFhS+xG+Lxdpprk89VnkbmehU/DSaPrLTGMzndWBPdYlI2xCrZZ8r0jKEg/9N6RRd
         P0j7tOFJJy+1lwq0cUqU0U46DUet0Hrqf4LaqEMRqxLvargFPvgtzM2hwvnxo9QA/tyg
         UILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4x7RuylqcI+40EpLni4YbXnwf4Sk8Q6oFoguQTRWis=;
        b=S42MN53z0Ucsch+8RHRI38P9o09PtX8Vai0vr0pGQ/FaUGuFR0oSxOLBIuS0+AFyYV
         KrwAcMLLMd8YEj19N6fSgcHkdNURAgdI7Tor9dGK10qkfnb0baxJMcPiNutYUH/ul4UN
         9dLGKLBxUdyDHHVNo/CwhHfln+kG3wvXzYE0ummCLZZeMNhC1fiuUnu5nQ7KJ++BAUnb
         9qQ8/TEwWHNgArdmoxDn5gMKQR+LLWtr7vpPRkmLoYWz0tLLqpB2GTc/njJssizeavcZ
         VzMCh/0vhGXzsSkp+OuPXUD1FulsIdhrA9vcIiRICaFdnJ1s1QL96qUcU58b60pVH1QM
         +oGg==
X-Gm-Message-State: AOUpUlEMyrIZUEpC/3uw7HC90Yj5SjMYIuucrD4d9KlRDG3CfON2rLIh
        Dv0dWTBSlsjfnkSW/QcNV2M=
X-Google-Smtp-Source: AAOMgpet5PFSEDLO9xqp6P+Df7NzcUtP9XIktGmSYxHszSAp6q/bBABSTwSTLLToZHJM8Pqd49sv6w==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr14441959wrt.162.1532890510112;
        Sun, 29 Jul 2018 11:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id g125-v6sm8674247wmf.16.2018.07.29.11.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 11:55:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/7] staging: rtl8188eu: replace tabs with spaces
Date:   Sun, 29 Jul 2018 20:54:45 +0200
Message-Id: <20180729185447.19903-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729185447.19903-1-straube.linux@gmail.com>
References: <20180729185447.19903-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces in function definition and variable
declarations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/hal_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_intf.c b/drivers/staging/rtl8188eu/hal/hal_intf.c
index 0baf4e616b6a..c43e7b438058 100644
--- a/drivers/staging/rtl8188eu/hal/hal_intf.c
+++ b/drivers/staging/rtl8188eu/hal/hal_intf.c
@@ -8,9 +8,9 @@
 #define _HAL_INTF_C_
 #include <hal_intf.h>
 
-uint	 rtw_hal_init(struct adapter *adapt)
+uint rtw_hal_init(struct adapter *adapt)
 {
-	uint	status = _SUCCESS;
+	uint status = _SUCCESS;
 
 	adapt->hw_init_completed = false;
 
@@ -34,7 +34,7 @@ uint	 rtw_hal_init(struct adapter *adapt)
 
 uint rtw_hal_deinit(struct adapter *adapt)
 {
-	uint	status = _SUCCESS;
+	uint status = _SUCCESS;
 
 	status = rtl8188eu_hal_deinit(adapt);
 
-- 
2.18.0

