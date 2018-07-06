Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EB3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286A223F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jgfFaEOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286A223F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeGFOba (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:31:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeGFOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:31:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so15018956wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vhh4jC6J4CbthbiiFd5lCvq63L+XCcDVV1BKRF2NppA=;
        b=jgfFaEOz5Xtvcnh5hfFkJb5vVl0bGJaL11FTxuFE7dQ+SWZg8cgvPkLOs88e9zJb8B
         Cx2kZUY3US75bxDF17KJnaPkTV0goZxQBcSHnrV6nDEOEA1WeQ70qHxdIQV8adDmaP5/
         wqyz2mra4wMxSOYvwUF7A4IOXnej0whyosWHo15BLfIBDWasECNwXzNxiLDtu9Y0DXRr
         71YU0Avky8jrcLDDtN52Xuw3lAmdF/EjaYlHIho8YiKppmWDQFXfXY2aVPoGDpOeJJ0Z
         KJDjle1n7f18KsVhk6CuLtbnvhj5cjyzNB5VmrAqinQUW6qs37xnkt+fUE6M9vklaqq+
         IOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vhh4jC6J4CbthbiiFd5lCvq63L+XCcDVV1BKRF2NppA=;
        b=fhf6jg/3Du7e9M4WfTnJfjkNRa9ikEtPxcserqqiVNoJnlormLIDgpNEqBwGbKJABP
         vwdIO4XxiVAYk1ZRqClb5AJBvLCsH9LFoDFdWHQmJyR7SO0eKOO5ejIu8UYyHP9qk2yQ
         r1aCqUQHJBg2xFe/px0UMEL07rlPuNTExT3EtbluWEwm/KRCbxCH5DhK2js0t4JUbLBL
         gG54RPOOSC/EKJkPPxI2W2weTF/dX5sY0czOdKTHqorTitGj3vWrZas9chAil1RmDAYE
         0al/QgY1543pc0srOwydRP1wMseP9wVJ8TDv8TXofh7vOELTHzY+PwnZ824IHbOQ1AmG
         BCtw==
X-Gm-Message-State: APt69E3I3oBHvwGGZ+F/MhutIFDSLeSrpxjqJTQtNRq+jachUh11VsCg
        DbBe3vPhFoUer3XT0ljrJ+naDQ==
X-Google-Smtp-Source: AAOMgpdxIzD+kQmwpjuaIXhuz48zZvKGGwh2DG363Z3LAOsVfgLsstpkeAwWmVpoTShhOOwhSSrP9g==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr7394587wmf.17.1530887486947;
        Fri, 06 Jul 2018 07:31:26 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b190-v6sm14358709wma.24.2018.07.06.07.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 07:31:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] reset: meson: add audio arb controller
Date:   Fri,  6 Jul 2018 16:31:20 +0200
Message-Id: <20180706143122.7612-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the audio ARB controller which is necessary to
enable or disable the DDR access for the FIFOs of the audio subsystem.

Jerome Brunet (2):
  reset: meson: add dt-bindings for meson-axg audio arb
  reset: meson: add meson audio arb driver

 .../bindings/reset/amlogic,meson-axg-audio-arb.txt |  21 +++
 drivers/reset/Kconfig                              |   7 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson-audio-arb.c              | 168 +++++++++++++++++++++
 .../reset/amlogic,meson-axg-audio-arb.h            |  17 +++
 5 files changed, 214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-axg-audio-arb.txt
 create mode 100644 drivers/reset/reset-meson-audio-arb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h

-- 
2.14.4

