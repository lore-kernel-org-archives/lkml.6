Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2091C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8602145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jx0fgPj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8602145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbeKNUWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:22:17 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39084 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKNUWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:22:17 -0500
Received: by mail-wr1-f45.google.com with SMTP id b13so16599952wrx.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 02:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4804e+YAfMwo0m2iTgsbgD/GazyqzJvjXf1Ea4ELfk=;
        b=jx0fgPj52zq9lvkex17tOmm2GyHsl4TJ/eaEiVCoQajEt9kjGlJ6edw+Azd4O2Ugd9
         jksLHnZGNFQrBu8Luwcy6OJeW1hADA+uUOogWcc4KKYAqtvyXPC9odY1hPndX1Y//mTf
         VHTs8K5LrYYXgPsFFu//ARjUqebRAxakxXCZBmddYkZdpwOwU1smb/dFAj7ouiEpqKvX
         PMbTdArtA3rvQL/DOFByx5JKp4s/BpaiygQailf35B4ccLMeBGy96Ddb/OzhymJAQNSe
         S5Va5rN5JSgphU6Sw0YX2yh1q6/N/Re7R00TtmOT4hyPP8n8nNJa8Jkz2QlcKSRQxzCi
         1xgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q4804e+YAfMwo0m2iTgsbgD/GazyqzJvjXf1Ea4ELfk=;
        b=URWr1+1DmV0uQqHp0C8bMCoWT70+7CmrbBp8zVnZDDWlQOEOoUFZJrE0jHNyyl1j1P
         KLJibviflfmCGaOl7EGSba+Lk/FHwFR9IpiFYCUasjqqg/3dgDXDzr/PhOmbadxQUezH
         tgmXaavC2QKOnjhaqu21akc31dpflFVV53uYM0nbva5DwBsbYiSpR5+ebOP4W9etj6as
         FXXqb/yCjmlitImslWrmaE1V9RzhTUteDfV/xIWK2KsRqwmosTAjX2QjYhAI6iH6ZXzq
         yq2I41HDDZH8NUzbrIIiIRbFqTzoo8NUDoH7CwRr8NPt2ubMmhjA1BTC2xTctgTkAiMR
         ILsw==
X-Gm-Message-State: AGRZ1gJXrlHy1Nd2R+gd9O3UHS0al+zZJe6A6eyswV0p1ciywJr7JiJL
        8WRdSQQKMmjocd+wwBhm4XYyKQ==
X-Google-Smtp-Source: AJdET5dBZlFJr2rARIrao+Qwunc58a2k8/PtrRlOm//dh8GXwPvG0ve8sWMIXJRfjxLUm0zt3XpE3w==
X-Received: by 2002:adf:a31c:: with SMTP id c28-v6mr1270067wrb.195.1542190778603;
        Wed, 14 Nov 2018 02:19:38 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm19832140wrs.55.2018.11.14.02.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 02:19:38 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: add Libretech aml-s805x-ac support
Date:   Wed, 14 Nov 2018 11:19:23 +0100
Message-Id: <20181114101925.10526-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the libretech aml-s805x-ac, aka 'La Frite'

Jerome Brunet (1):
  dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings

Neil Armstrong (1):
  arm64: dts: meson: add libretech aml-s805x-ac board

 .../devicetree/bindings/arm/amlogic.txt       |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s805x-libretech-ac.dts  | 249 ++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts

-- 
2.19.1

