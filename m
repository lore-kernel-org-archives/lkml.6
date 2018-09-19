Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05DBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BCC206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 20:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIdEBUZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BCC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbeITCUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 22:20:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35730 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeITCT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 22:19:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so7158566wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXYYXmRluC0jjgE3HlYYssosxAQKJ/zlfwgo/DlNejo=;
        b=PIdEBUZzJX/6nU8/1NrLaS69niPj1aUWu+lc/aTsdHJaGdj9DHF++Q3xPXP371NVcL
         XlldkdwdWaMJ1LEooz/KnHousyqAIr/C3ulSVc7K5njTyV4rKJFx5PpQDB2jPbK2RDWf
         vO/jLLhr6Wi5KrMfMmx1n21yj2AUk22T41jBX9PPhj56jo0sXIrGahwjfA3wg7qiKESe
         SZIV9W0FkqnziuwRWvjeLBfABqQtr1JiNe+x3+Tn6NNAk8bIYZ93D8+ZavugeSJDQTB4
         pYpLILv/Gp3pt9lEIYJvKmgJDt9YrT6xgxHUPevQxCrrBaRKLm6CJvCR6cD/DY7rRrPl
         wqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXYYXmRluC0jjgE3HlYYssosxAQKJ/zlfwgo/DlNejo=;
        b=llj+33ONYv+t9AlzN9Rfh8coXeWaq3uGd5vzuqiilOWXe6i5fEHTbkZruzO3XeQ45l
         7GJbyCuwDyIlThzzUzTybJoScu7gTyzSjU0To4oQr68MlHnVe11Dtz4gbf5Lhx9s4prD
         j6lJOTlDFAhH1EkUGzbh5Rx2+wUteanPVEl8jgXsIBh+SWlMzyMfwi/teVXKJAjxpMQb
         1cDzU+MjvBLoMe4ZZ8sBGKCmbZ01EWjJ+3POl9kD0Yke/dwOuivH30Pop1olpTI4WYVR
         pizSl2JmPjWA0qBv/GsNM8Q+jRzPMKT8ujMhQwl9tRPaEH7KzDNg4uC+OhH6cC6NqDgX
         EP9g==
X-Gm-Message-State: APzg51BL3qOtzpwkGdK3BWgsVXL5RzS80NWU8WkAghDGu+4dxaJI9mrE
        gELKgH5AuyAzb/glAuW6eik=
X-Google-Smtp-Source: ANB0Vdb9DkP04QlYNvBTmF+Vb1R8zDJhWJFa3iBS682MG722+cGaWfjaeULl6avB3XudNj1o4Ssx9A==
X-Received: by 2002:a5d:674d:: with SMTP id l13-v6mr30090629wrw.197.1537389619624;
        Wed, 19 Sep 2018 13:40:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id b10-v6sm18013637wrr.88.2018.09.19.13.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 13:40:19 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: clean function definitions - style
Date:   Wed, 19 Sep 2018 22:40:01 +0200
Message-Id: <20180919204001.2358-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919204001.2358-1-straube.linux@gmail.com>
References: <20180919204001.2358-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not line break function definitions where not needed and
move the return type to the same line.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 5fc346a285c2..d95940485126 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -240,8 +240,7 @@ s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	return status;
 }
 
-void
-Hal_InitPGData88E(struct adapter *padapter)
+void Hal_InitPGData88E(struct adapter *padapter)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 
@@ -258,11 +257,7 @@ Hal_InitPGData88E(struct adapter *padapter)
 	}
 }
 
-void
-Hal_EfuseParseIDCode88E(
-		struct adapter *padapter,
-		u8 *hwinfo
-	)
+void Hal_EfuseParseIDCode88E(struct adapter *padapter, u8 *hwinfo)
 {
 	struct eeprom_priv *pEEPROM = GET_EEPROM_EFUSE_PRIV(padapter);
 	u16			EEPROMId;
-- 
2.19.0

