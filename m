Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeA3B2D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:28:03 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.33]:42139 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751539AbeA3B2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:28:02 -0500
Date: Mon, 29 Jan 2018 19:07:42 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jacob chen <jacob2.chen@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, Antti Palosaari <crope@iki.fi>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH resend 0/8] fix potential integer overflows
Message-ID: <cover.1517268667.git.gustavo@embeddedor.com>
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
X-Source-IP: 189.145.57.174
X-Source-L: No
X-Exim-ID: 1egKOm-0028F3-EJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:36224
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm resending this cover letter due to a typo in the ARM and LKML
addresses in the previous e-mail.

This patchset aims to fix potential integer overflows reported
by Coverity.

In all cases the potential overflowing expressions are evaluated
using 32-bit arithmetic before being used in contexts that expect
a 64-bit arithmetic. So a cast to the proper type was added to each
of those expressions in order to avoid any potential integer overflow.

This also gives the compiler complete information about the proper
arithmetic for each expression and improves code quality.

Addresses the following Coverity IDs reported as
"Unintentional integer overflow" issues:

200604, 1056807, 1056808, 1271223,
1324146, 1392628, 1392630, 1446589,
1454996, 1458347.

Thank you

Gustavo A. R. Silva (8):
  rtl2832: fix potential integer overflow
  dvb-frontends: ves1820: fix potential integer overflow
  i2c: max2175: fix potential integer overflow in max2175_set_nco_freq
  i2c: ov9650: fix potential integer overflow in
    __ov965x_set_frame_interval
  pci: cx88-input: fix potential integer overflow
  rockchip/rga: fix potential integer overflow in rga_buf_map
  platform: sh_veu: fix potential integer overflow in
    sh_veu_colour_offset
  platform: vivid-cec: fix potential integer overflow in
    vivid_cec_pin_adap_events

 drivers/media/dvb-frontends/rtl2832.c         | 4 ++--
 drivers/media/dvb-frontends/ves1820.c         | 2 +-
 drivers/media/i2c/max2175.c                   | 2 +-
 drivers/media/i2c/ov9650.c                    | 2 +-
 drivers/media/pci/cx88/cx88-input.c           | 4 ++--
 drivers/media/platform/rockchip/rga/rga-buf.c | 2 +-
 drivers/media/platform/sh_veu.c               | 4 ++--
 drivers/media/platform/vivid/vivid-cec.c      | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.7.4
