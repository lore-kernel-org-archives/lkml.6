Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804117-2-12075585760408343736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804117; b=hHlSFYAWJ3nOsRzxOGc+8QsjbpAaRWwbJBLI/EMpi7I/UT4
    ih+Apko2C+KMbqGmfQNNCygSXLnJRJ+z1fSHU+9BQpryRtCMft08hNLM1PSGCxl9
    3TC9wac3DO+bXPJd2AqXxZzFIXZQUNiqFtdOghWsy6GdgA/bgj0p38HJKaVG8cLP
    6ilxqd8r5a6SrKVGcMWAZay5NBkQ+cUX7IaffbOOveqh3rnlOA1NmW+6tLtrug1p
    IXYCbn5ZZlt3KsOvx7ured48j+rTcMeWNNlH0HIYzzhk2j3bBYZIo0fDcvIE26Hb
    BFF+I1yWmcmIUEIo46dHhNfERsjCREKHkfNFwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804117; bh=iCCSKqVv80YAYSUNHUZ9yZ1u11
    8/CNlMPGd0OQ+P8TI=; b=CJfZEPcwMzpuAI6+aPk5mOmnY0FGuICsQS8CwdHA5Y
    YrYwzpgYhlLyOVK5JwmznEWTzFL6Vg+GoF1lV5tmMpE3OsmuEowbw4jEQaAbgXCf
    S3KFlME1US6J0UbAC+IQy52OZ3jWBRPfbonA4U3KCOqG0W9277N7yfzMdAXABhrr
    wj/HTfrxODxro5sj/CQ3vq7h2AgbT83nEepOGektvRnqw9uuWQwe9z1QyHnFqxDT
    OffYznFDbPJGGrD3XFPJI6ATiDrXGivGpPZW9V9vuy7sVEuAzy3LRtliOxCd3vsE
    9bTWbHlFjgQUnhz4FLhIkvPZkPYDy4xqZdMT881WHunw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbeCWKIU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755507AbeCWKIQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 079/177] orangefs: do not wait for timeout if umounting
Date: Fri, 23 Mar 2018 10:53:27 +0100
Message-Id: <20180323094208.792427775@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Brandenburg <martin@omnibond.com>


[ Upstream commit b5a9d61eebdd0016ccb383b25a5c3d04977a6549 ]

When the computer is turned off, all the processes are killed and then
all the filesystems are umounted.  OrangeFS should not wait for the
userspace daemon to come back in that case.

This only works for plain umount(2).  To actually take advantage of this
interactively, `umount -f' is needed; otherwise umount will issue a
statfs first, which will wait for the userspace daemon to come back.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/orangefs/waitqueue.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/fs/orangefs/waitqueue.c
+++ b/fs/orangefs/waitqueue.c
@@ -124,7 +124,14 @@ retry_servicing:
 		gossip_debug(GOSSIP_WAIT_DEBUG,
 			     "%s:client core is NOT in service.\n",
 			     __func__);
-		timeout = op_timeout_secs * HZ;
+		/*
+		 * Don't wait for the userspace component to return if
+		 * the filesystem is being umounted anyway.
+		 */
+		if (op->upcall.type == ORANGEFS_VFS_OP_FS_UMOUNT)
+			timeout = 0;
+		else
+			timeout = op_timeout_secs * HZ;
 	}
 	spin_unlock(&orangefs_request_list_lock);
 
