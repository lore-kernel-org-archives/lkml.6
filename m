Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC786C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DF02086D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKzhg/o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbfAOXGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:06:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40723 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbfAOXGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:06:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so3943120edr.7;
        Tue, 15 Jan 2019 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BOCUmPup8Edk6qGTKEBM7IsNV16PwGHPAS/vuqQPaQk=;
        b=eKzhg/o+gbO9X7EAEvjpumJg2mTz9Q+Es4uHrxG2vtMbmstWg0RpfobT71nluNN2pu
         KOu1PfyM8WxKrInbRn2Dao9FlFD8RULgOTO11vURMRx8Zrd10M+IfYHfDGprybpxT585
         Ba08BHpyg2Rld7uW+fKsKWfcI1fZRppsnYFSzgVeetgIIqUIR9Fn+kE/hjPTAoLBf5rd
         0Eo97W6YQtN7LhCDaYe0Db40+20fA2nZreFWNBrlTc5nlHdfhV7axBOtirumOBDdyNvy
         KCmASW5WUCo+3lx9ITHV0yGfx/mTCknMdU9ySlaSrMrrjW3+fSGdxq/dVxgbt5MX1bEc
         8meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BOCUmPup8Edk6qGTKEBM7IsNV16PwGHPAS/vuqQPaQk=;
        b=m9CT80fm/sUCtGIeYcUYN2K9r4nyyKRJV5oH+IcgSGLdk1Jyl9dZ3tymOSUOc6bvLd
         b8f4z05v+f9jQJB9f364t6w575GygtlM2VNOi8ZjhsDCIpHCEehKgmLaZ/md45/ZdfeY
         x9AAVXiJW5Z4BRPT/s0pyxRT0qGjqZbcn8A41WQRBrXpXa75Kpk/9R2XdwYIpIaOSnUI
         Pavq5IKXjx3BjN77t+8kU983RFJRaPvYC26c2VNvWeiFQA6piqFad1q+8m+Lp7PQaGsj
         DFP/zpt5WKP2SHzOqtnvwy1IqFnaDFkloYxV+VNp7wsck7+ni0mPK7Qz0U7KCuLX0xaP
         pwEQ==
X-Gm-Message-State: AJcUukcA9mNMUXIgT1YjJ/dShpdRn810xuMOriYna41ge4be/yVhu9WV
        f+6PGPv7Xw37CwGxwPzM6hI76EUm
X-Google-Smtp-Source: ALg8bN723zZfoMqBq1PgEDmpdR/+YuYgXg21r/W1RytKhp2DCaKtQv0KmoAR8uz1pVheU759yNdpWw==
X-Received: by 2002:a50:ab5a:: with SMTP id t26mr5096887edc.293.1547593612749;
        Tue, 15 Jan 2019 15:06:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v14sm4872324edq.74.2019.01.15.15.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 15:06:52 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell
        Dove/MV78xx0/Orion SOC support)
Subject: [PATCH net-next 0/3] net: dsa: Split platform data to header file
Date:   Tue, 15 Jan 2019 15:06:10 -0800
Message-Id: <20190115230613.28334-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series decouples the DSA platform data structures from
net/dsa.h which was getting used for all sorts of DSA related
structures.

It would probably make sense for this series to go via David's net-next
tree to avoid conflicts on the ARM part, since we cannot obviously
include a header that does not yet exist.

No functional changes intended.

Florian Fainelli (3):
  net: dsa: Split platform data to header file
  ARM: orion5x: Include platform_data/dsa.h
  net: dsa: Include platform_data header file

 MAINTAINERS                                  |  1 +
 arch/arm/mach-orion5x/common.c               |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c |  2 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c  |  2 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c |  2 +-
 arch/arm/mach-orion5x/wnr854t-setup.c        |  2 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c     |  2 +-
 arch/arm/plat-orion/common.c                 |  2 +-
 include/linux/platform_data/b53.h            |  2 +-
 include/linux/platform_data/dsa.h            | 68 ++++++++++++++++++++
 include/linux/platform_data/mv88e6xxx.h      |  2 +-
 include/net/dsa.h                            | 61 +-----------------
 12 files changed, 79 insertions(+), 69 deletions(-)
 create mode 100644 include/linux/platform_data/dsa.h

-- 
2.17.1

