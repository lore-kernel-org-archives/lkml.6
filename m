Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804535-2-12981354145707040238
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
    t=1521804535; b=kjX24iIEEfysYIbXce0PK7s1lg/MrKSzCqo6LDd95t4czoj
    P/xzNgun+aIWGQXgTdq1xQ5tZhCVyietezi1D/9q1JMFDovHTK69WX/6Tm8eGu69
    6ROtipfEacKJ0eZzVqogV+lR3J0tGf9SqoXpJyIll1o5Y5Sh6iKGl8zB1v3yMQR/
    bQEbtW7WURTa9+b32UJ3ZgK05F1q8JUldVn3pMr0BuE8JqTJsp5tv5lhQspoGu9c
    XkhIZeUcjvqxsC0VfY/sDalV8mD10VVW9IxMD/QjQUcPcv8oxRtTu5YCrlrGdhIV
    QJEWrp2KzmDBapW7jf/hIB402PCVb6FaTwiHAAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804535; bh=QMIrFCIUbhs1rM/81MIfD8lvXG
    6ZV6amXUYDoGEEJ9g=; b=PgF2nQ9rjaJTlC4Hjw2XS4RjJMFoid5ETMgVem/RYr
    Lg896OPqujNhaIQS6y3iNfFp+i/etSUCUKUXIuXED43GyVtBBO7YTXnRm8EUxXmF
    j5CbsKzI64XzY82zCdPaBeWTWhfAVsGzwdHCYLJ8RjozBVVmm5bD7I4c8GCzXFQO
    ey641ImnU2P9lz/1rbBY1l2kijjqWdBZ2wakUyAjPCBkgfxDiiCQAhEGAW5PpuzV
    krVjKxtg5QWXEzFJfEZotolWi6o4sEbE3VwUI1snua9CSiKGdueGb5gH9mtRufLX
    xWUSwEEPKCDO/8KdV7H+pEpk8Ul8gC2pp0fagTF07vbQ==
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
        id S1755275AbeCWKGo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:06:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754936AbeCWKGn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 048/177] IB/mlx4: Change vma from shared to private
Date: Fri, 23 Mar 2018 10:52:56 +0100
Message-Id: <20180323094207.440173275@linuxfoundation.org>
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

From: Maor Gottlieb <maorg@mellanox.com>


[ Upstream commit ca37a664a8e4e9988b220988ceb4d79e3316f195 ]

Anonymous VMA (->vm_ops == NULL) cannot be shared, otherwise
it would lead to SIGBUS.

Remove the shared flags from the vma after we change it to be
anonymous.

This is easily reproduced by doing modprobe -r while running a
user-space application such as raw_ethernet_bw.

Fixes: ae184ddeca5db ('IB/mlx4_ib: Disassociate support')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1182,6 +1182,8 @@ static void mlx4_ib_disassociate_ucontex
 			BUG_ON(1);
 		}
 
+		context->hw_bar_info[i].vma->vm_flags &=
+			~(VM_SHARED | VM_MAYSHARE);
 		/* context going to be destroyed, should not access ops any more */
 		context->hw_bar_info[i].vma->vm_ops = NULL;
 	}
