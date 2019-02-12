Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6FC20838
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o9dUh1Wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfBLOXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:23:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39817 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbfBLOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:23:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2883444wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG3De299oLFFk5dERNO5JVx+5pMyQTogB9vh2Bdbvnw=;
        b=o9dUh1Wuu24ngMSSyOBxY02FUnv3Fdp8Gl6X2n+1tetyTCMSSHivsSd9WAha1CXsAf
         Oe6+A8J/7HLJ1a7ayNLe28Ujgr37+GFay8S9/aJ9CkkLaZ/SZNomKyh1Rg4AEt1kgRbU
         YLLluatgf7y2J7yIE2wQZHjWT5PXQiimgZBtxe7a+DsUc4BzwT7KBa8U0SXL98mcy2f9
         Z9/zeEx86QX+xZ75QIvPxg3RsS7/ui4WJTi/m4hpn5w/5cABXhEOhQX9L/3GL2sk4WMn
         zS7pAmw+mT+lM+Nvpn8G2ICTRJeoCOunaT1+IZ6mvmcV7ZIK3UKQRmy8Qe/JpQa3SaW4
         YVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZG3De299oLFFk5dERNO5JVx+5pMyQTogB9vh2Bdbvnw=;
        b=FRGK43qZsX5Vwj/guLU83HawWXzq3qogjvvMfcPNk+cOijUf6A4+jlSwLuH+4xb7n+
         M11hWnIYMeGzIt7Z6y5CFSF5k2UTsqJeQ6BOSLvoWdwcfwd7INpfrUQ7XVl1Z9vxs9KK
         naBHkppuiH6gn4xYrtsqaWC02E3U9K4C6RvRpDFEdMxAPN+oLkH3Rnx5x6DxQNzM03Af
         ZYuoxOxhpqOnwdA0TzYnp90ZR8kGx7yhP1xTa5BPOEUl/TLBtECSez0E7ro4xI9Ug3j7
         9zUbbxZhwRCCPaBNdurRho4stE/xJ7JoMhW9FVKerEiCRVSRrdMSW9MxGRnoudhYdwEx
         +okA==
X-Gm-Message-State: AHQUAuav4kdmKWwjoVL9Z5gBUThnVGf2mv7jggW3ebuohY7sXMS4LhA2
        ramFkP/icKcqNsS5Pj1bwavrBg==
X-Google-Smtp-Source: AHgI3IbCXBU8Yp+zJ34yAUx1SNdEn3jRMsPv1Fy9to0JPtp1vVW0scNwQdvOLfil0egE64Imk+RufA==
X-Received: by 2002:adf:e641:: with SMTP id b1mr3007847wrn.213.1549981426490;
        Tue, 12 Feb 2019 06:23:46 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y22sm39043216wrd.45.2019.02.12.06.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:23:45 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: meson: Add SoC ID detection for G12A
Date:   Tue, 12 Feb 2019 15:23:41 +0100
Message-Id: <20190212142344.13634-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- Fixes the package id detection for S905 variants and AXG packages
- Adds new SoC IDs and Packages IDs for G12A/G12B
- Adds Add AO Secure node for G12A dtsi

Neil Armstrong (3):
  soc: amlogic: gx-socinfo: Add mask for each SoC packages
  soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
  arm64: dts: meson-g12a: Add AO Secure node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi |  6 ++++
 drivers/soc/amlogic/meson-gx-socinfo.c      | 37 ++++++++++++---------
 2 files changed, 28 insertions(+), 15 deletions(-)

-- 
2.20.1

