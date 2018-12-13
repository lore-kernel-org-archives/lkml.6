Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD0AC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D3220879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675672;
	bh=IEvcX6zksJVUWNU4jTjjy5Nei+aGXQOyAk6OFZy4V/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h1L6d3FrDbOnwqfo7ssAzyv+LmLkl5ZN5BmZ9FC0sMyq3Z+xKMs/cvbH0HLaCoeHm
	 JbaFXC1gEVgDGS1hYawYCfpnDvRb+bhYII9EOymqZPTeX++9BhyHZMQd5FWfu+wfaU
	 aC5fE4s8nWrHtTvpTy/bWy758K/JiIpPgU/RhwI4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbeLMEeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729512AbeLMEeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:34:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E63620672;
        Thu, 13 Dec 2018 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675650;
        bh=IEvcX6zksJVUWNU4jTjjy5Nei+aGXQOyAk6OFZy4V/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aco+lbb0ADldJk3uVIuW2SG+3BxlWoLJk/Hpzf/zLGEi+5V+O2sSWmLI3FBYZKpjN
         cULJNQj/uZhSfzkoEfRSyjOVHNgI0nyYHWpXybVRLbSutiRiGE1oGVCWwq7iv3aXj0
         BK3M4KC9PymnX9e4aoZeSyxLM3u2gxF0WsKFFXXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 15/16] cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)
Date:   Wed, 12 Dec 2018 23:33:42 -0500
Message-Id: <20181213043343.76896-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 6e785302dad32228819d8066e5376acd15d0e6ba ]

Missing a dependency.  Shouldn't show cifs posix extensions
in Kconfig if CONFIG_CIFS_ALLOW_INSECURE_DIALECTS (ie SMB1
protocol) is disabled.

Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index a2172f3f69e3..35bbf6b64982 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -111,7 +111,7 @@ config CIFS_XATTR
 
 config CIFS_POSIX
         bool "CIFS POSIX Extensions"
-        depends on CIFS_XATTR
+        depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY && CIFS_XATTR
         help
           Enabling this option will cause the cifs client to attempt to
 	  negotiate a newer dialect with servers, such as Samba 3.0.5
-- 
2.19.1

