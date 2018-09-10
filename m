Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3242C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF412086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LeTWVIq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF412086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeIJX2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:28:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35448 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbeIJX2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:28:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so22559559wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=viADXigqIJMPlnjUgEK9/NKiFxmKFjUYSuhb7HLIcNY=;
        b=LeTWVIq3pQ5g9Cryce7Q9DjjJVh4iIEJXOQqmRgGbkPJE1/OhqjRx4vPirI/HE5mtK
         4GpjyUYhvZZelK6ygWM3AEZjfVpQoKcl8L7hu8LnF36nXDNF8MWeDzjfhrWtxoEETiBd
         Q+SFURH1ozAbMVLYzlhKkye0hCmNk3rDdaDoR0Bl0llMc/JweYnGYx7rfuY9q8GJegOo
         Q9ozWogVtgICbOhxqSXJJ6ejcXFbKDVgpZhGAXlpWP4QwCv/C0VWCpX7DAZnUw6+uoIt
         qF3ikY/OOsb11Dnauba7zLmkiOprxH92pQn3UzKvD5Sw0zRyVBoMjtf6DHIdJMnzkZMs
         FedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=viADXigqIJMPlnjUgEK9/NKiFxmKFjUYSuhb7HLIcNY=;
        b=kEWXovIYv3ViWNQz6YnQ3R2Gl4xIiM2VmAfKZ8PTZ+sSPvzzWvEtKYBOq5aeRSberl
         O8VzC4cEZag7CBrpxn1IXIO+EAdTgSON+HaYT25n062f9TlCkfp4EZfQs64eakZxcTBJ
         IXhYvt0ShaTLRr/D+U+m8RidCBl6ge1jjpge097K1LcB16Tr79kmCLqL8SrNLnX3G3SQ
         sn4sxKSeZ2m3KWFxypJATJ+3ny5lL3PizD9DgkUnk/q0pT3TvCcpOWh57VnGwyvBbj8W
         XREfxRrkLsCKIosMBNIkvg0wfeO9NUHVL2ph6zSbvRpBYFbgisLCYuh8eByBSCz9TCsx
         8p7w==
X-Gm-Message-State: APzg51D/1UB7G/frqJUbLPKHTd77TksvNHAFfSpTij83yAMU+rkGfso1
        HATD5FEIUt+vtBcq5rMvCvN43DEupmY=
X-Google-Smtp-Source: ANB0VdaNNDOwKVJjOhVJ7gLUBW9A3H3iHslmtcFG3tYvIi1eo24+3DNmOwsN+tMPze/mFqRJjySgaw==
X-Received: by 2002:a1c:eec4:: with SMTP id j65-v6mr1536356wmi.143.1536604400496;
        Mon, 10 Sep 2018 11:33:20 -0700 (PDT)
Received: from bender.home ([2a01:cb1d:4ce:ea00:10fd:4780:9fae:1ba3])
        by smtp.gmail.com with ESMTPSA id f13-v6sm14678916wrt.9.2018.09.10.11.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 11:33:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
Date:   Mon, 10 Sep 2018 20:33:15 +0200
Message-Id: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing chosen and memory nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d399078..f0de884 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -60,6 +60,15 @@
 		serial1 = &uart_A;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
 	main_12v: regulator-main_12v {
 		compatible = "regulator-fixed";
 		regulator-name = "12V";
-- 
2.7.4

