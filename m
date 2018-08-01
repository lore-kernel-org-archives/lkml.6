Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE68C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15576208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yyc0ry5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15576208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbeHAP0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:26:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38152 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389274AbeHAP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:26:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14-v6so20191182wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ePQe82+YZ1VwP46Ks/CbeTUUfAhCqcgKrDC3S/t0XaA=;
        b=Yyc0ry5/lhqlPLZK/Wy0FEdEeyFHTvFXj7o9Q9+uqlHGOzZzFCCeXrFJN3lk26r6Zx
         Kf8IIoPoP7q9x8r5S85mt76UaCCFibUBlB744PCNiZAtHf52sIe5n26hRre/geCCEswI
         dj23lkjIzO08BDgL+Ws7QP3zF5vrl6qzHQJf8eotfC7hfpfvjn//VnJSe4VhGT5+9T8J
         EMXeVR1LHcyltGRBx6kEtrmYKf33xrS9CXZe+ZdCr+F0CiR8vaZVTIpDjm+RgfgJ/6Vr
         +EPJIq27tQoxNwG5n2bv6Op6QLU+1+4Vj2bFZZ8zQJOT/TGRgIsSi6/Cuoz9z9Ju8hGS
         bmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ePQe82+YZ1VwP46Ks/CbeTUUfAhCqcgKrDC3S/t0XaA=;
        b=JkO2h4/9DumsSVwg+JyD7TkU9K8S+UwN3C95BmhXOIn6/gL3taEHdyDtutuiebfFeG
         x4mHE/anvnrI3Np1DkalaiEJz9TtVZRzl/qWYtagMNjYaOKCKXczv40fNn3fRxBpen5n
         TAffCG8NWpIIchGeeYi0q20aDqwxr7keJM0cM+ZpyX9j96AxRHcNeBQBYfePSSGgR2cp
         H+QdyP0KlZGNcOeiheLT5cxLTnFLMBcB3WQSpr3llSEDk3y3uidxPav1UQiOak4ONBkU
         fcLE8/E64MTkZSSHHjJFCvqQgKUXTiYZUW5QzeRbtwDJdHNO/tbZBLHIx5xpHnioP8p3
         VwQQ==
X-Gm-Message-State: AOUpUlGM+MIKZOQyd6UZLNlUm9HtmpY5kgoDe34jjoBU9JAhj4UBsfIS
        RnsIBjw76mVIy/N2HA4ntqWBPg==
X-Google-Smtp-Source: AAOMgpfFNgo6++jFb/yFDGmH3ituknmPZO6Dz1VWx2dY2BqCNE+/hVETvI9Zxli2QeRi/aNDcOaZ5Q==
X-Received: by 2002:adf:cc0a:: with SMTP id x10-v6mr22997787wrh.242.1533130852551;
        Wed, 01 Aug 2018 06:40:52 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f8-v6sm24347080wrj.9.2018.08.01.06.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 06:40:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: meson-axg: add audio support
Date:   Wed,  1 Aug 2018 15:40:30 +0200
Message-Id: <20180801134033.21739-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patchset is to add the audio devices on amlogic's
AXG SoCs.

In term of dependency, apart from the clock bindings you have already
pulled for your second PR to arm-soc, this patchset requires the ARB
reset bindings [0] for patch 1.

Changes since v1 [1]:
 - Dropped applied changes
 - Update card bindings following Rob's comments on the card DT binding
   documentation.

[0]: 3bfd2fe0ab49 ("reset: meson: add dt-bindings for meson-axg audio arb")
[1]: https://lkml.kernel.org/r/20180724125238.14567-1-jbrunet@baylibre.com

Jerome Brunet (3):
  arm64: dts: meson-axg: add audio fifos
  arm64: dts: meson-axg: s400: enable audio devices
  arm64: dts: meson-axg: s400: add sound card

 .../arm64/boot/dts/amlogic/meson-axg-s400.dts | 180 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  67 +++++++
 2 files changed, 247 insertions(+)

-- 
2.17.1

