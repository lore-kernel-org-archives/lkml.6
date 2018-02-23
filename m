Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755044AbeBWUDH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:03:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38220 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbeBWUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:04 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv5 0/5] Motorola Droid 4 Audio Support
Date: Fri, 23 Feb 2018 21:02:49 +0100
Message-Id: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds audio support to Motorola Droid 4. I dropped the
regulator from the DT binding as requested by Mark.

Tested:
 - Playing via both DACs using Speaker, Earpiece, Headphone
 - Recording using internal Mic
 - Volume Controls

Known not to work:
 - 3.5mm detection support (requires closed source firmware,
   needs further investigation)
 - Modem / Bluetooth Audio (this needs something more sophisticated
   than the audio-graph-card driver. I will have a look once
   the basic support has been merged)

Changes since PATCHv4:
 * Replace verbose GPL text with SPDX header
 * Use "GPL v2" as MODULE_LICENSE
 * Drop "default MFD_CPCAP" for the codec driver
 * Use SOC_SINGLE instead of SOC_ENUM for Phase invert switches
 * Find DT node by node name instead of by compatible property
  - Drop Acked-by from Rob Herring
 * Add new patch for MFD driver to implement the mentioned
   DT change

Changes since PATCHv3:
 * Drop regulator from DT binding, request VAUDIO from
   global regulator namespace instead

Changes since PATCHv2:
 * Fix a whitespace issue
 * Fix const notes Takashi provided
 * Fix a DAPM route issue I accidently introduced in v2

Changes since PATCHv1:
 * Add patch from Tony exporting soc_dpcm_runtime_update
 * Integrate DT patch for vaudio initial mode
 * Split dt-binding from codec patch and add Ack from Rob
 * Fix CPCAP position in Kconfig/Makefile
 * Avoid "err +=" constructs
 * Simplify reset function
 * Drop cpcap_audio_read/write helpers
 * Do not use tertiary operator for mute register value
 * Update Input Mux logic
 * Switch from simple-audio-card to audio-graph-card

-- Sebastian

Sebastian Reichel (5):
  dt-bindings: mfd: motorola-cpcap: document audio-codec
  ASoC: codec: cpcap: new codec
  mfd: motorola-cpcap: Add audio-codec support
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: omap4-droid4: add soundcard

 .../devicetree/bindings/mfd/motorola-cpcap.txt     |   42 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   13 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   78 +
 drivers/mfd/motorola-cpcap.c                       |   51 +-
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1568 ++++++++++++++++++++
 7 files changed, 1757 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.16.1
