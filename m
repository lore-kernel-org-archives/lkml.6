Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3794194-1519933930-2-13965299127111941706
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
    t=1519933929; b=Z392UDCoYtouI0F1YIZQkFBETlmFW7C5F8b/NV5tHC99bwQ
    fp/Gub+6NGRPfQ54bgUeLAdfzDZwoMh7S2NkMldXXBZ3rhzTFZNPT6YGI/h3pDDD
    xZOWYQ6Hxo2p+hTI6UDWoEHQDEY8EfrAQwJyV67LuQReK9AI8AF8y3kajZPICc1W
    +E/LqvTni0hP2bIVL6RQAiIQt1xYXKjbPFiPs/H93zRmTLVHGB4BQVRdOX0dfPRl
    M5ylRSRnOT2rwwLXpizyNvFwJSc2C+ww8n3sSsgm8dBQ2oTSINrXvPkKhcySYUZF
    IHsei73kDoBZBEUo3Yga9ZalDWekPZhLJ+FsZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519933929; bh=a+I3BE6q7djptDD6nLh1GZoRKE
    W3eKf9hpLcRJcELvg=; b=m3g0CQdFuThRWboeyewuDnweGWXnHK/7Cv8pMxCC91
    0Q+HEj/S4HnwpHyBYN7APNvdH8GGBrwPhyS8aZAZCEionI//oUeWB9AlN7THLqvx
    w/XMf4PqPINYj20Uf1+Nr5wYxY+emCg6UfjSVH4eQMch25PpEn1lUMKmqPyTcsza
    PbPb6578JxL44Fs59+HB3KO7LLfPe2Jlq/KjOiGhz0z3A+7td3Li9bsBeConwg2Y
    D4X6B+hfp/uYF5AMDdKJ3G+Wa6AVOHvHXBYM7chBXT8H6ge5XTZW/uMZyghIehT2
    8+dvrCMEFfOc2SreUMj+hweJxRlj4YiCN9BukdHk3i0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161415AbeCATqV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:46:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161343AbeCATqT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Mar 2018 14:46:19 -0500
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
Subject: [RFC PATCH V1 00/12] audit: implement container id
Date: Thu,  1 Mar 2018 14:41:03 -0500
Message-Id: <cover.1519930146.git.rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Implement audit kernel container ID.

This patchset is a preliminary RFC based on the proposal document (V3)
posted:
	https://www.redhat.com/archives/linux-audit/2018-January/msg00014.html

The first patch implements the proc fs write to set the audit container
ID of a process, emitting an AUDIT_CONTAINER record.

The second implements an auxiliary syscall record AUDIT_CONTAINER_INFO
if a container ID is present on a task.

The third adds filtering to the exit, exclude and user lists.

The 4th, implements reading the container ID from the proc filesystem
for debugging.  This isn't planned for upstream inclusion.

The 5th adds signal and ptrace support.

The 6th attempts to create a local audit context to be able to bind a
standalone record with the container ID record.

The 7th, 8th, 9th, 10th patches add container ID records to standalone
records.  Some of these may end up being syscall auxiliary records and
won't need this specific support since they'll be supported via
syscalls.

The 11th is a temporary workaround due to the AUDIT_CONTAINER records
not showing up as do AUDIT_LOGIN records.  I suspect this is due to its
range (1000 vs 1300), but the intent is to solve it.

The 12th adds debug information not intended for upstream for those
brave souls wanting to tinker with it in this early state.

Feedback please!

Here's a quick and dirty test script:
echo 123455 > /proc/$$/containerid; echo $?
sleep 4&  
child=$!; sleep 1
echo 18446744073709551615 > /proc/$child/containerid; echo $?
echo 123456 > /proc/$child/containerid; echo $?
echo 123457 > /proc/$child/containerid; echo $?
sleep 1
ausearch -ts recent |grep " contid=18446744073709551615"; echo $?
ausearch -ts recent |grep " contid=123456"; echo $?
ausearch -ts recent |grep " contid=123457"; echo $?
echo self:$$ contid:$( cat /proc/$$/containerid)
echo child:$child contid:$( cat /proc/$child/containerid)

containerid=123458
key=tmpcontainerid
auditctl -a exit,always -F dir=/tmp -F perm=wa -F containerid=$containerid -F key=$key || echo failed to add containerid filter rule
bash -c "sleep 1; echo test > /tmp/$key"&
child=$!
echo $containerid > /proc/$child/containerid
sleep 2
rm -f /tmp/$key
ausearch -ts recent -k $key || echo failed to find CONTAINER_INFO record
auditctl -d exit,always -F dir=/tmp -F perm=wa -F containerid=$containerid -F key=$key || echo failed to add containerid filter rule

See:
	https://github.com/linux-audit/audit-kernel/issues/32
	https://github.com/linux-audit/audit-userspace/issues/40
	https://github.com/linux-audit/audit-testsuite/issues/64

Richard Guy Briggs (12):
  audit: add container id
  audit: log container info of syscalls
  audit: add containerid filtering
  audit: read container ID of a process
  audit: add containerid support for ptrace and signals
  audit: add support for non-syscall auxiliary records
  audit: add container aux record to watch/tree/mark
  audit: add containerid support for tty_audit
  audit: add containerid support for config/feature/user records
  audit: add containerid support for seccomp and anom_abend records
  debug audit: add container id
  debug! audit: add container id

 drivers/tty/tty_audit.c    |   5 +-
 fs/proc/base.c             |  63 +++++++++++++++++++
 include/linux/audit.h      |  36 +++++++++++
 include/linux/init_task.h  |   4 +-
 include/linux/sched.h      |   1 +
 include/uapi/linux/audit.h |   9 ++-
 kernel/audit.c             |  74 +++++++++++++++++++---
 kernel/audit.h             |   3 +
 kernel/audit_fsnotify.c    |   5 +-
 kernel/audit_tree.c        |   5 +-
 kernel/audit_watch.c       |  33 +++++-----
 kernel/auditfilter.c       |  52 ++++++++++++++-
 kernel/auditsc.c           | 154 +++++++++++++++++++++++++++++++++++++++++++--
 13 files changed, 408 insertions(+), 36 deletions(-)

-- 
1.8.3.1

