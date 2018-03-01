Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3692783-1519933713-2-6851487351224958289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1519933712; b=HtkCOzWeQF0nqJwLMFce4lpaGGhnKXniUemvOcuqEP/Nxk8
    Eixse4tddAKGWA4WGe6tsGKFq9ZegZhMDcp3qRbWToA/Mk3p3d9+HXJAYcNqH1yM
    b9or7Su5jBeBdV3Mp+1SYHofAqKSzlR1plAgjXK8SWqEIZ+WHFdweQXNeBhygtnP
    7lii91VUyp7VYkPP6uShlGA5JDmYrhhB6uj6lSz2gbrXNmw0Y4lVqbCsTFRXidvX
    xt8S3d2cv/Csfus4q30CVeIx9YSD7rjhj2qMR+W+tpOSZdY/lulAwp4aJWbiY+iD
    DDXfrsGVTE+IcdL4ix06gobPoQsPw+XkzqYSrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1519933712; bh=xMZfxAT5fFtD1WhDpmxq0DELrQLPNWJcXpi
    uSzS46pE=; b=XNoipd5as0/o0I+DDpS76+SsUrtmq4mvfTkAiuuPRMr/rg5zXWV
    SDqUXzemCQrXecxmAp/fJrfooKgRhdfYflXNpIkY9jec+apcec+PbaD4rmVtJ4ky
    jOs8yACyMhF2FB+0eMPKjURhNxcD47PBLpXcqtZ7qxpPxYstFky6Wmk+SMfWKBqz
    PFGJucn2I33cetyA68e+brdp+BA4YIkIDbexJtU8/42u5pwfOnkqGuCkIpAU8XRz
    w9UTJsa11NEwTWHDD6bxE9Oj47WryH8HdVDKAMURS7TsCBeQXabdjAargtqujnN0
    An15mPJ2xoBQ0AsE1wqm2o7oUzkV+d8zDNA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033812AbeCATsH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:48:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1033819AbeCATrU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:47:20 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Cc: mszeredi@redhat.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        simo@redhat.com, trondmy@primarydata.com, eparis@parisplace.org,
        serge@hallyn.com, ebiederm@xmission.com, madzcar@gmail.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [RFC PATCH V1 11/12] debug audit: add container id
Date: Thu,  1 Mar 2018 14:41:14 -0500
Message-Id: <1a9d4cdacd1dd3c51c4ba2a3f4888d0591c5b6f3.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
In-Reply-To: <cover.1519930146.git.rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Switch from the 1000 range to the 1300 range for the prototype until it
can be worked out why the former aren't showing up in the logs.
---
 include/uapi/linux/audit.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 8443a8f..c392b3b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -71,7 +71,8 @@
 #define AUDIT_TTY_SET		1017	/* Set TTY auditing status */
 #define AUDIT_SET_FEATURE	1018	/* Turn an audit feature on or off */
 #define AUDIT_GET_FEATURE	1019	/* Get which features are enabled */
-#define AUDIT_CONTAINER		1020	/* Define the container id and information */
+//#define AUDIT_CONTAINER		1020	/* Define the container id and information */
+#define AUDIT_CONTAINER		1333	/* Define the container id and information */
 
 #define AUDIT_FIRST_USER_MSG	1100	/* Userspace messages mostly uninteresting to kernel */
 #define AUDIT_USER_AVC		1107	/* We filter this differently */
-- 
1.8.3.1

