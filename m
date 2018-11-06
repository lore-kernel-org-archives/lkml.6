Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3EC46465
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CAC2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDeu8WqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CAC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388467AbeKGECo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:02:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:38040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbeKGECo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:02:44 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A51520827;
        Tue,  6 Nov 2018 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529370;
        bh=mr8bjpKJuNvuWt0yCK5QYep3MiI2l4nON4kLEq1ktM0=;
        h=From:To:Cc:Subject:Date:From;
        b=dDeu8WqEWVbV3giVX+vsJMA8Reyzx5/p476Nbf072PO9JEiDZ5uwmfSIAkj9Co+nq
         PZmpq2Vzl4qp44nwa18HKnYO4ah/1BWq0Sej/3QxJv1VMIgDFxfRNCuhOMyAd0+BpR
         zsRN6ouJuJRJdWU1H9vRuMnWP7oGZWd3dkpFsEf0=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 0/4] Simplify mediatek clk driver probes
Date:   Tue,  6 Nov 2018 10:36:05 -0800
Message-Id: <20181106183609.207702-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suggested this some time ago but nobody has gotten around to doing it
so far. Well now I have! Here's a patch series that cuts down the
boiler-plate code that Mediatek clk drivers have to multiplex probe
amongst the device match data.

Rob/Frank, I'd prefer to take the first patch via clk tree so I can
merge it all in the next release. Otherwise, I can pull a stable commit
and merge it that way in case you want to take it through your tree.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>

Stephen Boyd (4):
  of/device: Add a way to probe drivers by match data
  clk: mediatek: Convert to platform_driver_probe_by_match_data()
  clk: mediatek: Drop THIS_MODULE from platform_driver
  clk: mediatek: Simplify single driver probes

 drivers/clk/mediatek/clk-mt2701-g3d.c | 28 +++---------------------
 drivers/clk/mediatek/clk-mt2701.c     | 20 +----------------
 drivers/clk/mediatek/clk-mt2712.c     | 21 +-----------------
 drivers/clk/mediatek/clk-mt6797.c     | 20 +----------------
 drivers/clk/mediatek/clk-mt7622-aud.c | 28 +++---------------------
 drivers/clk/mediatek/clk-mt7622-eth.c | 20 +----------------
 drivers/clk/mediatek/clk-mt7622-hif.c | 20 +----------------
 drivers/clk/mediatek/clk-mt7622.c     | 20 +----------------
 drivers/of/device.c                   | 31 +++++++++++++++++++++++++++
 include/linux/of_device.h             |  1 +
 10 files changed, 44 insertions(+), 165 deletions(-)

-- 
Sent by a computer through tubes

