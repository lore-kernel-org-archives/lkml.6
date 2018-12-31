Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C36C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1886F21783
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="O/gK0avf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeLaVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:47:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbeLaVrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:47:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so13041023pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzbID4cPz5p3YB+iynLwm/8n+8ZRTYuq7NL3iNt4c44=;
        b=O/gK0avfs3tvqXfiDlB5cB013b8KHkbDZj8o9oKz8EtMzIiu7ctdt27Cef2kbqVxUF
         D5HrvX0lPI+ccqpDpkG3+JhpaM4NS4z++JWCWyPzdldZ6xKUYM9QUmkqvtdkbVtMxMz3
         4SaIDQ449KV181+C1mU8YGR5k6jSWBftEy9D95eK212gzScp/yRg6ToVsRquySzbGH07
         eanrfMo8aOuGLwm0o+yy5QLtK5pRy0p6VRMiXNt81tk5UAck6c5YQpPNdcTIrjfXCh8G
         bG8WKlsAPuHiVGksCfIyfLGi3aCbNhtPu/IkQ2qEtxK7IrcKpj8l4xXv2uKAm/uHH/J2
         /0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzbID4cPz5p3YB+iynLwm/8n+8ZRTYuq7NL3iNt4c44=;
        b=cgIZzJUIFP6IjwrrHdeqMHiXimIny6IHu8bNsLTlh7Op6cPMYXyvusAMuRtz0J5ARB
         D3tLWYrUVycL1yD4Dj4UoWJn9s6+uiTPSlm3oOWVbnykU73HFwdvRupYmkKEceAsMIcu
         qUsC2PoVrGQ9uall00v9Y3MerF+s8fQ+Z3k2FwQpMt3cD/SSjajewfryIcrPM+viI7O+
         P14gX02lzT9SSHmyTEHibdW9edUPBCgw1CnMk2sLnGOcRPKPE/3sT0sprWsNUECv1gVD
         jvVwNP/WrT3NaqCGJXMuFbpML5DyRlLWUDa5E95fgLiAZBE5AwRUPaEM6qL2fV12G6MW
         udtg==
X-Gm-Message-State: AJcUukdx2jvyZL240gQkXtl+qg/ECYylvvRwL6rfWY3UisBiBv/RQSKV
        wu6mAZnm0cSkW/GFB3+5kyJqng==
X-Google-Smtp-Source: ALg8bN5KDybRvtW/y1g68pWrftpCN6yO0VOVkbbXW70XGsin7YP+Gsf0pj2fDYDKXYmQA664TQ3asA==
X-Received: by 2002:a63:7a09:: with SMTP id v9mr8812820pgc.112.1546292819781;
        Mon, 31 Dec 2018 13:46:59 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:46:58 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates
Date:   Mon, 31 Dec 2018 13:46:40 -0800
Message-Id: <20181231214640.17015-5-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231214640.17015-1-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most changes here are to enable new drivers and platforms in the various
configs that affect them. Most of these have been covered and described
in the other branches, we mostly keep defconfig separate to avoid
conflicts between SoC/dt/driver updates that they otherwise would be
grouped with.

One thing worth mentioning here is that OMAP changes from using their
own UART driver, to 8250, for the multi_v7_defconfig shared config on
32-bit. This means that the console is now named ttyS* instead of ttyO*.
This change was already done for omap2_defconfig a while back, so most
users of these configs have either already updated, or can easily follow
the same patterns as they did at that time. This makes platform support
slightly easier for distros, since they no longer need to keep track of
a separate console prefix for these platforms.

----------------------------------------------------------------

The following changes since commit f7f6260f0489617b49176f1b30e2cdd5c43e0918:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to 82c7b351be3fad005ba38a26f7f1ab7f0841e505:

  Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"

----------------------------------------------------------------

A.s. Dong (1):
      ARM: imx_v6_v7_defconfig: add imx7ulp support

Adam Ford (1):
      ARM: omap2plus_defconfig: Add tlv320aic23 as module

Alex Gonzalez (1):
      ARM: imx_v6_v7_defconfig: Select TOUCHSCREEN_GOODIX

Andreas Müller (2):
      ARM: imx_v6_v7_defconfig: Enable BT_BNEP
      ARM: imx_v6_v7_defconfig: Enable USB_ANNOUNCE_NEW_DEVICES

Bjorn Andersson (4):
      arm64: defconfig: Enable QCS404 configs
      arm64: defconfig: Enable some qcom remoteproc configs
      arm64: defconfig: Enable core Qualcomm SDM845 options
      arm64: defconfig: Enable GCC and PINCTRL for MSM8998

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select the PXP driver

Fabrice Gasnier (1):
      ARM: multi_v7_defconfig: enable STM32 analog & timer drivers

Fabrizio Castro (1):
      ARM: shmobile: defconfig: Enable SII902X

Horia Geantă (1):
      Revert "arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO"

Jagan Teki (4):
      arm64: defconfig: Enable MFD_AXP20X_I2C
      arm64: defconfig: Enable DRM_SUN8I_MIXER
      arm64: defconfig: Enable DRM_SUN8I_DW_HDMI
      arm64: defconfig: Enable PWM_SUN4I

Jan Tuerk (1):
      ARM: imx_v6_v7_defconfig: Enable DA9063 PMIC support

Leonard Crestez (1):
      ARM: imx_v6_v7_defconfig: Enable CRYPTO_DEV_MXS_DCP

Linus Walleij (2):
      ARM: defconfig: Update the vexpress defconfig
      ARM: defconfig: Enable the PL111 DRM driver on vexpress

Marc Gonzalez (3):
      arm64: defconfig: Regenerate for v4.20
      arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
      arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO

Marek Szyprowski (5):
      ARM: exynos_defconfig: Add MAX8998 RTC and charger drivers
      ARM: exynos_defconfig: Add MAX8952 regulator driver
      ARM: exynos_defconfig: Add TOSHIBA TC358764 bridge driver
      ARM: multi_v7_defconfig: Add MAX8952 regulator driver
      ARM: multi_v7_defconfig: Add TOSHIBA TC358764 bridge driver

Olof Johansson (7):
      Merge tag 'vexpress-defconfig-arm-soc' of git://git.kernel.org/.../linusw/linux-integrator into next/defconfig
      Merge tag 'omap-for-v4.21/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'qcom-arm64-defconfig-for-4.21' of git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'renesas-arm-defconfig-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'sunxi-config64-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/defconfig
      Merge tag 'samsung-defconfig-4.21' of https://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'imx-defconfig-4.21' of git://git.kernel.org/.../shawnguo/linux into next/defconfig

Otavio Salvador (1):
      ARM: imx_v6_v7_defconfig: Remove explicit ARM_UNWIND disable

Tony Lindgren (2):
      Merge branch 'omap-for-v4.20/defconfig' into omap-for-v4.21/defconfig
      ARM: multi_v7_defconfig: Enable 8250-omap serial driver and use it by default


 arch/arm/configs/exynos_defconfig    |   4 +
 arch/arm/configs/imx_v6_v7_defconfig |  10 ++-
 arch/arm/configs/multi_v7_defconfig  |  13 +++
 arch/arm/configs/omap2plus_defconfig |   1 +
 arch/arm/configs/shmobile_defconfig  |   1 +
 arch/arm/configs/vexpress_defconfig  |  24 ++----
 arch/arm64/configs/defconfig         | 128 ++++++++++++++++--------------
 7 files changed, 105 insertions(+), 76 deletions(-)
