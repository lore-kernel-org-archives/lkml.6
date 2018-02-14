Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031685AbeBNWHv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 17:07:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51790 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 17:07:49 -0500
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 0/4] Motorola Droid 4 Audio Support
Date: Wed, 14 Feb 2018 23:07:37 +0100
Message-Id: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.15.1
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
 - Modem / Bluetooth Audio (needs different DAI/I2S config)

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

Sebastian Reichel (4):
  dt-bindings: sound: add motorola,cpcap-audio-codec
  ASoC: codec: cpcap: new codec
  ARM: dts: motorola-cpcap-mapphone: add audio-codec
  ARM: dts: omap4-droid4: add soundcard

 .../bindings/sound/motorola,cpcap-audio-codec.txt  |   17 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |    5 +
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |   84 ++
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/cpcap.c                           | 1588 ++++++++++++++++++++
 6 files changed, 1701 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/motorola,cpcap-audio-codec.txt
 create mode 100644 sound/soc/codecs/cpcap.c

-- 
2.15.1
