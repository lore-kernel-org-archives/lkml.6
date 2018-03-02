Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-441027-1519963459-2-3975813036716436846
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519963458; b=bWusnzC7Nqs2RJkerGR9g+2sX1z7JkfBfik+gHtEaVB3oME
    nx2xmGm5rimF4PDIkyT+ZQpp80MsMvN1+HRfATn8CZIoJlJrfVE5+LIMGhROmwOh
    YPUs1UFDy8Y+pfz4izO5qGrXjMEiWUQr4RB8OMiogAVBuB96xaQSZU+si81ye7Cw
    B2r0cpquV1MgKOnuviwPCay5coDRZOyOnrTwBODkLaW5cPHTc9kLgU680PrDe7EF
    dsZQ8spmYtUKPhrS5aTjqpIVgyxGtLSSzQTs4nFrZ3VknKgA+tSHrBHLygWLtFmO
    1WlkFtgeAkmiT/lwBzc2WCztLsfyIYcAQtrvDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519963458; bh=rEB95E/ATwxTmP2l2XrhYNjl2ql9TRoxEkgyJ5GI2bE=; b=A
    qGy9YJWlcVG8GVWni6/CzPHeaIcBRqIxqpfRyn4piALStce9h1x7bJK4gVTJFWFQ
    rUZ+BMk5Hc4IXHysTOcUz2aWP+R1Qj6OyR0nI5gQU8FfkEozImjT2XFngFTUIXaj
    9BEIthXQVwMTupF5ubsY2QkXrg9pfX/Y4thgOOac3BIUegIFduw9paXaXeihSwf1
    x+5MEmIkSWGLJ6hT/lNl2BR8vsAWz434ajlDoShl1x4fycoBAhieur6K0TAscMtt
    B+IV+STuZ72kYEwu+AY7NuRoWOk9t+ICmkgKy9Nn3Qbcyc9yfH2ql1CZYw3eOgDp
    afhPMwON4JoVCBiAWhBWA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164921AbeCBEDn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:03:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:19606 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164868AbeCBEDk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:03:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="21455146"
Subject: [PATCH v5 11/12] dax: fix S_DAX definition
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:54:34 -0800
Message-ID: <151996287403.28483.8962319815764432894.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Make sure S_DAX is defined in the CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y
case. Otherwise vma_is_dax() may incorrectly return false in the
Device-DAX case.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b2b2e15d227b..1242511b1c46 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1859,7 +1859,7 @@ struct super_operations {
 #define S_IMA		1024	/* Inode has an associated IMA struct */
 #define S_AUTOMOUNT	2048	/* Automount/referral quasi-directory */
 #define S_NOSEC		4096	/* no suid or xattr security attributes */
-#ifdef CONFIG_FS_DAX
+#if IS_ENABLED(CONFIG_FS_DAX) || IS_ENABLED(CONFIG_DEV_DAX)
 #define S_DAX		8192	/* Direct Access, avoiding the page cache */
 #else
 #define S_DAX		0	/* Make all the DAX code disappear */
