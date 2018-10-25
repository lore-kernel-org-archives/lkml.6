Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F16ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E98F20840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2inf8dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E98F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeJYWoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeJYWoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD53D20848;
        Thu, 25 Oct 2018 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476685;
        bh=oBILSpFjPQVIx8vSZXYdE9YuEdMisgHIni1h9IC6BCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2inf8dxDnt+eBzMzfBMyb9fLKCDtffSuC8gxDXtql72EeM5DGdkp7Z+ctC5BUpdb
         mD6fN1BXcu251QuWCLqNAk6O4aW/gNE8DRM9kqQkB8ajdZPtfcXwiu34hGxvOfe2jW
         cnLajarDK+HgNkQ/EgjcRkasRjHvaOe+UCCDW4yQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 22/46] cifs: Use ULL suffix for 64-bit constant
Date:   Thu, 25 Oct 2018 10:10:29 -0400
Message-Id: <20181025141053.213330-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
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
index 2cd0b3053439..d01cbca84701 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -712,7 +712,7 @@ cifs_get_file_info(struct file *filp)
 /* Simple function to return a 64 bit hash of string.  Rarely called */
 static __u64 simple_hashstr(const char *str)
 {
-	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	const __u64 hash_mult =  1125899906842597ULL; /* a big enough prime */
 	__u64 hash = 0;
 
 	while (*str)
-- 
2.17.1

