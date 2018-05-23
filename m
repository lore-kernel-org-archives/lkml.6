Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeEWGVR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:21:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40618 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbeEWGVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:21:13 -0400
X-Google-Smtp-Source: AB8JxZpa4lRrmxkuLd2r2CoKZRrgbcb6mFp8cYvt+K1r7wg1uJpcaLeKmWhPbIR40jggLtE9siVtZQ==
From: "=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?=" <vokac.m@gmail.com>
X-Google-Original-From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com,
        andrew@lunn.ch, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, michal.vokac@ysoft.com
Subject: [PATCH net-next v3 0/7] Add support for QCA8334 switch
Date: Wed, 23 May 2018 08:20:17 +0200
Message-Id: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.7.4
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

Changes in v3:
 - Rebased on latest net-next/master.
 - Corrected fixed-link documentation.

Michal Vokáč (7):
  net: dsa: qca8k: Add QCA8334 binding documentation
  net: dsa: qca8k: Add support for QCA8334 switch
  net: dsa: qca8k: Enable RXMAC when bringing up a port
  net: dsa: qca8k: Force CPU port to its highest bandwidth
  net: dsa: qca8k: Allow overwriting CPU port setting
  net: dsa: qca8k: Replace GPL boilerplate by SPDX
  net: dsa: qca8k: Remove redundant parentheses

 .../devicetree/bindings/net/dsa/qca8k.txt          | 23 +++++++-
 drivers/net/dsa/qca8k.c                            | 64 ++++++++++++++++++----
 drivers/net/dsa/qca8k.h                            |  7 ++-
 3 files changed, 79 insertions(+), 15 deletions(-)

-- 
2.7.4
