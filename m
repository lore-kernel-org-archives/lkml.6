Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3B2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D088C20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnY9cos1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D088C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeGWUmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:42:40 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41911 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbeGWUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:42:40 -0400
Received: by mail-qk0-f196.google.com with SMTP id d22-v6so1178601qkc.8;
        Mon, 23 Jul 2018 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ct8x3E30AHH6EAGdxFhW39P6ckuCN8DkFYXBfUia9T8=;
        b=qnY9cos1j+8xXzxzAY8Pp1B+LTj/fPhTCHA0WAQWf2657r4FX4J9J+Dvy1OBsgfy6Q
         AIu7MnYBQx+hyZoeAVj1RR5DE+TqmF8WllgcFrEf9mVUQ7qLypAa7FuvU4ZgWMpBzklR
         ykqwk3OBf4sdUACK81scjRRUJtNgF6+ursARazWXZO+tCh03wnmR7OP8XDee3BVn8uah
         8oiNtgaa6S1DqP82E2I9OBxSqx3iUVwtBGx3bG/L7IslkIL8l0BnOiC3i+7Zmozz6PRu
         5ZgE9uK71IctEfNHOQLr94QlQWwhTdTocYKVGsYqiHA+tbLZkPYDBzx/W4oBD1jAnSCV
         2n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ct8x3E30AHH6EAGdxFhW39P6ckuCN8DkFYXBfUia9T8=;
        b=XzgGULLqNv8vGjZk2F1X6bYU/pAYBRK6FGFwHpyPRqXSN9VEuXtIf0OSQIPZIdtOuS
         CmLLpisMVC1N51nH9QqfYtzHl9bnmGcraJf/vM8BvBi0uW/L7iCoQXOKXsbcE+tVdFok
         tFDfSV5IMXfMpK3+A+WyJcGANo3OAfTjvPBVprBXDXKGYu3vzoS4UZqZiW9DX5+RfVnI
         DCs4PqvKMNHU8TtHNVGEgZlIKUu+wZAoDtLYj2tFw4+2bKVxwnT2BkRPny55Fzqdg4p0
         2eC9PisFQDLUuiTKJ6BfBm5t/DTSvEvD7NytTSC/+kJYu+dQFzOiuCeZ4WPI4WSQwLWQ
         pPSw==
X-Gm-Message-State: AOUpUlFcP7d+LNoyFUtJadA8B2qbvBH7ZwaTa/YwsRTDc9o8VRMIzODM
        dMyLxiwAwVkqXtZLXv8hiS0=
X-Google-Smtp-Source: AAOMgpcILs2y9tRH6jfO0mh4kttVvIYl4LY6qrsca8syvZrUfRJK8ekbAncE1p9jBgK/mkPOHDtV2g==
X-Received: by 2002:a37:cc44:: with SMTP id r65-v6mr13215944qki.285.1532374797141;
        Mon, 23 Jul 2018 12:39:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-134-220-116.hsd1.md.comcast.net. [73.134.220.116])
        by smtp.gmail.com with ESMTPSA id 16-v6sm6863042qkd.93.2018.07.23.12.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 12:39:56 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 1/2 v2] Add sw2_sw4 voltage table to cpcap regulator.
Date:   Mon, 23 Jul 2018 15:38:47 -0400
Message-Id: <20180723193848.32491-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723193848.32491-1-pgwipeout@gmail.com>
References: <20180723193848.32491-1-pgwipeout@gmail.com>
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

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
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

