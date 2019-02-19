Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A0521773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opperline.com header.i=@opperline.com header.b="Kab+m19m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LU5NlASt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbfBSADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:03:36 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33293 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730731AbfBSADg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:03:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D5F3C22187;
        Mon, 18 Feb 2019 19:03:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Feb 2019 19:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opperline.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=AbB78He6Yw7AUygeU+cYTP6E+F
        tSXe9cmIB/85NQed8=; b=Kab+m19mp3SxQpljvRL6oS+HdkUZpAkCszuzNgB2/U
        zbpj4SXcJYAXERjTIEXmn3+ZUQLL4YgIDmnKTnHMFPgNnH6i3o+j+CiphdrrpD/J
        Plez3OExuRGIs/MfaTt8q5TdDvMB3t8myfEk5EDLoEpb9wVkU222aTNZihNwqpbc
        EuOtve2P9fuM8Sbcy2oNjZuvnJ/SWsCoEcVq37qXArhfiGG2ID2VYhZ8hYSxbWFX
        pgHFAE6YiACViHBH4+3ZCARafTYj0GYDbxxbNcl4v20I4C3GDBo2TS6jsB+blPqI
        UrgaFgNKh01GTzyAHrC3TG0VVAb9bvPVb/YQg9n3heHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=AbB78He6Yw7AUygeU
        +cYTP6E+FtSXe9cmIB/85NQed8=; b=LU5NlAStrOni3qNyaIjrtHEEIKDaX4QR7
        cvp1c75Pvsam0Ukuww7Dr+hoYHTmifnXugYdc/MPUA3YyKaLFub5d0eoM4ylHF35
        nvqhQsRAX++xKuSFqaev6UYMm96s7XDj1HeDaDXK8uXgZ0nR2p2MGFstO4/SGp8s
        3bP1igt68HMRnCjBUeIoRWzp0wW5EQP6X9+yI7wqpLi2Mm2E/NDg2s7/K1eebrZK
        MZIoV8Mpr/G2FbyQLXu0W9s1qRIPbjhhkdMiN1itysqqHM2jifDQ0tmxp43tdthd
        T9Xwm1tIu062BmXwrDO8HWql+ePNGNhkq9CEo7+3mQ0Oc9JN7WojA==
X-ME-Sender: <xms:1UdrXK8EBu4-CjMaswqzLKSYdv8ty-F1tNR8ex8XXxkZ97SmXYa1EA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtddvgddujeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepufhtvghphhgvnhcuofgrrhhtihhnuceolhhotghkfihoohguseho
    phhpvghrlhhinhgvrdgtohhmqeenucfkphepjeefrdehledrheekrddutddtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehlohgtkhifohhougesohhpphgvrhhlihhnvgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:1UdrXKdj6GhNPEAfYvfh5Nci0vqaSxgOgvS_UM3xqA9wgpCqU8oubA>
    <xmx:1UdrXCgctoBwGfsOfeLEWyQowZMCsPKHjhR3DZzW__mAzrTPl4azeA>
    <xmx:1UdrXBzvW-bxmSFcvs54ZZTJNnwVKWpdaMG7NCf7iQO6QbQJ1WQIJg>
    <xmx:1kdrXJ40bRw71lD7jvlWqsWElms0l0wS3xxH4M6n3RWppCemZmNbog>
Received: from localhost (c-73-59-58-100.hsd1.wa.comcast.net [73.59.58.100])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF688E4624;
        Mon, 18 Feb 2019 19:03:32 -0500 (EST)
From:   Stephen Martin <lockwood@opperline.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        santhameena13@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lockwood@opperline.com
Subject: staging: rtl8188eu: fix bad indentation for conditional statement
Date:   Mon, 18 Feb 2019 16:01:55 -0800
Message-Id: <20190219000155.23899-1-lockwood@opperline.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed else block indentation

Signed-off-by: Stephen Martin <lockwood@opperline.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 3b1ccd138c3f..1723a47a96b4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -626,7 +626,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 				if (pframe[1] & 2)  /* From Ds == 1 */
 					rtw_secmicappend(&micdata, &pframe[24], 6);
 				else
-				rtw_secmicappend(&micdata, &pframe[10], 6);
+					rtw_secmicappend(&micdata, &pframe[10], 6);
 			} else {	/* ToDS == 0 */
 				rtw_secmicappend(&micdata, &pframe[4], 6);   /* DA */
 				if (pframe[1] & 2)  /* From Ds == 1 */
-- 
2.20.1

