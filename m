Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064F6C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74883206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.utexas.edu header.i=@cs.utexas.edu header.b="CzQKSc3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74883206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.utexas.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJCGeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:34:31 -0400
Received: from newman.cs.utexas.edu ([128.83.139.110]:46043 "EHLO
        newman.cs.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:34:31 -0400
Received: from vyasa.cs.utexas.edu (vyasa.cs.utexas.edu [128.83.130.99])
        by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id w92NmZI1039730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Oct 2018 18:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
        s=default; t=1538524115;
        bh=dkrY+DqnTAJNptUr3/EePmEwiO9FYAvv/i57aampzyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzQKSc3y2ZMMoWdiMaltQctMyMFA6FReT7W7MB6PK8UFbRNJmdBT8GHLixD9gWHGB
         0zQalZCoshL/eVleNX8pknBpZnBbeId4S8/pNSglGu6KJvbxepXe0qoI25WCBOTuBw
         HYmACktpTQVO/WF0aiFcxXBv4Hgqiz1oxa5w3a4E=
Received: (from mihir@localhost)
        by vyasa.cs.utexas.edu (8.15.2/8.15.2/Submit) id w92NmZK0028776;
        Tue, 2 Oct 2018 18:48:35 -0500
From:   Mihir Mehta <mihir@cs.utexas.edu>
To:     akpm@linux-foundation.org
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        Mihir Mehta <mihir@cs.utexas.edu>
Subject: [PATCH] fat: Expand a slightly out-of-date comment
Date:   Tue,  2 Oct 2018 18:48:23 -0500
Message-Id: <20181002234823.28713-1-mihir@cs.utexas.edu>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002153232.fe76b9661ce1f226338f7654@linux-foundation.org>
References: <20181002153232.fe76b9661ce1f226338f7654@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.9 (newman.cs.utexas.edu [128.83.139.110]); Tue, 02 Oct 2018 18:48:35 -0500 (CDT)
X-Virus-Scanned: clamav-milter 0.98.7 at newman
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file namei.c seems to have been renamed to namei_msdos.c, so I
decided to update the comment with the correct name, and expand it a bit
to tell the reader what to look for.

Signed-off-by: Mihir Mehta <mihir@cs.utexas.edu>
---
 fs/fat/dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 7f5f369..ce5f958 100644
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

