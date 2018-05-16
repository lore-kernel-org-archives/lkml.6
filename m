Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-139798-1526471810-2-13828482555946055814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526471809; b=ZOwYU7bjdt416uzS1N3onofRCbSRb+LBDG/WRO5EL8pUYNqu/M
    MTxKR2VzRe8rNCdTou4jv92vRw5qU0hSf/MKwldwb14CM6gjvhfTZf9h+K2QYwHw
    3Yr9k/urT3kbkbva4Uwq2XPQ3MjFC5bOSYNQA/dQGyoU0xyy05uRQbWC3k2zcnSu
    F0Yi97JQTIaqMuX6zNiaZFLu4pn4sxcW72TH9UUcSgMRqy/5KNkIb2xhQWlF0LyS
    8njCEY7vVTvG/HlNzvblFrztUZSH3aOWeuMtqAqMnDK4sIsgumfEyX28vCN8hNYU
    Gf4zG4sQTeKYcOUuJy0Kqk3b1Y517haMR3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526471809; bh=aYQbB4LFbrPHBhcVcgWTrzpBTzOZ0Q
    zgDpviqcZ76yQ=; b=Y8d3TKLw06L/7RkUSzLFEeMUs5ujAmDRWQmh9l7PBG7vwL
    03DmKsAuvIx70fNEdw8liDMoIJFiXkTpyftNjGkHXK1rInRl5wrK6qVFNshty9+t
    yFB5GvApye4AzNhtA5T4w2OrHPd+BHunvUINK2nW9Mj2YYFNrK2dusTb+GYCg/Z1
    nwmFcBXDZuVG73WH7QAQqQyslIQXgdsfX0mzHTAegj3Q2J3Vakui8d0aT1/3GlDd
    fHS+YLQskHOhX1q1lA3VYw4qppdHkFx9KVbYyUmau9pS9UBtFLuKLgWERp4x+HUE
    yuHHUu97BZTCvfHdfp6jF1lMfrGS6B1LYLImVtbw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNaZ/7jixeHHtplrmVAiHtwO3PuY0ZKrf+SZcvakFgJpiHXDT/blXhCEt8cTF4jsn0lpLq1ok9Fa1axV4ak6pgzjXbOak2F96qJU0LxLOx7y0O/PYi2
    HJlzdHNytYSIHVbw/1bpZtvKsikbvMvWgCUORu6ljKqASZMBeyMfH96vh/JiWGh5OmVZLl42/eF2MXyJ/h3/p14sgmDxbg0EJd0mnwHTAoruOhwhmWKldGdT
    LAQT2Ovyz4dISzCRQ5gGJA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=egLj49zmsfWz6hTPycUA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeEPL4s (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 07:56:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752146AbeEPL4r (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 May 2018 07:56:47 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak81 V3 0/3] audit: group task params
Date: Wed, 16 May 2018 07:55:44 -0400
Message-Id: <cover.1526430313.git.rgb@redhat.com>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Group the audit parameters for each task into one structure.
In particular, remove the loginuid and sessionid values and the audit
context pointer from the task structure, replacing them with an audit
task information structure to contain them.  Use access functions to
access audit values.

Use dynamic allocation of the audit task information structure employing
kmem_cache.  Static allocation has the limitation that future audit task
information structure changes would cause a visible change to the rest
of the kernel, whereas dynamic allocation would mostly hide any future
changes.

Passes audit-testsuite.

Changelog:
v3
- drop patches 2, 3, 4 already merged.
- fix for previous v2 patch 3 (seccomp get audit_context)
- dynamic audit_task_info allocation from kmem_cache
- fix assignment in if statement v2 patch 1 (normalize loginuid read)
- fix a number of merge conflicts/checkpatch
v2
- p2/5: add audit header to init/init_task.c to quiet kbuildbot
- audit_signal_info(): fetch loginuid once
- remove task_struct from audit_context() param list
- remove extra task_struct local vars
- do nothing on request to set audit context when audit is disabled

Richard Guy Briggs (3):
  audit: use new audit_context access funciton for
    seccomp_actions_logged
  audit: normalize loginuid read access
  audit: collect audit task parameters

 include/linux/audit.h | 34 ++++++++++++++++-------
 include/linux/sched.h |  5 +---
 init/init_task.c      |  3 +-
 init/main.c           |  2 ++
 kernel/auditsc.c      | 77 ++++++++++++++++++++++++++++++++++++++-------------
 kernel/fork.c         |  2 +-
 6 files changed, 87 insertions(+), 36 deletions(-)

-- 
1.8.3.1

