Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053B2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B362084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="BGbcCvoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B362084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLKKzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:55:19 -0500
Received: from mout02.posteo.de ([185.67.36.66]:59689 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbeLKKzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:55:04 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E01122400FF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 11:55:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544525702; bh=XrwMYt1JZRS/F1cYgoTNzWzsed6pucZo/JX8ALhdeIE=;
        h=From:To:Cc:Subject:Date:From;
        b=BGbcCvoQZYQpJi0emMOSK1nMoUy3DhNvoEoyNFbKoqk7bSCdrlSjnmtJWfpUs42yT
         i2PdnOn/r8L+AwX2xU0+cj6a0jNThWDiiRUsTc0tYhS+9rkn8qysmyUNpSiDm1m9DY
         umJYBDcPtsFSIYrb0KvEfxBcrogY8OqMHEORiHOGahBTFHr90pCmAaXloH7VhbAt7+
         3aM1c+MdS8LHMNuh/c5RemVdMFn8ySBBHu89kLFhpaLie0wJnInIJmmCLhLHoc5md6
         RixEou/+azqq20NORERJ5RNr1MCSqFSAnwdBhuYOCEyMbr+YOwuSAaFXgHo21iTMBi
         ZsSi/cL13vSKA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43DcKK1yWPz9rxb;
        Tue, 11 Dec 2018 11:55:01 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH 4/5] drivers: staging: erofs: Fix parentheses error in macro
Date:   Tue, 11 Dec 2018 11:54:42 +0100
Message-Id: <20181211105443.21826-5-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211105443.21826-1-aaron.strahlberger@posteo.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of ERROR: Macros with complex values should be enclosed in parentheses
from checkpatch.pl

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>
---
 drivers/staging/erofs/erofs_fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index d4bffa2852b3..892c913960c3 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -38,9 +38,9 @@ struct erofs_super_block {
 /* 80 */__u8 reserved2[48];     /* 128 bytes */
 } __packed;
 
-#define __EROFS_BIT(_prefix, _cur, _pre)	enum {	\
+#define __EROFS_BIT(_prefix, _cur, _pre)	(enum { \
 	_prefix ## _cur ## _BIT = _prefix ## _pre ## _BIT + \
-		_prefix ## _pre ## _BITS }
+	_prefix ## _pre ## _BITS })
 
 /*
  * erofs inode data mapping:
-- 
2.19.2

