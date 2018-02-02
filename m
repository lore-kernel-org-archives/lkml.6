Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591062-2-16302119161413240044
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
    t=1517591062; b=ha0OL9C33qXm1kkBHb0P3zQ6idP3vkhwPJu30KnPP1sRbCJ
    oB7D0KetMgb9cZw3CKi536+7txsDc9IgCMfv8pHufXau/hWYqA7VRehTYTSnGGYd
    MaA1sGYyuDqmviootaAzM2fn5NBn1yNVlCSMAonVWgGWYKA/nQgOxXZ5zF4ALUJm
    6mhLXl8hi8TCGRu1nfMe5072SnxmwOoROmigVUaTP+B8rVwWVWlkSVEj62w7cEfy
    jDD3ugsSjRBfQQes5+MmvgXEX5u68zJtb2/iFFfovFGWKDQPSa5hw5MiNC3EO/ro
    U6nJ0lze1KL8pu+izFPPByi6p1eIHdM/rjhQNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591062; bh=giRwEXdeBxI5l4pKCN81C+ox+9
    BHKXlkUSsfpwvYI3k=; b=pJU9lMJj4ngWPJHLIyNFC8U2A6N9/GNCgysIp5DYRw
    MhI0X4JVh1hvh9wbxjPub8ic9hFGIS4lTBkYd7wKsJh8aggOQ9oZauNem//orkd4
    bYtb5Fe5lNSEK+NkarXbsCGoqfHEymHmY6YXe140SIQLtxdHTS5sNRorjmtVZpjR
    W2bCD15PCJIMtxRWJbkMKsMMxFWLo7hJAYJbzImX5zwY6JzSVuhYUDP09M5i0yCR
    GwNjp57/Aee/hi37+zTvUafMV3QFZON7GU7si1sJeSf+075X9SEFcbJk7/35gjPx
    DsaDMZTtYpdi+9VlvSkYzvRlxR6FVQv3JxtSYkP9z1IQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeBBREP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeBBREN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 35/86] reiserfs: remove unneeded i_version bump
Date: Fri,  2 Feb 2018 17:57:55 +0100
Message-Id: <20180202140825.761953399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Layton <jlayton@redhat.com>


[ Upstream commit 9f97df50c52c2887432debb6238f4e43567386a5 ]

The i_version field in reiserfs is not initialized and is only ever
updated here. Nothing ever views it, so just remove it.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/reiserfs/super.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2521,7 +2521,6 @@ out:
 		return err;
 	if (inode->i_size < off + len - towrite)
 		i_size_write(inode, off + len - towrite);
-	inode->i_version++;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	mark_inode_dirty(inode);
 	return len - towrite;
