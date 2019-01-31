Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED224C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C21A12087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfAaWKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:10:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42831 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbfAaWKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:10:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so1946604pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 14:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9yNR4ZYh/gSdToVQb+57U0UgLwEq5o9IiAlRNL3uH/8=;
        b=SeRNt1xrYRLEDRdcQHMXa0qtHaRy85cqARMOKThC5aUN1CKiivpf6mGFab0OEIly7N
         b286sOF5k4Zz8vFQMubh1Iv+s6sGEOWpUL5kvItg0Mgeh+N8ocsZira4v7HWKK8GeTtX
         L51T90POF+ZC3IY1BT5cOScBrYHf/tpZbs9xHDQ+Qyn3EjtKtzeBoGw2txO7659pRZzY
         ob5X+clG5yCMnFIiykd98E+MY0CcGjNX9b/FXDDSbTus65WDYN43CrkG/9pTy+i0e8VM
         hF0NfZemhsVskd4FLwMBaf6BmuwBRwY08ERJdScz2M8n+LsS91zekXK3h72ILKYnNAo/
         IiTA==
X-Gm-Message-State: AJcUukecixjOqztx9GXAvE9mrxAHidR5C+pdHdyXSHxBF7Iih07xyCj4
        03ksiNjMJR6e5CemTywHy4JiDQ==
X-Google-Smtp-Source: ALg8bN5CMB5JeqUrExjzVO1dbr2IwwTKhYTvS7218uy9eAKx4P31nDcg+NaAjfJhAlSurWrVYV0CLg==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr33893643pgv.438.1548972641978;
        Thu, 31 Jan 2019 14:10:41 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r80sm10279879pfa.111.2019.01.31.14.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 14:10:40 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH RESEND 3/3] Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
Date:   Thu, 31 Jan 2019 14:10:21 -0800
Message-Id: <20190131221021.176809-4-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131221021.176809-1-mka@chromium.org>
References: <20190131221021.176809-1-mka@chromium.org>
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
2.20.1.495.gaa96b0ce6b-goog

