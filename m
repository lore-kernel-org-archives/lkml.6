Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754847AbeC0R20 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 13:28:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754783AbeC0R2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 13:28:25 -0400
Date: Tue, 27 Mar 2018 13:28:22 -0400 (EDT)
Message-Id: <20180327.132822.403377635482599502.davem@davemloft.net>
To: Vadim.Lomovtsev@caviumnetworks.com
Cc: sgoutham@cavium.com, sunil.kovvuri@gmail.com,
        robert.richter@kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dnelson@redhat.com, Vadim.Lomovtsev@cavium.com
Subject: Re: [PATCH 0/7] net: thunderx: implement DMAC filtering support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2RHSXAq002382

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Tue, 27 Mar 2018 08:07:29 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> By default CN88XX BGX accepts all incoming multicast and broadcast
> packets and filtering is disabled. The nic driver doesn't provide
> an ability to change such behaviour.
> 
> This series is to implement DMAC filtering management for CN88XX
> nic driver allowing user to enable/disable filtering and configure
> specific MAC addresses to filter traffic.

This doesn't even compile:

drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ¡bgx_lmac_save_filter¢:
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:286:3: warning: ¡return¢ with no value, in function returning non-void [-Wreturn-type]
   return;
   ^~~~~~
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:281:12: note: declared here
 static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/cavium/thunder/nic.h:15:0,
                 from drivers/net/ethernet/cavium/thunder/thunder_bgx.c:21:
drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ¡bgx_set_dmac_cam_filter_mac¢:
drivers/net/ethernet/cavium/thunder/thunder_bgx.h:61:38: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define  RX_DMACX_CAM_LMACID(x)   (x << 49)
                                      ^
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:324:8: note: in expansion of macro ¡RX_DMACX_CAM_LMACID¢
  cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
        ^~~~~~~~~~~~~~~~~~~
