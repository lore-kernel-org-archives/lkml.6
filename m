Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51503C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7EC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675625;
	bh=P8FJaj+ZbPNh46pQqM3sch+2BOPlHiPNoYHMUQ86CoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=clmxw1rkaf1ha331j4RgR4bRh6t+jbk1EASp3RAN2vSZBkFL9cd3JY19F3Fqax9Kd
	 AHTcEh9Ql/uqGLvSIbqBCBQ1v40vqoYdvy68yjfZE+MsFFhFrjn8pn/fFvBGzNJv9Q
	 NgjBTTtAijcOpJhUDnrIeBn8NJt2IthVZ867+ttI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7EC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeLMEdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbeLMEdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF9220672;
        Thu, 13 Dec 2018 04:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675616;
        bh=P8FJaj+ZbPNh46pQqM3sch+2BOPlHiPNoYHMUQ86CoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utHhmuyYndkbm8D+aLGRaVuhqroGAbNfCr0tMkvmwS7XwtznT803NfYaDMby1W8b/
         cRNphj+mynF5gWqak4XV2SkSiWqpWJ703T+6JOXi20HJOMYwGw5Blo9Dmw0nI/3q0+
         1QRU5L7W/OfRcOsjdHmqQw8jvS0zGvc1waM2oFDQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 21/23] cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)
Date:   Wed, 12 Dec 2018 23:32:57 -0500
Message-Id: <20181213043259.76643-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043259.76643-1-sashal@kernel.org>
References: <20181213043259.76643-1-sashal@kernel.org>
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
index e7b478b49985..8bef27b8f85d 100644
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

