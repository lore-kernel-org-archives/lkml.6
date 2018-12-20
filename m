Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498B320449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298571;
	bh=X9EwunMy2rDC/GpA28C8Ppud/mJ80AKBEmUnBXFu8Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qa+v6h+/4CI8VXCV7O8B1yqxdpXbHOP6XPWevq+knqF0R0r75UbPqj2iHZZNz6Gtv
	 pCrro/KU/YUuExR77/REQL5CgskmcXso4JHkuiQqe3yVNxeSXbTcr7R5sOLIDR6YYR
	 uEsJjJWIg24MZjuH2kJk08ugW0jZVTfirb08rHuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733256AbeLTJgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730735AbeLTJ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:28:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E6D21741;
        Thu, 20 Dec 2018 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298080;
        bh=X9EwunMy2rDC/GpA28C8Ppud/mJ80AKBEmUnBXFu8Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMc3Y/gArug2ZYyrEozdjswR7ohgcuYtE+Kyl0zqwFUOmpS1VkJl6OsC/eNov+ANn
         mYxriACywYrXgBvOXZbdwusF/ClfS81BzGwxWURqCIgTItjf5AEYX/GXJFH8r5ijPv
         1eJESbqvzfQsSgKo03PCvxwp4mn884u7SsMPT/hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 63/72] cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)
Date:   Thu, 20 Dec 2018 10:19:02 +0100
Message-Id: <20181220085924.811945708@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index cb0f1fbe836d..7b95e7971d18 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -121,7 +121,7 @@ config CIFS_XATTR
 
 config CIFS_POSIX
         bool "CIFS POSIX Extensions"
-        depends on CIFS_XATTR
+        depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY && CIFS_XATTR
         help
           Enabling this option will cause the cifs client to attempt to
 	  negotiate a newer dialect with servers, such as Samba 3.0.5
-- 
2.19.1



