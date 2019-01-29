Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2CBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092602183F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="S1t4U1Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfA2Iiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:38:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43441 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfA2Iiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:38:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so13957716lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 00:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2kIF2D3mfXdnTnzYqtCaYs/f84OFeKZVdbluyx94wg=;
        b=S1t4U1GazkO17kk1fRBuCQ3f2Pf1eINj5CfgSCCN0EeDVvvsm61crKWE7JHzRdkDnx
         k57T9tEc69TsC6WJjcvpZMowMHSXpDSVB1vuaj9W9V3KGHWkuuTSEEBvptQiXb5g+MI0
         Obm98QY6TG/17kRNhGUKnbvAXYEJSHBcGbDvY6DCPlJHmOmh04L0aV7Qk3fJDWQ/3J1s
         zVz7aMsej3tnhjmit/sxs6xdTe5ZrBpODfem7iWZpbSAYWPIGZr2hMY48tvIIeHg0e8+
         b8klJoSIwnqkpx2hTv+skH+vcajwGjxunVNKXMvsHP5IGbMyMd3jHCz2SThOpxWoTsr1
         DgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2kIF2D3mfXdnTnzYqtCaYs/f84OFeKZVdbluyx94wg=;
        b=K1jJDm5DIMjp6j4KWND+hq8OAIfn/F+moeJyVaDmwfMHnUGjKQ9ttIBuSvhtupn/kH
         tBpzp593/NGD75z+Qm5gNhTwuyGWjHU7JOJNNMB2XtOTmyWEyelKqj2sxZFBbMozjoyF
         jF521wkjoZSp4QkXlx+WUqWMcGQZrFiaeTJgPpq2kFzm5SkHVLgm1zf+QtMhy2pLOVAF
         frRMmzQXS4dVypw/8bVyBYGZIPCLqqgtu5wle9tcA8Ka/b+NooRZTXRdJ1Hpg1TuUhRO
         G2IX1DbLDW+0orwhMUhBdZpyTJMKHV0+anaxHPTat1t5w78a+TxrCTXH2QvPwND1OVYU
         MCrw==
X-Gm-Message-State: AJcUukeEkf0LMheqdbFqXVKscA7zhUbEASDJ+GzE0LwVh/OUBpWLMeWZ
        jhwk1oGn8C7mabhYc5ncUCI8+Fmpkrw=
X-Google-Smtp-Source: ALg8bN4mKQac98KnNky6NTlCEmXxnSI56YEfDH00b4hZMdWZBrh7D7cW51qR6eeYHRkPkMgL786ncg==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr18948956lfa.40.1548751129399;
        Tue, 29 Jan 2019 00:38:49 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id v17-v6sm3378774ljg.32.2019.01.29.00.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:38:48 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v4 0/2] spi: support inter-word delays
Date:   Tue, 29 Jan 2019 09:38:42 +0100
Message-Id: <20190129083844.20572-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 drivers/spi/spi-atmel.c | 18 +++++++++++++-----
 drivers/spi/spi.c       |  5 +++++
 include/linux/spi/spi.h |  6 ++++++
 3 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.19.1

