Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163699AbeCBAZj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:25:39 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44296 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163031AbeCBAZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:25:36 -0500
X-Google-Smtp-Source: AG47ELu8WBz5Yengtz9rYfxHxYdvuzbcLWImFfgRMXFgo47/mfS0UVv/gpKLf/KlhB/tugEfW6NP1w==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 0/4] net: dsa: Use strncpy() for ethtool::get_strings
Date: Thu,  1 Mar 2018 16:25:25 -0800
Message-Id: <20180302002529.15226-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After turning on KASAN on one of my systems, I started getting lots of out of
bounds errors while fetching a given port's statistics, and indeed using
memcpy() is unsafe for copying strings, so let's use strncpy() instead.

Florian Fainelli (4):
  net: dsa: b53: Use strncpy() for ethtool::get_strings
  net: dsa: loop: Use strncpy() for ethtool::get_strings
  net: dsa: microchip: Utilize strncpy() for ethtool::get_strings
  net: dsa: mv88e6xxx: Utilize strncpy() for ethtool::get_strings

 drivers/net/dsa/b53/b53_common.c       | 4 ++--
 drivers/net/dsa/dsa_loop.c             | 4 ++--
 drivers/net/dsa/microchip/ksz_common.c | 4 ++--
 drivers/net/dsa/mv88e6xxx/chip.c       | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.14.1
