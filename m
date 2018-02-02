Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591515-2-15798597563137297766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591514; b=sz4KX3u1ArWTjjKH4EdhUlBgbMBTipvIXLQa5ZRt4LOzRec
    UwedQG9E9JIl+fp/XDARWeUCVtSa/xxlvy5i1mboIL3uFJ3pU6eEdBQBN+aOgycn
    05SgnAtdZu8oSj8JhjI1t475e+NNwerzz3K4FMDzrDUnhJ2A85yq8+rSgJiAsT5l
    m4DbzpHdYCm8RFsxABRzlmcWZYXM8mZg/jw/kHZAH3cul8Ujj66LQ3s+1Ie2AzKC
    JDDHHWIbZ9cBwAX3dGF6Nd0HSqVSfM97RQ2GUmdIOZHsucvpcrMc8ZuG9KfskKZN
    fCUd3tO6IS3fXVBJKY9ybPeefumCnCQ77HJiDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591514; bh=w4Pm8v/Ap1YIZcvMmFTvUytAei
    534h3lbOfbpw+2rtE=; b=qI8dN+HJKpBPCdlYisI7E42g25WK8RAI/tQqQqZz2Q
    5J3V4KKbg2DWpVZ3tdDZqWBGRQtXcIu9bm/gZ35T+Z1tCGiADUEeRFg0kjfBaWSn
    AQ4Z0/rM5h4dqPGa7euGZyuGNE7jF9ICIBWdqhIM/h0QpgU4nw2kCITCWeDiq2XL
    T6QUeAlY7ZywQMcO8gCtfCzZI3QG59E1wsZ9QDx3lh5vO9t7Koj5G0PhEn3Q38iJ
    IiEvyXZGUxeefNnZYfs1Q1Axvca0kQ8nK1/ARE0WXg+mtB/BXjVs9aXRCbiFCDzD
    cCebiVbMnGQpdyeAW1H6ITnJHcorlz7GRpyGQBHW75Dw==
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
        id S1752665AbeBBRLw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeBBRLt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:11:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 075/156] reiserfs: remove unneeded i_version bump
Date: Fri,  2 Feb 2018 17:57:36 +0100
Message-Id: <20180202140843.671899843@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@redhat.com>


[ Upstream commit 9f97df50c52c2887432debb6238f4e43567386a5 ]

The i_version field in reiserfs is not initialized and is only ever
updated here. Nothing ever views it, so just remove it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/reiserfs/super.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2591,7 +2591,6 @@ out:
 		return err;
 	if (inode->i_size < off + len - towrite)
 		i_size_write(inode, off + len - towrite);
-	inode->i_version++;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
 	return len - towrite;
