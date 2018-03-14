Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2464639-1521056533-2-10067799755885875127
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521056533; b=Nj6OkMKt5saAkAUIT7sEXmdEb6jDFuPlgxVUgBakaBvRrYl
    wBnhWGppBugLDM18RLzqbHnoFv0si8Vx0UD2LNhzGgya548bhf8zU9LefarOhzOn
    n4uvklgC+IAlwpnpOjb2iH4Ih4s0UCiN9MzAIgV86YrZMIVu5ACj8DaJ1WZQCSUe
    BQtpU8FmXCqrRuno5G8wI3KiLeoH0gDqxNUYRp1jrBW+whF9EFRUbNdsTvtheaGC
    ABpZILoIuVkx3fc+O+AfeuTeOu4vzJRc3EdnWgxcetDsGdwBrpTcMoeurtmsEupf
    AKbxNAHoxYTgh47E2cKy43nDcSOzVyVL+0ADJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date
    :message-id; s=arctest; t=1521056533; bh=cUE5CuSiJicx2Rso+Y1Z25J
    lkwP1MTL7LvdsLWTk+kA=; b=Px1FvT4Ly0Lv9eX7T5BjUhdLlmKS3v6KcgeMgcQ
    8vf9r2e7xla655cNAEKUlmYyNm2j8ZLOqusa/FKP6kRroq6qmkeb589sMncgyt0z
    ZSAlq07YDJXMLCQSBquIIimMVFhl61vlk1AAQ5au5gmYpACgBLQpA2Y1U9CyfENG
    PrVr3ynw5D59F4z+hr776I+KU8O56VBOOPB9tpEndGYH5Uf+wNWpCVyr8VmpWaSS
    g8Z74gF9Lwica9WgmMEv0ALcKQj1Uqn31w22Io/NcDZJrLXjmEdTOqKQ1MYBxGCp
    aBN0v/3Q+1+gAbjwVjPdKykVZtb4ABZ608Vw71VJtOuGxsQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jHJF1zzv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p1vrHKiv;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jHJF1zzv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p1vrHKiv;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097B22077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELstsQjLzsfVVmK9xtjXNZOqxAW25fw2DWGMq1JhPFMGhfeuOITEITkeu69GTj2aILaWgy+Zjw==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCHSET v2] percpu_ref, RCU: Audit RCU usages in percpu_ref users
Date: Wed, 14 Mar 2018 12:41:57 -0700
Message-Id: <20180314194205.1651587-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

Linus, if you want to pick up the first three fix patches, please pull
from the following branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git percpu_ref-rcu-audit-fixes

Changes from v1[L] are

* blk_queue_enter() patch dropped.  Needs further investigation.

* queue_rcu_work_on() dropped and documentation improved.

* rcu_work conversion patches separated out.

Original patchset description follows.

Jann Horn found that aio was depending on the internal RCU grace
periods of percpu-ref and that it's broken because aio uses regular
RCU while percpu_ref uses sched-RCU.

Depending on percpu_ref's internal grace periods isn't a good idea
because

 * The RCU type might not match.

 * percpu_ref's grace periods are used to switch to atomic mode.  They
   aren't between the last put and the invocation of the last release.
   This is easy to get confused about and can lead to subtle bugs.

 * percpu_ref might not have grace periods at all depending on its
   current operation mode.

This patchset audits all percpu_ref users for their RCU usages,
clarifies percpu_ref documentation that the internal grace periods
must not be depended upon, and introduces rcu_work to simplify
bouncing to a workqueue after an RCU grace period.

This patchset contains the following eight patches.

 0001-fs-aio-Add-explicit-RCU-grace-period-when-freeing-ki.patch
 0002-fs-aio-Use-RCU-accessors-for-kioctx_table-table.patch
 0003-RDMAVT-Fix-synchronization-around-percpu_ref.patch
 0004-HMM-Remove-superflous-RCU-protection-around-radix-tr.patch
 0005-percpu_ref-Update-doc-to-dissuade-users-from-dependi.patch
 0006-RCU-workqueue-Implement-rcu_work.patch
 0007-cgroup-Use-rcu_work-instead-of-explicit-rcu-and-work.patch
 0008-fs-aio-Use-rcu_work-instead-of-explicit-rcu-and-work.patch

0001-0003 are fixes and tagged -stable.

0004 removes (seemingly) superflous RCU read lock usages.

0005 updates the doc and 0006-0008 introduce rcu_work and use it
instead of open-coded rcu+work.

This patchset is also available in the following git tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git percpu_ref-rcu-audit-v2

diffstat follows.  Thanks.

 drivers/infiniband/sw/rdmavt/mr.c |   10 ++++---
 fs/aio.c                          |   39 ++++++++++++++++-----------
 include/linux/cgroup-defs.h       |    2 -
 include/linux/percpu-refcount.h   |   18 ++++++++----
 include/linux/workqueue.h         |   23 ++++++++++++++++
 kernel/cgroup/cgroup.c            |   21 ++++----------
 kernel/workqueue.c                |   54 ++++++++++++++++++++++++++++++++++++++
 lib/percpu-refcount.c             |    2 +
 mm/hmm.c                          |   12 +-------
 9 files changed, 130 insertions(+), 51 deletions(-)

--
tejun

[L] http://lkml.kernel.org/r/20180306172657.3060270-1-tj@kernel.org
    http://lkml.kernel.org/r/20180306173316.3088458-1-tj@kernel.org
