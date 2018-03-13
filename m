Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCMGRn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:17:43 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38357 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751217AbeCMGRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:17:41 -0400
X-Google-Smtp-Source: AG47ELsAtQdjFCtyIJxEEhbT5iy6PC0arrD58gVv3sKS80JOMxdRvbKyvrbM86C7YHilB+3scL51Nw==
From: Joel Stanley <joel@jms.id.au>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v4 0/2] watchdog: Add Nuvoton NPCM (Poleg) driver
Date: Tue, 13 Mar 2018 16:47:24 +1030
Message-Id: <20180313061726.21601-1-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: Fix comments from Guenter
v3: Address comments from Guenter and Tomer, add Rob's review
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
 drivers/watchdog/npcm_wdt.c                        | 254 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt
 create mode 100644 drivers/watchdog/npcm_wdt.c

-- 
2.15.1
