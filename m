Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A08CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E760206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955969;
	bh=YVF0yT3f2WP404RMvkpvJDTOaXP+Ui0h05CyqKXZJDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pg14bodYG4K49ObAZpgb2NxOEN9y8VEJbp1wTDRuqeu2TdMskMBud74+tz3PFt3bJ
	 m3UdlJKMKR0aqL99vtSAPGtmVbQYUfvC+MFGXpaAR9JzK024eo5crqX9Ak8cXhXVtA
	 c6Q/hEObKtCvrB+spTAPmJCYRBDfOboS6HsOzlF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfBWVGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfBWVGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:06:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B1520861;
        Sat, 23 Feb 2019 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955964;
        bh=YVF0yT3f2WP404RMvkpvJDTOaXP+Ui0h05CyqKXZJDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6afxrt1Ra6ruD4DeUa4wK3qI9LnJk/zwiR5jii4NeGYZAEnwGUIWir9vKvuQ29z2
         voIZekrXXA+M4ITldEfkZcsfcCRC99v/TD0Br4absMfigtu5tXiHj7f+Qe/PEKsQlR
         1y6ChBKbWmtzffhhSqKHgnbF7csfspPzBBQkngyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 60/72] apparmor: Fix warning about unused function apparmor_ipv6_postroute
Date:   Sat, 23 Feb 2019 16:04:10 -0500
Message-Id: <20190223210422.199966-60-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Vorel <pvorel@suse.cz>

[ Upstream commit a1a02062ad466052a34a8c4323143ccf9726eb52 ]

when compiled without CONFIG_IPV6:
security/apparmor/lsm.c:1601:21: warning: ‘apparmor_ipv6_postroute’ defined but not used [-Wunused-function]
 static unsigned int apparmor_ipv6_postroute(void *priv,
                     ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 42446a216f3bc..7d1eeb0849687 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1598,12 +1598,14 @@ static unsigned int apparmor_ipv4_postroute(void *priv,
 	return apparmor_ip_postroute(priv, skb, state);
 }
 
+#if IS_ENABLED(CONFIG_IPV6)
 static unsigned int apparmor_ipv6_postroute(void *priv,
 					    struct sk_buff *skb,
 					    const struct nf_hook_state *state)
 {
 	return apparmor_ip_postroute(priv, skb, state);
 }
+#endif
 
 static const struct nf_hook_ops apparmor_nf_ops[] = {
 	{
-- 
2.19.1

