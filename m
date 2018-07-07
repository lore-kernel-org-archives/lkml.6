Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F62C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9369223B8
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jt6cWn8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9369223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeGGKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:09:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46349 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeGGKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:09:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so10819281lju.13;
        Sat, 07 Jul 2018 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNivvWlWeK4i8NHmuIjPRGbUd+bA9WHDN4Lx1yfHQH4=;
        b=jt6cWn8DULoTYWgAyqVDO3U9qwBh3VGUvWw3VFSfDLQyHZ0urXjWYEYnVvbs7LKCEZ
         Llub5GVrafv7EpcarrAKTdsJCVdiXcE25DVhbI1hB1ZJVgixlu5wJuz5U/m5VPdrjsfc
         w+hBqFpGNnNDOw6movz4iyD16ElFl+gkM/7+nm2qQc8vlB8xpwRHfzoQclZPKb6EZ2Q3
         JlEvamSyfRGWDae/4KsqYuXTZ9+8CE+A7YKTDUgMpTD8q2M2AijheOAqTscEetQosdhQ
         wcLHfV8qfQeMIzvfWcHWnjh1+6MvVUpNJqc2JCED5L6XnlTNsxWOMs/ULz4ElzEIk/eQ
         0hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YNivvWlWeK4i8NHmuIjPRGbUd+bA9WHDN4Lx1yfHQH4=;
        b=FqtqicPZDnmjLq3OIP9yTBtamH8I+0QcF3NcFdJ6eSEe/Nx18KtQvaiLYvgPh0CSy/
         +f80MJrc3WuB7faJzry+m5CJ9CV4n3TXhdJsaOcPHV0HD6Oz2c2mKq5W3ZzVwyTnaK/o
         MB7i4oFyKvFjJrgRAePQ0Hu7sisP2olKBnMsWoe4IFJOl2pZrsPMyoOn+GzOmdK+B/bb
         amasVOVo4I/cOf365kbAbuosFzOMB32JLYy0U68RRKnAasyXh8jnTUmh/mEGODa2ROyf
         0YG6j0BnhoIw+zvXsf5cTXc7InjwCnTrl1icJd5I0fDSX5C+7EULUyAgDW4xTzpzUTK/
         oNlA==
X-Gm-Message-State: APt69E3olrDDW4p5iOyD++OxdLyj3KQUxbTXhPszXnorGSTYDif7hwKY
        IW8ZIJaXrXnhYpvR9/RkpiE=
X-Google-Smtp-Source: AAOMgpecSIPiXVXHtjW3+HsigvNpgvcp4b6PEqPm/RBec4+QpBvGH7bwl4E9aDNFnc9vnZD0k82W9g==
X-Received: by 2002:a2e:5f89:: with SMTP id x9-v6mr8234673lje.16.1530958188829;
        Sat, 07 Jul 2018 03:09:48 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-170-61.play-internet.pl. [94.254.170.61])
        by smtp.googlemail.com with ESMTPSA id k77-v6sm1321292lfi.46.2018.07.07.03.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 03:09:48 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com
Subject: [PATCH v4 0/5] Initial support for Samsung Galaxy S and Galaxy S 4G
Date:   Sat,  7 Jul 2018 12:09:38 +0200
Message-Id: <1530958183-10956-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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

Changes from v3:
  - Removed already applied patches
  - Fixed dts warnings in s5pv210-aries.dtsi

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

Paweł Chmiel (3):
  ARM: dts: s5pv210: Add initial DTS for Samsung Aries based phones
  ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy S phone
  dt-bindings: samsung: Document bindings for Samsung aries boards

 .../bindings/arm/samsung/samsung-boards.txt        |   5 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/s5pv210-aries.dtsi               | 419 +++++++++++++++++++++
 arch/arm/boot/dts/s5pv210-fascinate4g.dts          |  45 +++
 arch/arm/boot/dts/s5pv210-galaxys.dts              |  77 ++++
 5 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
 create mode 100644 arch/arm/boot/dts/s5pv210-fascinate4g.dts
 create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts

-- 
2.7.4

