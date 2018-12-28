Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F078C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFBE217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeL1WGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:06:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42890 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeL1WGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:06:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so10480912plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhnrDAarOzLArd1gQlJciBVJgtFLaThMeoRobG1BvVM=;
        b=qOdjzRMPi+/Yp/ZZ6S9XbpFFzsQg75FZKAw+kfrRQhZiVU2C6xZCEz9wEPXFkaZDbL
         34LZolcHqR2dvssAkPe7XS2nKXY/Jjtf3dsipwxTUefKla76uuJwv5IYOB80/e0prbAE
         00IbOENG3Ynx7ic1sg4xzP7Heu0XfOP5sWuTvIFNXb3qR7SBzckmjVqTc+bZJFmbnHk2
         +ne5JDw6AeisMzeeahfoYdLQNwwECwf4ird4ItyroBdcUNgBKmfk5e8/tXMQHZku/UAh
         H3JP6K1CjiqXFd7H3GlDbOS9/SFrTPsFXHpqhB9xuWl2k89bLcktt/o0G5AIPVeaqkcq
         vx2Q==
X-Gm-Message-State: AJcUukf0nEFrb9PZXeTmTE6HTjA7amORwi+vwyAS30mkYr4VQmXT6x5R
        2QD3JzG4yFRqyrOX/Qh9cXXY/Q==
X-Google-Smtp-Source: ALg8bN6kJyVKBqxRlBomCIapcyaHk1x62gTsJjD8CVhSYQ3kwvYMn6arVre/P3oRbMvhFlVQfyWSTA==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr29609176plt.106.1546034768677;
        Fri, 28 Dec 2018 14:06:08 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f62sm49333537pgc.67.2018.12.28.14.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:06:07 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 3/3] Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
Date:   Fri, 28 Dec 2018 14:05:46 -0800
Message-Id: <20181228220546.367-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181228220546.367-1-mka@chromium.org>
References: <20181228220546.367-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set quirk for wcn3990 to read BD_ADDR from a firmware node property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v3:
- none

Changes in v2:
- patch added to the series

tested with https://lore.kernel.org/patchwork/patch/1003830
("Bluetooth: hci_qca: Add helper to set device address.")
---
 drivers/bluetooth/hci_qca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea33..0535833caa52c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1193,6 +1193,7 @@ static int qca_setup(struct hci_uart *hu)
 		 * setup for every hci up.
 		 */
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
-- 
2.20.1.415.g653613c723-goog

