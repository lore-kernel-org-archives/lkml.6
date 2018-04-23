Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755092AbeDWMl5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 08:41:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46396 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754954AbeDWMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 08:41:54 -0400
X-Google-Smtp-Source: AB8JxZoXOriIofPSaXLn0GgV7I89V4WfkzxqnlNbSI6rb3TFjx9tzFt/506BDsKzbyfShqGKcz55FA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] nvmem: meson-efuse: add write support
Date: Mon, 23 Apr 2018 14:41:46 +0200
Message-Id: <20180423124149.3077-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds write support to meson efuse driver.
The first patch just changes the way the nvmem data are allocated w/o
any functional changes. The second patches actually adds write support.

The memory being an OTP, it is safer if it remains read-only by default,
which is why I also submitted this DT patch [0]. It has now been merged by
Kevin.

If a user knows what he is doing, it should be easy to remove the
read-only property from the board DT. This can be done in u-boot, before
starting linux:

 > fdt rm /efuse read-only

Tested on the gxl libretech-cc

Changes since v1 [1]:
 - Remove un-necessary code in callbacks
 - Rebase on v4.17-rc1

[0]: https://lkml.kernel.org/r/20180316145021.8517-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180316150113.9779-1-jbrunet@baylibre.com

Jerome Brunet (3):
  nvmem: meson-efuse: remove econfig global
  nvmem: meson-efuse: simplify read callback
  nvmem: meson-efuse: add write support

 drivers/nvmem/meson-efuse.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

-- 
2.14.3
