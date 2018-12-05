Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB7C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E8920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ncaGGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E8920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeLEJgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727583AbeLEJgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:23 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2910A20850;
        Wed,  5 Dec 2018 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002582;
        bh=+ncAE5kEEOzgn9AOnTgg8lGrzCtguiQMB2Kw1wL5WbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0ncaGGZOEv0a3AM8qo7sR3hwG3MURmJHLwKgzp/CKuw/PpdCad0F7RUlGiMbp9oL
         DKbYypKEenhTfPtt8/GMfu9pT0VXPzOmD1pPG9dB/b885Uq2Qtaja1JoJWldLFgiO0
         VffGsArMRiuWmXTTd+sArLg+RWpqLT/T0HgMZFc0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 007/123] staging: rtl8723bs: Fix the return value in case of error in 'rtw_wx_read32()'
Date:   Wed,  5 Dec 2018 04:33:59 -0500
Message-Id: <20181205093555.5386-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit c3e43d8b958bd6849817393483e805d8638a8ab7 ]

We return 0 unconditionally in 'rtw_wx_read32()'.
However, 'ret' is set to some error codes in several error handling paths.

Return 'ret' instead to propagate the error code.

Fixes: 554c0a3abf216 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index c38298d960ff..4f120e72c7d2 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2289,7 +2289,7 @@ static int rtw_wx_read32(struct net_device *dev,
 exit:
 	kfree(ptmp);
 
-	return 0;
+	return ret;
 }
 
 static int rtw_wx_write32(struct net_device *dev,
-- 
2.17.1

