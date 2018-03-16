Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2571388-1521191926-2-10793130458405669445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521191926; b=L5xFgsqY9TPNqnVCzBcS8H441urFn4q5OcIsaQJOBfMrFyN
    fVH+t3UsmkyAQRIdjx86ZYFsZxQGrGMxxRj5hi4s8DKmWqb+hc9CpxX/soeJ3R4y
    TejQXc5Mvt6hC9huSDu0H0lQG5FF3h5GMi22cHm0Lqqv2pQPKrx4YxYybiF0YkCk
    Knf0DLVsVB6kNnBj71zhsPaPu26JCIAR0v3hGA0MxzUrySGJKrfgR54jX7CwBMH+
    UswJat9ZHH/BVIdMmgqQgFQMkDMKyriImoS1H4GUl+gIPJ0aBOAAyFq4oU73UNLS
    XUxRTxSnktA/uGAG4bmGX/xyTTt1i6a9oDqZm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521191926;
    bh=nlpoCTjIXJCC/TKk5/ZHvl5GgcxoP3gGQS88I3mRI90=; b=u7UP4ipL+MUM
    8TyCEOZih7mXtaCLUEQ1xv9Ld9o6oTDvVxr3+TXyvAJwJLDZ0MyzrWaOXPut6Njq
    m8YeWMgl3YsIRBaIZNAHpw5Sr2K7dovs7OE4FLaFhvBnWCijd0uuT5rFzMz+nV2g
    POOXi0JjE0qT+InjUFqbTaKAEqvVxLqNOdMjsrzW/wP+GzJr8O1pfWYP3m1Q92BA
    fzqXm0kbiuxbd4C3X/5sEXMG6BtBHpc6e7IGhMxhFC6GsEH7AavZQHpQfJhrPVku
    VvS1r+P+JBmkFrufXVkUOVlFxNucbMjtD9Ug6qhCdOSMUMk5Mbyll8v6Cfi+irQ+
    DVQcl8SHpA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeCPJS0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:18:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753253AbeCPJSS (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:18:18 -0400
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
Subject: [PATCH ghau40 v2 5/5] start normalization containerid support
Date: Fri, 16 Mar 2018 05:12:29 -0400
Message-Id: <1521191549-19764-6-git-send-email-rgb@redhat.com>
In-Reply-To: <1521191549-19764-1-git-send-email-rgb@redhat.com>
References: <1521191549-19764-1-git-send-email-rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/normalize_record_map.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/auparse/normalize_record_map.h b/auparse/normalize_record_map.h
index 1507bb5..c529e2e 100644
--- a/auparse/normalize_record_map.h
+++ b/auparse/normalize_record_map.h
@@ -25,6 +25,7 @@
 
 _S(AUDIT_USER, "sent-message")
 _S(AUDIT_LOGIN, "changed-login-id-to")
+_S(AUDIT_CONTAINER, "changed-container-id-to")
 _S(AUDIT_USER_AUTH, "authenticated")
 _S(AUDIT_USER_ACCT, "was-authorized")
 _S(AUDIT_USER_MGMT, "modified-user-account")
-- 
1.8.3.1

