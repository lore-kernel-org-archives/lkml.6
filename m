Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA01BC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AC32184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="otnSV9ZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfA3IkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:40:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45893 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfA3IkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:40:10 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so19918792ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihsNiSMFkLb0DdAUyOACz+6mnXEKjNCi8ZHwAIp6izc=;
        b=otnSV9ZQvFMGbtMvP4+9BKyw63k4/TkTPpnJoK2khxrx854ovZM/5FDLPBCGdqoWW2
         dfyPM121FOGw2msgvNcdMbEfsdxO0N1mkP9/V5q85HKle+2SPqe2LVDsLWzquk3wQU8f
         QtXK6QGPiM3t1+ds5rdtmNLzuKHshPjJc3Xc5sh2FXg7BQqyL60SZ3GSBFZMG3qmSrsO
         37U/xPNvwyqX9dojtRJuDbhvzEEHVDEEEN7AUJHsu+snmqvMFNBVB/33j1yRxetmmIj3
         HHSFD0dbd+SuWUknGc8GpRMkdPMxPG49cnS9rDiX8LNsqv/86RP1v9SWRjLcHBD0wJ7H
         30uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihsNiSMFkLb0DdAUyOACz+6mnXEKjNCi8ZHwAIp6izc=;
        b=VzyNoR3D8T0i+k2TLepjMrtbv+PbPNebJ47Ilc88AmpCooILNLZeP94Gfu9XdW4lSp
         LRc/mtzj1A7/M8jcgb1U5FSuIOI0DrdmNEK0J+GVHq3We+PilvM4GSINGDUHfJfi8hOI
         B4h7PXPnIxjy5BnhRaza6P68xyPDolfopNic1G+LPlAtzH2V+hozcRrN1IoZA9+5h66M
         ofb9raxiQ7+HES1ZijmOhAociqW4Acbu5e9VAXehudYHhPlBQCpsgkPhJ4cuBXJ0Ni39
         88YnEJXyHMbEuabUbL3Ap9hFJnENixOJBMC7u6hQsjdiYeyfU9HmiR+d/PIzgXEXeUO4
         7eAA==
X-Gm-Message-State: AJcUukc2BVNy0GP/w67+ixqx6DJ4GYnEkQfCw4Vqmr8k0h872mQU0o/u
        8hptRUNFGeH9XqGx+Tuo2a1fpqwA62Q=
X-Google-Smtp-Source: ALg8bN4kL5FN/q9Hft0KvbKppetAnNFJikCBYfHrOPLqS4VdOoVp7YwV4Pi7FI9fS+KmY5t/hyz9Jg==
X-Received: by 2002:a2e:91c1:: with SMTP id u1-v6mr21668428ljg.188.1548837608324;
        Wed, 30 Jan 2019 00:40:08 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id q67sm176734lfe.19.2019.01.30.00.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 00:40:07 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v6 0/2] spi: support inter-word delays
Date:   Wed, 30 Jan 2019 09:40:03 +0100
Message-Id: <20190130084005.18649-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed in v6:
* Changed name of field word_delay_us to word_delay_usecs as per
  suggestion in patch review
* Add Nicolas' ACK to spi-atmel patch

Changed in v5:
* Rebased on linux-next
* Fixed up Atmel patch to simplify register setting

Changed in v4:
* Rename word_delay to word_delay_us and slot it in _beside_ the
  existing word_delay parameter in spi_transfer (see commit message for
  more info).
* Add code to __spi_validate to make sure transfer and device align with
  respect to the word_delay_us parameter

Changed in v3:
* Drop setting of inter-word delay via device tree

Changed in v2:
* Fix atmel-spi driver to not unconditionally set minimal delay if no
  delay is required (erroneous clamping)

This short series adds support for SPI inter-word delays and configures
the spi-atmel driver to honour the setting.

Some SPI slaves are so slow that they are unable to keep up even at the
SPI controller's lowest available clock frequency.  I have such a
configuration where an AVR-based SPI slave is unable to feed the SPI bus
fast enough even the SPI master runs at the lowest possible clock speed.


Jonas Bonn (2):
  spi: support inter-word delay requirement for devices
  spi-atmel: support inter-word delay

 drivers/spi/spi-atmel.c | 11 ++++++-----
 drivers/spi/spi.c       |  5 +++++
 include/linux/spi/spi.h |  6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.19.1

