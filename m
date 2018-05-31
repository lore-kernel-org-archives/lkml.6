Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeEaLXi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:23:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754824AbeEaLWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:48 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        <sparclinux@vger.kernel.org>
Subject: [PATCH v2 21/21] sparc64: use match_string() helper
Date: Thu, 31 May 2018 19:11:26 +0800
Message-ID: <1527765086-19873-22-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 arch/sparc/kernel/setup_64.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 7944b3c..7af8c7e 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -512,10 +512,9 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 				break;
 			}
 		}
-		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
-			if (!strcmp(prop, crypto_hwcaps[i]))
-				caps |= HWCAP_SPARC_CRYPTO;
-		}
+		i = match_string(crypto_hwcaps, ARRAY_SIZE(crypto_hwcaps), prop);
+		if (i >= 0)
+			caps |= HWCAP_SPARC_CRYPTO;
 
 		plen = strlen(prop) + 1;
 		prop += plen;
-- 
1.7.12.4
