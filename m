Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3963414-1527690090-2-14895702984168709422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527690090; b=bB8ph09WZxvxQARJAaouvVt0S/Pb7v9f9If22ZM4InldAuPdJV
    Ub0/lyQaSyvPANOSi2hTWbVpdG59IYHdX3JE64pNLd7OeiPqgdG7PUCJFBQgzFvN
    +bFoCrGRK/np3Te7H3t/rPmv0CCE4I+rRjli+9G1wVyDoxbhmOrPNksgUNy8lbc6
    iRss74ZzUJavxf15cRl+a65CsokUtAUKDXAN16WDPxH7ngOMloJPZjpTRxknBD10
    jvAbuRxXs7x4cNq4A/qltHikHqFazCvyD+3c01fJeWDyhuEXvz7lLH2qNiH5iHUL
    wJdheo6m1gC0Xwd1yvlw4AIGAOQji6XuyS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1527690090;
    bh=WeIuXBeaZOC8Fuw5DEa3/A4E6A/avWGQ584Yew5W/Qc=; b=BJIYjxhCXcX9
    8EtoE88Wuuwkr5ySqPC6ef5th+dfn4CaLfu10/+Kwnnr26LFGmx9FepTLqEkIKhT
    b4YjQEdKQdFOoL4ocMKc9HHUd5wa902gH8l/AKuNOYOZ8k5a++Zasx8fRjV51OP5
    IGjW04V5HEqdv0UteTqwcW7ciiq08eKrmDtUfVUCo9gtkBwMI31e2vjzSCMgwdVt
    ctQxhV2vYZfNNxtCHtGGEX8oWCMBAY5SiuCpvRMcslqgCzRC0AlcaAQzaYeFNhnK
    GcnBiWhPkCiUjwl/6QrpdEmxc/bJC5EHr7u5pWryCLcgWJF2LC7hZhyST8iEdYgf
    I+UvFg5WQQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sony.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=sony.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKg+XfUsP5A9PQwgih13IojclDAFwN4X0f3OObWaUG4r1MNIU0peFWsj5w4FLRPZ8s7vr1B4NSjERW242OYumweYa8s/NUhOY8IKviWOiXyysLRB7O0b
    2iSdkRMO+5AwU7WjHzMusf4ZfSJxqvJ8wBl5aZBzbsSh3pogW2H7j6zjPmrtyiv8S6K8trfuhOCjpwfSGlIla//Uoa70TxDZlIzqEs66zfnJVR8ZjQTsJnJ9
    XSkhPJDHWndEjqtFsdi7hg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=oYMbf0bh4j_yEe8o77UA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeE3OV1 (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 10:21:27 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:11360 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751630AbeE3OV0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 May 2018 10:21:26 -0400
From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <james.l.morris@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH V3 0/5] selinux:Significant reduce of preempt_disable holds
Date: Wed, 30 May 2018 16:10:59 +0200
Message-ID: <20180530141104.28569-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Holding the preempt_disable is very bad for low latency tasks
such as audio and therefore we need to break out the rule-set dependent
part from this disable. By using a RCU instead of rwlock we
have an efficient locking and less preemption interference.

Selinux uses a lot of read_locks. This patch replaces the rwlock
with RCU that does not hold preempt_disable.

Intel Xeon W3520 2.67 Ghz running FC27 with 4.15.0-rc9git (+measurement)
I get preempt_disable of about 1.2ms in security_compute_av().
With the patch I get 960us as the longest security_compute_av()
without preempt disabeld. There are very much noise in the measurement
but it is not likely a degrade.

And the preempt_disable times is also very dependent on the selinux
rule-set.

In security_get_user_sids() we have two nested for-loops and the
inner part calls sittab_context_to_sid() that calls
sidtab_search_context() that has a for loop() over a while() where
the loops is dependent on the rules.

On the test system the average lookup time is 60us and does
not change with the introduced RCU usage.

The boolean change becomes a lot more heavy with this patch,
but it is a very rare usage in compare with read only operations.
The lock held during a policydb_copy is about 1ms on a XEON.

To use RCU the structure of policydb has to be accesses through a pointer.
We need 5 patches to get there.
 
[PATCH V3 1/5 selinux-next] selinux: Make allocation atomic in policydb objects functions.
This patch change the allocation for policydb objects. They are in its own patch
to make the complicated part easier to read.

[PATCH V3 2/5 selinux-next] selinux: Introduce selinux_ruleset struct
This makes the access for the rule evaluation going though a single pointer.

[PATCH V3 3/5 selinux-next] selinux: sidtab_clone switch to use rwlock.
We need to make sidtabs copys so this patch change the locks to a rwlock
and create a copy function.

[PATCH V3 4/5 selinux-next] selinux: seqno separation
This patch adds separation of the read and write and uses
the pointer to switch rule set. It uses seqno for error handling
since there are a possibility to have multiple access.

[PATCH V3 5/5 selinux-next] selinux: Switch to rcu read locks for avc_compute
All the preparation is done so this patch do the change of locks to rcu.

History:
V1 rwsem
V2 did not handle all policydb objects, solved with the policydb_copy
   did not handle sidtab for booleans, I think this one does however
   shutdown is not used but not removed. 

