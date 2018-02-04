Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-479967-1517786094-2-5905234850527737182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517786094; b=AIcplTBqTMoQx5E9ty/dl2sWO4ouP69fYt90zK7NA6DMD74
    6qKtntbBd8lFtbfQR65Q0kHXFkf2/Lh3rnVzAz5cZgeZGk0Z5jCpsjGA72Pe1M+J
    k/yKn70mk2IgI38bYmE7033iplxLP0OwPkLTElyGHUEDOYQyHgwoEMg5pj1g1neO
    sJ0p7RZqEIwg4qLRlI1cN9B7ADLP+Zw9PUS7q6pB/StdglhB3adtN3P1mjxZ/s8i
    CWWJTTxJxdxCWQesb0rCYYbepVvIjB0i+zA1GMKHmeNHKvP9USfZ4lbozNhLjQXI
    BRpPK7oHxYBTy29kHZ5+65ixhnzzgJk6eBwvs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517786094; bh=Crnldqxvaqo9tAGdOT+cMpqMCnRV7Sh4tJOhyrmtc0A=; b=M
    xcRGCkqxvaPbCUk4gZArCfYMd3irKNIxm1C5OXfa8Ku7VhYlWpngXGzPQLXjDQb8
    QdiJGZwc/NlQ1mv//we82YhrTk5bp13YWfy6ko3FvNw9WNWAFXcd4Jdocjf7mEIQ
    07EY9d/HZYnoSHX+OHm/D5kVhyL9Z6Ucamd4FHxe/ZQJl0v9lhoeSn6bmwF8EzIu
    WhAQOjo0s0rzJhKKMxtjBkEVvGUfoXgdiBy06M0xRjEtct9Or62B8UHgcH867+Xc
    P7PoqNy2UumoBKdV6FdKdvLlH9CI+bdIiWm4qvLoQtmZcYf+y3+ffdSlqhU+OIVG
    IGTPL05m1+Roh4O7bOIvA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeBDXOe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 18:14:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:17693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752110AbeBDXO0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 4 Feb 2018 18:14:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,462,1511856000";
   d="scan'208";a="198582639"
Subject: [PATCH 1/3] dax: fix S_DAX definition
From: Dan Williams <dan.j.williams@intel.com>
To: alex.williamson@redhat.com
Cc: jack@suse.cz, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Date: Sun, 04 Feb 2018 15:05:20 -0800
Message-ID: <151778552057.7139.16434857860597414697.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
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
Cc: Jan Kara <jack@suse.cz>
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 511fbaabf624..a3329258ff5c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1850,7 +1850,7 @@ struct super_operations {
 #define S_IMA		1024	/* Inode has an associated IMA struct */
 #define S_AUTOMOUNT	2048	/* Automount/referral quasi-directory */
 #define S_NOSEC		4096	/* no suid or xattr security attributes */
-#ifdef CONFIG_FS_DAX
+#if IS_ENABLED(CONFIG_FS_DAX) || IS_ENABLED(CONFIG_DEV_DAX)
 #define S_DAX		8192	/* Direct Access, avoiding the page cache */
 #else
 #define S_DAX		0	/* Make all the DAX code disappear */
