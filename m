Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705837-2-11344945499135450038
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
    t=1519705836; b=w0ssWhoMrg9St3r1wSksuqL2fAN7kSyEQYHnEpvQ5eQAdlA
    higzV+34zxBb6MnOsBxkE9FpulZajda69+KyFR++JDwHeQjSkeTEOmEbMu99zqd4
    qThUBCEdizGdkScX0FMwpuMZYtuQcZJqNFJ0A1QX6sFkAccY/FN9HqnohYo8JJlp
    eKvmgUZomlXLa8xjyKBLR4USPIvx2DXFskJpvV1TEHEH9LbbiiJx3SJKuV8wLayd
    +6r7TKofR85/2Jgqkg0AYns20zVDenXBZ3MObeAH2kv1sFj2J1n8YuCFrJ8xViCA
    vaIRjErDigHX11kuvoWS/30K7Sj8zVLVQsQXi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705836; bh=vl3YozDTuX41zQGt8KUuiP/JI2Mvz8vHnGcQzkUTFCE=; b=S
    qFBzn1q2/J2djrO64qQuP117rPHGZXfCPu2k6zNIfgcweaHJxvs9oR08hHVu+Gqe
    JszKLXs6tNVPLal5a9AN5w5QdIHMOHZR9T3J9h30+hjFRdrMIE9gbavvKecS8n9q
    oBWXEsg2+KSbJGfIQiN6CDFUSlBUziwGuji4wM/J8g14t/3MGWMFmriVs2U/+XoF
    CMcdAvFmfpS7Sw6328nc6RGUz/tdGBodxJCrB2Km5dhltCYMSKbkF51xi+8bIV72
    mXlFN3hPwmjUbgfvkQ9660E7fP/HBvwRo18JLyLqiDgL9LG29cSQBUXaJHNEJMPe
    wjjvAhkXQ1BKVTmQqePNw==
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
        id S1752163AbeB0EaB (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:30:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:7247 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752143AbeB0E37 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 23:29:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="21310287"
Subject: [PATCH v4 11/12] dax: fix S_DAX definition
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date: Mon, 26 Feb 2018 20:20:53 -0800
Message-ID: <151970525357.26729.16503435900105555250.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: <stable@vger.kernel.org>
Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8021f10068d3..ae8d2495f51e 100644
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
