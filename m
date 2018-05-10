Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994144-2-18432739986276411186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994143; b=WtM3/IjO9bH1b8eeLfRrm5JOQVUPjSaReRYEubx9B8tMGTLhzi
    sdQ3hcXEfAb+FwzOmtI8JS/y6FWwk3ge5qbf4MhAmlUc7xfx0STWY2dYKC8tAS6/
    Cwd7TeWlDbT9K95S4FFbbYjtdqzRXV/RabsML9qaKm7Oqutf2NOMTqUC3bOXpRtx
    ak6UQvdADksVRauk5inpZJPgGp8TWmfg0763cwtkK3cT7DCR/DJL6qTXWutNmblv
    b+1iKKAy/TPpgmO47MUFxDwPt6nEvNiAEj8AK9aMl/aB3XMODz3P6+LN2SuK1DmZ
    gdxpgrMToPAq1Lta0VyliPAvC9Los5NlEZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525994143; bh=
    ppCIzkRqlyMY4LaeOzdSR24UcqWN9ZLXPsJxBYnJn4I=; b=FMT4onHBtp8mYfmt
    LzrVZvOFRYMB8uHRqPx9rHkhZ4kHwFngASE3sQHgbvLy7SJBx6tjdc2zW4A5OC3G
    yzqGdpujFZMk3Gq/9nhP89eeoX6//06VefHrv3rgdOY69/GmelrftM3Y++KKwAuI
    Y3BANUrK8A/SGrq1zqRsG87zFQ7bhKyBmlNGzxoWDWWh1CD2TJg0sxK9QEDeD6B4
    ke0RlHtnHsXJhyf2i/piPa+UaQZh16s/0STQ4ZqhyO0uA3DX3xI2dJ2vYHhcfhUd
    89GV4lHECwFiq3lAzdQZnRFsH8Tw+CHkSzpUWosW1HDHeTF0rzesKOa9EA+pJJPY
    WWYLQg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Rf+cJiRT x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Rf+cJiRT x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCI8xd7oEbocJiAMGflaGIJrOevQ5D/no38UcPj2b8pNWuI2eFI7l5DXcAKYWwXC8bcxwjDh5n/ym/BFpDpvP+U7qEQIPwddzZVixaCMttIRLLz4EXvP
    RWGQLMYDbixk6fhXhSRrt/iqhZRpaqMlzeX+ywWi0YLhiAYRs+U4nrRE8iy0cYxu1j0KVgeFy/3IysONFS8CkCuXXYK7/+0EycS+8RuL8j9gmrKHAtvRIeNu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=R3lB337yEIZaQDNGCekA:9 a=rqw7mSoZ1ZR_Sk9o:21 a=tz07tDrAf94JNcnt:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeEJXPY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbeEJXOH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:14:07 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc: sandeen@sandeen.net, dhowells@redhat.com, fliu@suse.com,
        jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 2/4] xfs: add verifier check for symlink with append/immutable flags
Date: Thu, 10 May 2018 16:13:57 -0700
Message-Id: <20180510231359.16899-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180510231359.16899-1-mcgrof@kernel.org>
References: <20180510231359.16899-1-mcgrof@kernel.org>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Linux VFS does not allow a way to set append/immuttable attributes
to symlinks, this is just not possible. If this is detected we can
correct this with xfs_repair, so inform the user.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 fs/xfs/libxfs/xfs_symlink_remote.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
index 5ef5f354587e..42dd81ede3d6 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.c
+++ b/fs/xfs/libxfs/xfs_symlink_remote.c
@@ -242,5 +242,10 @@ xfs_symlink_shortform_verify(
 	/* We /did/ null-terminate the buffer, right? */
 	if (*endp != 0)
 		return __this_address;
+
+	/* Immutable and append flags are not allowed on symlinks */
+	if (ip->i_d.di_flags & (XFS_DIFLAG_APPEND | XFS_DIFLAG_IMMUTABLE))
+		return __this_address;
+
 	return NULL;
 }
-- 
2.17.0

