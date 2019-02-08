Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D189C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A73121920
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBHHl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:41:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:40721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfBHHl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:41:59 -0500
Received: from axis700.grange ([87.78.226.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJWAZ-1gq5v73D7z-0032Oc; Fri, 08
 Feb 2019 08:41:54 +0100
Received: by axis700.grange (Postfix, from userid 1000)
        id F2DAC61CC2; Fri,  8 Feb 2019 08:41:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by axis700.grange (Postfix) with ESMTP id E65D361CB3;
        Fri,  8 Feb 2019 08:41:53 +0100 (CET)
Date:   Fri, 8 Feb 2019 08:41:53 +0100 (CET)
From:   Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-X-Sender: lyakh@axis700.grange
To:     linux-kernel@vger.kernel.org
cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH resend] regulator: fix device unlinking
In-Reply-To: <alpine.DEB.2.20.1902060904060.14292@axis700.grange>
Message-ID: <alpine.DEB.2.20.1902080840440.22709@axis700.grange>
References: <alpine.DEB.2.20.1902060904060.14292@axis700.grange>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ci3PxP42kzEbYkZwjH2R/tBxn/9EqbQGtNK0VKfjiprpHM3RYNQ
 uQeHbVFEakKezBi5LCEWLY2mBMnurVNqJ/4EGzbXQ6Sy0KnUhSb+OabiN2UlewSX1HOAsxJ
 ubS7HNI414avUCQAlI5ziGfxErNp9ixGd2rjcabB7zc45yHagCXY7RgZYR5FvJcWN0tEm+3
 saOgq8I3sIGblHhdm0x8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gtJUQweyFQg=:TBXMgawgwcployA9hCoSH4
 FSGdb9w3TN9M+w4s132FYuS3hzIFgBtz5+plruTiFG43lSnIiQ1IvC1yn/aPTtlKoc5aQPX4K
 FU1R7Dt3I/wBiJH7/cXJatP9fGK4bkrSTxuUqtDwUR0EXFTwleqHEp4EIBKWGA/h22cH2Vl8T
 y7bi04eK9ezhQTccMQU77/9tngliKC7NCOwIUXYJMJgtpLPvyYO5T1cFHkUwu7He4OKW8uW3O
 hpQQ8ZeJnw9RpZmJV8+TbQCUOI0f3oyhrIkShpM2sLIrU9tvEJDCepF2eDWEQeHfawGrdWZ/7
 xkMqpmM1LSPKUPV0Um4mf31nxorlcdpFQNAem019k1Gb3GhTVlA2Es2nunI8DfgNLO4CQu7kn
 MTIoFxhcyUU93OW4viqG22j0kf4+wn4XcOqx4XZIy9ElLaA/3+mbb2+sA+KrZ5vcdYm8+lJse
 R3K789X01W7X+o7ecjbouyJ23aiUK+iuUFquIXZQXYpXyyJdCDod0yh5pUOP2nL+LS9fYtp2w
 XQBoEUwdxJG67UmyBZGFi3Z+krh2ZWt4xIJ23qpGjxFNyr9xI83v8d8h+s7l8/g8HKTQaM0+1
 cx/4RHis+Qp/FRYRcuTkQLgsbZeLNtbtHEZ3LNMp/SZPPeCd6cKnpR68DGSxXiZIGLl/FbDRu
 OXLM0exuUoqRb70rKem6Qt5/bk9ynPyQuI/lguEZBrImp/MPnvqADhikQNseczG1lAociCxc4
 yj4vT7+VmV0Qj2VWvUYyoz1Yo6bkHaYNOlJxZVNTaZslR+ftm69cno7zLoAoQHBJzeUFU0tBq
 Clsw4IRTZpMmfFR5VqLiIPv4GqmVdL7z+gKBKvw+iBYgfRwZr2oe7iPdkaY/3NSuWRQONFNVg
 SuNqA89ITjG9G0OyPCD0A3eeTOKyg0kJdhOFYdZGS3lUGt3/qXOMQKDIE+UcZpspzvU+Vt5gV
 UMume4/F11A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

Device links are refcounted, device_link_remove() has to be called as
many times as device_link_add().

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---

Resending with the "PATCH" subject line modifier.

 drivers/regulator/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..342102e8bc21 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1837,15 +1837,7 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
-		int count = 0;
-		struct regulator *r;
-
-		list_for_each_entry(r, &rdev->consumer_list, list)
-			if (r->dev == regulator->dev)
-				count++;
-
-		if (count == 1)
-			device_link_remove(regulator->dev, &rdev->dev);
+		device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-- 
2.17.1

