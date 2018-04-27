Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932245AbeD0B5q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:57:46 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:43952 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754298AbeD0B5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:57:44 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com
Subject: [PATCH net-next 0/3] net: dsa: mv88e6xxx: remove Global 2 setup
Date: Thu, 26 Apr 2018 21:56:43 -0400
Message-Id: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parts of the mv88e6xxx driver still write arbitrary registers of
different banks at setup time, which is misleading especially when
supporting multiple device models.

This patchset moves two features setup into the top lovel
mv88e6xxx_setup function and kills the old Global 2 register bank setup
function. It brings no functional changes.

Vivien Didelot (3):
  net: dsa: mv88e6xxx: move trunk setup
  net: dsa: mv88e6xxx: move device mapping setup
  net: dsa: mv88e6xxx: remove Global 2 setup

 drivers/net/dsa/mv88e6xxx/chip.c    | 47 ++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/global2.c | 62 ++++-------------------------
 drivers/net/dsa/mv88e6xxx/global2.h | 25 ++++++++----
 3 files changed, 65 insertions(+), 69 deletions(-)

-- 
2.17.0
