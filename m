Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E554C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35974217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfBRVII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:08:08 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57907 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfBRVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:08:03 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M894P-1gzOdr1DG7-005Hqb; Mon, 18 Feb 2019 22:07:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Stafford Horne <shorne@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>,
        arnd@arndb.de, linux-riscv@lists.infradead.org,
        Guan Xuetao <gxt@pku.edu.cn>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Yury Norov <ynorov@marvell.com>
Subject: [PATCH 1/8] compat ABI: use non-compat openat and open_by_handle_at variants
Date:   Mon, 18 Feb 2019 22:07:05 +0100
Message-Id: <20190218210712.3503891-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190218210712.3503891-1-arnd@arndb.de>
References: <20190218210712.3503891-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Orj12xgdgMLKf/0v9QWyyXfYt0be3LlRpxJPHPgrMPDM0BnJ6WV
 BiLjhwLgc5U1C/Ku6TThTvBytLILEw94wcflD2P4D8aMVj1M6BMTtsRvQzpDcQi5i2KJmXB
 F+hHXIGVuNx9XyXbHpXSVjE9Lmp6xT8wlf1TVaf6ckTcv5FJ+tMk94wMt83YlYfQSPdcQQA
 vUP00Bef/iee0lCoDfhSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AmDHvMow4jU=:wgjN+bHjmauBTwC5INBuZa
 kwbgPKcxBciSswCZ8/hJX+dA1uKNGxkSQqFWNgUDq9u0H35s+lBE0HS7/bwFirv911RTPPV64
 1QQOCoG/Xv16krmGDJ0c0FzpFwadl4hNLJI+Of0fiQby0i/vJelQdmZf0mt/pgQAazojAZe/e
 FWGpoxzc87oMSDeCUkmRkMA8mZlSuVFPeffCZ7ItzTPBD1xRE4ZLjuMLdzFP14X2czSBqH/UY
 Qt98uvuQb7EUmsBv6mfPxSoUAJ+xKyi4AGkXToXFKc9WOxk4oVhtemBgsFNLGANMqI804JiBv
 700hovB3xfegQzjPemFFwbqE+VpkKpGnOBo+j5MxJvZa03KP3teLkNLAJJmpJu9X7/P/V5fLC
 kNo31gUG4OUYLmep7kwSXhwP46H8zabPtxvXjLdzCWuNQIagzzPoMHMK53ARD8D1gfuZ3Lq+E
 V0DRm9L/csRhGFpfi1EAIYC60T1NxI1BuKAMPqmji5oCBs9q34kiY4mwkWt2J8XVqod77IJ8u
 Yf2GWsxQRDzHfuxfF4pbfj/LBpeaNJUQD8894H24It3r7y4vmCe5Tq0DkkONzy/RhHtKS3ckF
 NRb9duTX2JUd+mqkIgwf8c+sC1K4i+njwigthjhjFPzpp1qDiHQ7BKuyPaDeU5NeFTyPLBjSW
 AQ75D7twBBuOAdhOdZbLdPptocCntHHJS0RbZTTRKKS3NOJpQiiCwk/+18PZkGe7zRx+jzjAs
 Y3NEYyjIAXAUv4vZQ0frh0vqCvbkPt9qcs+E0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@caviumnetworks.com>

The only difference between native and compat openat and open_by_handle_at
is that non-compat version forces O_LARGEFILE, and it should be the
default behaviour for all architectures, as we are going to drop the
support of 32-bit userspace off_t.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index acf9a07ab2ff..b928eff3bf92 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -179,7 +179,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -678,8 +678,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_3264(__NR_clock_adjtime, sys_clock_adjtime32, sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.20.0

