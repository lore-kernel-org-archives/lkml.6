Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeBHRww (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:52:52 -0500
Received: from mout.web.de ([212.227.15.3]:44531 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752229AbeBHRwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:52:47 -0500
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] drm/exynos: g2d: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <f1a7c103-fd17-3a61-61f7-570436e3c452@users.sourceforge.net>
Date: Thu, 8 Feb 2018 18:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:fQYMOc3XEJUDVzV3IYQC5KePaeztR3A9CeJ5xwfR8QYcsUf5ubr
 si67bxJUAE1g02ByDLLozjpG90N8u+/FIasO01cu4u3tBbbirpD8apFoGMvnkWsVkvPrxR3
 RDJbMvrcBOJ5Z182EYl1vLnm+FqctmlooFZliTHKH2ADECjNFiEDbtozETyKofx2sNYu2R6
 m5KqTqQ0RZ4NfYe6hB5tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OTx37NLgaGY=:cBTEvtLvVMUdASe6FLOUq0
 X7Dn4eoEixOD/iUgFrfMEODlvYJf923xpz12StOlFsh0EtStGsN/3hmC3eCNPA6C4nwuPYsQS
 FtfOqnyrKeZ19L8P5G2cP3TiwJBL8P3GJgU2FNqpeY/ijS0c/i8yxsRGu07HoXs3v/51pzZqi
 RGJPh/XnKBmf5Uqla/54F/70GwiQWfSdC6crRdADJ5N98QQhxrkmBEkWgy4m0H00TDyaOMG0G
 ROs6RLRWSGK2mXUR/7J4BzD9ks0U/qKtPl5jIZuJbPmj/g0shlIQwls+k8bI9yCm3ij1ksmp5
 NMZw43/RaSedpiCRduL/W2SN4tSNKoqBFWwqPzTyX3+9BV3uPs6g7OERfWd9ZdFHC24myyxCl
 gGOLTU6l9aTuvMaL8O63W7onISBDBAo7dm0keOp9f2nSENl7u1/b8le9JBEUhFgBe6PckVbRO
 lbxYxnwmsz8qNncMFcwM/OpO0YczcwQOBkAdbjzIgs6ukcFsBwbKOS7LcyXGanAdkuDA8TTyQ
 9AFdZ7nQ8NRLK2Qudl+PlqxhkiBlYqllzxG6iZ+boFg9RBJBaVZBh2ioP7huAnOoEstye6l0A
 RXY/+CZfWMVAr2xAPvOMkuNDmadOPgYEubNSA+G9oeplgnZJH8bk+vaDVHnZj/V4BhG9pb6ra
 ansy7+G7UJxromUq4cyWXArKtku3vrCZXCzhK8YQKwFQA1H2YZkTrliMu0eU6X/N/Byqe7IhC
 svVWncEjGyfgjwyajIrwKNNKYYzlONqiNO3rQgg/brW8thXDcy9QhCCKz+opjAcMvU6fZ6r9J
 JfkbqCaPqYPcP8P3asnMO65YO3VkXxNpazLKwIBRe83zDPoUOM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Feb 2018 18:42:51 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 2b8bf2dd6387..5eb0d3292525 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -286,7 +286,6 @@ static int g2d_init_cmdlist(struct g2d_data *g2d)
 
 	node = kcalloc(G2D_CMDLIST_NUM, sizeof(*node), GFP_KERNEL);
 	if (!node) {
-		dev_err(dev, "failed to allocate memory\n");
 		ret = -ENOMEM;
 		goto err;
 	}
@@ -1358,10 +1357,9 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 		return -EFAULT;
 
 	runqueue_node = kmem_cache_alloc(g2d->runqueue_slab, GFP_KERNEL);
-	if (!runqueue_node) {
-		dev_err(dev, "failed to allocate memory\n");
+	if (!runqueue_node)
 		return -ENOMEM;
-	}
+
 	run_cmdlist = &runqueue_node->run_cmdlist;
 	event_list = &runqueue_node->event_list;
 	INIT_LIST_HEAD(run_cmdlist);
-- 
2.16.1
