Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965041AbeEIPjt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:39:49 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36122 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935379AbeEIPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:39:47 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 0/3] net: dsa: mv88e6xxx: cleanup Global Control 2 register
Date: Wed,  9 May 2018 11:38:48 -0400
Message-Id: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mv88e6xxx driver still writes arbitrary values in the Global 1
Control 2 register at setup, which layout differs a lot between chips.
This results in an inconsistent configuration, for example with the
Remote Management Unit (RMU).

The first patch adds an operation for the Cascade Port bits, the second
patch sets the device number in the device mapping function and the
third patch adds an operation to correctly disable the RMU.

Vivien Didelot (3):
  net: dsa: mv88e6xxx: add a cascade port op
  net: dsa: mv88e6xxx: set device number
  net: dsa: mv88e6xxx: add RMU disable op

 drivers/net/dsa/mv88e6xxx/chip.c    | 45 ++++++++++++++++++++++-----
 drivers/net/dsa/mv88e6xxx/chip.h    |  9 ++++++
 drivers/net/dsa/mv88e6xxx/global1.c | 48 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h | 30 ++++++++++++++++--
 4 files changed, 122 insertions(+), 10 deletions(-)

-- 
2.17.0
