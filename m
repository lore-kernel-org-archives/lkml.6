Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeEUN3O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:29:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55729 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeEUN3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:29:09 -0400
X-Google-Smtp-Source: AB8JxZoVT/gWJGd7cKZ0Iv5HCzyzCiMVNGvadtW8nXetAVnWBZIMBXUc4ylX8Mh6Gmt28n1sxdDkHw==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org, michal.vokac@ysoft.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 0/7] Add support for QCA8334 switch
Date: Mon, 21 May 2018 15:28:06 +0200
Message-Id: <1526909293-56377-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series basically adds support for a QCA8334 ethernet switch to the
qca8k driver. It is a four-port variant of the already supported seven
port QCA8337. Register map is the same for the whole familly and all chips
have the same device ID.

Major part of this series enhances the CPU port setting. Currently the CPU
port is not set to any sensible defaults compatible with the xGMII
interface. This series forces the CPU port to its maximum bandwidth and
also allows to adjust the new defaults using fixed-link device tree
sub-node.

Alongside these changes I fixed two checkpatch warnings regarding SPDX and
redundant parentheses.

Michal Vokáč (7):
  net: dsa: qca8k: Add QCA8334 binding documentation
  net: dsa: qca8k: Add support for QCA8334 switch
  net: dsa: qca8k: Enable RXMAC when bringing up a port
  net: dsa: qca8k: Force CPU port to its highest bandwidth
  net: dsa: qca8k: Allow overwriting CPU port setting
  net: dsa: qca8k: Replace GPL boilerplate by SPDX
  net: dsa: qca8k: Remove rudundant parentheses

 .../devicetree/bindings/net/dsa/qca8k.txt          |  5 +-
 drivers/net/dsa/qca8k.c                            | 64 ++++++++++++++++++----
 drivers/net/dsa/qca8k.h                            |  7 ++-
 3 files changed, 61 insertions(+), 15 deletions(-)

-- 
2.1.4
