Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325942-2-16624747692430860972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325942; b=h/iNJrGpak2A9YhzrzW6Lfbo9Luhs0u8F+m5J3MYrpIvJLI
    r0nYhsNnw5Vmdffiqsh8ZrdtKl6f9sdh+U4UwODth0NA07RJe9YY1s7W/KgGJI2T
    ftNboyWRaULukK5kdzUFMKr/J/D56Uao3o9heA6abJUrbEP2TnWFc69/gjCPvnqN
    ud0y1GpbT8oh1kY/5RrYR3C+81PBNz+vCcz8KOEHuTrteay0oZVjZOa4y4eEB3Sk
    NY/JspsWTcp30StXfxEwExZweIHVv3DnmUKUiHLXHJa8TGzWh/4jJtDQOwZQltlV
    Ywc4AHI++PqNi8r0471Pryjs+nb4HWET/mVpbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325942; bh=WYR3sZWkiU/WtXSbB8u
    nXgtvq6De49Ag6H4pzTxg/4o=; b=Q82ZOO2QpwihAvt/Z2zx8HNWjDWTtkEqH6v
    Iphge+iPzIIAqiek/88EfOVT1Xo6dgifl24b+LzH5Y6e2gD96o38IVYx+Yysk5M+
    fnV1pUBxm86Zxq5hFopo2sLW0fq16hobVr4Ne7Bxfdfh18nMpQbNxLj575eEI4UN
    Xr6UjBE9stlJdKfYVWFCYpxOzgWihSh/eJJERnOc1UaUemNoC/PGiaf9W1v1Dt3e
    arXiKtplrf2sN5XwKA8MIrhS81YEVYbJSeXwTu38oP5ZcWLqYYHMTFaBg8VwO16m
    Fb7bLD6ocNf9fLBOOaFQNhkSXp7juDDlMHXoVF4hQEUo8JCa70w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeBKFMD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41409 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752624AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Latchesar Ionkov" <lucho@ionkov.net>,
        "Tuomas Tynkkynen" <tuomas@tuxera.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.126111496@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 12/79] fs/9p: Compare qid.path in v9fs_test_inode
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tuomas Tynkkynen <tuomas@tuxera.com>

commit 8ee031631546cf2f7859cc69593bd60bbdd70b46 upstream.

Commit fd2421f54423 ("fs/9p: When doing inode lookup compare qid details
and inode mode bits.") transformed v9fs_qid_iget() to use iget5_locked()
instead of iget_locked(). However, the test() callback is not checking
fid.path at all, which means that a lookup in the inode cache can now
accidentally locate a completely wrong inode from the same inode hash
bucket if the other fields (qid.type and qid.version) match.

Fixes: fd2421f54423 ("fs/9p: When doing inode lookup compare qid details and inode mode bits.")
Reviewed-by: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Tuomas Tynkkynen <tuomas@tuxera.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/9p/vfs_inode.c      | 3 +++
 fs/9p/vfs_inode_dotl.c | 3 +++
 2 files changed, 6 insertions(+)

--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -469,6 +469,9 @@ static int v9fs_test_inode(struct inode
 
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
 	return 1;
 }
 
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -105,6 +105,9 @@ static int v9fs_test_inode_dotl(struct i
 
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
 	return 1;
 }
 
