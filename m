Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E53C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C01C20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cPYdaOOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C01C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967062AbeFSQKE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:10:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37091 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967029AbeFSQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:09:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so1486354wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Vn+iQu4vTgRDY1K1v5D86tPnWPlL/gmK3VpcZLouIWI=;
        b=cPYdaOOGKl/66MJNSm8JdniYhhjtksmD2wub5+pc5HHwjkFVkv0ngpMOZnUOL3+y1s
         avmc2JH6/e7SVmnTXLwmMMjZV7iUOs58AaQDs07FBZl8UDbEuA73gaConK212vw9F6/Y
         UIZsPcHvd5IPcDXlMelPs+/X0/YMvzaRAOTZHaFySdtbbMKgaSDxBbmVCVz3wd4Cha1I
         +nTR83s7kMH6VL5+CS+n0DtH3F+GD5Jv3bECNowfKM/FjELqOl5G823bFMZqjzDnopRk
         Cvdd9Z7V7SQ/1IDExf7x50ojMvDlqZtaXUIY6c2kVbWm+BXJZ+g6Xo8lChCX0lgMyfya
         IjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vn+iQu4vTgRDY1K1v5D86tPnWPlL/gmK3VpcZLouIWI=;
        b=a0L/W4txqQpR9+AK7gGBIYYjooi4qBDfKoJ4gQBycttlxK+FK3TbPlN/Ax8CQURkAv
         9sm6kq4xvn9IJBecStWyThyv6GOt6ipXlA47cyMG2kxS3Z9JD+Eoza6lHioDWS6o9adM
         +yEgVy2GGbij4BjHAJK/jNXvifnSXP0gEW3AytZUpke+rVZwN4+P8lc/WWOcDtCpkoav
         fBaFRskuBFi84wpoM+ZEcpYc3GmnH/cOlPEILVUnIe8pvb7jfxEepL8MDpb5JL3RmnKW
         TCiTBdXib0rAcd4wCt+Ryk9q4tvoGdBackqMhw8T7B9WFosHN+Wpf/XSO/Vej9CGASJ/
         x2EA==
X-Gm-Message-State: APt69E18FoXQsh+4rYXpenstnuJDdL+wubtqBwRgoR/G5GgoeA2suKqA
        8rOp9buiR/YJtYi4LO+KnxWnVg==
X-Google-Smtp-Source: ADUXVKL86//nG8KcyXqLUbQSkjz9qX5XP0taMipG/ajt/VwF9CxSIw5BGIgj/SNKsqDLmyv7jpdlbw==
X-Received: by 2002:a1c:1d1:: with SMTP id 200-v6mr11949469wmb.145.1529424597966;
        Tue, 19 Jun 2018 09:09:57 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-1-7080-22.w90-116.abo.wanadoo.fr. [90.116.249.22])
        by smtp.gmail.com with ESMTPSA id 74-v6sm619327wmt.31.2018.06.19.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 09:09:57 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/3] net: davinci_emac: fix suspend/resume (both a regression and a common clk problem)
Date:   Tue, 19 Jun 2018 18:09:47 +0200
Message-Id: <20180619160950.6283-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Earlier today I sent the first patch as a solution to a regression
introduced during the v4.16 merge window, but after testing David's
common clock series on top of 4.18-rc1 + this patch it turned out that
the problem persisted.

This is a follow-up containing the regression fix and two additional
patches that make suspend/resume work with David's changes.

Bartosz Golaszewski (3):
  net: ethernet: fix suspend/resume in davinci_emac
  net: phy: set the of_node in the mdiodev's struct device
  net: davinci_emac: match the mdio device against its compatible if
    possible

 drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
 drivers/net/phy/phy_device.c           |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.17.1

