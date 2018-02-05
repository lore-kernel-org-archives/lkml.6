Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeBEUaQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:30:16 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.78]:30488 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeBEUaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:30:10 -0500
Date: Mon, 5 Feb 2018 14:06:18 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacob chen <jacob2.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, Antti Palosaari <crope@iki.fi>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2 0/8] use 64-bit arithmetic instead of 32-bit
Message-ID: <cover.1517856716.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1ein1x-003H4K-JM
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:46548
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix LL and ULL to various constants in order to give the compiler
complete information about the proper arithmetic to use. Such constants
are used in contexts that expect expressions of type u64 (64 bits, unsigned)
and s64 (64 bits, signed).

The mentioned expressions are currently being evaluated using 32-bit
arithmetic, wich is some cases can lead to unintentional integer
overflows.

This patchset addresses the following Coverity IDs:
CIDs: 200604, 1056807, 1056808, 1271223, 1324146
CIDs: 1392628, 1392630, 1446589, 1454996, 1458347

Thank you

Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Add suffix ULL and LL to constants instead of casting variables.
 - Extend the proposed code changes to other similar cases that had not
   previously been considered in v1 of this patchset.

Gustavo A. R. Silva (8):
  rtl2832: use 64-bit arithmetic instead of 32-bit in
    rtl2832_set_frontend
  dvb-frontends: ves1820: use 64-bit arithmetic instead of 32-bit
  i2c: max2175: use 64-bit arithmetic instead of 32-bit
  i2c: ov9650: use 64-bit arithmetic instead of 32-bit
  pci: cx88-input: use 64-bit arithmetic instead of 32-bit
  rockchip/rga: use 64-bit arithmetic instead of 32-bit
  platform: sh_veu: use 64-bit arithmetic instead of 32-bit
  platform: vivid-cec: use 64-bit arithmetic instead of 32-bit

 drivers/media/dvb-frontends/rtl2832.c         |  4 ++--
 drivers/media/dvb-frontends/ves1820.c         |  2 +-
 drivers/media/i2c/max2175.c                   |  2 +-
 drivers/media/i2c/ov9650.c                    |  9 +++++----
 drivers/media/pci/cx88/cx88-input.c           |  4 ++--
 drivers/media/platform/rockchip/rga/rga-buf.c |  3 ++-
 drivers/media/platform/sh_veu.c               |  4 ++--
 drivers/media/platform/vivid/vivid-cec.c      | 11 +++++++++--
 8 files changed, 24 insertions(+), 15 deletions(-)

-- 
2.7.4
