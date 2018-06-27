Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D886C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01E123D0D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkIqkYZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01E123D0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966008AbeF0RMl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:12:41 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35455 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964947AbeF0RMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:12:38 -0400
Received: by mail-lj1-f180.google.com with SMTP id i125-v6so2244561lji.2;
        Wed, 27 Jun 2018 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZ2WdJLfpAzuJARzAVev5tREHsVidLx5HnilW1tiyT0=;
        b=gkIqkYZFfV0wmgVHAw5hToBacK+os8XfGsRKJu/arvl2WirYt9tSRATXHQN3NATxfk
         9S2vedsINAme5Dnh254vfM1UFlBBPCA1b+/hip/nzG9PTJHgWDBXGzI0GUdXphbBBhio
         6Ng1Igw5I3lmR+wW2GrE+of3zvSQ6tbRQ4St+iUZRE1MgyZjwiTL8X5OPuBAxtAieika
         f3m8f9mXXPZ9LOvK6KvLq/R4I2gsYzvSAtyv8sgtyYMMd+JFoF4tVWwJsjPQWvjIZGRb
         LyYEI47Ed4l9k1UpcFoVSXwRDMso40GoIE8KTByAVzBykTRgiWp7YrcGTLENdE072xLN
         5RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oZ2WdJLfpAzuJARzAVev5tREHsVidLx5HnilW1tiyT0=;
        b=hwqF+NclsYmys6vCr3vAg1+mPyKFF51ppECIbM+aZHJGUD29o5TmQJL6k+RXPZzesv
         McHcXwkiIrUNDqeljB+bQOHDK6EFv1H7e0PMKy37OQhk6Ho5DmoUacTD3jkG6XhFyIMB
         Lk6HZUAV3fLfenuSysyMrkSSlTSbpYt7rLajw/vSeuIqFxS41su/M+Xk8eofaj8db8gs
         i3LcQoUZV1FBaNsy5GsC/oSZk3Eizg4oSAyzouhr2UjZdDg9ivePmM8dAIsTIkcdcWpn
         CEUdPbyYrsa34Md4yhZhsP0tMjWelSLJJjAPUBaxnF1lgtTJlBLbIJEanQF/YR2241Y5
         MitA==
X-Gm-Message-State: APt69E0Eq8XWJjtz8JstSCbrr1tifiOq1IUQFeDazUpcdW105uLRYuQj
        tCcBzsRkvuMydw16QMsmhJcpAV/oSwg=
X-Google-Smtp-Source: AAOMgpd96h24GDdFWrVtW+Oz2kGT2CAd3mewGQcUdbiqe5XY/RcDZFj2+grFXhLMM4O7s/0g1lWoDQ==
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr4660907ljh.78.1530119556665;
        Wed, 27 Jun 2018 10:12:36 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id n9-v6sm929344lfb.7.2018.06.27.10.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 10:12:35 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v2 00/10] Initial support for Samsung Galaxy S and Galaxy S 4G
Date:   Wed, 27 Jun 2018 19:12:14 +0200
Message-Id: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Samsung Galaxy S and Galaxy S 4G.
Both are commercial phone based on Aries family.

Changes from v1:
  - Removed duplicated and unneeded headers
  - Corrected node names
  - Formatting fixes
  - Removed unneeded pinctrl and sorted entries
  - Set correct interrupt type for max8998 pmic
  - Add missing regulators
  - Added missing commit msg
  - Added stdout-path
  - Added information why we hardcode bootargs
  - Added new patch which adds information, that there are samsung boards,
    not using exynos bases soc.
  - Split patch updating s5pv210_defconfig into three parts.
    First is result of make savedefconfig, second adds drivers required
    by both devices and last adds some options, which are usefull in booting
    typical Linux distribution.

Jonathan Bakker (2):
  ARM: dts: s5pv210: Add initial DTS for SGH-T959P phone
  dt-bindings: samsung: Document bindings for SGH-T959P board

Paweł Chmiel (8):
  ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
  ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
  ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
  dt-bindings: samsung: Add S5PV210 as possible soc in Samsung boards
  dt-bindings: samsung: Document bindings for Samsung aries boards
  ARM: s5pv210_defconfig: Run make savedefconfig
  ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
  ARM: s5pv210_defconfig: Enable options needed to boot typical Linux
    distro

 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 413 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |   2 +
 arch/arm/configs/s5pv210_defconfig                 |  49 ++-
 7 files changed, 589 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

-- 
2.7.4

