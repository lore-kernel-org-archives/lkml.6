Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324425-2-5214016146916609436
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
    t=1518324424; b=hU7eonQuB5JKcN6CsfErvwXQSUjyiRQg0G+qRKf/189G3Qq
    oodgioq7KBaI8dEPPaEcdwNBICgt1/bCzBA4k/7FwJlz/PBS3oARrPXCPh6mL7ZX
    Mn3WVKgP77YF1neQb9lapJrlu9puYUxDcJfKglBr+c5nvmR4pHeM41MvomOLgR26
    Pdn5pgKqkdXgUmn1VOgj4IYosbNeS5IBK94r8WyiKdWbAmKLZFtOVSrXRw5WrVmN
    Kf40dgYiCzGjtxopjrANzPz0pfoA1Iici325gQCIDoiH5uGUHWvciVQ4imoPWdj7
    yBpEku+pt647YyKk4ioYwiViG3NGQ2kdre0PBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324424; bh=BMBC225P6FR3RYuyN0O
    FMbven6giQEBbn7A5v2QaBjI=; b=B/fjs53wUIzeE9ezWFDVDoS+LMqE6BkXmp4
    pXqc7gAFRofHdzMtWnNeTgawk0A0o6TC6+ntGM8uTlXVdqz8m2gFCTvwSc0B3fGI
    T+ZG2BscB/wuYoE7hnAVr8MJfwU5wMuilR37aaBU9g7X05ujiYQdAfo5J8TTQWAP
    wZS57zFLQVL+lYdh0FxyMP+SxvUnQ34ijMpunOZ37VNoC//ZAaMLPG8LjWa8gZqT
    Mk5q/xZnJjXEESvwgJ+m0IJ8K8EjeuLAIsx9pNrED8M1pG3DUg297Z/wBaGwFIGO
    kNdrFU28db951u5Yhq+R6Ti39x5miJU+dHDfLcXOcpLL87Zau2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeBKEpP (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:45:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41821 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752844AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Pradeep Thomas" <pradeepthomas@gmail.com>,
        "Anna Schumaker" <Anna.Schumaker@Netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.601770727@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 092/136] nfs: Fix ugly referral attributes
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

commit c05cefcc72416a37eba5a2b35f0704ed758a9145 upstream.

Before traversing a referral and performing a mount, the mounted-on
directory looks strange:

dr-xr-xr-x. 2 4294967294 4294967294 0 Dec 31  1969 dir.0

nfs4_get_referral is wiping out any cached attributes with what was
returned via GETATTR(fs_locations), but the bit mask for that
operation does not request any file attributes.

Retrieve owner and timestamp information so that the memcpy in
nfs4_get_referral fills in more attributes.

Changes since v1:
- Don't request attributes that the client unconditionally replaces
- Request only MOUNTED_ON_FILEID or FILEID attribute, not both
- encode_fs_locations() doesn't use the third bitmask word

Fixes: 6b97fd3da1ea ("NFSv4: Follow a referral")
Suggested-by: Pradeep Thomas <pradeepthomas@gmail.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/nfs4proc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -243,15 +243,12 @@ const u32 nfs4_fsinfo_bitmap[3] = { FATT
 };
 
 const u32 nfs4_fs_locations_bitmap[3] = {
-	FATTR4_WORD0_TYPE
-	| FATTR4_WORD0_CHANGE
+	FATTR4_WORD0_CHANGE
 	| FATTR4_WORD0_SIZE
 	| FATTR4_WORD0_FSID
 	| FATTR4_WORD0_FILEID
 	| FATTR4_WORD0_FS_LOCATIONS,
-	FATTR4_WORD1_MODE
-	| FATTR4_WORD1_NUMLINKS
-	| FATTR4_WORD1_OWNER
+	FATTR4_WORD1_OWNER
 	| FATTR4_WORD1_OWNER_GROUP
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
@@ -6015,9 +6012,7 @@ static int _nfs4_proc_fs_locations(struc
 				   struct page *page)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
-	u32 bitmask[3] = {
-		[0] = FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
-	};
+	u32 bitmask[3];
 	struct nfs4_fs_locations_arg args = {
 		.dir_fh = NFS_FH(dir),
 		.name = name,
@@ -6036,12 +6031,15 @@ static int _nfs4_proc_fs_locations(struc
 
 	dprintk("%s: start\n", __func__);
 
+	bitmask[0] = nfs4_fattr_bitmap[0] | FATTR4_WORD0_FS_LOCATIONS;
+	bitmask[1] = nfs4_fattr_bitmap[1];
+
 	/* Ask for the fileid of the absent filesystem if mounted_on_fileid
 	 * is not supported */
 	if (NFS_SERVER(dir)->attr_bitmask[1] & FATTR4_WORD1_MOUNTED_ON_FILEID)
-		bitmask[1] |= FATTR4_WORD1_MOUNTED_ON_FILEID;
+		bitmask[0] &= ~FATTR4_WORD0_FILEID;
 	else
-		bitmask[0] |= FATTR4_WORD0_FILEID;
+		bitmask[1] &= ~FATTR4_WORD1_MOUNTED_ON_FILEID;
 
 	nfs_fattr_init(&fs_locations->fattr);
 	fs_locations->server = server;
