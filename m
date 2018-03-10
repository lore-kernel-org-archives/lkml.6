Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbeCJDuo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 22:50:44 -0500
Received: from gateway36.websitewelcome.com ([50.116.124.69]:39190 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932299AbeCJDun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 22:50:43 -0500
Date: Fri, 9 Mar 2018 21:02:18 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] EDAC, sb_edac: Remove VLA usage
Message-ID: <20180309235654.GA9887@embeddedor.com>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1euUm3-002ubf-Lb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.117.58]:49068
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with a fixed-length array instead.

Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---

Notice that due to this change, the field max_interleave is no longer
used after it has been initialized. Maybe it should be removed?

Thanks
--
Gustavo
---
 drivers/edac/sb_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 8721002..11cb2c9 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -110,6 +110,7 @@ static const u32 knl_interleave_list[] = {
 	0xdc, 0xe4, 0xec, 0xf4, 0xfc, /* 15-19 */
 	0x104, 0x10c, 0x114, 0x11c,   /* 20-23 */
 };
+#define MAX_INTERLEAVE	ARRAY_SIZE(knl_interleave_list)
 
 struct interleave_pkg {
 	unsigned char start;
@@ -1899,7 +1900,7 @@ static int get_memory_error_data(struct mem_ctl_info *mci,
 	int			n_rir, n_sads, n_tads, sad_way, sck_xch;
 	int			sad_interl, idx, base_ch;
 	int			interleave_mode, shiftup = 0;
-	unsigned		sad_interleave[pvt->info.max_interleave];
+	unsigned int		sad_interleave[MAX_INTERLEAVE];
 	u32			reg, dram_rule;
 	u8			ch_way, sck_way, pkg, sad_ha = 0;
 	u32			tad_offset;
-- 
2.7.4
