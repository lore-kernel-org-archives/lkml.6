Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E300C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DAB2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qc2tR4Mk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DAB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeKHWZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:25:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40516 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeKHWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:25:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id i17-v6so21125951wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nxpMMCYWSFWXNIFPId8SwguThCMN22bu5Vmyb8nJFx0=;
        b=qc2tR4Mkzz5cpf1fkpnINLnC/RHZvZKtcD4wUq+oS907JBd6rfs+pvBHATB8gjAq3S
         VDWBczMgtD3R4kyqW7L75cBa2rWZGC73zKvc4zIZyU6qbMswyelUi5JDau2xqrKRIhIa
         HxnROoEZQjsq7bzAQ53iUPtK9xxMpagZnc4Pl4MMAyZ3NPaDPz2Gh8hG1ftK1/NBxgaf
         ZpzNbpZoBY/setMtK96C628GJ3JbaU0XIUKMG1eF4/igXfqYCnlyHqazPvtPt9vmmbUM
         DpFuZt2Azp6JGJsX8HRszccRWv3VTi8NLIfBEPelfqyBWpMOa/y4AeXwkyJwUqJIAr8O
         4TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nxpMMCYWSFWXNIFPId8SwguThCMN22bu5Vmyb8nJFx0=;
        b=lhmiU9z+Df9YjFp8ZfR27WhAK3MvvbSJWsbfvEeyc/m2FpWPPK5PoHu4Sbb/8lrLI8
         KXR2zDn500wUCDI38QHi2UVBwuk6kSAgU+dFDi+sRWMDk8XyMOByuiTRwCp78pNhUL8z
         a7VdRCZoBa8hI8AYrs3fx3dBs0EAyNDBIj3dfVTkla0iEFvGKOZLy9IUgpyB/fefQR3/
         jhoEPKRWtN6b6C523odnKovFz9MIh8taZrsA3g6KxVdZfp5hRizJCFbCwcHudwL3sQou
         SLhuM20/ngkK1HRUIgDX+6O7zGu/CSsCS9sNxEQZ4CHHO4lUCQosJ/wWW8tA/7wHXLxP
         CABw==
X-Gm-Message-State: AGRZ1gKauCHpyySlN7gQpVqkpD+HhizQ0vXcHCOL0NpRclD5V4WD7ZNr
        yc4M9FYRJhKoF8H6ltV2zQIepA==
X-Google-Smtp-Source: AJdET5dOEbmCVsA1ouLdk5OZXufcrQx15B4mkoDiJi89grafd9vC+BPuvyIgc0MMfVkBY9J84jebtw==
X-Received: by 2002:adf:f542:: with SMTP id j2-v6mr3885305wrp.70.1541681413971;
        Thu, 08 Nov 2018 04:50:13 -0800 (PST)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e5-v6sm2470014wru.88.2018.11.08.04.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 04:50:13 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Yasunari.Takiguchi@sony.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: sony-cxd2880: add optional vcc regulator to bindings
Date:   Thu,  8 Nov 2018 13:50:10 +0100
Message-Id: <1541681410-8187-3-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds an optional VCC regulator to the bindings of the Sony
CXD2880 DVB-T2/T tuner + demodulator adapter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt b/Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt
index fc5aa26..98a72c0 100644
--- a/Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt
+++ b/Documentation/devicetree/bindings/media/spi/sony-cxd2880.txt
@@ -5,6 +5,10 @@ Required properties:
 - reg: SPI chip select number for the device.
 - spi-max-frequency: Maximum bus speed, should be set to <55000000> (55MHz).
 
+Optional properties:
+- vcc-supply: Optional phandle to the vcc regulator to power the adapter,
+  as described in the file ../regulator/regulator.txt
+
 Example:
 
 cxd2880@0 {
-- 
2.7.4

