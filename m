Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BD7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E02721571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="GBFXZjBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E02721571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeI0Vax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:30:53 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:45295 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeI0Vax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:30:53 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 17:30:52 EDT
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w8RF0mlh040798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Sep 2018 10:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1538060449;
        bh=4u4JTW4q3QRUDm25erCFoTcYAjnDpOC4BWAK//MFNsk=;
        h=From:To:Cc:Subject:Date:From;
        b=GBFXZjBZieXDSi+DHpORwy0l+KBfbwTGZc9G74tOnJPd4dPQrivVTuU+43PtCRlJ3
         wbT7CbKBLExCjGW6Rc/REyufJRJhEcL33g0ldGRG40vh4f517Ev//Mks4nIMYYdERD
         sp0LN5CTeaVIbg9Fqy61pipc74MNwz9kr0N58dfA=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w8RF0mLN011577;
        Thu, 27 Sep 2018 10:00:48 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     hirofumi@mail.parknet.co.jp
Cc:     linux-kernel@vger.kernel.org, Mihir Mehta <mihir@cs.utexas.edu>
Subject: [PATCH] fat: Expand a slightly out-of-date comment
Date:   Thu, 27 Sep 2018 10:00:46 -0500
Message-Id: <20180927150046.11538-1-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Thu, 27 Sep 2018 10:00:49 -0500 (CDT)
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
 fs/fat/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index b833ffe..d954e18 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -368,7 +368,8 @@ static int fat_parse_short(struct super_block *sb,
 	}
 
 	memcpy(work, de->name, sizeof(work));
-	/* see namei.c, msdos_format_name */
+	/* For an explanation of the special treatment of 0x05 in
+	   filenames, see msdos_format_name in namei_msdos.c */
 	if (work[0] == 0x05)
 		work[0] = 0xE5;
 
-- 
2.7.4

