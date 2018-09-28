Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5F9206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="cBUyBU8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5F9206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI2CPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:15:19 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:49463 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeI2CPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:15:19 -0400
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w8SJnuOM013529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 14:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1538164197;
        bh=4HSo9XEidbY+TNBViYKSixTVMw1Va9JYeI++uw7QaQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBUyBU8Gj5d+IoT/QKQuVQKsPRkvDeMJ5ohXlL39oBZHZ8OJSeK31i60Mhym8CWeB
         j6Y7exDISMsk5bofpe3Twv1FWjvUVCH0d49nBVGhJO3R+z66rlRtOr/zA6vz7AS/zU
         pbPEtOPGPLgkW5rc914n2fUAfAmjx2Nsy5wlNXsA=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w8SJnuaF024002;
        Fri, 28 Sep 2018 14:49:56 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, Mihir Mehta <mihir@cs.utexas.edu>
Subject: [PATCH] fat: Expand a slightly out-of-date comment
Date:   Fri, 28 Sep 2018 14:49:47 -0500
Message-Id: <20180928194947.23932-1-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <87sh1tewtw.fsf@mail.parknet.co.jp>
References: <87sh1tewtw.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Fri, 28 Sep 2018 14:49:57 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file namei.c seems to have been renamed to namei_msdos.c, so I
decided to update the comment with the correct name, and expand it a bit
to tell the reader what to look for.
---
 fs/fat/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 7f5f369..f4db13f 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -369,7 +369,9 @@ static int fat_parse_short(struct super_block *sb,
 	}
 
 	memcpy(work, de->name, sizeof(work));
-	/* see namei.c, msdos_format_name */
+	/* For an explanation of the special treatment of 0x05 in
+	 * filenames, see msdos_format_name in namei_msdos.c 
+	 */
 	if (work[0] == 0x05)
 		work[0] = 0xE5;
 
-- 
2.7.4

