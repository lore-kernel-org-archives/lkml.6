Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4E21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vJfO6znI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfA1SN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:13:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34477 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfA1SN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:13:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id f7so19239491wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MKOMw3GPLwhaK3fZEE540FDtl/EyZN/SvnHp5Licpnc=;
        b=vJfO6znIX57dbSA17Zj1WZVcEav0BNGNJew2iC+PC4KHJJAHIa8yrSf4JSY+c8AkvI
         I8v5BQKQgCNQy3DT5+4BwVL3xS7CWeMFNnGifi2Htly5aaPJesuNm9/00a/WektGIrlZ
         80R0yO9t/+XePNCS/VYsxIYx5vURsQAIMSWEUMvRR4jzY/ysPFIRlxyYrwHn+gYoFFbv
         vFQGjIBs4hMnENePpPbvu+F2KAPlFjE53u2DZxIcSwRvnSfSl6jmPnvjVqvc80WG2rJv
         lcFpdLz2Oz4uVaurm/rtBntnxrA5s239X9AeYCijzhcGkO6e4thfO43S2jlYds8zTAF4
         wKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MKOMw3GPLwhaK3fZEE540FDtl/EyZN/SvnHp5Licpnc=;
        b=mBcX5wZJXO87Nhyq0ATBlAQ83CHhjgwVCSvLkXmFO0dwUMPdDPEA0HjpTQWWaMd5yy
         fF2yjc1h/CEmn8PaeX1XkIy5V9kqnlfTnTjr1EnY2PcjpDOC1Wm27sfp9YtZ5tCGjVbb
         GWcX6UkRWPNrExR/OqHRa8cGTULUMcvO3ifntK5HAOHaEX34eZDLFrusz9IUDcz2aZQ9
         VZUyEe1OcqS3zO3NUWvI6Nld2VQCkB4OipDbsaeh4Ip8lGxbfHTmo/8dNaclqdS+VwZq
         TKdmg3lfc2vdP+xj2beVVc2nb5HMVhNeZu4shd5wxRav+kqX125c0j4BfSV8mICIvf/0
         24PQ==
X-Gm-Message-State: AJcUukfVxXuIcAjl3dm8qSkivsxuBYN2P8h6Ysyl5XavFdk8Lit5fQKv
        VJrpawEPH/zbrauYIz49MeDvQA==
X-Google-Smtp-Source: ALg8bN6QrAShPwPuJHzGpFBgZ0o1AQLzcLrTEbHIEXHrhsoJ6UprNweLT6O0dlWgnKuV0T1dTQl4rQ==
X-Received: by 2002:adf:bc02:: with SMTP id s2mr22163043wrg.255.1548699205641;
        Mon, 28 Jan 2019 10:13:25 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y185sm110654wmg.34.2019.01.28.10.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:13:24 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reset: meson: add g12a SoC support
Date:   Mon, 28 Jan 2019 19:13:13 +0100
Message-Id: <20190128181316.30814-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds new dt-bindings for the reset lines of amlogic g12a SoC
and the related compatible in the driver.

Changes since v1 [0]:
* Correct patch 2 commit message.

[0]: https://lkml.kernel.org/r/20190128141330.21927-1-jbrunet@baylibre.com

Jerome Brunet (2):
  dt-bindings: reset: meson: add g12a bindings
  reset: meson: add g12a compatible string

 .../bindings/reset/amlogic,meson-reset.txt    |   7 +-
 drivers/reset/reset-meson.c                   |   1 +
 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h

-- 
2.20.1

