Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F554C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E642145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdXjsgfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E642145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeK3BXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbeK3BXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10712208E7;
        Thu, 29 Nov 2018 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501065;
        bh=5q2NEILofJZ7uHnulWLelzH1f8jLa/Wdw625hWXGwMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdXjsgfmM+YEs2NvNPSmgJ7fXh7tl8mtMrlSI1tK+4YqlaZShSGD805pFxgaaek1i
         OvQ4W9LxYZ7TJhIWgzUtB3lY9BuCkGzxlibIzjPf6RK+vp6c75x8DpzJFrsKb+/nqa
         y/9xhbQ56Vwv8KIFbiSnRReAk1b49R/lq/Nu0Xwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        Borislav Petkov <bp@suse.de>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/86] x86/entry: spell EBX register correctly in documentation
Date:   Thu, 29 Nov 2018 15:11:53 +0100
Message-Id: <20181129140112.287500330@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 75ca5b22260ef7b5ce39c6d521eee8b4cba44703 ]

As EBS does not mean anything reasonable in the context it is used, it
seems like a misspelling for EBX.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Acked-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 8be48b1d7596..b569b46660fc 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1208,7 +1208,7 @@ END(error_entry)
 
 
 /*
- * On entry, EBS is a "return to kernel mode" flag:
+ * On entry, EBX is a "return to kernel mode" flag:
  *   1: already in kernel mode, don't need SWAPGS
  *   0: user gsbase is loaded, we need SWAPGS and standard preparation for return to usermode
  */
-- 
2.17.1



