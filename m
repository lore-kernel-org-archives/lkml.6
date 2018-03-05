Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeCELqA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:46:00 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43489 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933014AbeCELp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:45:57 -0500
X-Google-Smtp-Source: AG47ELvfa9m1fdQqi698yuoGwasaFW/fzDM4RsVuEOOChWuTX7uoqPVrTic2qboRPqqMk5ZeFX7JuA==
From: Joel Stanley <joel@jms.id.au>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 0/2] watchdog: Add Nuvoton NPCM (Poleg) driver
Date: Mon,  5 Mar 2018 22:15:39 +1030
Message-Id: <20180305114541.9917-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Address comments from Guenter and Marcus

This is a driver for the Poleg board that is in the process of being
upstreamed. I have tested it on an evaluation board.

The watchdog is a single register inside of the timer IP. This made me
think about how to describe the device tree bindings for a while, but
after some discussion I settled on describing the watchdog separately,
and giving it's own compatible string, and it's own driver.

The timer is being reviewed over here:

 https://lkml.org/lkml/2018/2/26/492

Joel Stanley (2):
  dt-bindings: watchdog: Add Nuvoton NPCM description
  watchdog: Add Nuvoton NPCM watchdog driver

 .../bindings/watchdog/nuvoton,npcm-wdt.txt         |  28 +++
 drivers/watchdog/Kconfig                           |  11 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/npcm_wdt.c                        | 230 +++++++++++++++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
 create mode 100644 drivers/watchdog/npcm_wdt.c

-- 
2.15.1
