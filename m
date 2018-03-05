Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934919AbeCEMst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:48:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56161 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933451AbeCEMsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:48:45 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: [PATCH v2 0/2] ASoC: Add support for DAC PCM1789
Date: Mon,  5 Mar 2018 13:48:15 +0100
Message-Id: <20180305124817.7421-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

The current series is the second version to add the support of Texas
Instrument's DAC PCM1789. This DAC is very minimalist and does
not have many registers.

It is important to notice that this DAC needs to always have clocks
enabled (even without any data) otherwise it will be in a "desynchronized"
state and can not send data correctly.
This issue has been solved by performing a reset each time a sound
is played. This reset can produce a "pop" noise.

Depending on your DAI, you will need to provide and enable the MCLK
to be able to communicate with this codec throught i2c.

Changes since v1:
	- Create a new file to support pcm1789 instead of converting the
	existing pcm179x driver. All the patches are merged into one patch.
	- Update the code to use gpiod for the reset.
	- Add some fixes according to Thomas Petazzoni's reviews
	- Create a new patch to add device-tree bindings for this new DAC.

Thank you in advance for any review.

Best regards,
Mylène

Mylène Josserand (2):
  ASoC: codecs: Add support for PCM1789
  ASoC: Add bindings for PCM1789

 .../devicetree/bindings/sound/pcm1789.txt          |  21 ++
 sound/soc/codecs/Kconfig                           |  12 +
 sound/soc/codecs/Makefile                          |   4 +
 sound/soc/codecs/pcm1789-i2c.c                     |  76 ++++++
 sound/soc/codecs/pcm1789.c                         | 288 +++++++++++++++++++++
 sound/soc/codecs/pcm1789.h                         |  28 ++
 6 files changed, 429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt
 create mode 100644 sound/soc/codecs/pcm1789-i2c.c
 create mode 100644 sound/soc/codecs/pcm1789.c
 create mode 100644 sound/soc/codecs/pcm1789.h

-- 
2.11.0
