Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeEJTmJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 15:42:09 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751660AbeEJTmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 15:42:06 -0400
Date: Thu, 10 May 2018 20:41:29 +0100
From: Justin Skists <justin.skists@juzza.co.uk>
To: devel@driverdev.osuosl.org, lustre-devel@lists.lustre.org,
        James Simmons <jsimmons@infradead.org>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: lustre: lnet: add static to libcfs_dev declaration
Message-ID: <20180510194128.GA19653@tanglefoot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Provags-ID: V03:K1:vs34+PZRiK6l3hdn68ZymWh3KGrwaobOou4RU2SN8+wd9h/+9x8
 pufC1tdFmHqmFNQYn5k+FYEtLxxOcGaleYFNuAu8/fJlNPdzKQV5E5r9jhz3ifmJWK9AG0Z
 gP8unzyaazBCeuIb+fDqh3agPieNzdARbWwOjuTEC2zRTkwFGJBf2OeusTIcZa77DWqb9VK
 LmWAiE0wbCIGJyraqbaoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9sK/1nr3LWM=:mLPprsXSvM+TRF6SvGHluO
 vuyTL0ypkUY+rkUHOmj/OxBRa1uh1PhGNQ0D8wBDHdDy/fwmkL+nJxMl+Z9M54YW5Jp6Zaeck
 39ixVAyApzXirvCENmAVqdw3Rd4BRnAc6/BMf1xcdiGEtA/IzCbZTChf+pqhUUHMplAO7NOJV
 XSYSUS+am6H4vV5gLpGbEca5ddnoDpLlLWXlsnp3wtRKMnxCja6rmYEu9LkD+PzNGO5CJl+an
 EMK9uI+3Z9H8wf3RXKmtqAzVoEfwrNLjCMN0fOsAtynYPrDsnGTaRRpfCwTn20gXnbSSUkKIQ
 BPzD8CAKMdz4G3rDLRR4kLhPQLV4KlUWtbS1WNXiSpul2wfD7QiiiR0p2+r4Y/pEqlTtyJnAW
 QiiSX9I9rKiiwwu1nHsyySSSC8Tk7bIrtjxnBWA8+/tIV87TDeCqUE4y4JTQT+iYPqaRXe1R8
 8J9g1dn938wX5ZD3dYbMJfvAdZRf/p8RjiA5Im8/e9Oe6Nh1jER/I7P9Pr4bHOHIJnz2qu/xS
 3ZKs4JRj8eD+GFiYErt+epuO/gdU8QENtpv7PUE4SE4G1VW0WNjKXNzUHnyA1Acu0oaQSl1EP
 OdMizO+q+/cYSHwfkedoGuTmjO5Wb7LJI3w4gwD9Yz0G5DHWXuap+TCmBFI2tmdxDKex11wlg
 +ArxioaTYdTApiEvGZfPrAiBe/BLFoECNRCkq1Tl5UERa7sxOfDAoOrytH5nqryr+8w8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a static prefix to the declaration for libcfs_dev. This would fix
the following sparse warning:

drivers/staging/lustre/lnet/libcfs/module.c:317:19: warning: symbol
'libcfs_dev' was not declared. Should it be static?

Signed-off-by: Justin Skists <justin.skists@juzza.co.uk>
---
 drivers/staging/lustre/lnet/libcfs/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lnet/libcfs/module.c b/drivers/staging/lustre/lnet/libcfs/module.c
index ca942f474a55..e021e439f140 100644
--- a/drivers/staging/lustre/lnet/libcfs/module.c
+++ b/drivers/staging/lustre/lnet/libcfs/module.c
@@ -314,7 +314,7 @@ static const struct file_operations libcfs_fops = {
 	.unlocked_ioctl	= libcfs_psdev_ioctl,
 };
 
-struct miscdevice libcfs_dev = {
+static struct miscdevice libcfs_dev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "lnet",
 	.fops = &libcfs_fops,
-- 
2.17.0
