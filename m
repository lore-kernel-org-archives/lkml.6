Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2645812-1521192027-2-14177327817993436246
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
    t=1521192026; b=vzcp21Dm+GIyi32b7+s+SwGxnGHC1jAqLXvAFS/y6oieEa7
    bLso+MMPSPfMPqAiW68YsymCSU/tueF1EeU+48wVtxU3C8Ig5VTisOf6ThPXQkEZ
    N4pQlcQCKhrSK1Glep7vM5HTFrsB2UApuGhus+Rpqnm/ySNFn1cAdq7sw4SpJVYZ
    gBMNVc/b31NDlSwkZUpY1AHDkIred4rG4PfOPWWXTTuZFjndAbgz3gov4I36+SlU
    jUrUPnv5MIrfs+H7xdhQlplvHirB+I70nE+FH5F+6qD5c/XTYMn0nZUB0qUDtZP4
    BpjXayW2jf5JXzhy+tY+LFnL4KFml/ea1R6WNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521192026;
    bh=gC2Thi3MshZDaPVisE7T5hvZsCVl8Gp7yBKcB2+wIts=; b=WzfHiHn2YNe+
    IGxrLc5tWy+RPGWsTSOhExdHdSXxEL9iEKH7fWq6WYgv9DJvHmYJat+/vwaiQSn8
    QG0thG5Q523XqLi2vIp3pl78NAo8z+SiRtT/IbqCXZEVIi76B3FAT1otIYU8MX1W
    D41V9SCnmiQ4LSxG8ZBQpwTUgIEG9Cxpaar+78WL71CaAA1/ZS7odw2g5PzVHsKB
    RI4CftqPJr3lSn5KXDgYQGUEJ4rD5eWPv4MPrsidcA+V2A7ueMCktyt0XfgqO0VX
    m35DaAxWLiizmIYG04DyE9ZXLkc7EUIi56e9LybOJfFfbe6ZMXcv5JVdb2lkdA7I
    eZRQ27IA0w==
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
        id S1753160AbeCPJSH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:18:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753128AbeCPJR6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:17:58 -0400
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
Subject: [PATCH ghau40 v2 2/5] AUDIT_CONTAINER_INFO message type basic support
Date: Fri, 16 Mar 2018 05:12:26 -0400
Message-Id: <1521191549-19764-3-git-send-email-rgb@redhat.com>
In-Reply-To: <1521191549-19764-1-git-send-email-rgb@redhat.com>
References: <1521191549-19764-1-git-send-email-rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This defines the message number for the container ID info record should
the kernel headers not be up to date and gives the record number a name for
printing.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index 6d431b9..756a3b8 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -282,6 +282,10 @@ extern "C" {
 #define AUDIT_FANOTIFY		1331 /* Fanotify access decision */
 #endif
 
+#ifndef AUDIT_CONTAINER_INFO
+#define AUDIT_CONTAINER_INFO    1332 /* Container ID details */
+#endif
+
 #ifndef AUDIT_ANOM_LINK
 #define AUDIT_ANOM_LINK		1702 /* Suspicious use of file links */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index e2fd536..5c4892a 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -124,6 +124,7 @@ _S(AUDIT_PROCTITLE,                  "PROCTITLE"                     )
 _S(AUDIT_FEATURE_CHANGE,             "FEATURE_CHANGE"                )
 _S(AUDIT_KERN_MODULE,                "KERN_MODULE"                   )
 _S(AUDIT_FANOTIFY,                   "FANOTIFY"                      )
+_S(AUDIT_CONTAINER_INFO,             "CONTAINER_INFO"                )
 _S(AUDIT_AVC,                        "AVC"                           )
 _S(AUDIT_SELINUX_ERR,                "SELINUX_ERR"                   )
 _S(AUDIT_AVC_PATH,                   "AVC_PATH"                      )
-- 
1.8.3.1

