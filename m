Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406650-2-14850343305352413100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406650; b=PdM+A4Lq7uO9rqs96kDj83zw8iiHb+MhiqvoeEXbhcoNxA/gOu
    PF0ereCLVFsj+9C/2CB949jBF76nmkxeZNq8jbvbeE2joSkuNRtIg26+VZ76qjZw
    ki0r3HgjyNeLesSzRFis1zSgkw1F/Rlcqj5RZ/AcHKkWMcRLRk/8poIWi22u7jOo
    IOcqaSNbdWqR+Jn2SSYEXk91tkzcuAbdttIK0VpW3/KiNPLYTRe7+ITWLpKXplRW
    gr0rvpLyW7iwdVL85XMfr/Zt0n+7LNwGWhLAJT92BKtvv1Xvmg5N1nTYTss52PIG
    H4teBO9/SbaaNwPezSUxkCZlMiVSRrOTGuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406650; bh=7D75LwFb1LASn4v9nThlD2GFnXNAwj
    QMiDIv/fxCnrw=; b=mCF+IhZVAxNkRahv+MMuNPU1jxYxRSdKGVLUpg45PN9RYW
    piWiYjUXYO9a9j89nWKoViEAdziYe42cmdNfLvu0mp1a6pDPyAuD620DvV+a8iCU
    hlrveIgEE0fNrPtAtO+Z0kMb4VhXOwNprwlLWsGaDk15t1j/sT2OaMb9jCToaGlI
    yfrvgubh1KVYObxbvrTRBPIDjakRV/Lcsr5HYTUT0YcDXvlJMNwPkUxoprltfAQd
    gM21pBE1aabvDOl7TjeXWnZ8Avlw83omYE5UMnMP3fV7tnynnhAVtRTnMraGV+zL
    +p8NaDtZGku4rgzxrfCNdcpJSbEVEU2uCejcD4gg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF+0+SHgeP01VNr9fQnm4FBuduNWmJfcLkBfaXCDuo5FsxK/bet82EGbLtZelf6Eqd8odALd+Qv0o2Fl4/TqmtHIOGZ/Wj8ME5EldFHFNUpGQcZdh8eG
    VoCzNknwiC5q0cZsqhMoyFt+VIlOp/iNUT7AVzG4FbPqjMUu9SuDXKo0MJtOVDNzbMCWot7hlWd1OGcU19WDDout3MOIatH7DR00bANGOO+JQRkTFhx750Fa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=tvyFtlzUmmTVg9JsgHoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeDVOR0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:17:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeDVORW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:17:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wen Xu <wen.xu@gatech.edu>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.4 51/97] ext4: fail ext4_iget for root directory if unallocated
Date: Sun, 22 Apr 2018 15:53:29 +0200
Message-Id: <20180422135308.136426210@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44 upstream.

If the root directory has an i_links_count of zero, then when the file
system is mounted, then when ext4_fill_super() notices the problem and
tries to call iput() the root directory in the error return path,
ext4_evict_inode() will try to free the inode on disk, before all of
the file system structures are set up, and this will result in an OOPS
caused by a NULL pointer dereference.

This issue has been assigned CVE-2018-1092.

https://bugzilla.kernel.org/show_bug.cgi?id=199179
https://bugzilla.redhat.com/show_bug.cgi?id=1560777

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4231,6 +4231,12 @@ struct inode *ext4_iget(struct super_blo
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
 
+	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret = -EFSCORRUPTED;
+		goto bad_inode;
+	}
+
 	if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE) {
 		ei->i_extra_isize = le16_to_cpu(raw_inode->i_extra_isize);
 		if (EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize >
