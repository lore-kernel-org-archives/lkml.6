Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2645812-1521192053-2-4045798100493100272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521192052; b=HGgParbAZrEcnee19FjoXvBxvCwX2HZG+XEd2Y07RxHFH9T
    2GLyghsd3uU6f8QydZC7Hl8ua+j9cDVinSGIYfu6PDOxXMXtq7fsvjF0bir7SpX2
    ntiI7+L1SIYJ7oLjfb3kWGVUikKNtWh+3I4D6HUtp/BhFSJdSKxW/p3t2PpFVFzh
    dM+XhHLGKfVgk1QsnptJGZa7YjBtb0ETT1zO5eIr4UWXixz1iMIe1ReaoeelHGeo
    /yVYiIbi3Y8GuKr5+zO8fLQUHjPVidqQ22+3r9jmvkuNmLns/+NjZZkGHrFDjgn1
    S+zENHpVK2yEhFmP8ua5oMosvveDukNedG6Pwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521192052; bh=JluqGsc1Z9AH0mevNK2hSJE3wd
    l5GXXqNMiSnY/yYzI=; b=tLw8vNG9477xPzbSrBidrJAgOJl2VaMn9qc8OVBWFA
    5j+vMc40JS/CuDAVpDmwyB9J0wtMhSKnq0FiuivezLouotqzohGxPi6UZ9m73ZYP
    7DQYKLL1JkVqm00QOYJRa+OeD7QmFckvec7Ju56US3KaUMO6B9eQmmVIYsjXnNvM
    i9L++VS3chyBIgBAPNHexuFLqRs3kVYB8ficqs9eWpTRa9XDWttKwDFV5/UfHou+
    owng4BC2F4lExLdaNKaGF8FjHL69zVqYR7Qyraf5I9V7V9qaddxBsUmPfcWHmZhP
    BCJi6/VpxQqF4mZoQH9KhG0+l0sVplEzRb+dGDp+zQmg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1751858AbeCPJRw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 05:17:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbeCPJRv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 16 Mar 2018 05:17:51 -0400
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
Subject: [PATCH ghau40 v2 0/5] add support for audit container ID
Date: Fri, 16 Mar 2018 05:12:24 -0400
Message-Id: <1521191549-19764-1-git-send-email-rgb@redhat.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add support for audit kernel container IDs to userspace tools.

See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/32
See: https://github.com/linux-audit/audit-testsuite/issues/64

Richard Guy Briggs (5):
  AUDIT_CONTAINER message type basic support
  AUDIT_CONTAINER_INFO message type basic support
  auditctl: add support for containerid filter
  add ausearch containerid support
  start normalization containerid support

 auparse/normalize_record_map.h |   1 +
 docs/auditctl.8                |   3 +
 lib/fieldtab.h                 |   1 +
 lib/libaudit.c                 |  36 +++++++++
 lib/libaudit.h                 |  15 ++++
 lib/msg_typetab.h              |   2 +
 lib/netlink.c                  |   1 +
 src/auditctl-listing.c         |  21 +++++
 src/aureport-options.c         |   1 +
 src/ausearch-llist.c           |   2 +
 src/ausearch-llist.h           |   1 +
 src/ausearch-match.c           |   3 +
 src/ausearch-options.c         |  46 ++++++++++-
 src/ausearch-options.h         |   1 +
 src/ausearch-parse.c           | 171 +++++++++++++++++++++++++++++++++++++++++
 15 files changed, 304 insertions(+), 1 deletion(-)

-- 
1.8.3.1

