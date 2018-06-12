Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A10D6C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362F1208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kw2eC/MF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362F1208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934289AbeFLACo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:02:44 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44728 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934163AbeFLACY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:02:24 -0400
Received: by mail-pg0-f49.google.com with SMTP id p21-v6so10529825pgd.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azk97IP073KKmknfWgLfxCsxBoD/Z2CSCOoIkQhylqI=;
        b=kw2eC/MFQi5lr7uHLwbFP6AQSVANv9bWabGzYsddmtXdnRG/bTWhZudkv7p1E3pCif
         QwmztiwLKcoGq7zpzcV9A2zq7FkNib19a/EZdmcz7xL+2FiElOdVS7wa3NIR/ntxtZKd
         jBfbGFQYDsVUHcJ/LCM7Vi9np9MaIElmD3SG2Fdkf4oCb2GfgpDwhXEQ4WoqeMfPKnP3
         hqRyx9k8xw6MiVYZW5xovG2mGk/lQPNlpZRVrqkBpsoPEXgQgw5dKP72346jeeuSVICf
         8PZP6uSp0oKKiBx3ouNg0w6J7roKqpH9kHfdFMVYvRLZkJLFGjtgxyzcws7IP8dTOHdU
         +DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azk97IP073KKmknfWgLfxCsxBoD/Z2CSCOoIkQhylqI=;
        b=TJnRmKzIvZCVHOOPdMSy3P1bRg+zGdTPLUSshf/18ahq7aUEDsSNMvHnUI4NaSZX6Q
         prvF2D51lWk6LH8WjXycRzMf0OepizJc8mIr+p/JiHBgKnDPP7YjyyFRWnhedinzxlJt
         LgkiyukFEUbBpr7NXNoehwt/IVjJSY6HhkfHCiQEGuNLoWeM+XALFoKCJBuoQUoxSTCb
         1G6PKCFZKVC6CQVjmZnwu9p9OFHieL7oOSb4/6GhD5KAJhJfUj5wryW9gVjFXvpFEHi9
         lP1UcCmDvh8WsfIJ9ZZJJMIJ4/J1eYzMB4jjhj87Rfti9Py6VInG2T0TgEcLxSUAAFoM
         3kWA==
X-Gm-Message-State: APt69E27HS2S7Ef3RsGCuyve2n+aEKGZbkimzIKKQt81hg66ljl3J0so
        UeHNFvpOLVtGmgERl8QQwHRy9g==
X-Google-Smtp-Source: ADUXVKJ+GhR0+8udcVZpZL3ljQOwpee7buPEvDcgLxPHpNRETMVBdGCTZ/bVS1fxjqJmxCUObkYqcg==
X-Received: by 2002:a62:1282:: with SMTP id 2-v6mr1231101pfs.243.1528761743428;
        Mon, 11 Jun 2018 17:02:23 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id c27-v6sm82016623pfl.63.2018.06.11.17.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 17:02:20 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: SoC: late updates
Date:   Mon, 11 Jun 2018 17:01:42 -0700
Message-Id: <20180612000142.28883-5-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180612000142.28883-1-olof@lixom.net>
References: <20180612000142.28883-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a branch with a few merge requests that either came in late, or
took a while longer for us to review and merge than usual and thus cut
it a bit close to the merge window. We stage them in a separate branch
and if things look good, we still send them up -- and that's the case
here.

This is mostly DT additions for Renesas platforms, adding IP block
descriptions for existing and new SoCs.

There are also some driver updates for Qualcomm platforms for SMEM/QMI
and GENI, which is their generalized serial protocol interface.


Conflicts: None

----------------------------------------------------------------

The following changes since commit be27adaf4994b312165150f1340efa367963f587:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

for you to fetch changes up to 14321604c82c5415a72e894b83b587a345f5bdf2:

  Merge tag 'renesas-dt-for-v4.18' of https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/late

----------------------------------------------------------------

Alex Elder (8):
      soc: qcom: smem: fix first cache entry calculation
      soc: qcom: smem: return proper type for cached entry functions
      soc: qcom: smem: byte swap values properly
      soc: qcom: smem: fix off-by-one error in qcom_smem_alloc_private()
      soc: qcom: smem: fix qcom_smem_set_global_partition()
      soc: qcom: smem: check sooner in qcom_smem_set_global_partition()
      soc: qcom: qmi: fix a buffer sizing bug
      soc: qcom: smem: introduce qcom_smem_virt_to_phys()

Biju Das (8):
      ARM: dts: r8a77470: Initial SoC device tree
      ARM: dts: iwg23s-sbc: Add support for iWave G23S-SBC based on RZ/G1C
      ARM: dts: r8a77470: Add SYS-DMAC support
      ARM: dts: r8a77470: Add IRQC support
      ARM: dts: r8a77470: Add SCIF support
      ARM: dts: r8a77470: Add SCIF DMA support
      ARM: dts: r8a77470: Add EtherAVB support
      ARM: dts: iwg23s-sbc: Add EtherAVB support

Bjorn Andersson (1):
      soc: qcom: smd-rpm: Add msm8998 compatible

Chris Brandt (1):
      ARM: dts: r7s72100: add USB device to device tree

Fabrizio Castro (14):
      ARM: dts: r8a7743: Adjust SMP routine size
      ARM: dts: r8a7745: Adjust SMP routine size
      ARM: dts: r8a7790: Adjust SMP routine size
      ARM: dts: r8a7791: Adjust SMP routine size
      ARM: dts: r8a7792: Adjust SMP routine size
      ARM: dts: r8a7793: Adjust SMP routine size
      ARM: dts: r8a7794: Adjust SMP routine size
      ARM: dts: r8a7743: Add watchdog support to SoC dtsi
      ARM: dts: r8a7745: Add watchdog support to SoC dtsi
      ARM: dts: r8a7790: Add watchdog support to SoC dtsi
      ARM: dts: r8a7791: Add watchdog support to SoC dtsi
      ARM: dts: r8a7794: Add watchdog support to SoC dtsi
      ARM: dts: iwg20m: Add watchdog support to SoM dtsi
      ARM: dts: iwg22m: Add watchdog support to SoM dtsi

Geert Uytterhoeven (35):
      ARM: dts: r8a7792: Add RWDT node
      ARM: dts: r8a7793: Add RWDT node
      ARM: dts: lager: Enable watchdog support
      ARM: dts: koelsch: Enable watchdog support
      ARM: dts: porter: Enable watchdog support
      ARM: dts: blanche: Enable watchdog support
      ARM: dts: wheat: Enable watchdog support
      ARM: dts: gose: Enable watchdog support
      ARM: dts: alt: Enable watchdog support
      ARM: dts: silk: Enable watchdog support
      ARM: dts: r8a7790: Correct mask for GIC PPI interrupts
      ARM: dts: r8a73a4: Correct mask for GIC PPI interrupts
      ARM: dts: sh73a0: Add missing interrupt-affinity to PMU node
      ARM: dts: emev2: Add missing interrupt-affinity to PMU node
      ARM: dts: r7s72100: Correct watchdog timer interrupt type
      ARM: dts: r7s72100: Correct RTC interrupt types
      ARM: dts: r7s72100: Add PMU device node
      ARM: dts: r8a7790: Add PMU device nodes
      ARM: dts: r8a7791: Add PMU device node
      ARM: dts: r8a7792: Add PMU device node
      ARM: dts: r8a7793: Add PMU device node
      ARM: dts: r8a7794: Add PMU device node
      ARM: dts: r8a7743: Add PMU device node
      ARM: dts: r8a7745: Add PMU device node
      arm64: dts: renesas: draak: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: salvator-common: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: ulcb: Rename EtherAVB "mdc" pin group to "mdio"
      arm64: dts: renesas: r8a7795: Correct whitespace
      arm64: dts: renesas: r8a7796: Correct whitespace
      arm64: dts: renesas: r8a77965: Correct whitespace
      arm64: dts: renesas: ulcb: Add BD9571 PMIC
      arm64: dts: renesas: salvator-common: Add PMIC DDR Backup Power config
      arm64: dts: renesas: ulcb: Add PMIC DDR Backup Power config
      arm64: dts: renesas: r8a77970: Add secondary CA53 CPU core
      arm64: dts: renesas: r8a77970: Add Cortex-A53 PMU node

Guenter Roeck (1):
      soc: Unconditionally include qcom Makefile

Jacopo Mondi (4):
      ARM: dts: r7s72100: Add Capture Engine Unit (CEU)
      arm64: dts: renesas: eagle: Enable HDMI output
      arm64: dts: renesas: r8a77995: Add VIN4
      ARM: dts: r8a7740: Add CEU0

Karthikeyan Ramasubramanian (1):
      soc: qcom: Add GENI based QUP Wrapper driver

Kieran Bingham (9):
      ARM: dts: wheat: Fix ADV7513 address usage
      ARM: dts: r8a7790: Fix sort order of VSP1/FDP1 nodes
      arm64: dts: renesas: r8a77965: Add FCPF and FCPV instances
      arm64: dts: renesas: r8a77965: Add VSP instances
      arm64: dts: renesas: r8a77965: Populate the DU instance placeholder
      arm64: dts: renesas: r8a77965: Add HDMI encoder instance
      arm64: dts: renesas: r8a77965-salvator-x: Enable DU external clocks and HDMI
      arm64: dts: renesas: r8a77965-salvator-xs: Enable DU external clocks and HDMI
      arm64: dts: renesas: salvator-common: Add ADV7482 support

Kuninori Morimoto (8):
      arm64: dts: renesas: r8a7795: add HDMI sound support
      arm64: dts: renesas: r8a7796: add HDMI sound support
      arm64: dts: renesas: salvator-common: use audio-graph-card for Sound
      arm64: dts: renesas: r8a7795-es1-salvator-x: enable HDMI sound
      arm64: dts: renesas: r8a7795-salvator-xs: enable HDMI sound
      arm64: dts: renesas: r8a7796-salvator-xs: enable HDMI sound
      arm64: dts: renesas: r8a7795-salvator-x: enable HDMI sound
      arm64: dts: renesas: r8a7796-salvator-x: enable HDMI sound

Laurent Pinchart (4):
      ARM: dts: renesas: r8a7791: Add FDP1 instances
      ARM: dts: renesas: r8a7793: Add FDP1 instances
      ARM: dts: renesas: r8a7794: Add FDP1 instances
      ARM: dts: renesas: r8a7790: Add FDP1 instances

Magnus Damm (5):
      arm64: dts: renesas: r8a77970: Update IPMMU DS1 bit number
      arm64: dts: renesas: r8a7795: Enable IPMMU devices
      arm64: dts: renesas: r8a7796: Enable IPMMU devices
      arm64: dts: renesas: r8a77970: Enable IPMMU devices
      arm64: dts: renesas: r8a77995: Enable IPMMU devices

Mahesh Sivasubramanian (1):
      drivers: qcom: add command DB driver

Masahiro Yamada (1):
      ARM: dts: renesas: replace toshiba, mmc-wrprotect-disable with disable-wp

Niklas Cassel (1):
      MAINTAINERS: Update pattern for qcom_scm

Niklas Söderlund (11):
      arm64: dts: renesas: r8a7795: decrease temperature hysteresis
      arm64: dts: renesas: r8a7796: decrease temperature hysteresis
      arm64: dts: renesas: r8a77965: use r8a77965-sysc binding definitions
      arm64: dts: renesas: r8a77965: Add R-Car Gen3 thermal support
      arm64: dts: renesas: r8a77965: add I2C support
      arm64: dts: renesas: r8a7795: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a7795-es1: add CSI-2 node
      arm64: dts: renesas: r8a7796: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a77965: add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a77970: add VIN and CSI-2 nodes
      arm64: dts: renesas: salvator-common: enable VIN

Olof Johansson (3):
      Merge tag 'qcom-drivers-for-4.18' of git://git.kernel.org/.../agross/linux into next/late
      Merge tag 'renesas-arm64-dt-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/late
      Merge tag 'renesas-dt-for-v4.18' of https://git.kernel.org/.../horms/renesas into next/late

Sergei Shtylyov (21):
      arm64: dts: renesas: r8a77970: add FCPVD support
      arm64: dts: renesas: r8a77970: add VSPD support
      arm64: dts: renesas: r8a77970: add DU support
      arm64: dts: renesas: r8a77970: add LVDS support
      arm64: dts: renesas: eagle: add EtherAVB pins
      arm64: dts: renesas: v3msk: add EtherAVB pins
      arm64: dts: renesas: r8a77980: add PFC support
      arm64: dts: renesas: condor: add SCIF0 pins
      arm64: dts: renesas: condor: add EtherAVB pins
      arm64: dts: renesas: r8a77980: add MMC support
      arm64: dts: renesas: condor: add eMMC support
      arm64: dts: renesas: v3msk: add DU/LVDS/HDMI support
      arm64: dts: renesas: r8a77980: use CPG core clock macros
      arm64: dts: renesas: r8a77980: use SYSC power domain macros
      arm64: dts: renesas: r8a77970: add CAN-FD support
      arm64: dts: renesas: eagle: add CAN-FD support
      arm64: dts: renesas: r8a77980: add CAN-FD support
      arm64: dts: renesas: condor: add CAN-FD support
      arm64: dts: renesas: r8a77970: disable EtherAVB
      arm64: dts: renesas: r8a77980: disable EtherAVB
      arm64: dts: renesas: initial V3HSK board device tree

Simon Horman (21):
      ARM: dts: r7s72100: add soc node
      ARM: dts: r7s72100: sort subnodes of soc node
      ARM: dts: r7s72100: stop grouping clocks under a "clocks" subnode
      ARM: dts: r7s72100: sort subnodes of root node
      arm64: dts: renesas: r8a7796: sort subnodes of the root node
      arm64: dts: renesas: r8a7796: sort subnodes of the soc node
      arm64: dts: renesas: r8a7795: sort subnodes of the root node
      arm64: dts: renesas: r8a7795: sort subnodes of the soc node
      ARM: dts: lager: Drop unnecessary address properties from port node
      ARM: dts: porter: Drop unnecessary address properties from vin port node
      ARM: dts: gose: Drop unnecessary address properties from port nodes
      ARM: dts: koelsch: Drop unnecessary address properties from port nodes
      ARM: dts: alt: Drop unnecessary address properties from vin port node
      ARM: dts: silk: Drop unnecessary address properties from vin port node
      ARM: dts: kzm9d: Drop unnecessary address properties from gpio_keys node
      arm64: dts: renesas: r8a7795-es1: Enable IPMMU devices
      arm64: dts: renesas: r8a7795: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a7796: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a77965: Add address properties to rcar_sound port nodes
      arm64: dts: renesas: r8a77980: add resets property to CAN-FD node
      ARM: dts: r8a7740: Add CEU1

Sricharan R (1):
      firmware: qcom: scm: Add ipq4019 soc compatible

Stephen Boyd (1):
      soc: qcom: cmd-db: Make endian-agnostic

Takeshi Kihara (3):
      arm64: dts: renesas: r8a77965: Add all MSIOF device nodes
      arm64: dts: renesas: Add Renesas Ebisu board support
      arm64: dts: renesas: r8a77965: Add SDHI device nodes

Wolfram Sang (2):
      ARM: shmobile: r8a7794: alt: add EEPROM to DTS
      arm64: dts: renesas: salvator-common: add eeprom

Yoshihiro Kaneko (5):
      arm64: dts: renesas: r8a77995: sort subnodes of the root node
      arm64: dts: renesas: r8a77995: sort subnodes of the soc node
      arm64: dts: renesas: r8a77965: sort subnodes of the root node
      arm64: dts: renesas: r8a77965: sort subnodes of the soc node
      arm64: dts: renesas: r8a77970: sort subnodes of the soc node

Yoshihiro Shimoda (19):
      arm64: dts: renesas: r8a77965: add usb2_phy nodes
      arm64: dts: renesas: r8a77965: add usb3_phy node
      arm64: dts: renesas: r8a77965: add USB 2.0 host nodes
      arm64: dts: renesas: r8a77965: add usb_dmac nodes
      arm64: dts: renesas: r8a77965: add HS-USB node
      arm64: dts: renesas: r8a77965: add USB 3.0 host node
      arm64: dts: renesas: r8a77965: add USB 3.0 peripheral node
      arm64: dts: renesas: r8a77965: Add PWM device nodes
      arm64: dts: renesas: Add Renesas R8A77990 Kconfig support
      arm64: dts: renesas: Add Renesas R8A77990 SoC support
      arm64: dts: renesas: r8a77990: Revise the psci node
      arm64: dts: renesas: r8a77990: Revise the cache controller node
      arm64: dts: renesas: r8a7795: salvator-xs: enable usb2_phy3 node
      arm64: dts: renesas: r8a7795: salvator-xs: enable hsusb channel 3 node
      arm64: dts: renesas: r8a7795: salvator-xs: enable USB2.0 host channel 3
      arm64: dts: renesas: r8a77990: Add PFC device node
      arm64: dts: renesas: r8a77990: Add GPIO device nodes
      arm64: dts: renesas: r8a77990: Add EthernetAVB device nodes
      arm64: dts: renesas: r8a77990: ebisu: Enable EthernetAVB


 .../devicetree/bindings/firmware/qcom,scm.txt   |    3 +-
 .../bindings/soc/qcom/qcom,smd-rpm.txt          |    1 +
 MAINTAINERS                                     |    2 +-
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/emev2-kzm9d.dts               |    3 -
 arch/arm/boot/dts/emev2.dtsi                    |    5 +-
 arch/arm/boot/dts/r7s72100.dtsi                 | 1038 ++++----
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |    4 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |   10 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |   18 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi           |    5 +
 arch/arm/boot/dts/r8a7743.dtsi                  |   19 +-
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi           |    5 +
 arch/arm/boot/dts/r8a7745.dtsi                  |   19 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts       |   48 +
 arch/arm/boot/dts/r8a77470.dtsi                 |  336 +++
 arch/arm/boot/dts/r8a7790-lager.dts             |    8 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |   67 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   11 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |    8 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |   37 +-
 arch/arm/boot/dts/r8a7792-blanche.dts           |    5 +
 arch/arm/boot/dts/r8a7792-wheat.dts             |   16 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |   19 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |   11 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |   37 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |   14 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |    8 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |   28 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |    9 +-
 arch/arm64/Kconfig.platforms                    |    6 +
 arch/arm64/boot/dts/renesas/Makefile            |    3 +-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts |   46 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi    |  144 +-
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |   46 +
 .../boot/dts/renesas/r8a7795-salvator-xs.dts    |   85 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        | 2499 ++++++++++--------
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |   28 +
 .../boot/dts/renesas/r8a7796-salvator-xs.dts    |   28 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        | 2395 ++++++++++-------
 .../boot/dts/renesas/r8a77965-salvator-x.dts    |   28 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts   |   28 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       | 1601 ++++++++---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts  |  116 +
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts  |  137 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |  661 +++--
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   81 +
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |   60 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |   99 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |   65 +
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |  281 ++
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |    2 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |  730 ++---
 .../arm64/boot/dts/renesas/salvator-common.dtsi |  187 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |   37 +-
 drivers/firmware/qcom_scm.c                     |    3 +
 drivers/of/platform.c                           |    1 +
 drivers/soc/Makefile                            |    2 +-
 drivers/soc/qcom/Kconfig                        |   18 +
 drivers/soc/qcom/Makefile                       |    2 +
 drivers/soc/qcom/cmd-db.c                       |  317 +++
 drivers/soc/qcom/qcom-geni-se.c                 |  748 ++++++
 drivers/soc/qcom/qmi_interface.c                |    5 +-
 drivers/soc/qcom/smd-rpm.c                      |    1 +
 drivers/soc/qcom/smem.c                         |   77 +-
 include/linux/qcom-geni-se.h                    |  425 +++
 include/linux/soc/qcom/smem.h                   |    2 +
 include/soc/qcom/cmd-db.h                       |   45 +
 68 files changed, 9184 insertions(+), 3650 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
 create mode 100644 arch/arm/boot/dts/r8a77470.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77990.dtsi
 create mode 100644 drivers/soc/qcom/cmd-db.c
 create mode 100644 drivers/soc/qcom/qcom-geni-se.c
 create mode 100644 include/linux/qcom-geni-se.h
 create mode 100644 include/soc/qcom/cmd-db.h
