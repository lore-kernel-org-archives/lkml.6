Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B249C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275BB2150B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tjader-com-br.20150623.gappssmtp.com header.i=@tjader-com-br.20150623.gappssmtp.com header.b="vjlcdHru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275BB2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tjader.xyz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeI0CDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:03:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45442 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeI0CDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:03:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so177580qtr.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tjader-com-br.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aD8vaM2QfeGDxgqrzIHxPbzJO+mwTau/pqQf83Qbak=;
        b=vjlcdHruyuNjVAYFTFQfLvq/N9TJkmFjt0nP7YfWkLB4vyCogZQ4nIC7+4zCz3wmYV
         67F7u2oxZ6re8WiH6jwYLlEiMMJD3eFcbthGxpby4GoYnHawBSuTLDRth8vGsOj+ciKy
         uHmSg7lfRePCU3kVhkj2RO+36WbnCVdYtHbZ2SWPi02JEnSbge35lQGZyEsHmrpxICc9
         +GIhRgmEey41kUU7Zv2/oAjVevFmQmpXU7HJ/nMLq4oTb5nLs4C+N4F+hZV9KLN5UNST
         BGm73cJdmBv1lfhbpYJ0z57op86Y9N1yKF++tvnSh+yjkhmIssrd04xmn2atvhGT+Or4
         Hcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/aD8vaM2QfeGDxgqrzIHxPbzJO+mwTau/pqQf83Qbak=;
        b=bfUqFa+toQ2w+QE5VvIKCHcvWSVILgRfv4/u/cMPraAieXW59+1bGIDLi7+6g9u1s9
         J5Dvy85JjIFUn79++1O0YpwEJHSBnalgGlA8goQu3GW7B+K4H1zG2RUzf2AEgsW2lkit
         9IFmaDP2LUzF6W6KW5UXXh9Q7AjGfwrsHR/vBTG6IB9HUsaaY4yU1ddQGOuG2xpD+HNT
         8FYXYhaT75EOUUeBv6CY2TebyHlD1d41LdE6+ItNETBgVewRKFouU6rIsvdn5pg3ru9c
         jLv7kcfLPhtBEsqqmuIqSMe78caMy5g+rWBsYtt/lxdmetAL2er/AEzMWV9bqoA6yXF3
         8rnQ==
X-Gm-Message-State: ABuFfoijeXAU/55fFStP0pN3mE+reOz4yUPIvIGNBHgWJkR5sgBRuqCb
        i9oMNxcLNkse7t9iETQBaoYvvQ==
X-Google-Smtp-Source: ACcGV60c6VHq4rpzIZf8FzaIAgeOIksC4syYuMX5uc2H+nadbAFvZeQnTyP08dN4THjHYMVYJXr+8g==
X-Received: by 2002:ac8:2672:: with SMTP id v47-v6mr5621759qtv.287.1537991343438;
        Wed, 26 Sep 2018 12:49:03 -0700 (PDT)
Received: from azula.lan ([189.35.46.156])
        by smtp.gmail.com with ESMTPSA id x6-v6sm2971340qtj.77.2018.09.26.12.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:49:02 -0700 (PDT)
From:   =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>
Cc:     =?UTF-8?q?Rodrigo=20Exterck=C3=B6tter=20Tj=C3=A4der?= 
        <rodrigo@tjader.xyz>, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: allwinner: a64-olinuxino: set the PHY TX delay
Date:   Wed, 26 Sep 2018 19:48:24 +0000
Message-Id: <20180926194824.8832-1-rodrigo@tjader.xyz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926170545.ogcmt36ff7jmqxkl@flea>
References: <20180926170545.ogcmt36ff7jmqxkl@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY found on the A64-OLinuXino requires a TX delay in order to
operate properly. Olimex uses a 600ps second delay in their BSP, and
that has been found to work, so let's use that value in the current
DT.

Signed-off-by: Rodrigo Exterckötter Tjäder <rodrigo@tjader.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 6ef3dd4c2389..f7a4bccaa5d4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -105,6 +105,7 @@
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_dcdc1>;
+	allwinner,tx-delay-ps = <600>;
 	status = "okay";
 };
 
-- 
2.11.0

