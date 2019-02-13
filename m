Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C31BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A700222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026744;
	bh=X49ohnDIm5wUUx8INhd0YOnPIGraaH2fNuB2nlyoh0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rfjvVyw4Xp2HDb2W3FdtgoYO3dJPgCrBJLK2YiuWqSwGQc3KN7XbutjkMavwxbEa8
	 FP2FEmRQAv5IrDBuYFREbpGl2GzDOTml+bMnOnhyT5fcpmBezAuKY+6mIt5teJwlqt
	 um1wk9UilbK5DQgILC4mvpzTucCrW9Z3dYW1ruZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbfBMC7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:59:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbfBMCgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BBEB222CA;
        Wed, 13 Feb 2019 02:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025384;
        bh=X49ohnDIm5wUUx8INhd0YOnPIGraaH2fNuB2nlyoh0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CtA8vtNeF2P5SYLXGlE8YwYKkH31LFenI23uxBsSYkEg4lxS0fkejscqK+wzS25sz
         6DvMffuUzL6AuCZYpCmvN/+1s2gx7C4ROsSRP8NB/vl7LJ2RHkFO63+jqfTlg+bOll
         8KL8XKHIHMzf/crRcrZ5w2wFi2v8BfZr+P6U8RqQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cheng-Min Ao <tony_ao@wiwynn.com>,
        Yu-Hsiang Chen <matt_chen@wiwynn.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 093/105] hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table
Date:   Tue, 12 Feb 2019 21:33:24 -0500
Message-Id: <20190213023336.19019-93-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
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
index 8844c9565d2a..7053be59ad2e 100644
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

