Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeCPPBT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 11:01:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38218 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCPPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 11:01:17 -0400
X-Google-Smtp-Source: AG47ELviUsVKnv+3KFYXMwIjaR/dH1AiwAgzD4siaoDxEyNMOajwsyy3ZO96coGxbFEtCdOZ4ConMA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nvmem: meson-efuse: add write support
Date: Fri, 16 Mar 2018 16:01:11 +0100
Message-Id: <20180316150113.9779-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changeset adds write support to meson efuse driver.
The first patch just changes the way the nvmem data are allocated w/o
any functional changes. The second patches actually adds write support.

The memory being an OTP, it is safer if it remains read-only by default,
which is why I also submitted this DT patch [0].

If a user knows what he is doing, it should be easy to remove the
read-only property from the board DT. This can be done in u-boot, before
starting linux:

 > fdt rm /efuse read-only

Tested on the gxl libretech-cc

[0]: https://lkml.kernel.org/r/20180316145021.8517-1-jbrunet@baylibre.com

Jerome Brunet (2):
  nvmem: meson-efuse: remove econfig global
  nvmem: meson-efuse: add write support

 drivers/nvmem/meson-efuse.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

-- 
2.14.3
