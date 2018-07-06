Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD7AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5FA22449
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpd4M9Yr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5FA22449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeGFSd0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:33:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39421 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbeGFSdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:33:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id t7-v6so9802485ljj.6;
        Fri, 06 Jul 2018 11:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1ulwFJNe8KI5JEzHbonRxAhjJPz1ErZKKp2PppNW6o=;
        b=Fpd4M9YrKPVRgLSOAbcRqvi1NFjU7R4aA9GcKfCP5/hlJtxj8BhApd7TidhuusTO+h
         lNJU6b5LI/VIJIeX00NvF167atVptm+Qa3GBtUmh8rZdOeAXpoTYObYFmjaaaHIBUR+G
         fa2RuryQgM+A6V0Zkx7mvUWGeF2Ty1rQXu5eI5+pt7pJaUerwdj3ekhrBU0IBOiVXeMJ
         kz4X4Cg2mN5xAKCgq8+Hwlvt/MaaaSgkW4hHgeDS52Dvy+yOq2SO0qnui3CIsqsDAbBH
         QbSgRbdnZzuPJkHKbVQDH//9FVpgnPoEJKVtPgGV8R2AFwH2Ar5qTYIoNZPgOOMPelGU
         u9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1ulwFJNe8KI5JEzHbonRxAhjJPz1ErZKKp2PppNW6o=;
        b=KXYFCO38Mv+RJwOaCB1JnDyzhzz6pM8fq1yMZ6cMdzPOyeXQ2SgoAhOsCjy6fksDOg
         hY72XRpH5rUFFbzgw9SHVEVEYGEFflSwlNq+hi94BhOhSbvrbNppNpeqYBUzGsUVCHvm
         QQRGwXtC713s+Mjy3hAVhqQOdlDOnQLnIxRBmHsU/o/MtjPZLhckVpw4rLgD1dxFl8zl
         oEiu0IWqaG5l1b1/WzDHHjOjvFbwkshRLp7uxcLDxSQK14P4QTOAdBZAWUomvbBJ5ALq
         PC4EsmQssf6MxzDZ/vcuNXyRfnqWApRPTP5cObPucNhy0p7IKaq7i3sShOJp9XwCAfW1
         by9w==
X-Gm-Message-State: APt69E3FuMWFc9/P3w8+GT+UcuzD3RkpqBgKATTKN1B9wB4M5PkfAgUV
        6/oK6hC8T8JX501Y9831tt8=
X-Google-Smtp-Source: AAOMgpdDhcMvegiyv19OIjlX9nLEBQDAgjeDVZuxUQbAZFh0bCHy4MjEY0g768PlGCWPA7ZnzGSJ/w==
X-Received: by 2002:a2e:439b:: with SMTP id z27-v6mr7050056lje.84.1530902002426;
        Fri, 06 Jul 2018 11:33:22 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id l82-v6sm2314697lfb.8.2018.07.06.11.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 11:33:21 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v3 0/9] Initial support for Samsung Galaxy S and Galaxy S 4G
Date:   Fri,  6 Jul 2018 20:32:41 +0200
Message-Id: <1530901970-14972-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Changes from v2:
  - Restored pinctrl nodes order
  - Correct order of nodes in aries dtsi file
  - Added Reviewed-by to one of patches
  - Added Acked-by to one of patches
  - Squashed two patches updating samsung-boards documentation 

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

Paweł Chmiel (7):
  ARM: dts: s5pv210: Add missing interrupt-controller property to gph2
  ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
  ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
  dt-bindings: samsung: Document bindings for Samsung aries boards
  ARM: s5pv210_defconfig: Run make savedefconfig
  ARM: s5pv210_defconfig: Enable drivers for Samsung Aries based phones
  ARM: s5pv210_defconfig: Enable options needed to boot typical Linux
    distro

 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 423 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             |   2 +
 arch/arm/configs/s5pv210_defconfig                 |  49 ++-
 7 files changed, 599 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

-- 
2.7.4

