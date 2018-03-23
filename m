Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806617-2-798524571787774876
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
    t=1521806616; b=BisnnSs8kM6otrVXz7MzjM/1geSqTNGucAjA1yqxpQnybAZ
    TyElF204vAuYzoV1R+TEuruRzS4NdNpNYcKQvghefQe8v8AkG0QF3tFBRgKMeffe
    Wz+wG9Ddz0XlQBYZ9+wxMdT8oxmghqxR5pnV+zMT97tJ6sOGg2wmbca0cmQqJRiT
    +Oe0I8735RKe1Ki2vMXdHRlUBqQ31KqccJ1rlkE0NAetu/yhYhPV+xw3X5ICHisq
    b19uiLioSqXBrP5CLsTgyDZKewu5uiQ5ZktoRa9ZSyHb9KiK5bazEulNvMAkUMLT
    k6dSmNU6LlzFtB9NkQKFI19dz1uTkgTNp2a/HAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806616; bh=MVWgk79t79s2VJeP7LnsSzHZPk
    0Bz9I57CTc1a9QKG0=; b=plmgUzyjVpzFa3Hq3PmvdV1QDqFiQW/mbVtUAn/bIH
    m6XnOiSpwKX2yoJJ8u/MN7tLMCXGtCCoM9wwr49j5iWg9vTXGNcfKvC5X3rGDDsf
    5wQ6fq4gxOC0cfY1a0Bg/yHpv22D598P+H/stWDotZUl/cvRsmSsF/fWM+vlEa+U
    heuSqxwda/WixwYlp8T+SB5CQdO56fS2BSEkjymsSM5tThjVmFmNEC+IDbBXIAFa
    mMT/tPfi5Jf5IlWRttAVKnbOgSOmGqy1wxbBdwia0fCzHU1wJmIUQRHAkoGCNLDa
    37u6ZVBIeHV7jyswiAjcMUvOkTmsCZgZnLyXkHqWfIvA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1753385AbeCWJ7m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbeCWJ7j (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 67/84] RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS
Date: Fri, 23 Mar 2018 10:54:21 +0100
Message-Id: <20180323095422.096639066@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>


[ Upstream commit 744820869166c8c78be891240cf5f66e8a333694 ]

Debugfs file reset_stats is created with S_IRUSR permissions,
but ocrdma_dbgfs_ops_read() doesn't support OCRDMA_RESET_STATS,
whereas ocrdma_dbgfs_ops_write() supports only OCRDMA_RESET_STATS.

The patch fixes misstype with permissions.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -834,7 +834,7 @@ void ocrdma_add_port_stats(struct ocrdma
 
 	dev->reset_stats.type = OCRDMA_RESET_STATS;
 	dev->reset_stats.dev = dev;
-	if (!debugfs_create_file("reset_stats", S_IRUSR, dev->dir,
+	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
 				&dev->reset_stats, &ocrdma_dbg_ops))
 		goto err;
 
