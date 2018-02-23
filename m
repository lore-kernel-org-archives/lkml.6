Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519411395-2-13579488270109490512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411394; b=BmbBE7NmDQz8tpPv8bm58wyBUskn1uw1j1fdzrnKJuZGdR7
    Oi7guZYHswc3fiC/pEWx2f3jmNzGPyHAwWDPnz2GUE6xTo0ilPR3OSRtp9fk2+uo
    WMczcV0sDg/1FOcy60ZL9oj1GuFZA1kC3o3JAmIwD0uVLvbwUIT+cTlbGpWTi8M4
    p5qj5jr8iIgH18TP8Lh+EbgL92AxB88/kDW6HEcJ/47W8KGOpJy8tYYx11HYPP7P
    GLAm0ZEB2cEyKR3MBtwEzvZ14XdNwAP5RFUbnrXgXr3kwynDFiU/Y4d9X47S7MSx
    ADGZeQNF/lQuQjdRwabcgVntzvWXJyjZstYy0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411394; bh=SspVtpEm6X54jP68Cer29UWNRI
    EO2dCxJT8rOU3IH4E=; b=uIhyl+tscEiN7IGmv00WWqAO7+FQy2HN/E+TS//xyc
    esl3MOtNqPIKPLdPcdVN97KFsvl+2t8OM0erGL9UcZnZVigeg97VLHW1pWrjOwnT
    F4sEzJN1XKGqZ/NYHIvO0wokOm7qqIGbcvYkkVv935zWe8l94R9hHv0xKDiRIz8/
    a7302wkQKdETbe59la8t5e+ZbP2KrRDZd6ZSyFQv0/oBa7goGBE7Ut54s5TCL/Yo
    l3w9losIlZwTd5nV0jWHZqrLHPxQCD2EiUAu5mun6OGgorhZd7sVvOKZub2BtwJ0
    8TjOjFJPah+Y3NMvMEMhDKIPFwtDU+TBwT+QMsINaJOQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933180AbeBWSnL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:43:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933219AbeBWSnK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4fbcfcc0d2e6592bd641@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.9 026/145] netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()
Date: Fri, 23 Feb 2018 19:25:32 +0100
Message-Id: <20180223170728.199612968@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

commit ba7cd5d95f25cc6005f687dabdb4e7a6063adda9 upstream.

xt_cgroup_info_v1->priv is an internal pointer only used for kernel,
we should not trust what user-space provides.

Reported-by: <syzbot+4fbcfcc0d2e6592bd641@syzkaller.appspotmail.com>
Fixes: c38c4597e4bf ("netfilter: implement xt_cgroup cgroup2 path match")
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/xt_cgroup.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -52,6 +52,7 @@ static int cgroup_mt_check_v1(const stru
 		return -EINVAL;
 	}
 
+	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
 		if (IS_ERR(cgrp)) {
