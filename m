Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517590901-2-9138783298226396866
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517590900; b=NgKhTZU/oLVLXO/wDeTZTS1al65rmwpwSWZdcEgmBbPfTZP
    JqEcISwHC1sVDq3B2zqtri1x3WPc+7AudBDGWfoSBYpXcKoLV8UgLKpZbrQ6tgvr
    /oTx16G5iQBQF4nzhFGUeRhq9Ma3TCQASe43AYJ9R7XaJezUP0Bik6NguNVn04o9
    4BG+Y0iaYYYsEsaVZMCrI2anc9JCJosFcq++FkF80BaN6DWE9/ggYEflfTJuOzST
    YX5WHjrvKlrE0RjJb3FsylBxLU1wxTK6gWtbVELtL5109jTDdxY9f7++FdJMeiMp
    UubhfQqaxquJpcQIsVPxSXeftSJb5rj3xSRl37g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517590900; bh=UqfzBEFizmWcDpEy+b6xA1twch
    y+qMM+SVajx7cACJs=; b=VZMs2PR03tPz0lhkVkZgNS0ar39WoV1GhINRCxYLH4
    +689LS695N9KY5cxPp8+GZGbVEqRhL5S6yxL2LV9H5ZokwfAEOIQWSpuYKExacTz
    G3AC54H4rVelXZOGU24bOGkePr0XbutrwJkekzO/A8TgESXv/RQLf31xVAIHNQxo
    6xdlKMB5Q43xfEWmgpxdgz66wKRD+k9nLnLAetEjAmOrskzLF0zI57hY0nPp8QTR
    V9ruZ3ybafhAdV8KcNC34HaflBxiX9elCZimFJ+Tgw81lgqBILt8QGjA7DMlCnJd
    P9w9yZKuw5AqKm/dWq39TkUtFd615bXWPQgWyme+V+3A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeBBRBh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:01:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35142 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752593AbeBBRBc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:01:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Brian Foster <bfoster@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 49/67] xfs: ubsan fixes
Date: Fri,  2 Feb 2018 17:58:18 +0100
Message-Id: <20180202140820.758478009@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Darrick J. Wong" <darrick.wong@oracle.com>


[ Upstream commit 22a6c83777ac7c17d6c63891beeeac24cf5da450 ]

Fix some complaints from the UBSAN about signed integer addition overflows.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_aops.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -310,7 +310,7 @@ xfs_map_blocks(
 	       (ip->i_df.if_flags & XFS_IFEXTENTS));
 	ASSERT(offset <= mp->m_super->s_maxbytes);
 
-	if (offset + count > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + count > mp->m_super->s_maxbytes)
 		count = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + count);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
@@ -1360,7 +1360,7 @@ xfs_map_trim_size(
 	if (mapping_size > size)
 		mapping_size = size;
 	if (offset < i_size_read(inode) &&
-	    offset + mapping_size >= i_size_read(inode)) {
+	    (xfs_ufsize_t)offset + mapping_size >= i_size_read(inode)) {
 		/* limit mapping to block that spans EOF */
 		mapping_size = roundup_64(i_size_read(inode) - offset,
 					  i_blocksize(inode));
@@ -1416,7 +1416,7 @@ __xfs_get_blocks(
 	}
 
 	ASSERT(offset <= mp->m_super->s_maxbytes);
-	if (offset + size > mp->m_super->s_maxbytes)
+	if ((xfs_ufsize_t)offset + size > mp->m_super->s_maxbytes)
 		size = mp->m_super->s_maxbytes - offset;
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)offset + size);
 	offset_fsb = XFS_B_TO_FSBT(mp, offset);
