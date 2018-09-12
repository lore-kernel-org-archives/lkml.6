Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4537A20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MB/Cwi2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4537A20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeILNIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:08:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33170 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeILNIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:08:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so982099wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=byBgUvkvrlWQi4xwkK6BlLeUrcNu5Y/Stmt4ahLbhjg=;
        b=MB/Cwi2ZjJnVpBuGxC8yz9oYiL75Ov9SCYUVQVtkmNRKdGANhtHIvEkn+zo9u8Lv/J
         hbPAq6URJDy6bBnEG+GY2s4jyn1ZSjtAyjdsG2RqKs0aizk99mqApxNuGLJGyUfAsHhB
         pAA2Jam5EJQZ7ONwEqJeE2M97bWe+6uNMaelV088O39HFQHweTDFHj736D1GdR34Fy4z
         ZUjlxjwZ5PYoymsO40T8GHpHB877pjWAnpX2DGEUIbiqqNscHJBU+9ESd75QOk5eSA/j
         PILB2U2ZJoN30q6uO0UjVjPzPBxoGdCHKxpCNppBHmRkFNwbMxzxvEZnvt2zTRRKXDMa
         w4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=byBgUvkvrlWQi4xwkK6BlLeUrcNu5Y/Stmt4ahLbhjg=;
        b=VVJshFHJPKs8LfJrgAtuxIqwQrU4lc0DjDGMMhdiaaa4dNQxoTAgw6VbA5XQGBKNNs
         jf2RlKcvO7qonxMH5ciB/OekFM4xsNA+nq8sBEcJy30Ywn7JDpa7dcBpYXENqXrTm/wd
         XE9JqmF7QcUdRVmiSP0TCOXrRoVqkrlmAzU58rFHals6hYVx2S8EqAm0QfHia/Ohnrmp
         I02RUrTGZVxxPn8qaP1L3uiuEQE5Rptk1OFbSKu5cqtkldK657Od7fWYkostn6HUdfp5
         UnXeYcCeJUP5SHWssTGVEwFKTh/bLvwMP0MBYfrj1kssAR0yM7msMWsj8gHPsm2NAFbx
         Md0Q==
X-Gm-Message-State: APzg51AaRhV68tSzSkJRTTbh9u26gmWYBqwP3RP2LwJ6u3DTLac0Q4+H
        frDzNJYviQieuJzEpCv+QtpBnQ==
X-Google-Smtp-Source: ANB0Vda/qPgvk4DCLJOMgIBeYjS81KhBYRb9tQCgWoEXsh20SPm8oGVPW4rJB+BjW9Jkba8azsKPMQ==
X-Received: by 2002:adf:e14f:: with SMTP id f15-v6mr580888wri.42.1536739506959;
        Wed, 12 Sep 2018 01:05:06 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id 139-v6sm1225182wmp.4.2018.09.12.01.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:05:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/2] eeprom: use devres for nvmem providers
Date:   Wed, 12 Sep 2018 10:04:55 +0200
Message-Id: <20180912080457.12238-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on the nvmem framework recently I noticed that there are
many providers that don't use the devm variant of nvmem_register().
This series contains relevant updates for eeprom drivers.

Note that these patches are independent from my other nvmem series[1].

[1] https://lkml.org/lkml/2018/9/12/265

v1 -> v2:
- fix an invalid devm_ free in patch 1

Bartosz Golaszewski (2):
  eeprom: eeprom_93xx46: use resource management
  eeprom: at25: use devm_nvmem_register()

 drivers/misc/eeprom/at25.c          |  3 +--
 drivers/misc/eeprom/eeprom_93xx46.c | 19 +++++--------------
 2 files changed, 6 insertions(+), 16 deletions(-)

-- 
2.18.0

