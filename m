Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7622BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C174208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSqgwSBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C174208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964954AbeFNPQW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:16:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45401 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964777AbeFNPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:16:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so3711288plz.12;
        Thu, 14 Jun 2018 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=mSqgwSBfgBjO1wF5/qftZxBS0rV4R470lnhyLF4Qarry7Dyl3IwcUgjm+Ec7flkhUd
         mXPnu4WRTXqzg23m0bRfByuc5NSUT9TMFj5xhdnjFpWuwifEdlIPcZjZzrzEbB0W0kO2
         tZRoUsnzFf23pJnxoVW/W2SAlTKnp5DAoToW1CBrAlQlftFLmgIeKpr+p6j5mNpsEhMS
         kdijmkMT0ri7TSvqu5Ssi1dySvDBuiHyxX/OZU3fpxeAbCxo5IlMIcGVajvFf6nm4h63
         OcQKdjNnlcKilrHEUUOUFFwMZ2FCfqdVbBMHGr5Wvuy519RiovS9aIF1fKzaHlQQiRLe
         bsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLF05pfFqEy0KBvOMrLNMdcV6wQeNNbKUA6cbfKEhVQ=;
        b=CFBTcXEmcQFHYKg/NpqUwJKTY8BMFaHHA+fHK5osEALxKqNi2yzXOEsy8tc0t+PaBh
         pSo0QvU/ibADV4kptp98Gs8JXGmPiV8+54RaoRLNaW0AahXA3QMUi3HZ7iGcJ5Tr2jeW
         0w8KnzUEgbkeF53MLgVn4iaeP51IrjUiXW0omGbCQc+eNWbtZw+xuPcEATqfXhAkhxGq
         UrS/XYhLjw4WXSmphZB1fsbebybC4JExFiH/q7hInM5u8WPmcdUTVHQfxtMjcE3MEq2Z
         Boxy3otpU27R1fcUABXjbHwvmo2N09SgmX/bFhZkPlSq0Qgac0r7b4ECCiF56YIzKMtD
         4Yig==
X-Gm-Message-State: APt69E3jHlYmDlwxkz+1YhGkxqyMKjxcr/iKxMNTntE7bQDAIDOT4Q+J
        +Q310x5HZGFQUD/A7lKGJg==
X-Google-Smtp-Source: ADUXVKIFzL47t1WBV+UKndcJqUDDPtHjE9qGBNFWk0OpLChHTmAiP/226nNAFhcEylX3dz/oubG1Nw==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12-v6mr3472677pls.169.1528989380174;
        Thu, 14 Jun 2018 08:16:20 -0700 (PDT)
Received: from localhost.localdomain (host81-131-105-100.range81-131.btcentralplus.com. [81.131.105.100])
        by smtp.googlemail.com with ESMTPSA id u63-v6sm8337276pgd.65.2018.06.14.08.16.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 08:16:19 -0700 (PDT)
From:   Craig Tatlor <ctatlor97@gmail.com>
Cc:     ctatlor97@gmail.com, linux-arm-msm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry for the Qualcomm BMS
Date:   Thu, 14 Jun 2018 16:14:17 +0100
Message-Id: <20180614151435.6471-4-ctatlor97@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180614151435.6471-1-ctatlor97@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com>
 <20180614151435.6471-1-ctatlor97@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c125f705f78..be485caf9313 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11646,6 +11646,12 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BATTERY MONITORING SYSTEM
+M:	Craig Tatlor <ctatlor97@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/power/supply/qcom_bms.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Todor Tomov <todor.tomov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.17.0

