Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3119BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB62B2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026031;
	bh=qND/tzvc7JIgtuenQ1WcIjulKE/Qx61mW8iVL2pqh/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzSG99DMnV9c0GVhM3/NdBRE4OUQCbV7o+IpEELouN20j7Ya5Kc25wpCSya2b7bjk
	 WCQjCTtylK2Im7zyvhFxlFxEJnHz4PzBE+oB9/2rAH8MDGo/S5mCU9WEILzj3hGXou
	 0niCUwntxksj/91wJuhaFI6uD450YjLvh2IqtDXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbfBMCrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbfBMCkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3E8E2175B;
        Wed, 13 Feb 2019 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025632;
        bh=qND/tzvc7JIgtuenQ1WcIjulKE/Qx61mW8iVL2pqh/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpJKFe53eZG3jnbpD/WLOHjhLr0bKe7eCejJrU/CX7OFTZhsggSnbmHaloagzjvPK
         Q1V8kxR+vlk3+98sqs1bmlEGwCqOc7f1G8713djHu6MZ7AzIDZxTGk1x2zU6b7Iyq1
         S4DjC8mxxhWiqJsRvcstgloXe6wMdSSz9YR8/aIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng-Min Ao <tony_ao@wiwynn.com>,
        Yu-Hsiang Chen <matt_chen@wiwynn.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/34] hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table
Date:   Tue, 12 Feb 2019 21:39:47 -0500
Message-Id: <20190213023952.21311-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
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

