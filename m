Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C12C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C05620856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 10:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laD9dgft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C05620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeICOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:21:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53679 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbeICOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:21:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id b19-v6so547421wme.3;
        Mon, 03 Sep 2018 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RUdmpyjvYH/P3gTVki1Kcr+96q6wklBBPgCeGs+6Dmc=;
        b=laD9dgftVxceZOvDHfCHlcltULXv1fqRzKjtuF6i1CuYCH/3IpLneIU0UA4HTWLzbm
         k7/KWF2eyedhidhT7l8W32vTlv/h6ybsNUqQ8XjhXKsPQIL2jwEMbZK9JkJAeP8oRTMp
         qtxIfTf4Xe9bG+2LoPGO5i7T1WKibKTBMdw7e85Dxt98zyvdOpHGBWdcZz5wEGhhxtuC
         xPt4t22anO0uGSCM0Ghc5YX9pyZzcBYVBWuBAa5UKUdfEV6eAiha9zB8YTjWTWSs1bqC
         lwdGAFQsJ1Clf7KWTH97gmoIQ6Bl6TPY+/21UW3JLhiJipizln9AfdYWnDldNzBxyFiI
         T+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RUdmpyjvYH/P3gTVki1Kcr+96q6wklBBPgCeGs+6Dmc=;
        b=p5jwA1njYneRudRMErrjbrYV0UrkyWuhSIw9MEq///cZzOXPeOUdvIVCEfH+VwhNx1
         5ZePCadHSNjptQpkIl+VCeCETclL1k7ALb3QlGqskDW/zRv4keA4W7UAFVFKgdijihbw
         9XLMbg2CV7rqKs9BYsvFyL/g24t5HeV2aVntzNcutgg9zzR9jEq2xxpwjD55ohxmN9GK
         3IvlmRcxCNOx9Mevkzqs2SJIAJe4geech6DmXM1PQzW3Byh5XV7SXlEM2IKKOnNqVDCe
         SWasKa2ejX4kv8IT+D1aFVTsv5M1vOOOStK7tpsTxkChDf0XlIeKLoXg6ITGqThtPtNg
         wbCw==
X-Gm-Message-State: APzg51AHRYR/YvVSU+CeJzpUZfz5PhF0Q6ctO1mpkSa7muPbpEuibgKO
        W3/w0s0HATVp53riClhH8GEos+ir
X-Google-Smtp-Source: ANB0VdYO7WlmRYurEh9tWRufF7iTZ5egaNo4eHQzghRCOy6uc+EMDSvuAWuAJCI1AcCDdzcCYZnuJg==
X-Received: by 2002:a1c:2e11:: with SMTP id u17-v6mr4638794wmu.102.1535968933093;
        Mon, 03 Sep 2018 03:02:13 -0700 (PDT)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id k34-v6sm31773936wre.18.2018.09.03.03.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 03:02:12 -0700 (PDT)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     axboe@kernel.dk, hdegoede@redhat.com, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH v5 5/9] dt-bindings: ata: ahci-platform: document phy-supply
Date:   Mon,  3 Sep 2018 12:01:57 +0200
Message-Id: <20180903100201.23131-6-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch document the new optional phy-supply.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index f495774c8af9..45b451961612 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -31,6 +31,7 @@ Optional properties:
 - clocks            : a list of phandle + clock specifier pairs
 - resets            : a list of phandle + reset specifier pairs
 - target-supply     : regulator for SATA target power
+- phy-supply        : regulator for PHY power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
 - ahci-supply       : regulator for AHCI controller
-- 
2.16.4

