Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB6EC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604921934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026268;
	bh=qND/tzvc7JIgtuenQ1WcIjulKE/Qx61mW8iVL2pqh/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpirdoyh7WyB47WSWYMYEJYkbGItiNbboNd5OWt65A3WucL8lugBlA0ntAJUnWq+G
	 VnKag7uNqMuZ3YCT5AOJN+X2t+kOfucZ3IyDEnXAMgDgg5tGT06PeDyWf1cMDowFpy
	 iOLFrfKZSjsJmnXgELgiOA0DWY4UVP1zERy0GKKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfBMCvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388722AbfBMCj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCC2222CA;
        Wed, 13 Feb 2019 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025568;
        bh=qND/tzvc7JIgtuenQ1WcIjulKE/Qx61mW8iVL2pqh/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8vv0Xi/zo0wQev3RPG6OcChDsQ6XftaQVnIbDD+pz6BjS9UH4tT6N+xtS1L1JGUU
         drDM408t3LTZDHB8NOn8EXYLaUcXkbEwSi/kf6xneuj+5bx73a+XhJ+HLqu2aDLgyQ
         bCdX/BkdZJ7XVHunHf/eqYpfc88BC3G3E3y+mQFo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng-Min Ao <tony_ao@wiwynn.com>,
        Yu-Hsiang Chen <matt_chen@wiwynn.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 74/83] hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table
Date:   Tue, 12 Feb 2019 21:36:52 -0500
Message-Id: <20190213023701.20286-74-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cheng-Min Ao <tony_ao@wiwynn.com>

[ Upstream commit f422449b58548a41e98fc97b259a283718e527db ]

Correct a typo in OF device ID table
The last one should be 'ti,tmp442'

Signed-off-by: Cheng-Min Ao <tony_ao@wiwynn.com>
Signed-off-by: Yu-Hsiang Chen <matt_chen@wiwynn.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tmp421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index e36399213324..ceb3db6f3fdd 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -88,7 +88,7 @@ static const struct of_device_id tmp421_of_match[] = {
 		.data = (void *)2
 	},
 	{
-		.compatible = "ti,tmp422",
+		.compatible = "ti,tmp442",
 		.data = (void *)3
 	},
 	{ },
-- 
2.19.1

