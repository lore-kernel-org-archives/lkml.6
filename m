Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE95C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6B320857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="XxO7yeL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeL2Lk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:40:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38365 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeL2Lk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:40:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so11043685plb.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=nGdkRYHQIL7iMhVUjwMmQZYCUJey53JIJTC7veVRPLQ=;
        b=XxO7yeL/nkJiH9jpPiTmBlngngGakwn3No20XrqogEhN6c5pzFuHH7bb1Omd62EvS+
         mG2N/y5/hjTEzPDAQrKW4kc4elR5hw3kS0oQmSquhY0vkmwJYmwfr/XfrFg5IeQyqanQ
         qu2CDNAZ2Ko817mIVrpMWxlxbnke41SvYHWcTRkKik1CLfzBcdkhuvbxVU5Iq1bHe4di
         P71LkVnwKXrYJ6r7ELIlRQoRADzitjGWbHRO7DAv/9kVJHWatx+jM4MMgHVTj3kP2iN3
         7awGd3gwahYZr795RnlqaMeAFJxblronODHITBu+ocyQJO/BujTU6XmEdyNqFZ/ZoJxL
         526A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nGdkRYHQIL7iMhVUjwMmQZYCUJey53JIJTC7veVRPLQ=;
        b=siRTQJ1aBCAGaPHyveaxC7CpIDsxZt30R12qhBeAbDeDr2sNwxn27obKSLkxX7g/5W
         X+1KJRgfzpihSuMerMqkvjYbhLYTpksul1n4L0XIZpdq16GRqEGGM86I3TDgNN1xTb7S
         4+lzw7843V5ASCf+dVdleoDCNPzBS3IDdPxiaPi/+Rx1Mc6NxDgBtOrxFCgayV1Dpv4H
         l8ery+P0ICrCOLJyDSBXuGD4CfZVi832K7D/7UBdxfBHQkgMrB5HZsoVIiKtOf7oXDdf
         N/DD+0tZA59cVpW2WxfNEClczeRPLGEJZTTefOdUk22NfPXK/2nLLm85w2qzLj5dk8Fh
         TFHQ==
X-Gm-Message-State: AJcUukcHzkMqaxIivl99z6+lHdchcZJEqNrZW5igZ+7cVA0H31dOKE9r
        cm+JBVoTESFMaSHqF72thFKjxm9lCPo=
X-Google-Smtp-Source: ALg8bN71j668PcZlnMQeghvQKg+BDIpEI9e9sKeOnqOLyCnRzxOYdpqhdeTftu24NbX3J33H31lJgg==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr30483055plq.117.1546083658229;
        Sat, 29 Dec 2018 03:40:58 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e259-0267-3521-1d47-ee3d-d8f8.emome-ip6.hinet.net. [2001:b400:e259:267:3521:1d47:ee3d:d8f8])
        by smtp.gmail.com with ESMTPSA id 196sm176413341pfc.77.2018.12.29.03.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 03:40:57 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lochnagar: Set up correct .data field for "cirrus,lochnagar2-mic2vdd"
Date:   Sat, 29 Dec 2018 19:40:47 +0800
Message-Id: <20181229114047.4265-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trival copy-n-paste mistake.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lochnagar-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 5a89e6d4b9a6..818d20410518 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -226,7 +226,7 @@ static const struct of_device_id lochnagar_of_match[] = {
 	},
 	{
 		.compatible = "cirrus,lochnagar2-mic2vdd",
-		.data = &lochnagar_regulators[LOCHNAGAR_MIC1VDD],
+		.data = &lochnagar_regulators[LOCHNAGAR_MIC2VDD],
 	},
 	{
 		.compatible = "cirrus,lochnagar2-vddcore",
-- 
2.17.1

