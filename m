Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326390-2-639958596273430557
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
    t=1518326389; b=EhipQ7FsSZLMLn5U06ME49YWWncoJBmZRSiM5mpplYe/zN4
    2OQ7TH/d8vWx8cZMVY9e3l1MIJCKRVm2UQgLMDPxVgc3Wxyaf479xsUWyArbHCYK
    6cQm1fhrUzHD3z3AKznZepaXNCf9kNzPk1HOtbXRlEVyGaL3M1vUkMCI3lIl3/my
    wxP40FtntQLxRqdzoA87mD/aqNOh6Vn7gS71+5yRT0TrevcXssfYTik0e6eszHQ2
    1bsN4sh3/GDl/XWWJfak6lz2hmgwfVlRvHzpEI9TkRGwFrtARaseLYrGN31uULtl
    HUj41pyZNEiVoO6Ri+3AxvD8RkuSzqGs+rdz7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326389; bh=rXF2ngcqtijKihugpCg
    qvumQ7PaNwIlzGvaRtPOxLf0=; b=WgpB+gcUy9pSICtSDMyJ8K9hB53QfigGGTC
    P21yOg1it6bdUU4Fdpt+/FwvcPbb/nlj+1WFAoXjQBJN1ILxfW79yTB89Mr3CQoF
    0qenjq0UMwuhwkLEqpWOF0pVsQEo+FDxDo9cOq1Q8H4pHd349mTEdxfh2LH/haC9
    Vl7fH9eurW6Bn6WToE8uqm3/hlS893d18UJZja7riM4Dol3Ssz8k6xL9JfZNqc1w
    rC4T1k/ZV/HtAObTPzqU+SMXB/QdjV94Br8PVmkrvGOUISjGGmBVBv2Rcf/1kN/f
    ZXaBJ2lDBp4q4clIZqy/KisBWGpYzoRgssUfrdaakIIN738JQAQ==
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
        id S1752580AbeBKFTe (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:19:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753300AbeBKFSW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:22 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        "Tuomas Tynkkynen" <tuomas@tuxera.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.16699497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 027/136] fs/9p: Compare qid.path in v9fs_test_inode
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
@@ -483,6 +483,9 @@ static int v9fs_test_inode(struct inode
 
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
 	return 1;
 }
 
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -87,6 +87,9 @@ static int v9fs_test_inode_dotl(struct i
 
 	if (v9inode->qid.type != st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path != st->qid.path)
+		return 0;
 	return 1;
 }
 
