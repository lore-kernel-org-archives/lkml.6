Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeEKVQ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:16:56 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37188 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbeEKVQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:16:53 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 0/3] net: dsa: mv88e6xxx: remove Global 1 setup
Date: Fri, 11 May 2018 17:16:33 -0400
Message-Id: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mv88e6xxx driver is still writing arbitrary registers at setup time,
e.g. priority override bits. Add ops for them and provide specific setup
functions for priority and stats before getting rid of the erroneous
mv88e6xxx_g1_setup code, as previously done with Global 2.

Vivien Didelot (3):
  net: dsa: mv88e6xxx: use helper for 6390 histogram
  net: dsa: mv88e6xxx: add IEEE and IP mapping ops
  net: dsa: mv88e6xxx: add a stats setup function

 drivers/net/dsa/mv88e6xxx/chip.c    | 121 +++++++++++++++++-----------
 drivers/net/dsa/mv88e6xxx/chip.h    |   3 +
 drivers/net/dsa/mv88e6xxx/global1.c |  73 ++++++++++++++---
 drivers/net/dsa/mv88e6xxx/global1.h |  15 +++-
 4 files changed, 149 insertions(+), 63 deletions(-)

-- 
2.17.0
