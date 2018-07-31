Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9E5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E3208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJoi1vQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3E3208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbeGaLC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:28 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36341 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbeGaLC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id w24-v6so874296wmc.1;
        Tue, 31 Jul 2018 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFYj5wJ3q2XBZytzOAcMDH0abbnx8Rd0P2eZ3zHd9dQ=;
        b=eJoi1vQkcQ6frxJl8nfUOiEXG5NQBRid6dmpZLdOohaAVHXmvONqX+pSpI9xKzqlFV
         o0BoPvONZ9QJK7JbvkIEbPjwpsEgOJxALEMcAxCyXXGIDiLe1XIV39WytTNADxt7cWkD
         SkhiIu+AYwABZrVU23dem4vzN77AqJ0zbhf28vj5O2DX4cpzQ4HfRxmSh4pfIRuqIKup
         JmeSn5Vm9jKJeuNcR5VpSUun2sUeV511GYKzbkndSPdBgSAK0q8E6XI0whg8rZX3Z5jK
         tVtgSqkX9fE32MR9g1gWa5Ho+UwhDwTCWxtoWAMY9JKu1ujWghz1+oumnFdyQnbe789O
         1EGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFYj5wJ3q2XBZytzOAcMDH0abbnx8Rd0P2eZ3zHd9dQ=;
        b=p9WNMlDcBRTH/UKpQAAsZWx2a2nBDnVSwZW+1OEPhXfsFcgqH8dqkylLqmeOF77nhV
         3IjxiUDXCqEfzxrCF16G9voKCnbtf6l5WRIdod3P+6Fgdq1+OwOIWTEriI188lLa3K0d
         w2g9PXXuEu4LCzekVJB+JGmh62Zw3X8PoPqod87bBHxen7SK2ZV9J+xA80nMbKJAdtjJ
         pKTAOaActMgBksTQnbplgwfc0ody+Lklx+ocbLqPfd9rJJ5AUoivUbwzmUR+dLtRUu6/
         qWBPqafPv8C+FAGTUwYroYHwqK0U/SLpY9P1AYYwB2C34TkcMjecdh/eGAC1r0fJKfx6
         YGdw==
X-Gm-Message-State: AOUpUlGPoYeyRvkt51/ep1XFDOF8+aTcionQNjqcpz2wjiNrXzPjsc1g
        ic8v5sAz3jFPKXJ+CB8o4Ys=
X-Google-Smtp-Source: AAOMgpcdt4oVgjAP2SJJ5mnfA/6W4FcpK7KAcxeInUOOd2O4q7a+cCL3CP38tuoV4hHT743cUVmVCA==
X-Received: by 2002:a1c:9f12:: with SMTP id i18-v6mr1768517wme.124.1533028982895;
        Tue, 31 Jul 2018 02:23:02 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id y191-v6sm1670873wmy.4.2018.07.31.02.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:23:02 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de,
        andi.shyti@samsung.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v6 3/4] ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller
Date:   Tue, 31 Jul 2018 11:22:57 +0200
Message-Id: <20180731092258.2279-4-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Bananapi M3 has an onboard IR receiver.
This enables the onboard IR receiver subnode.
Unlike the other IR receivers this one needs a base clock frequency
of 3000000 Hz (3 MHz), to be able to work.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 3b579d7567c8..ea23ff821166 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -183,6 +183,11 @@
 	status = "okay";
 };
 
+&r_cir {
+	clock-frequency = <3000000>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.11.0

