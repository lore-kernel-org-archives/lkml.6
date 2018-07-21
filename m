Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A410E20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiAmkIyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeGUBec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:34:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45873 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeGUBec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:34:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so11832027qti.12;
        Fri, 20 Jul 2018 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jNHEmiMUbgsxbbOM3eVQNH1BY1k6Ym3TZHXCOd81D74=;
        b=SiAmkIyvrCFIqcseAF7kmU5Sl/iXVwbAd1mBXYOPBFL3/fwqdopsh3uwt7klruNlU2
         5OsETtaeNKFyEcOrrxigsUIOx814LQpuOVfbEbKCQsCnXYwopW9ftqdI6G80IXFsQ397
         kkBDlcS3d1UL6QyDGWz95d1xnzqo6GbET3LjG47nv5oDkSfNQL+3yLjdTNnlBsb8kJZL
         6NX8c82ULZuNWHHvCdszEW0dtGxKiVaJn7NwoK2bBBe/1p7D8SDMFXjkp6ICJxNou27S
         iYxmO1aoONImEnohqHpakZsHhZu10YeznTSO+atI580YlZz2uF6bs4cD/JQNHyFnvpdW
         JIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jNHEmiMUbgsxbbOM3eVQNH1BY1k6Ym3TZHXCOd81D74=;
        b=DmlZhuO5nmVb/zuXsfqBNGMMKXiIKALheT3VaDLD9XxWxnVW+ZuSBpRKkYEYg3+Ueb
         RN/edZnYAP6W481aRChS4hCXKcUl34KoHmDwnW8Knc0DcnscEdXTwGfKHtiQer0hMV4+
         O8ny0KFHlaLQkoMC80uVFkae/pwQsuNv1QNc++iADvtSvdOGfhfSKb7womH42NWiHz0/
         s2IopWoyv4HbUxcXaU/j73GC7qnXQoJ1MdLBC5N3/nJDVeUsKqbOlkMuSHDfpegVAljt
         NhMnWTPq31VY7Byg82eyDCpjrfnrSkHYniQ/WFEFZyZfaPLZ7RfoTVfuBvZjqeU0QaEv
         YiAg==
X-Gm-Message-State: AOUpUlF/n71fmMzX2VnWBUiYxcbDPilWQngSJtBaGp1Y6mFAPbteua40
        CiTN8mWRQckSJkfF+Th6IVNSCD19S8SOYg==
X-Google-Smtp-Source: AAOMgpecuSw0Re2Ad9R0LPWjt1jrVAvzMxdoPm6U/tcZU5A2+AS0dn1Ph4KzH3hMktA3eK8PzwDA6w==
X-Received: by 2002:a0c:a991:: with SMTP id a17-v6mr3772432qvb.83.1532133830664;
        Fri, 20 Jul 2018 17:43:50 -0700 (PDT)
Received: from ?IPv6:2601:153:601:7d2a::100b? ([2601:153:601:7d2a::100b])
        by smtp.gmail.com with ESMTPSA id e21-v6sm2159567qtc.67.2018.07.20.17.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 17:43:50 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     girdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <d38d3fea-dc7d-09fe-651e-386b36befde1@gmail.com>
Date:   Fri, 20 Jul 2018 20:43:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW2 and SW4 use a shared table to provide voltage to the cpu core and
devices on Tegra hardware.
Added this table to the cpcap regulator driver as the first step to
supporting this device on Tegra.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
  drivers/regulator/cpcap-regulator.c | 23 +++++++++++++++++++++++
  1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/cpcap-regulator.c 
b/drivers/regulator/cpcap-regulator.c
index bd910fe123d9..c0b1e04bd90f 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -271,6 +271,29 @@ static struct regulator_ops cpcap_regulator_ops = {
  };

  static const unsigned int unknown_val_tbl[] = { 0, };
+static const unsigned int sw2_sw4_val_tbl[] = { 612500, 625000, 637500,
+                                               650000, 662500, 675000,
+                                               687500, 700000, 712500,
+                                               725000, 737500, 750000,
+                                               762500, 775000, 787500,
+                                               800000, 812500, 825000,
+                                               837500, 850000, 862500,
+                                               875000, 887500, 900000,
+                                               912500, 925000, 937500,
+                                               950000, 962500, 975000,
+                                               987500, 1000000, 1012500,
+                                               1025000, 1037500, 1050000,
+                                               1062500, 1075000, 1087500,
+                                               1100000, 1112500, 1125000,
+                                               1137500, 1150000, 1162500,
+                                               1175000, 1187500, 1200000,
+                                               1212500, 1225000, 1237500,
+                                               1250000, 1262500, 1275000,
+                                               1287500, 1300000, 1312500,
+                                               1325000, 1337500, 1350000,
+                                               1362500, 1375000, 1387500,
+                                               1400000, 1412500, 1425000,
+                                               1437500, 1450000, 
1462500, };
  static const unsigned int sw5_val_tbl[] = { 0, 5050000, };
  static const unsigned int vcam_val_tbl[] = { 2600000, 2700000, 2800000,
                                              2900000, };
-- 
2.17.1
