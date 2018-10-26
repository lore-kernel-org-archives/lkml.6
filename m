Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEEC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F8720824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfEJxvUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F8720824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJZJkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:40:32 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39668 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJZJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:40:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id e4so6951110qkh.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10e/Xz0YxiqH2iV1U6DF0+PZlA1LEYFu+TyLcfzn15k=;
        b=OfEJxvUV8Inuao2aC/vOuBE9WSloNRwLaN6lf4Qtb8h4i3yQfgD7t9amSIAcUMdtan
         aaItYj9y9c8TGiTOTmJwN14E2ToioZglQvN5+9UA4h87spViiWWI4JRuum9JitpZRBzZ
         6ubvV/babDrPvFGd/oxvlJ/TwVFEXFALFwAH7Vb1MJaUaxxQouep3e2ZYEtG2s/ry6nB
         yygdxBnvjzUzjDGqRTl8MXiTW15VxmNXEy3Jm2UZ0kk3MTDeZn/8ZAc5ANqAEHpMc7Ri
         IJcxCkYSnsS9Fxrdr0UJCBadqW+1dKMJBUbFqTvcbYUOQQsfN083ZuJM4bFdz1VV7WVk
         EO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10e/Xz0YxiqH2iV1U6DF0+PZlA1LEYFu+TyLcfzn15k=;
        b=Yzd5TrNZ068pFCU2ovE+/OTPBlFbJAE0wb70o8WcupTIrsMJKCE/I+YxAWUfUeevth
         1x9a9PcxHiLEdnfuGfhpAVPNcqo+c3YivuR/wJrcDrg1hcrU5fRe2fW7wop6M4IlZVaA
         92ctwEiFK2iD+ltn80oLlXTiR+Q8KPAUrjIe6nTI/Ys9gtY/vw9uBqmZyWtbrseDgOFr
         ZL7B2dyO9yitH+s2wOm0tuWwvfk/10Fe2faQWKzAhg6XTEkEZxVEHEDNuaRRfF3q9Xac
         ThwrDKbL2D3NlhiMXdDPsrmKFH6zNoMpQMLG3QYL1GKhZv0JU+l2tydld9R3Sc33grtd
         2bzQ==
X-Gm-Message-State: AGRZ1gIwJQsmCUNztDUTnDoOw5lUCFVADV4MTPISPSai3ohIr4zUvNfQ
        D045qxGmYaMEeMFoqB8k0EM=
X-Google-Smtp-Source: AJdET5dANUkfKI61v4JDZL1A5r0VmZ5SGoGM2LIZba92Zkp8/EhXJ5OvfvBGQWAIU4qG7exLfDMoGw==
X-Received: by 2002:a37:6388:: with SMTP id x130-v6mr1312248qkb.118.1540515937124;
        Thu, 25 Oct 2018 18:05:37 -0700 (PDT)
Received: from localhost.localdomain ([186.222.90.17])
        by smtp.gmail.com with ESMTPSA id x56-v6sm4820567qtc.60.2018.10.25.18.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:05:36 -0700 (PDT)
From:   Diego Viola <diego.viola@gmail.com>
To:     hdegoede@redhat.com
Cc:     axboe@kernel.dk, tj@kernel.org, linux-kernel@vger.kernel.org,
        Diego Viola <diego.viola@gmail.com>
Subject: [PATCH] libata: Apply NOLPM quirk for SAMSUNG MZ7TD256HAFV-000L9
Date:   Thu, 25 Oct 2018 22:05:12 -0300
Message-Id: <20181026010512.2562-1-diego.viola@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

med_power_with_dipm causes my T450 to freeze with a SAMSUNG
MZ7TD256HAFV-000L9 SSD (firmware DXT02L5Q).

Switching the LPM to max_performance fixes this issue.

Signed-off-by: Diego Viola <diego.viola@gmail.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a9dd4ea7467d..57706ab1b545 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4553,6 +4553,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL, ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
-- 
2.19.1

