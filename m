Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeCRRWt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 13:22:49 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:41227 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeCRRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 13:22:47 -0400
X-Google-Smtp-Source: AG47ELu9l8ePTj8OW4+4Ssa7mSfDwO3itm4CLnInZCltWEaFe8KG8dJ8U8UNcP9H93RoHwmujpQsHg==
From: Matt Porter <mporter@konsulko.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] TDA7419 audio processor driver
Date: Sun, 18 Mar 2018 13:22:36 -0400
Message-Id: <20180318172238.9795-1-mporter@konsulko.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an ASoC component driver for the ST TDA7419 audio
processor which is commonly used in automotive audio applications.
The datasheet can be found at
http://www.st.com/resource/en/datasheet/tda7419.pdf

Changes since v1:
	* add supply and mute gpios to binding
	* remove writeable register, already the default
	* add "Switch" to all switch controls
	* move register default reset to probe and comment
	* rework part-specific volume handling to handle register
	  power-on default values
	* remove custom register init values
	* add audio route pins to binding
	* add DAPM support

Matt Porter (2):
  ASoC: add tda7419 audio processor binding
  ASoC: add tda7419 audio processor driver

 .../devicetree/bindings/sound/tda7419.txt          |  38 ++
 sound/soc/codecs/Kconfig                           |   6 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tda7419.c                         | 654 +++++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
 create mode 100644 sound/soc/codecs/tda7419.c

-- 
2.11.0
