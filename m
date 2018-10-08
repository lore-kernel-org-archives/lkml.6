Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4266EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D364214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2YVFx9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D364214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeJIBts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbeJIBtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D0820C0A;
        Mon,  8 Oct 2018 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023804;
        bh=/Fc0WGzm5vRDnmPOI1Jn1b0boUhPAOy7qsrQ0bTZ4rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2YVFx9U8sF3EgfClFA5bn3ZnKoJaBFUP+iGgElBc7yqUHnuDHdF0T3soDYxt/dx+
         yjgLcIQoinPgJCiQEL5LCB9HvEJMcc4Ds862RiUGKL3CMebaJ3vZmv3EoFd8BOfktf
         m2eHzfw3fPScLIlyMgZkaiGfFTyJGFJrHNWEfMJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 090/113] tools/vm/page-types.c: fix "defined but not used" warning
Date:   Mon,  8 Oct 2018 20:31:31 +0200
Message-Id: <20181008175536.262785738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
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

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 7ab660f8baecfe26c1c267fa8e64d2073feae2bb ]

debugfs_known_mountpoints[] is not used any more, so let's remove it.

Link: http://lkml.kernel.org/r/1535102651-19418-1-git-send-email-n-horiguchi@ah.jp.nec.com
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/vm/page-types.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -150,12 +150,6 @@ static const char * const page_flag_name
 };
 
 
-static const char * const debugfs_known_mountpoints[] = {
-	"/sys/kernel/debug",
-	"/debug",
-	0,
-};
-
 /*
  * data structures
  */


