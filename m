Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15545C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6E820849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="CunAFVF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6E820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeLLMCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:02:18 -0500
Received: from mout02.posteo.de ([185.67.36.66]:46963 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLMCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:02:18 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B557D2400FF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544616134; bh=EVUn3QKghPXtZVKAoADJEBDqY8HU3MngXW+Hyg6Wz7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=CunAFVF9lJpWJZSb56sC/P6ea5HWdpEFinQr8oe/WO3JEl/QoTiEX8DH5j93lklGM
         Y7qkZ3PMw2gKuW5HxWRZekVOFh5YfvMArSFbwz+jDFmuICr7T7y6br8V7xuguAdPEi
         ByxJzN7qDVy/MhICy0lvPfCv6U9HWumL0MAi6p+9I61icBHUyygIL9MZisY2uV/VS3
         xDKIrTsEMBTgI/N7MZamoO8r3Tc/ufwj2smj0VAqpXx4XXHDOhEMC8ZYi2EFZ6gXMC
         g3Mt5Lwv0DEkiRMuHIsG7dzw0UCLZuXHrt3/7Pw2fc35CPHtk27WwVH+fNPNx6kF9I
         0YmSJa/GwsgXg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43FFmN2Fcdz9rxR;
        Wed, 12 Dec 2018 13:02:12 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH v2] staging:erofs: Remove __EROFS_BIT macro
Date:   Wed, 12 Dec 2018 13:02:09 +0100
Message-Id: <20181212120209.16304-1-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <9d324f50-e632-c020-04b9-57269ff7bdca@aol.com>
References: <9d324f50-e632-c020-04b9-57269ff7bdca@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `__EROFS_BIT` macro is used only once, do define the
`EROFS_I_DATA_MAPPING_BIT` constant. This Patch removes this
macro and expands it in the place it is used.

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>
---
 drivers/staging/erofs/erofs_fs.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index d4bffa2852b3..da5562df847b 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -38,10 +38,6 @@ struct erofs_super_block {
 /* 80 */__u8 reserved2[48];     /* 128 bytes */
 } __packed;
 
-#define __EROFS_BIT(_prefix, _cur, _pre)	enum {	\
-	_prefix ## _cur ## _BIT = _prefix ## _pre ## _BIT + \
-		_prefix ## _pre ## _BITS }
-
 /*
  * erofs inode data mapping:
  * 0 - inode plain without inline data A:
@@ -58,11 +54,14 @@ enum {
 	EROFS_INODE_LAYOUT_INLINE,
 	EROFS_INODE_LAYOUT_MAX
 };
+
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATA_MAPPING_BITS       3
 
 #define EROFS_I_VERSION_BIT             0
-__EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
+enum {
+	EROFS_I_DATA_MAPPING_BIT = EROFS_I_VERSION_BIT + EROFS_I_VERSION_BITS
+}
 
 struct erofs_inode_v1 {
 /*  0 */__le16 i_advise;
-- 
2.19.2

