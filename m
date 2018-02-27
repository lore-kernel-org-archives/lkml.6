Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-983322-1519719611-2-6622972747087626038
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
    t=1519719611; b=qvOzoNs2rZkHihu1dGFlOCsd5YJXKj25BxwS87l4badmUx3
    NE58pj193h0faWyOgbO9yaknS/HD+0KsNkW17A6c1GAxRmHKZWb7AL1LWNGAu9/j
    cpmu9KPg9l4ZeT2KcO2e/5Q1ShBUEM8kOicPd8J8STYJ9DemGyRkGPAiuQD+MhPQ
    M0ChqU9DV4qWCA2uwt7EkaZKvT9c0j49pSq+pD7YpB4ZS/oplf9pnqZYd2bbpReJ
    /4Ouv8W/3M9Hn6YFswB7wtjE45gZlv36yTZoRIXP3kqoRwDyQsrA7OihUIG3bcPz
    MQMXZKwEwpbkr/bKs0YqVWj2pF3nA0KuzyqILjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519719611; bh=5qrHL2V6pqti0d6XMvQXJKIf7O
    nT1ixS/5dm6h8ufR0=; b=ofKnJF/m/M57RCgnifj/oQm9ZB0c6H7DTkU7b24Tmt
    BBcFfBCJO2evtiZge2Fdgs05SJ9J2aHZI0eJbvBzc5XGFNqrgAcyFcKgFob5hI2l
    t7zT5lz38cNl5iath9Mhp54sbMn5wQ/GoyESqlDiIkdhFgJIhk3ZpWYw6ivHkCO7
    SHOX7G4LSF0YseqhDiTDDqioCYgdZ0IylUYn2DQS44u4X77Pcu8lX2z2Cey0Zzom
    REK4gq6x3Fqj5lSnW2+r8C2dTpaVdQkULJPeCBzQClj9drNJp4DomSF/trgWSxDW
    6xEaILy6g64oEAulNrIrRkJ+eJsloFguHojnDbdl1++w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeB0IUF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 03:20:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752098AbeB0IUD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 03:20:03 -0500
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/3] userfaultfd: non-cooperative: syncronous events
Date: Tue, 27 Feb 2018 10:19:49 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18022708-0040-0000-0000-00000438442A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022708-0041-0000-0000-000020DA6EEC
Message-Id: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270100
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

These patches add ability to generate userfaultfd events so that their
processing will be synchronized with the non-cooperative thread that caused
the event.

In the non-cooperative case userfaultfd resumes execution of the thread
that caused an event when the notification is read() by the uffd monitor.
In some cases, like, for example, madvise(MADV_REMOVE), it might be
desirable to keep the thread that caused the event suspended until the
uffd monitor had the event handled to avoid races between the thread that
caused the and userfaultfd ioctls.

Theses patches extend the userfaultfd API with an implementation of
UFFD_EVENT_REMOVE_SYNC that allows to keep the thread that triggered
UFFD_EVENT_REMOVE until the uffd monitor would not wake it explicitly.

Mike Rapoport (3):
  userfaultfd: introduce userfaultfd_init_waitqueue helper
  userfaultfd: non-cooperative: generalize wake key structure
  userfaultfd: non-cooperative: allow synchronous EVENT_REMOVE

 fs/userfaultfd.c                 | 191 +++++++++++++++++++++++++++++----------
 include/uapi/linux/userfaultfd.h |  14 +++
 2 files changed, 158 insertions(+), 47 deletions(-)

-- 
2.7.4

