Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E584C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E1620870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOd+bkBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E1620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeJYWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbeJYWtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F3D20848;
        Thu, 25 Oct 2018 14:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476984;
        bh=IHB1PiIXJkhHNYTgMHoa0wylMx94HHp6TSUzeEQF7fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOd+bkBfvh7WQUR6MGJkgrG4wFJhZl7G9oFDrvG86vu13wsmKcWbNQFbsrut+oKCi
         OaOfBLHuB14crimA3rR1TAFzmzLRlENv9VPTSv8VeegJFQhnLN5QSd3rgmiLeZY9b+
         g6R5DofTc5bSwc2oI+Z3i5kDkBGHIERhpxD7Kan8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 82/98] cifs: Use ULL suffix for 64-bit constant
Date:   Thu, 25 Oct 2018 10:14:07 -0400
Message-Id: <20181025141423.213774-82-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

[ Upstream commit 3995bbf53bd2047f2720c6fdd4bf38f6d942a0c0 ]

On 32-bit (e.g. with m68k-linux-gnu-gcc-4.1):

    fs/cifs/inode.c: In function ‘simple_hashstr’:
    fs/cifs/inode.c:713: warning: integer constant is too large for ‘long’ type

Fixes: 7ea884c77e5c97f1 ("smb3: Fix root directory when server returns inode number of zero")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a012f70bba5c..77a18fe10805 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -704,7 +704,7 @@ cifs_get_file_info(struct file *filp)
 /* Simple function to return a 64 bit hash of string.  Rarely called */
 static __u64 simple_hashstr(const char *str)
 {
-	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	const __u64 hash_mult =  1125899906842597ULL; /* a big enough prime */
 	__u64 hash = 0;
 
 	while (*str)
-- 
2.17.1

