Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeDDNQi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 09:16:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34855 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDDNQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 09:16:36 -0400
X-Google-Smtp-Source: AIpwx48dpVFL9BapUpL0vosDQLVm2eeDWf/wvSDENMs8XRxM47AbhIbZ4u5PSDVBh8lcj4g4xQQb5g==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/4] ARM: imx: use device properties for at24 eeprom
Date: Wed,  4 Apr 2018 15:16:23 +0200
Message-Id: <20180404131627.9135-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

This series converts all users of at24_platform_data to using generic
device properties or - as is the case with PATCH 1/4 - drops the
platform data entirely since it's not needed.

Bartosz Golaszewski (4):
  ARM: imx: vpr200: drop at24_platform_data
  ARM: imx: pcm043: use device properties for at24 eeprom
  ARM: imx: pca100: use device properties for at24 eeprom
  ARM: imx: pcm037: use device properties for at24 eeprom

 arch/arm/mach-imx/mach-pca100.c | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm037.c | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm043.c | 13 ++++++-------
 arch/arm/mach-imx/mach-vpr200.c |  9 +--------
 4 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.16.3
