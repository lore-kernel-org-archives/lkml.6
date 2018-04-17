Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeDQMwd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:52:33 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:34430 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752087AbeDQMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:52:31 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="277046813"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Chen-Yu Tsai <wens@csie.org>, Rajendra Nayak <rnayak@codeaurora.org>,
        Juri Lelli <juri.lelli@arm.com>, Carlo Caione <carlo@endlessm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] Renesas RZ/N1D SMP enabler
Date: Tue, 17 Apr 2018 13:47:59 +0100
Message-Id: <1523969291-41756-1-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*WARNING -- this requires the base RZ/N1 base patches (v5) already posted

This patch series is for enabling the second CA7 of the RZ/N1D.
It's based on a spin_table method, and it reuses the same binding
property as that driver.

v2:
  + Added suggestions from Florian Fainelli
  + Use __pa_symbol()
  + Simplified logic in prepare_cpu()
  + Reordered the patches
  + Rebased on RZN1 Base patch v5

*** BLURB HERE ***

Michel Pollet (3):
  dt-bindings: cpu: Add Renesas RZ/N1D SMP enable method.
  arm: shmobile: Add the RZ/N1D SMP enabler driver
  ARM: dts: Renesas RZ/N1D SMP enable method

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r9a06g032.dtsi               |  2 +
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c         | 85 ++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

-- 
2.7.4
