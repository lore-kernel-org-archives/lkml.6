Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2539098-1521191510-2-2008356238919868552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521191510; b=cLJZYIvmlDY9vrFgwXr3QK3NpU8hKcuTwVGn+CecEe6Nyvm
    wmYxrFhR2C5xex868ywNObsfZAy7bV+FjDhSVY++deyWx84NNhsbje/ut7CHN6sT
    UtoE2eC8aRLy0Jge5GLTUP1z7OYVu97ggqSLbAeRV6hfXuzz9I3S8VsblYMk6d3U
    sh+0YYBiI2E0aBDNHwPaAAlEHu/2JLY242K2PLKoj6gJikxWMiKTXhRNub3rQfks
    hWyg19uDqECzc3K3SjcRFpkBAUTDLjCfTke6q6Aml9B9AsSFazpgONBS6jeRHB9V
    VLdTkutHNyAYIfFEjiS0myr4FArP9CgNn+kiqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1521191510; bh=bLaEMbO0ldqaq4NcLykgh0R/f9gReY1auzF
    u6X3lG8E=; b=PVhpBm0TqVfq6n7nc45yecFspn9zUE7lP3X7J9ox3KkO3cZamW+
    CTYWONeTtEAN6xa2HWXV6eTI6LZiMQ9bAWEEzoT6Vg7Myzg1mDr1/46KKxByy3Sa
    PWbtW9rH6kkAnBhwAhvJ75Dd9OadFZB7whEWhm13nUZ7VR2TbIPPxoLK4ua0jajm
    zCalSuGHpEFnQ+D67HRcJiFaRM8zTlRYLCzjfeT/CtmDtI3CWxOhu5furOd0hu/u
    eWCQ5ocr8veVot7aPxSiP2Ya30WIq/OfpSyskh4d/ph+Ff6IM/2sFIx21FVXStKt
    CtUXOncjqgzOFGyIOdjcCTt7nWrbSZmXtrg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-75 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeCPJK4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45046 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeCPJGO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:06:14 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: luto@kernel.org, jlayton@redhat.com, carlos@redhat.com,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH ghak32 V2 02/13] audit: check children and threading before allowing containerid
Date: Fri, 16 Mar 2018 05:00:29 -0400
Message-Id: <995b77557010b2f9aed0e10435f7b8536df7a5db.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
In-Reply-To: <cover.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Check if a task has existing children or co-threads and refuse to set
the container ID if either are present.  Failure to check this could
permit games where a child scratches its parent's back to work around
inheritance and double-setting policy.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 29c8482..a6b0a52 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2087,6 +2087,10 @@ static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
 	/* if we don't have caps, reject */
 	if (!capable(CAP_AUDIT_CONTROL))
 		return -EPERM;
+	/* if task has children or is not single-threaded, deny */
+	if (!list_empty(&task->children) ||
+	    !(thread_group_leader(task) && thread_group_empty(task)))
+		return -EPERM;
 	/* if containerid is unset, allow */
 	if (!audit_containerid_set(task))
 		return 0;
-- 
1.8.3.1

