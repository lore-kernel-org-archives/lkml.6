Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55922C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83D220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PmWjn/fO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83D220849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeLMOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:36:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45596 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLMOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 09:36:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so2073878wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb5cfE46cR4q74hmmtB9K+WQvjM4s04FZxZRpcAuErI=;
        b=PmWjn/fO4vx90hC0WuwsNwNzxr8TJuaOjKnQ/cbYTeDqciK6sUoIAPcE/c8kny3Ive
         QX+PzFXo8WQdvGNkvgK6nFmvSOxWSDm+060t65fWzWNhWCfXAe450cbRK0zkRtoZIadX
         UD6EJ20GkT3TmsvcoGg6qbtyoURwRLsRrT560Z6vRKGwAWVzj5u4+SuRVCTIhjyMJIFS
         Zj6fpKTI3w5Qbzhd+McIDEH0BIpkWZdH9Bb9MZHwtP5HB2JStvyL7Lt5kM4N128j3W9O
         FWyOHOa6+0fJwegz/uj28iX9kVuHxy0BDqTw0eCsD63CXnFIpgQcQiPZQsfEgqhzxUjR
         Cfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yb5cfE46cR4q74hmmtB9K+WQvjM4s04FZxZRpcAuErI=;
        b=KkKJ8NuWDdeXmUyBgbfITu86SNIeHGoSvT/iHAP/sWvQhYvCjKJE8cGMnDSau1sBzl
         wdE5IS7EzO0bGKs6EcDyoePSFkPpgY+fDF3MdrlqfA6cMu610IMoA085lhfMIl38tCUO
         tVdKPCudlYyb47q8d1GvmCHfslG/y4jBcLcIKsuc+XX3VzZ/1LMk8JTIx/iyDs1988gu
         ZnLV1SP5qytw3WAbcHtH+Xld9ltBmk4Og/ii6uDVQ034OhecJ4k7npGLKT/RUTOQEXmN
         w4thrAdEYtSbfFOvuWOlhhtrMnyMjtuowo5MffK0uEovSQWJPONTDLaS7kMTevdbnOLX
         MgVw==
X-Gm-Message-State: AA+aEWbu17PvE9A/2PSsvDhbwdZ+QxPG7QB2OjvNWiJbeiBcJUurs0ud
        Q8QSWrbfLmtunSYGRH6+TPIm2Q==
X-Google-Smtp-Source: AFSGD/XhuRllbYmOKhh97NQZMVvETuYIP8Hp8nlQaSZ4tXLsgEUKjQQVgpps95xDbqy9waYyl8PD0w==
X-Received: by 2002:adf:e383:: with SMTP id e3mr20948557wrm.31.1544711799508;
        Thu, 13 Dec 2018 06:36:39 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id e12sm4929930wmf.22.2018.12.13.06.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 06:36:38 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson-axg: add spdif input
Date:   Thu, 13 Dec 2018 15:36:28 +0100
Message-Id: <20181213143631.19218-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds spdif input support to the axg SoC family and the
s400 reference design.

Kevin, ASoC support for this spdif input (including the binding doc) just
got merged in the ASoC tree [0]. Until the related patches hit mainline,
you may get a warning about using undocumented bindings.

[0]: https://lkml.kernel.org/r/20181213120843.876CB11254D1@debutante.sirena.org.uk

Jerome Brunet (3):
  arm64: dts: meson-axg: add spdifin
  arm64: dts: meson-axg: s400: add spdif-dir codec
  arm64: dts: meson-axg: s400: add spdifin to the sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 24 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 12 ++++++++++
 2 files changed, 36 insertions(+)

-- 
2.19.2

