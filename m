Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9737F2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 05:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JewELMNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9737F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeIZLca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 07:32:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55209 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbeIZLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 07:32:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so771732wmb.4;
        Tue, 25 Sep 2018 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMxy9odM3Lh06EGEquedZ58Dwp03RDMkTWHS4zeDbHA=;
        b=JewELMNzuY/lq7tIH2G7CAy0KMLu0CnCRk5eZvym9VQanBkvdCsQUzL0B4kPCpQLXQ
         NBSDJsxNIBJneXW7Cx1kihTvJapKGCsFwz1HtzXtSypaZQRT/ZvpJGQ+oPI5d2tf7hd9
         ICDy4Oqvu+uJDc+WLrs10IygLVvIdlzhHGy1zSQf2L5t7Ma7VFK8tFLKU+nnqRDbpOAw
         dFyNw6ag9lT7viXWq44ZZ0yPB4cUBIcVxck9xjP0wRnkxkXRUiS41MBdwYwtqNGQa7YC
         CcyjzX5CpCTjhUxQ8DrGJqxUkXJNO3sP1hOu7mIiqOtLDtnOYL82X6vRNtlUHyfKWVhz
         K0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMxy9odM3Lh06EGEquedZ58Dwp03RDMkTWHS4zeDbHA=;
        b=cMlRgQVkYKXtI5IPGPw9peRGzaGdCjqtmjpvDvQw/rT+Mr4d5bCSRoGAGg/6wVWfLJ
         rP4lhKTNcmM1omsKWBn2SD4hPZP4MP9aOFT2AaOS+0gUT1Egc14uXMohZHt7RQc7L6gr
         rZojU9GNUSBELTUUS7kMf+e1Lq3JyYuZw3I8RZkYs8Pan9yzpBQ/TFUSUgtcW/+zF35b
         p3egMSX0KljSIOj7u7PmEx8E5nNeTI3B4E64yoqF/hT7sBTvVJSzkTRgCjOqjNpsNqfN
         ThdqkrhKJ4XkZLXBnAu8x8MgePEVfDVoQHfk+jKxLDLIbrsiqIwe8zg16VoZW1puHW0x
         fxYw==
X-Gm-Message-State: ABuFfoioSFgQF42GbtUSDWZ0OFQAJ2GySedCxjCTJDNCXfPaCUvJ2hpP
        HtEuFKAVQrl3D4ubptRE2ho=
X-Google-Smtp-Source: ACcGV62jbbLyNlplaalLus6oUaw5lBDFcSR31balyeBXOABCa4/sajiTw8D67fTgxsQaeB62IRn0bg==
X-Received: by 2002:a1c:9b95:: with SMTP id d143-v6mr2974645wme.95.1537939281884;
        Tue, 25 Sep 2018 22:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q5-v6sm3209512wru.79.2018.09.25.22.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 22:21:21 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vadim Pasternak <vadimp@mellanox.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] platform/x86: mlx-platform: Properly use mlxplat_mlxcpld_msn201x_items
Date:   Tue, 25 Sep 2018 22:21:15 -0700
Message-Id: <20180926052115.21223-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns that mlxplat_mlxcpld_msn201x_items is not going to be
emitted in the final assembly because it's only used in ARRAY_SIZE right
now, which is a compile time evaluation since the array's size is known.

drivers/platform/x86/mlx-platform.c:555:32: warning: variable
'mlxplat_mlxcpld_msn201x_items' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static struct mlxreg_core_item mlxplat_mlxcpld_msn201x_items[] = {
                               ^
1 warning generated.

It appears this was a copy and paste mistake from when this item was
first added. Use the definition in mlxplat_mlxcpld_msn201x_data so that
Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/141
Fixes: a49a41482f61 ("platform/x86: mlx-platform: Add support for new msn201x system type")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/platform/x86/mlx-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/mlx-platform.c
index d89936c93ba0..c2c3a1a19879 100644
--- a/drivers/platform/x86/mlx-platform.c
+++ b/drivers/platform/x86/mlx-platform.c
@@ -575,7 +575,7 @@ static struct mlxreg_core_item mlxplat_mlxcpld_msn201x_items[] = {
 
 static
 struct mlxreg_core_hotplug_platform_data mlxplat_mlxcpld_msn201x_data = {
-	.items = mlxplat_mlxcpld_msn21xx_items,
+	.items = mlxplat_mlxcpld_msn201x_items,
 	.counter = ARRAY_SIZE(mlxplat_mlxcpld_msn201x_items),
 	.cell = MLXPLAT_CPLD_LPC_REG_AGGR_OFFSET,
 	.mask = MLXPLAT_CPLD_AGGR_MASK_DEF,
-- 
2.19.0

