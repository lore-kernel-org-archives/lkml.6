Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D25C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E3C21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tlBY2iZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbeLXLPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:15:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38203 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:15:13 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so11274880wrw.5;
        Mon, 24 Dec 2018 03:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phpCNWgTkaVvzzS3nmFNxgp4mzU8ec9l7jdZBnsDYzY=;
        b=tlBY2iZFWJOBYvAmIdfFci7WlgH8Qi/emEjCslFz32qeGMgSoDYqE0Czh4pgi6c329
         fhNPHaP8bhIjMd2MJ8Jcwrc9m5E842f8Ia6RsUu6r9S0FW6fFL6wFjvPDBC8KPYjkpkK
         LBk39Kv1bwONOTieJ5pxkEQBvUsU4ZR2IO9ly59seDjeNz3EYObXKdb5XOwG3KEg2h0G
         o0qnoYqhFG8NPCigTOA9JCu1IQRlmNJTcmkyvUjKV2dvpl5oB05Vuozcmwe9fHEQiOhD
         GGrpIfR2NSoP/EkL8s8fPEVxZ8F0iMVZ9rWPxM5bxlQrwoHnUBS6KD4eXw00sFdRpA29
         Bomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phpCNWgTkaVvzzS3nmFNxgp4mzU8ec9l7jdZBnsDYzY=;
        b=Yt8048OF6FaFUbDerFH9D9Gr3L8TCwclzXDbQ7dJZuPjqw3N05vc1Boxo4AEZSEvm+
         g7J2Wgjn5mBY4QwGlPUcRfwBcccyL8YSssfqMEGA28ou9b7jWPN60n8CWtjefCcIIDMF
         jBqQGScad9zXlbOqBRdkibVGFZiBc9aEXhQ1l4XwRyyLrIDjgqXCst6USgejM2Q6tP2w
         xdZCP04pTroHTOLP+OjZe7NM2yrAZh4A7FMcpTE6rMwjlNnuKnPtVoandtJ/k1bhgpUF
         Wn/tR8279hcTFtt6et90PaTSHc6qf/GvDq5m1rBL/eNuNdDY5sntQggDar3z4EJm4kJ7
         NWaA==
X-Gm-Message-State: AJcUukcqOi6h3oOp0h0k0VSg1GG1Umrj1BgdLyOMYYml25cna9AD1X31
        +zlqJSH0GrK56WT6oORs04Pj9ids
X-Google-Smtp-Source: ALg8bN6usrpNtyjyQSY7VY3aAJT284EQna2I2eUZv7NS4BYeFN1Ug6D3lAT7wLHd2pSbntQcyRbxjg==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr11138330wrm.309.1545650110883;
        Mon, 24 Dec 2018 03:15:10 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id d4sm22753221wrp.89.2018.12.24.03.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 03:15:10 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v4.21-rc1
Date:   Mon, 24 Dec 2018 12:15:08 +0100
Message-Id: <20181224111508.23847-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-4.21-rc1

for you to fetch changes up to e94b815524f83536415d7d59cc1833ad05934d97:

  dt-bindings: pwm: rcar: Add r8a774c0 support (2018-12-24 12:06:56 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v4.21-rc1

Not a lot going on this cycle. There's some more cleanup going on and
new driver support that was not quite ready in time for v4.21-rc1, but
here are a few fixes and improvements that are good to go. The Kona PWM
driver can now be built on the Cygnus architecture and the i.MX driver
gained support for hardware readback. Some small fixes are provided for
the clks711x and lpc18xx-sct drivers. Finally, to round things off some
drivers are switched to SPDX license identifiers.

----------------------------------------------------------------
Alexander Shiyan (2):
      pwm: clps711x: Fix period calculation
      pwm: clps711x: Switch to SPDX identifier

Anson Huang (1):
      pwm: imx: Add ipg clock operation

Clément Péron (1):
      pwm: Enable Kona PWM to be built for the Cygnus architecture

Fabrizio Castro (1):
      dt-bindings: pwm: rcar: Add r8a774c0 support

Michal Vokáč (3):
      pwm: imx: Sort include files
      pwm: imx: Use bitops and bitfield macros to define register values
      pwm: imx: Implement get_state() function for hardware readout

Stefan Wahren (1):
      pwm: bcm2835: Switch to SPDX identifier

Uwe Kleine-König (2):
      pwm: lpc18xx-sct: Don't reconfigure PWM in .request and .free
      pwm: Drop legacy wrapper for changing polarity

 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt   |   1 +
 drivers/pwm/Kconfig                                |   4 +-
 drivers/pwm/pwm-bcm2835.c                          |   5 +-
 drivers/pwm/pwm-clps711x.c                         |  13 +-
 drivers/pwm/pwm-imx.c                              | 194 +++++++++++++++++----
 drivers/pwm/pwm-lpc18xx-sct.c                      |   3 -
 include/linux/pwm.h                                |  42 -----
 7 files changed, 173 insertions(+), 89 deletions(-)
