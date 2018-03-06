Return-Path: <SRS0=gsCl=F4=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-870783-1520357244-2-10714215208896238011
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
X-Mail-from: SRS0=gsCl=F4=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520357243; b=QNOEFZROmf4htoIw1oRvfQhgrYD3IyyK5DZUa7dEoqJvC9x
    J6s58EJPimBem9JZmTTbDGbStSeHhWWOyTdZ84LfoTJFsVyc7JHYbjKQFl0/vWbU
    1nSbjG8mTLfqZLnquK0TPOWHIjs5nLI1ebqag4olZRyc1VVNUQqUOwIxov0NKIK2
    GsrzWvIV/uiyLt8ecjjCLDry+j+PojfdV82T71T1VnqyC1MBZ/+g/j+xFqdcNL4m
    /M6CfPW/SQC16QBC8DMstHF9XReLFIBNpRAHPswp7HDOfrdGnF+qMPkwRHkNDcur
    94VbTIEe/KBzQCFTmpwnFboyXI6YXTSt4nYhXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date
    :message-id; s=arctest; t=1520357243; bh=lEZC/w/RiKT3EeWuSZhdzLi
    S3CqbZloT0713vm1tHEQ=; b=AA6gGNzBR+OyRgtnAYsh49Ql5q/oGoL+mT/11Dt
    cQa1M7nmSNMHeWMBWs4GnZlPc4a+IZKvwpTbT+DQiVOobMKTu0b0rWC4fEiAN+JD
    +BzY9xwvVSQ+96ClQhEkJ4118b51ISTV+rdkAXaDVuuapa3Rj20lI6w1v+BavUBq
    o+YFBgwZt7EXChHiSYov6FRj/YXBLGsnjPNm4CcdiFZ+aS2GklR3YhOkRCl2nBsX
    9NmA0btT3xrzQl+Xe5VeFgUcI/uB73m7YScscp99v2MK41mu6EfYoTcmvnknwAha
    bMNCYhYRJezBm6GjZ/dDL4gjW/zIfNNC9TdSORXbtX6CiMg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GCxJ8tG7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jp93ZI35;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=GCxJ8tG7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=gsCl=F4=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Jp93ZI35;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025942178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELvTuJFRSNGzdVZvz5m1w748ZoNNTPgtxoB+3CtfCmsFjd7JVd/qsh2uY27iLU41ho1wSocpFw==
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
Subject: [PATCHSET] percpu_ref, RCU: Audit RCU usages in percpu_ref users
Date: Tue,  6 Mar 2018 09:26:50 -0800
Message-Id: <20180306172657.3060270-1-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

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

This patchset contains the following seven patches.

 0001-fs-aio-Add-explicit-RCU-grace-period-when-freeing-ki.patch
 0002-fs-aio-Use-RCU-accessors-for-kioctx_table-table.patch
 0003-RDMAVT-Fix-synchronization-around-percpu_ref.patch
 0004-HMM-Remove-superflous-RCU-protection-around-radix-tr.patch
 0005-block-Remove-superflous-rcu_read_-un-lock_sched-in-b.patch
 0006-percpu_ref-Update-doc-to-dissuade-users-from-dependi.patch
 0007-RCU-workqueue-Implement-rcu_work.patch

0001-0003 are fixes and tagged -stable.

0004-0005 remove (seemingly) superflous RCU read lock usages.

0006 updates the doc and 0007 introduces rcu_work.

This patchset is also available in the following git tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git percpu_ref-rcu-audit

diffstat follows.  Thanks.

 block/blk-core.c                  |    2 -
 drivers/infiniband/sw/rdmavt/mr.c |   10 ++++---
 fs/aio.c                          |   39 ++++++++++++++++-----------
 include/linux/cgroup-defs.h       |    2 -
 include/linux/percpu-refcount.h   |   18 ++++++++----
 include/linux/workqueue.h         |   38 ++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c            |   21 ++++----------
 kernel/workqueue.c                |   54 ++++++++++++++++++++++++++++++++++++++
 lib/percpu-refcount.c             |    2 +
 mm/hmm.c                          |   12 +-------
 10 files changed, 145 insertions(+), 53 deletions(-)

--
tejun
