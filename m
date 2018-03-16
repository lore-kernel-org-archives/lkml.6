Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2571388-1521192034-2-13774215385548227854
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
    t=1521192033; b=sdtoIIVOcXX09QvsEBpwm6GL/STe5E4QJL32HFtnRkfLeOp
    sgBylYYc3lczyGHWKmqbOgeojTrDTuFAqBlE6YhaA/g+N+hpc5RsrYHCmC6erfuH
    v9Kyur7RAS9ZPFl7Uq36PiTvXqHXqygw2jHe8SL8QrOAkYTVRIeT+hJBJeTZz+1A
    rLSVDLfb0vWNLfIUPP9xuJs/Mjl6hz52bp3i2hZvKy035lqemK4oLGSXTp3nxf6U
    xRr9g6kYFFIM0u23rd73yAUaQO9S+XMlJnZ4KwgXgSk4RLt0Z0hm+sJ8mIw+2KO2
    o0m5OrI99lnCz8O0EQe4t2m4q3Pk4TLCVG6Y/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521192033;
    bh=7Jp6X9Cl6MCh/yU6O1KoZ4xQWApg8TFpB03bmF0jl2g=; b=dCWrInUPRZ14
    h+jq1hY9jJfNWHrOj4Nf1b6eaXgT0hoidX56y2q5bOMYJ14tzvHUFLbOy77snSfZ
    yECoL23WbzINwgOQMUa0rhU6Yf6ZYOBhRLVxHr5oM72vTgMpH4pQrHlPFuinEBaI
    +YXWjrPRiCSq6er4313s5KM7ucWgOnSVhyoqJhW1fd1GPnZq1CyRkj9d3qnbTA8z
    HQaoZt5Gq6tyB+4UK7o3aPsluGTuK51axT0/C2bJ9eztZad5GLmdbGlwv09UTSqK
    nQ0e6w5XQmmHxCfHrgwriyutrMEatCcPeU20lF8B3GAy4oLnt4Otv2ONZ54P4HFL
    O5fyGgtPZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S1753109AbeCPJR5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:17:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753085AbeCPJRz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:17:55 -0400
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
Subject: [PATCH ghau40 v2 1/5] AUDIT_CONTAINER message type basic support
Date: Fri, 16 Mar 2018 05:12:25 -0400
Message-Id: <1521191549-19764-2-git-send-email-rgb@redhat.com>
In-Reply-To: <1521191549-19764-1-git-send-email-rgb@redhat.com>
References: <1521191549-19764-1-git-send-email-rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This defines the message number for the container ID registration record
should the kernel headers not be up to date, gives the record number a
name for printing and allows the record to be interpreted since it is in
the 1000 range like AUDIT_LOGIN.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 lib/netlink.c     | 1 +
 3 files changed, 6 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index b681e8d..6d431b9 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -242,6 +242,10 @@ extern "C" {
 #define AUDIT_GET_FEATURE       1019    /* Get which features are enabled */
 #endif
 
+#ifndef AUDIT_CONTAINER
+#define AUDIT_CONTAINER         1020    /* Container creation notice */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 966865f..e2fd536 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -44,6 +44,7 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_TTY_SET,                    "TTY_SET"                       )
 //_S(AUDIT_SET_FEATURE,                "SET_FEATURE"                   )
 //_S(AUDIT_GET_FEATURE,                "GET_FEATURE"                   )
+_S(AUDIT_CONTAINER,                  "CONTAINER"                     )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
 _S(AUDIT_USER_MGMT,                  "USER_MGMT"                     )
diff --git a/lib/netlink.c b/lib/netlink.c
index 5b2028f..8847875 100644
--- a/lib/netlink.c
+++ b/lib/netlink.c
@@ -184,6 +184,7 @@ static int adjust_reply(struct audit_reply *rep, int len)
 			break;
 		case AUDIT_USER:
 		case AUDIT_LOGIN:
+		case AUDIT_CONTAINER:
 		case AUDIT_KERNEL:
 		case AUDIT_FIRST_USER_MSG...AUDIT_LAST_USER_MSG:
 		case AUDIT_FIRST_USER_MSG2...AUDIT_LAST_USER_MSG2:
-- 
1.8.3.1

