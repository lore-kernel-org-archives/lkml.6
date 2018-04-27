Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758638AbeD0QF0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:05:26 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43340 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758550AbeD0QFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:05:23 -0400
X-Google-Smtp-Source: AB8JxZqGOQ2IkZjXF4ToUsAgLaXsR50ZDF7KqLY5DpDd3stcYjvdAoQDUW2QorvZf4b8mk94FiWThg==
From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To: lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/4] mfd: max8998: Device Tree support fixes
Date: Fri, 27 Apr 2018 18:02:58 +0200
Message-Id: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series compose of 4 patches.

First patch, fixes platform data retrieval issue in max8998 regulator
driver, which could cause NULL pointer dereference.

Second patch, fixes platform data retrieval issue in max8998 charger
driver, which could cause NULL pointer dereference.

Third patch, updates max8998 charger driver, so it's possible to parse
devicetree for configuration.

Fourth patch, updates max8998 documentation, so it includes new node 
and properties, needed for charger.

All patches has been tested on (not yet mainlined), an S5PV210 based
Samsung Galaxy S (i9000) phone.

Paweł Chmiel (3):
  regulator: max8998: Fix platform data retrieval.
  power: supply: max8998-charger: Parse device tree for required data.
  dt-bindings: mfd: max8998: Add charger subnode binding

Tomasz Figa (1):
  power: supply: max8998-charger: Fix platform data retrieval

 Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++
 drivers/power/supply/max8998_charger.c            | 52 ++++++++++++++++++++++-
 drivers/regulator/max8998.c                       |  3 +-
 3 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.7.4
