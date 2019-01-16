Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBE6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725E5206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405787AbfAPQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:33:20 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:42740 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405722AbfAPQdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:33:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 76A51182E5;
        Wed, 16 Jan 2019 17:33:03 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 5hqGccoC1k4b; Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3675318539;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E5231E078;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 123A61E070;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 03AD92FF5;
        Wed, 16 Jan 2019 17:32:58 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id F175380B45; Wed, 16 Jan 2019 17:32:57 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH 1/8] vop: Use %z for size_t
Date:   Wed, 16 Jan 2019 17:32:46 +0100
Message-Id: <20190116163253.23780-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes these kind of errors on 32-bit:

 drivers/misc/mic/vop/vop_vringh.c:590:3:
 error: format '%lx' expects argument of type 'long unsigned int',
 but argument 7 has type 'size_t {aka unsigned int}' [-Werror=format=]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/vop/vop_vringh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index cbc8ebcff5cf..4267fa08b483 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -587,7 +587,7 @@ static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *ubuf,
 err:
 	vpdev->hw_ops->iounmap(vpdev, dbuf);
 	dev_dbg(vop_dev(vdev),
-		"%s: ubuf %p dbuf %p len 0x%lx vr_idx 0x%x\n",
+		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
 		__func__, ubuf, dbuf, len, vr_idx);
 	return err;
 }
@@ -670,7 +670,7 @@ static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user *ubuf,
 err:
 	vpdev->hw_ops->iounmap(vpdev, dbuf);
 	dev_dbg(vop_dev(vdev),
-		"%s: ubuf %p dbuf %p len 0x%lx vr_idx 0x%x\n",
+		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
 		__func__, ubuf, dbuf, len, vr_idx);
 	return err;
 }
-- 
2.20.0

