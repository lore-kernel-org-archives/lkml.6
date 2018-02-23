Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2089732-1519370888-2-10847620558033069520
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519370887; b=nRnWp+UlwHzidVjLucvMB22/xKVi2d0TwsB87j6QIaX17j0
    Z3LYC5GTyqQ2TMotOApEObyS6lNAfTGxw+8SOTBF1v1BtgdRDSFoyx+I3edcFl+g
    /LVYEwtIA5LzXsJe9gsI5J8DX3A8PpO50Z7NGXrJ8MZxLI8kYRwAa3bcnV+Xw7z3
    vShK/NN8JWpQQ5WJWsVMc3dssIR0JB5JuoXBaYqVcA7Tzc8sO0F/dNKBJdgtheYi
    T8OxqH21dqu7RwDEHXv/twu0EASqLMk3li7iqS7zOIVq++PFu4/J/rECBMoyrt6X
    80pYfdlWU4516ZsBsIUsSxgpTLjCNiAnXjjsOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519370887; bh=p74spGPsJdtO7lp/asHyp0UJ9QkdYixp8GQy8LwqZjI=; b=O
    23Q9Q4MvBNByfCcd6XLXRsHeZdtxsx6jfcMf/AiFb/OH1SeSOU6IuTzKaYngUpjY
    vjcM4rHNnSRQU0tVAxCNW+hk7vvCM2eqYCMUS0rrjKzwvJZSm5GbytRJr3kMNBWf
    ciiQsBdCr09FDUpoJ2n52ySpeZamAzYsAURmr5xhiSOhFmETf+ctJTPIIrYJZmc4
    A9x2mz55fQMswGCCYtY8Gh9gClv0WBCZI5PGs3moJBR/MFTkTm5BjXzrQpnAyftr
    aEC4R7gF3BEYMgL5qWa5MpOD6TlWRTKEobI3HKzpkFATqtf2i+UPpQTQfDDdXdiq
    157sJRHBIG7kd7nsUSg+w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeBWH1G (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:27:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:41453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeBWH1C (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 02:27:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="36845437"
Subject: [PATCH v2 3/5] dax: fix S_DAX definition
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Feb 2018 23:17:56 -0800
Message-ID: <151937027614.18973.7636331271085629639.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index 79c413985305..b2fa9b4c1e51 100644
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
