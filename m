Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AA5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2618520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNs8HjWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2618520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388497AbeGWTAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:00:52 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44486 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:00:52 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so1509224qtp.11;
        Mon, 23 Jul 2018 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sFptHQvSc/FFOFzEy3RdwkIEzRek0KJtZVJx7BYIZw4=;
        b=sNs8HjWqEBm9u0G41OgryyqhblNmJVt5p97kHpmiZ8yVLQ7YL5ewgtHLjfFkjWegpk
         hicgrAfFPG4YP30JMuLRm4S92+rh6AchOqeYpPU/n+LImfkBvuDMGnS7pWhZ4Q2ktioQ
         3Xx4pU69HJog38Q3OmyBwdNkLUdOZncNZzn1wLYiif58FXVSRmVK83OHB+/Yn6qiMQA9
         +OYKMG+H5GCvsOmlRHRDQQJolmBzbZ6ohBHGIPwTgKEUs73dYEJV/B8qE5rJYxCePaSe
         /xmpCmz1n51HbBAECnGzSD5cdQDlFq50iScTQvHJ67aMGTrRHUNqFAoIjmBcgE8EditP
         vpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sFptHQvSc/FFOFzEy3RdwkIEzRek0KJtZVJx7BYIZw4=;
        b=jWbzC4bE/HBPuD2spqxS+uDYH4IdUJG+yelbhEftpUgsmZNpwjQ27DF5uzhYZ4DaVs
         kAvEgcqf1V6tBncBlZzLodg3u54/tQ14GVyYtSNOCNeX1Ae0wYFmwKogPpUDYRYm9B3J
         sKo8auk4gKzHtWjOi0woSoQC/XAKhHHR+OJ8xWXeTNT6CaH3q9gAITT+Ec269bnwlqwO
         RNmMflOBEwfLSAUcGtLVUzgLlcVgFQsIXXZYW8xbkthZsjaG4Mr8VTUOgsj1oX45FyI0
         zgK6WUp49XSa3NZ3JxO5md0fT7bgfUVsMEVXX3Ohd3sx1frX3R1kX7S4k9FOC9rPHLLG
         R1JQ==
X-Gm-Message-State: AOUpUlEF6qDKfqxVxMpIjkEOIFyKD3ljp25ytMUtRDoNXlgssR01p3Q6
        K9t18pXNOa8/S66Qy42nEcVkFnRlFkA=
X-Google-Smtp-Source: AAOMgpf46xH76UrB16NtOihhEU7vrGtIT5K8niQ6UDiXkKO02VK5ti5H+aTkx4HwsOk54aogH8i3JA==
X-Received: by 2002:ac8:13c3:: with SMTP id i3-v6mr13157965qtj.54.1532368708809;
        Mon, 23 Jul 2018 10:58:28 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id h4-v6sm5954521qtp.53.2018.07.23.10.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 10:58:28 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Message-ID: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com>
Date:   Mon, 23 Jul 2018 13:58:26 -0400
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
+						650000, 662500, 675000,
+						687500, 700000, 712500,
+						725000, 737500, 750000,
+						762500, 775000, 787500,
+						800000, 812500, 825000,
+						837500, 850000, 862500,
+						875000, 887500, 900000,
+						912500, 925000, 937500,
+						950000, 962500, 975000,
+						987500, 1000000, 1012500,
+						1025000, 1037500, 1050000,
+						1062500, 1075000, 1087500,
+						1100000, 1112500, 1125000,
+						1137500, 1150000, 1162500,
+						1175000, 1187500, 1200000,
+						1212500, 1225000, 1237500,
+						1250000, 1262500, 1275000,
+						1287500, 1300000, 1312500,
+						1325000, 1337500, 1350000,
+						1362500, 1375000, 1387500,
+						1400000, 1412500, 1425000,
+						1437500, 1450000, 1462500, };
  static const unsigned int sw5_val_tbl[] = { 0, 5050000, };
  static const unsigned int vcam_val_tbl[] = { 2600000, 2700000, 2800000,
  					     2900000, };
-- 
2.17.1
