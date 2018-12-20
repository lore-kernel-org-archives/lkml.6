Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C6621903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opperline.com header.i=@opperline.com header.b="NxfPzy3s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFERMu2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbeLTVv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:51:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34523 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730700AbeLTVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:51:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B66422250;
        Thu, 20 Dec 2018 16:51:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 20 Dec 2018 16:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opperline.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=f1SoJRPZBz6d7KJt1BQmt8BAKa
        2gkm3+OW8Qob/jkIk=; b=NxfPzy3sFAwxFOSq1ClYJO3PpmK2bPFDO3G8I20vZ4
        jqUJ5RSBUriIds1/CLMkblVW88e5iHo4yT3Aqxj+bjmfjmO37Zeq4gO3VkOQpoXo
        VnyzSTxoW25sbg6kQZm4Xev1kdK1MqguK8SBIA8OFIBMqfcjybf6VbSLBaHUHTeB
        +7BdXjdwZklHcM4TIDPwKhylxTyfTTvLClTv+umECFajVU743o/YTxwIBjtZ+neu
        3logUNZBNkzEqSiCVaN/eHVGNtbgZNGLo8+T5sSXBt94w0IgF52k0OFeID9nxHby
        vdFli0Xy3w7LIaM5bONn25ZvxUls9KTvNcIEGBNfWilg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=f1SoJRPZBz6d7KJt1
        BQmt8BAKa2gkm3+OW8Qob/jkIk=; b=ZFERMu2k3xUSXSnNUBJg6vBY70ybiqum6
        GQOWlRezrRTgcFRwPQFY2S0zFbOGKLEVYtU+YRN/RsBDUExGKiyqHHu63WrX63ic
        D8pyenGpQc8h/bWYb7VyqbW6IVkrmayxg4s4N4rIye2ZGJvdNULH5O0TXuUgwQE2
        xfh+g//iCkUBMIm5/cT+/iWuE3YF9rUXf5icEu4hHNaZDi9jTEfMOjhZG8NGyCRN
        yg3Ky4YLuvyyIZtYKrXIqzj0psAFjcU2sefJDKT3qSGkeYkpRmv0lrgKw+c579mW
        uypaqkB9Y+bVM37+QDCbdJYT/UWb5hvR1WOTPSjb0kcCqjbAk7ZRQ==
X-ME-Sender: <xms:-w4cXODse4-FIQWC5G7v69aFXQiBX-AiEs_DUcL3yxcHVGarWqtjZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudejfedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuf
    htvghphhgvnhcuofgrrhhtihhnuceolhhotghkfihoohgusehophhpvghrlhhinhgvrdgt
    ohhmqeenucfkphepjeefrdehledrheekrddutddtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlohgtkhifohhougesohhpphgvrhhlihhnvgdrtghomhenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:-w4cXE8aSEweB_RvZtcnv-EhxJ78SeQ5Zy2j8_VipTUnuV9aWau5vQ>
    <xmx:-w4cXJW10L0hf5d6If_l2qn6u27ES22DRxPfAE2A0-zbwpIBRrEz-Q>
    <xmx:-w4cXNqIojwP4DwD4_SkAaPmYDC5MTs4VkaAaVXWQZtIzSzbZUo5gQ>
    <xmx:_A4cXKCYRPvgYme-I6Mwd_5WagUiCxto1UVOlnuY9F6fV3n4HaLeiw>
Received: from localhost (c-73-59-58-100.hsd1.wa.comcast.net [73.59.58.100])
        by mail.messagingengine.com (Postfix) with ESMTPA id D06A410084;
        Thu, 20 Dec 2018 16:51:54 -0500 (EST)
From:   Stephen Martin <lockwood@opperline.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        Stephen Martin <lockwood@opperline.com>
Subject: [PATCH] fix blank line warning
Date:   Thu, 20 Dec 2018 13:50:28 -0800
Message-Id: <20181220215028.19270-1-lockwood@opperline.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Stephen Martin <lockwood@opperline.com>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 0a7252aecfa5..4568cf52badc 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -496,6 +496,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 void sysfs_remove_files(struct kobject *kobj, const struct attribute **ptr)
 {
 	int i;
+
 	for (i = 0; ptr[i]; i++)
 		sysfs_remove_file(kobj, ptr[i]);
 }
-- 
2.20.0

