Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B50C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2220881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NHOGk9g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FA2220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbeGXN7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:59:12 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37037 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbeGXN7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:59:12 -0400
Received: by mail-wm0-f51.google.com with SMTP id n11-v6so2434408wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 05:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=o/vJKE08myW2sH9Z+eDbaZ2BwzpfBkqkGnlO1c8lUVk=;
        b=NHOGk9g6HOmpXFo9jpXlk0FQheqjyJhttG0X/M14pRr0/AbhKRqM94DnWp/OAWra8i
         DJwrzFzLsb3Vpav701L6k8k7iK/vdsi80OJVVoX2vzz6CDJV7ZQdfpcK8UckiYWiLXLT
         RidZsyfo27us2mJpbRXwz/tVIzzWvhZhixYUwDGwxwhWcTulz8ZgWR5ZbbCq/qEMY8nW
         69tTKr7BP0RTOW7nk9QiP65aq02fG4PQt51aIYlpgPrP92m7/PQv7VH0XASEEjYi98s+
         jHOqICU0cl8rY54YSyP++B/Dkga9t2hDyyWVgtsZiKhAClvACVJ9pIUY5JAZevmyL8/H
         YfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o/vJKE08myW2sH9Z+eDbaZ2BwzpfBkqkGnlO1c8lUVk=;
        b=DVjarrt2suum+2QxOT3kze0v9SJFdAvI3RFR1FRa39U8i3U+sUSRXmC1TTaNonh37X
         rprtdv/m0SpKSaW4fBWO2ldE9X6Tp7yEebsk9DGC+vXnseJtew/lC8+BNy2GhlCn3mYX
         W/pVK577cMzKEHSEgeyQYQpOIUhB/1Ej/rxFtKTcqKjX8iJgVqlQQmGA/guitf31pp9D
         TuE6UPqNsLgbp1Mou9fbxKT/Dba2z2H0OX2Cumdn53VEuQvZMzj2whX/NozW/byScXcf
         vLpAruwKYaJKkWJEuF0E54mXyQKMpAOQIMl2zMZcEhLI5Aqs1PCcQMJcdXKJeuL6jn7M
         5LIA==
X-Gm-Message-State: AOUpUlG43pCy89uQxe5bSFNenF6yDw358QtCOQldsHPbJ15sPe1f1BlU
        PMtFEptr1jVWa4QDXUtM/eanZA==
X-Google-Smtp-Source: AAOMgpdmpNBuZIxyMQUh8zgApUmMXX0Bvtq+rAEU0xE7c6u+6gJOgFT1JSLhhCR4/uRdapOm7yxlLg==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr1951696wmg.42.1532436770349;
        Tue, 24 Jul 2018 05:52:50 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id e7-v6sm20834235wrm.14.2018.07.24.05.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 05:52:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 00/14] arm64: dts: meson-axg: add audio support
Date:   Tue, 24 Jul 2018 14:52:24 +0200
Message-Id: <20180724125238.14567-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patchset is to add the audio devices on amlogic's
AXG SoCs.

Some codecs require some power supplies. This is why the 3 first patches
deal with the S400 power supplies, even if some are not related to audio.

In term of dependency, apart from the clock bindings you have already
pulled for your second PR to arm-soc, this patchset requires the ARB
reset bindings [0] for patch 5. I don't know if Philip can make it
available somewhere ?

Of course, if the dependencies make this patchset too complicated to
merge in this cycle, I'll resubmit once the next rc1 is out.

Jerome Brunet (14):
  arm64: dts: meson-axg: improve power supplies description
  arm64: dts: meson-axg: add vcc 5v regulator on the s400
  arm64: dts: meson-axg: add usb power regulator
  arm64: dts: meson-axg: add audio arb reset controller
  arm64: dts: meson-axg: add audio fifos
  arm64: dts: meson-axg: add spdifout
  arm64: dts: meson-axg: add tdmin formatters
  arm64: dts: meson-axg: add tdmout formatters
  arm64: dts: meson-axg: add tdm interfaces
  arm64: dts: meson-axg: add linein codec
  arm64: dts: meson-axg: add lineout codec
  arm64: dts: meson-axg: add spdif-dit codec
  arm64: dts: meson-axg: s400: enable audio devices
  arm64: dts: meson-axg: add s400 sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 237 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 216 ++++++++++++++++
 2 files changed, 453 insertions(+)

-- 
2.17.1

