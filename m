Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072F0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0520880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gfjDs/wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfA2Lnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:43:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41729 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbfA2Lni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:43:38 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so8629321pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 03:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BYtsksCc3g+PmSULTt0E8BRnvpc7E4mg6XPQVON9mcs=;
        b=gfjDs/wUKN6FehYc9VG0UQAzo8SAcw0p/mIsR+V4BLYvMJub3S7VgC1I8/q47qzeFK
         O8JvpFo/SgkXpxTjj09Byy3SSx12tZ4d5izHFj+3/vYuoZ8g946iYy5BWBFStVAMeNhK
         61QYTmBMDpuTLyUkyUNB65O1n4i9oJIwxaHxzuGaV6o3A2YMeG4qfLNwzEG2PzNEgiaS
         dP9CU+5qUwVTBqKAVaaqOYGSsDnbOsmg231a9RWacDmnce5iWUPGJuYWxkeDBzBeNIh6
         GBWJEGLT0fNvntImcNGQVUkZCA1pX6d38ROPCl2hoEZSr7sMAXAS320g+nKNMp9L3bO3
         PC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BYtsksCc3g+PmSULTt0E8BRnvpc7E4mg6XPQVON9mcs=;
        b=CA7J4aBj4dhKYYosXljYraBjIMU55cJETY7QJ1rVCS5iCGOQLDmTAESXBK8GMu350/
         orBb2L3pUHVU6zhd+quQBOKaWMeK+qBP0RhJ5V6681Poj1hnyIyB/imkoaDYNXBi95B/
         66GeX1L9F3am1O+fjA1CUzRVk3K/RCgqq6oD2II7rMsLw0JQ9TRc/J/deix8h0KTXmpr
         RMMV7IbihOV0HcLI+a8IOKvalWzNV8hNjujZBaCTyyXrbgxtPGF47JUuO0O+MyATtoGD
         UpvomEcKoH2bQvTc6C/SN50UPj3wsi6vsKptOPJKJtIQPisAEiB1IJ2RUaviorhlcqkR
         WgwQ==
X-Gm-Message-State: AJcUukfvENNwRjDWPZn+oBeTc00yQFfrIRF5zBPg1AjVIqqIPCs9g6Xu
        +ACeELX3NfWwMzzJ/44FIvqyPg==
X-Google-Smtp-Source: ALg8bN5lqCpISIJjZ6e0fXkpLyie8zITnv5vzILnqTWRM0mpQg+5nEcjVr/meZAIfUK91Kz8COIfIw==
X-Received: by 2002:a62:798f:: with SMTP id u137mr26058536pfc.168.1548762217083;
        Tue, 29 Jan 2019 03:43:37 -0800 (PST)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id p2sm48755717pfp.125.2019.01.29.03.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Jan 2019 03:43:36 -0800 (PST)
From:   Yash Shah <yash.shah@sifive.com>
To:     palmer@sifive.com, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v5 0/2] PWM support for HiFive Unleashed
Date:   Tue, 29 Jan 2019 17:13:17 +0530
Message-Id: <1548762199-7065-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a PWM driver and DT documentation
for HiFive Unleashed board. The patches are mostly based on
Wesley's patch.

v5
- Correct the order of compatible string properties
- PWM state correction to be done always
- Other minor fixes based upon feedback on v4

v4
- Rename the property sifive,approx-period-ns to sifive,period-ns
- Rename macros with appropriate names
- Remove unused macros
- Rename struct sifive_pwm_device to struct pwm_sifive_ddata
- Rename function prefix as per driver name
- Set deglitch bit before changing output waveform.
- Other minor fixes based upon feedback on v3

v3
- Add a link to the reference manaul
- Use appropriate apis for division operation
- Add check for polarity
- Enable clk before calling clk_get_rate
- Other minor fixes based upon feedback on v2

V2 changed from V1:
- Remove inclusion of dt-bindings/pwm/pwm.h
- Remove artificial alignments
- Replace ioread32/iowrite32 with readl/writel
- Remove camelcase
- Change dev_info to dev_dbg for unnecessary log
- Correct typo in driver name
- Remove use of of_match_ptr macro
- Update the DT compatible strings and Add reference to a common
  versioning document

Yash Shah (2):
  pwm: sifive: Add DT documentation for SiFive PWM Controller
  pwm: sifive: Add a driver for SiFive SoC PWM

 .../devicetree/bindings/pwm/pwm-sifive.txt         |  33 +++
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sifive.c                           | 261 +++++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
 create mode 100644 drivers/pwm/pwm-sifive.c

-- 
1.9.1

