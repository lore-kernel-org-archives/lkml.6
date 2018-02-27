Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeB0VZA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:25:00 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39256 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751689AbeB0VY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:24:57 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v1 0/4] ASoC: Add support for DAC PCM1789
Date: Tue, 27 Feb 2018 22:24:29 +0100
Message-Id: <20180227212433.2189-1-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

You will find in this series the support of Texas Instrument's DAC
PCM1789.
This DAC is very minimalist and is similar to PCM1792a except for
some differences in registers.
Series based on asoc tree, "for-next" branch (last commit 130c3888dfdc).

It is important to notice that this DAC needs to always have clocks
enabled (even without any data) otherwise it will be in a "desynchronized"
state and can not send data correctly.
This issue has been solved by performing a reset each time a sound
is played (see patch 04). This reset can produce a "pop" noise.

Thank you in advance for any review.

Best regards,
Mylène

Mylène Josserand (4):
  ASoC: codecs: pcm179x: Add PCM1789 id
  ASoC: codecs: pcm179x: Add support for PCM1789
  ASoC: codecs: pcm179x: Add reset gpio
  ASoC: codecs: pcm179x: Add trigger function to perform a reset

 .../devicetree/bindings/sound/pcm179x.txt          |   2 +-
 sound/soc/codecs/pcm179x-i2c.c                     |  17 +-
 sound/soc/codecs/pcm179x.c                         | 242 ++++++++++++++++++++-
 sound/soc/codecs/pcm179x.h                         |  10 +-
 4 files changed, 264 insertions(+), 7 deletions(-)

-- 
2.11.0
