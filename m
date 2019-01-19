Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3BA2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 13:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfASNPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 08:15:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:51943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfASNPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 08:15:46 -0500
Received: from localhost.localdomain ([116.30.194.192]) by mail.gmx.com
 (mrgmx002 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M9b03-1gw64G47wd-00CwVv; Sat, 19 Jan 2019 14:15:45 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] uio: remove redundant check
Date:   Sat, 19 Jan 2019 21:15:34 +0800
Message-Id: <20190119131534.13434-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:6j5u0xjxOb9QjftycIktpbOM3JqMWTyc0vHezmJRs/2CsqhXCjn
 XW38DAzg+IQNdKmrcteFelq0l9CHCuSgfkYB74EoPE2crnPAeJPIKWfu7AUQd6P1jHwf+rl
 0SSfaOgT3Wo+18CwPsL52hXtbYi4hIspG4sfHqz1rDXim6+9GQmzhjuRaDzdP1Cv8Fq9zEn
 JLwYya1HDFm1zpB0P7/dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CgbOcOZaLK0=:11FOovU194FmDQjJJ+mP1w
 g+pC8RYjFkSNmrN95Q/vRLMe/EdqRQ9Vs9vrY8twUOFFzcUCR/gWwLIOkLGjJa0LgssE81Dhx
 3YGczI+a1LmudAXCFs1ug2d1xG9j54RLBaI4DX3bKZz6ogV7qM6NQhXyMcvET+Pq8UUeo+zLq
 QDe4TU/rlq+FSmoJx5oVMgPaIgb2Pk2aGS+TRygJBbMSFJ9eTtjqIlE1DCwO++MM1XvrxJr3C
 VhCn+KAqpJDXaL0J9JNkMdt3oAw6v47YHygttGhHfMi1x3rMniPgKgSNpT12OcoJGbcrw68FV
 +l0BjcHPsiGSm3m2cQyocucuEE6uTixB0e6BA755bJvtL2cszyLggmbOSDGmMupQIvx9LF/4r
 52O9nIyyw8ZfKxj1kPfKbyoua+QIt/FHfPp5tAa3GGEp7vpcre5vNOu+7yHoqyMM7SMY6eg73
 k60y26+NsgPCkKoAC1K8nEtfd0FgGpJ1ahFkUnTr5P0TwIA99m9IMHeDmR1fsgc3Qu55wRDnF
 hn+yk7UlFeOFLMNdlxT3QkiP+yCmmnv6WRHo5z4NWnMpd91j8J27HMMlnseheuIgsL1r5LkTk
 uYDdyLQLRxP9fiyUjiUMkVZ6ZURxhnu/bgbopvkYnJvgJlFGLaLhqEbaeNg2ZnmgsWIZJa0Mf
 cGk0YNK+qj7RGRdmJsXGOmEvYtTU8AH29fW+Kc92gvi7x7OYXB1DiKY07KSo7q23m+QtnbukW
 eVAVFSA0qOSuEXsrWkiJG3FDX0h6of+IsiXgYnJwh199TFtgoS6qeEuF6UHwZ/SDEpZvdE+1x
 Lm2+Q9MUVCZ2T5363dddI0S+ejp+KvLOUbJ+LDmjQ+26pTUyvGOcV1KiR9kB7JIBGQZq2thuW
 syb6hIk3l2z1SOZgZvjjseZtpE/deq3lTfv5Rb67NXDaM9gAHNiuIRAE38B9y5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to check idev->info several times under
mutex lock, so just remove redundant check.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/uio/uio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 46e5c1c31ebe..effe72834c2f 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -494,7 +494,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 		goto err_infoopen;
 	}
 
-	if (idev->info && idev->info->open)
+	if (idev->info->open)
 		ret = idev->info->open(idev->info, inode);
 	mutex_unlock(&idev->info_lock);
 	if (ret)
@@ -635,7 +635,7 @@ static ssize_t uio_write(struct file *filep, const char __user *buf,
 		goto out;
 	}
 
-	if (!idev->info || !idev->info->irq) {
+	if (!idev->info->irq) {
 		retval = -EIO;
 		goto out;
 	}
-- 
2.17.2

