Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbeDBW7I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:59:08 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40252 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbeDBW7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:59:06 -0400
X-Google-Smtp-Source: AIpwx49t8TC4Nk9f6otuAVfSlbly1ZlAUHhuWDKsmLRbNNjN/em4YjaXIZWr56NsbGcwTD3hC7yIWw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/2] net: Broadcom drivers sparse fixes
Date: Mon,  2 Apr 2018 15:58:54 -0700
Message-Id: <20180402225856.4351-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series fixes the same warning reported by sparse in bcmsysport and
bcmgenet in the code that deals with inserting the TX checksum pointers:

drivers/net/ethernet/broadcom/bcmsysport.c:1155:26: warning: cast from restricted __be16
drivers/net/ethernet/broadcom/bcmsysport.c:1155:26: warning: incorrect type in argument 1 (different base types)
drivers/net/ethernet/broadcom/bcmsysport.c:1155:26:    expected unsigned short [unsigned] [usertype] val
drivers/net/ethernet/broadcom/bcmsysport.c:1155:26:    got restricted __be16 [usertype] protocol

This patch fixes both issues by using the same construct and not swapping
skb->protocol but instead the values we are checking against.

Florian Fainelli (2):
  net: bcmgenet: Fix sparse warnings in bcmgenet_put_tx_csum()
  net: systemport: Fix sparse warnings in bcm_sysport_insert_tsb()

 drivers/net/ethernet/broadcom/bcmsysport.c     | 11 ++++++-----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.14.1
