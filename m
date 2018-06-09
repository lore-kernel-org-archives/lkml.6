Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kmSmOPBHHFvNfgAAmS7hNA
	; Sat, 09 Jun 2018 21:34:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB504608BA; Sat,  9 Jun 2018 21:34:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7FB306032D;
	Sat,  9 Jun 2018 21:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FB306032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=twibright.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753415AbeFIVem (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 17:34:42 -0400
Received: from 109-183-129-149.tmcz.cz ([109.183.129.149]:37166 "EHLO
        leontynka.twibright.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeFIVel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 17:34:41 -0400
X-Greylist: delayed 1789 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jun 2018 17:34:40 EDT
Received: from mikulas (helo=localhost)
        by leontynka.twibright.com with local-esmtp (Exim 4.89)
        (envelope-from <mikulas@twibright.com>)
        id 1fRl2V-0003Wn-Ba; Sat, 09 Jun 2018 23:04:47 +0200
Date: Sat, 9 Jun 2018 23:04:47 +0200 (CEST)
From: Mikulas Patocka <mikulas@twibright.com>
X-X-Sender: mikulas@leontynka
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] hpfs: Use EUCLEAN for filesystem errors
Message-ID: <alpine.DEB.2.20.1806092257450.13306@leontynka>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the error code EUCLEAN for filesystem errors because other filesystems
use this code too.

Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>

---
  fs/hpfs/hpfs_fn.h |    3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-4.17/fs/hpfs/hpfs_fn.h
===================================================================
--- linux-4.17.orig/fs/hpfs/hpfs_fn.h	2018-01-10 09:31:23.000000000 +0100
+++ linux-4.17/fs/hpfs/hpfs_fn.h	2018-06-09 22:54:58.000000000 +0200
@@ -26,8 +26,7 @@
  #include "hpfs.h"

  #define EIOERROR  EIO
-#define EFSERROR  EPERM
-#define EMEMERROR ENOMEM
+#define EFSERROR  EUCLEAN

  #define ANODE_ALLOC_FWD	512
  #define FNODE_ALLOC_FWD	0
