Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeEOXCF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 19:02:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41864 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOXCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 19:02:00 -0400
X-Google-Smtp-Source: AB8JxZqwnTnyI8uayxbaIQDO2hBGphkuONig77lZxvH37EVRDI79PsToyhkq4cTlNK5sav7P57KJMg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list), opendmb@gmail.com,
        davem@davemloft.net
Subject: [PATCH net v2 0/3] net: dsa: bcm_sf2: CFP fixes
Date: Tue, 15 May 2018 16:01:22 -0700
Message-Id: <20180515230125.25886-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

This patch series fixes a number of usability issues with the SF2 Compact Field
Processor code:

- we would not be properly bound checking the location when we let the kernel
  automatically place rules with RX_CLS_LOC_ANY

- when using IPv6 rules and user space specifies a location identifier we
  would be off by one in what the chain ID (within the Broadcom tag) indicates

- it would be possible to delete one of the two slices of an IPv6 while leaving
  the other one programming leading to various problems

Florian Fainelli (3):
  net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
  net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
  net: dsa: bcm_sf2: Fix IPv6 rule half deletion

 drivers/net/dsa/bcm_sf2_cfp.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

-- 
2.14.1
