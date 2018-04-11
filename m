Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeDKOig (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:38:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50559 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbeDKOie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:38:34 -0400
X-Google-Smtp-Source: AIpwx4+ZMFf+VtB9jDNWUedQ+uSDCVHf+QwUdc1I0zeY+bZeh7rCgAcPEmET3z/cnwHbEKkUeFfqVQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>, Sven Van Asbroeck <svendev@arcx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/3] eeprom: at24: last bits of the big refactoring
Date: Wed, 11 Apr 2018 16:38:25 +0200
Message-Id: <20180411143828.1046-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to the big series merged for 4.17. The patches
contain some bits and pieces that were missing in the last submission
or depend on some new features merged this merge window.

v1 -> v2:
- dropped patch 1/4 because id_table is still needed as pointed out by
  Peter Rosin
- fixed patch 3/3: we need to free the dummy client if regmap_init fails

Bartosz Golaszewski (3):
  eeprom: at24: use devm_nvmem_register()
  eeprom: at24: provide and use a helper for releasing dummy i2c clients
  eeprom: at24: provide a separate routine for creating dummy i2c
    clients

 drivers/misc/eeprom/at24.c | 71 ++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 25 deletions(-)

-- 
2.17.0
