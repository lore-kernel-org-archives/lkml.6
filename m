Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A08CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EDA20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sP1u2LMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1EDA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeIJMg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:36:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIJMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:36:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so20765093wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 00:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sLJf014MKHMRH/ti0qljgihPWQUvfS4vqffAfOt5Eko=;
        b=sP1u2LMe5WElrSWeoIwxOjf3ebfxbejYJvXoXmGo/mbRQUI34n+WuElXKDsi2YozOc
         hr/Oh1dZIP04yPj2kIO3q/BrYOwz4egt8A3Lab4EBokWlnDay1yBxwWHjm3wp3qIj6Tm
         SFa3/EHfbTvkXDrERX5ZrgFpLJC+uWORqnnfuNdDYLAgq13n0oAEo2J6zg0NDQNC4k0f
         ceM4FaBLipLr0mB7/fAiLb47isnflX/M0xlQwOLM+P9nz0GCx7F3t7Ve5ixPjh8aLdHa
         cc5V4UW6rVdaAKmt/dRoFl2424/zg93XVtGjsgTSxx2hNtmO8bZokm2VEYnuQJiTTuof
         BFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sLJf014MKHMRH/ti0qljgihPWQUvfS4vqffAfOt5Eko=;
        b=Inv2r/dOuBV3LYyUj0ZLeBEyD9DkdzUBGVtxan2Gb+7aGWaUiSIHRxIVIaV0v+gg+D
         PSp3f6HgqY+5t/m/mvry+1xWsifyLB2ELbehFlTeP0HxJ+VBABHLWonukAiEv5XPBljf
         PilpZpQnCQlKLT6i28FE64WQAjTQD/aLPHdZfNGGw3doVzBdDNfDhN5IqHJcfCFRIwc4
         NxCQOQPFBtXomfDukOMnMwCgET+ntPYp8yO1sXcNxXUldK2Sl3JEabq8zxqJZSMXJNRw
         W8FbKRKrd5No3erD+z22dK06qNgn3HC8N7JLsWTMFzlNzE3H5WRgWj31xXZDXw/+2Yel
         kXqw==
X-Gm-Message-State: APzg51C8VvVrgFtDJtrrjH19jDVUARuSElaHR5F+ijiQLlvYUIPUUauX
        URMHUYh24dVJb5jsUnLOJ9ATPQ==
X-Google-Smtp-Source: ANB0VdaSk/U+QB7W1Vty1btuB9fTNLfs7ThCtpf8/x+47Ml/RrKGOAoPmM/Nl2koIrxsQpg0I/cQwA==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr12974058wrd.218.1536565453648;
        Mon, 10 Sep 2018 00:44:13 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-83-232.w90-86.abo.wanadoo.fr. [90.86.25.232])
        by smtp.gmail.com with ESMTPSA id j133-v6sm21589018wmd.12.2018.09.10.00.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 00:44:13 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Devang Panchal <devang.panchal@softnautics.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] eeprom: use devres for nvmem providers
Date:   Mon, 10 Sep 2018 09:44:02 +0200
Message-Id: <20180910074404.8041-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on the nvmem framework recently I noticed that there are
many providers that don't use the devm variant of nvmem_register().
This series contains relevant updates for eeprom drivers.

Bartosz Golaszewski (2):
  eeprom: eeprom_93xx46: use resource management
  eeprom: at25: use devm_nvmem_register()

 drivers/misc/eeprom/at25.c          | 3 +--
 drivers/misc/eeprom/eeprom_93xx46.c | 7 ++-----
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.18.0

