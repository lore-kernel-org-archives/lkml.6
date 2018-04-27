Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758511AbeD0N4W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:56:22 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:51113 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758450AbeD0N4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:56:14 -0400
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC: <dannenberg@ti.com>, <afd@ti.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v2 0/3] ASoc: TAS6424: Add support for mute, standby, and faster power on
Date: Fri, 27 Apr 2018 15:55:46 +0200
Message-ID: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mute and standby pins are available on the codec. If they are connected, they
should be managed by the driver, instead of relying on gpio hogs or on the
initial state of the GPIOs.

This series also includes a patch to improve the start-up time of the channels
by disabling built-in DC diagnostics. Those diagnosdtics basically serve to
detect :
- wires shorted together
- wire shorted to ground or vbat
- wire disconnected
This is not useful for all platforms and the addition to the startup time is
quite noticeable (230ms). The diagnostics can be enabled/disabled using a
dedicated ALSA control.


Changes in v2:
- use a ALSA control to enable/disable the auto diagnostics instead of
  relying on a DTS property.
- fixed typos
- use gpios (plural) instead of gpio in the documentation of the bindings


Jean-Jacques Hiblot (3):
  ASoC: tas6424: Add support for the standby pin
  ASoC: tas6424: Add support for the mute pin
  ASoC: tas6424: Allow disabling auto diagnostics for faster power-on

 .../devicetree/bindings/sound/ti,tas6424.txt       |  2 +
 sound/soc/codecs/tas6424.c                         | 78 +++++++++++++++++++++-
 sound/soc/codecs/tas6424.h                         |  4 ++
 3 files changed, 81 insertions(+), 3 deletions(-)

-- 
2.7.4
