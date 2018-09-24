Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D233ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F9F20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F9F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIXO5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:57:49 -0400
Received: from shell.v3.sk ([90.176.6.54]:58607 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXO5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:57:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A8FA0B6255;
        Mon, 24 Sep 2018 10:56:44 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EbrhXmboYNUl; Mon, 24 Sep 2018 10:56:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 64DDCBA1F0;
        Mon, 24 Sep 2018 10:56:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jmjsf9E9KAH5; Mon, 24 Sep 2018 10:56:40 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8F983B6255;
        Mon, 24 Sep 2018 10:56:40 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] mmc: core: Allow building PWRSEQ_SD8787 with LIBERTAS_SDIO
Date:   Mon, 24 Sep 2018 10:56:32 +0200
Message-Id: <20180924085632.448693-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sd8686 "libertas" SDIO adapter's power is controlled with WLAN_RST
and WLAN_PD pins -- pretty much the same way as sd8787. Allow building
the power sequencing driver along with the libertas Wi-Fi driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/mmc/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 42e89060cd41..2f38a7ad07e0 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -14,7 +14,7 @@ config PWRSEQ_EMMC
=20
 config PWRSEQ_SD8787
 	tristate "HW reset support for SD8787 BT + Wifi module"
-	depends on OF && (MWIFIEX || BT_MRVL_SDIO)
+	depends on OF && (MWIFIEX || BT_MRVL_SDIO || LIBERTAS_SDIO)
 	help
 	  This selects hardware reset support for the SD8787 BT + Wifi
 	  module. By default this option is set to n.
--=20
2.19.0

