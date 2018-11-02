Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD789C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FD62082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz9STM4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FD62082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbeKCEBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:35 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E96520848;
        Fri,  2 Nov 2018 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184800;
        bh=3TH8i8Y1v1rVHSD/WKylId06xFG/3c0cDtNvgUimD6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oz9STM4KT5jgV0RqXrXYcAlo+pYq5j26Pkmzl0J3vlqwWW4bwpxTf7z45Lr8AGvDc
         UKWJEw0f4R4Td9sL4yPS9H6VAfkkfevUQtWw7CjRfLlimf+CQNuHjGDpekyW3vb/t4
         Vo4jlZOn9N7hub1gg3nCZKV5AaSGNLMKfDHteaGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 071/143] cifs: Use ULL suffix for 64-bit constant
Date:   Fri,  2 Nov 2018 19:34:16 +0100
Message-Id: <20181102182903.013109044@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -712,7 +712,7 @@ cgfi_exit:
 /* Simple function to return a 64 bit hash of string.  Rarely called */
 static __u64 simple_hashstr(const char *str)
 {
-	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	const __u64 hash_mult =  1125899906842597ULL; /* a big enough prime */
 	__u64 hash = 0;
 
 	while (*str)
-- 
2.17.1



