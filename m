Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B2E2184E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130409;
	bh=1kv7jXhXkm5j9pbKQeCKwJ2FkO9luoAJWOwQjCUSFns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nyFP8wwtwK5x/BmhO0lQ6+0MDI3MxAv9oIZxz/5vJbdiz+LUGJun9da8pekCaZ++a
	 Bho6JRPosXfRJnZpUcd9HeRXMSH4JHJ04aGoabBysFHVgx6tBv5Gj6Zi9MrfaD9vSD
	 qpJq4ddTav2zzbLao+9qRrnGuTD1/s/XixYdewY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfBYVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732655AbfBYVdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA0F21841;
        Mon, 25 Feb 2019 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130400;
        bh=1kv7jXhXkm5j9pbKQeCKwJ2FkO9luoAJWOwQjCUSFns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7n/Ce04S/59gDLBfpGZjQI5gAnQ/vqQ+zrLnhtAFzhVSK5JZk902sddYitOZw+gq
         +i75VwB8SM3QwLuW+rPdQmX4156qTl5NLcnQt/eC1B+9P1msbd+wYtNSd3CxreEAr1
         kpYcqyXJB6SQY8iFev/DnNfRPddMYtfXTojhaUKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cheng-Min Ao <tony_ao@wiwynn.com>,
        Yu-Hsiang Chen <matt_chen@wiwynn.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 110/183] hwmon: (tmp421) Correct the misspelling of the tmp442 compatible attribute in OF device ID table
Date:   Mon, 25 Feb 2019 22:11:23 +0100
Message-Id: <20190225195113.226104453@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 8844c9565d2a4..7053be59ad2e4 100644
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



