Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5638CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A41F218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="hgRyAVQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfAYLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:44:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35406 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYLoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:44:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so6719534lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uZgeytfHcFfoxxwaJPRe+nMKCIYtTyciuS0VyMLAl0=;
        b=hgRyAVQR/JxBzSyWetarj8knMgSFD/WDjVWg2isDKSBIcHphNqDQ6YKu0fQrTStlMB
         OJs07Os9s+jYwPXfnunj0E6FcqaR8dF9uV/80UzoXBwx96kR28irhLy6ya3hrVoLdpNd
         vQP/7LPfKv5xGe8crcqx7Lvok3M3alOkkcVsDgPdQqXjGr5cAQdWt6a5BzIF4fO6Ue2E
         huIAq4YljM0u4Nbo1MQL+pthruIv8YKTrmY5MLHPAvOk43vM8z03RX3iyvGyrobUadz9
         Y7zxY+zH9yWQeBraXCCv9Lh3t/4DrBxsF/v/nrmrUsE908AHfEojZjvJqPf10laOE6Sp
         bQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1uZgeytfHcFfoxxwaJPRe+nMKCIYtTyciuS0VyMLAl0=;
        b=dLu2In+HP5Dh9rArmMzz5AmvrD0PYfoVG5yGb4QCvbn7duKrCFM6QAdf9bWJlgPyVx
         wHed9R+V6KG2Fugg3dTbyHCF9Z83DxZzO1lhMzS76zswpXuKSc7bs5uDJRi8TGIsAjCT
         5kOMvNJCXDZ7rSx1QiTmQI8lYKA7tpuw/vV34/+SAHWbX8AqxuvPiqsdxDl9b45PoALw
         togQqdAJe4LrS3+EzRaOuN1V1e6HGRMUvG/pqegjf/ouFUBzSKJD4I5fSZ9vusMzseAp
         reOJ9+sCpRzVP4bFsyShOAHcbQMsEsnndXlJyiIyTBA8tcWDE9VVSy7xKKDPo/nzue8f
         bfyA==
X-Gm-Message-State: AJcUukdKHA0XnKaXaet05zIz7AphLNkmtwEZbuEbetlPE2ycLdnBo18O
        Zr+zliwvKGFblaMjVVHtXJm60BhkRGA=
X-Google-Smtp-Source: ALg8bN7V9lQNIdgdU/gKYAG2vuhxH/ygZj73KJNHy/qQ8qoTx/5/KuI/oqFD2D3HUAbQwymgN22O/g==
X-Received: by 2002:a19:7352:: with SMTP id o79mr8668259lfc.104.1548416672309;
        Fri, 25 Jan 2019 03:44:32 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id l3-v6sm1490962ljg.21.2019.01.25.03.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:44:31 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 0/2] spi: support inter-word delays
Date:   Fri, 25 Jan 2019 12:44:27 +0100
Message-Id: <20190125114429.20066-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This short series adds support for SPI inter-word delays and configures
the spi-atmel driver to honour the setting.

Some SPI slaves are so slow that they are unable to keep up even at the
SPI controller's lowest available clock frequency.  I have such a
configuration where an AVR-based SPI slave is unable to feed the SPI bus
fast enough even the SPI master runs at the lowest possible clock speed.

Jonas Bonn (2):
  spi: support inter-word delay requirement for devices
  spi-atmel: support inter-word delay

 Documentation/devicetree/bindings/spi/spi-bus.txt |  1 +
 drivers/spi/spi-atmel.c                           | 11 ++++++-----
 drivers/spi/spi.c                                 |  4 ++++
 include/linux/spi/spi.h                           |  1 +
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.19.1

