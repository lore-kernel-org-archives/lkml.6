Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2852936-1526400168-2-106218866143296208
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526400167; b=EvJUw7W/yyVVkaj5pycF4L8caZfrZ+XDLNlq9RQ2x5sbPPg7Cy
    IJso9l0WZPiyeJRcLxwBWE+qIuOt6TCVzBeQ777yNsiAu4TpBV2Jb+0p4x0Aptdb
    4c3u6aG5F8MZq9uuS8tAybxteLNKOvV5mMwZhlv6FWpEDgS4cZyCFBpIydTEVOBy
    vCHdCYXtveBMDNmzYmpuyLcINTT7CGEw2/AKfrskgWHH+7K61S3zqXumNlCFI4yx
    UkuyAsWAmJQCqXpE1SLIjJzz0Zk8UKlI17d1PaaI/BBdDUBdfaUN33cbK2AIRkp9
    SKbpaEtWS3TSdCI1860TYtURB8WX9Ckp6lxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526400167; bh=ytjmk10uORuHSLPSfCxbPaxcvbMdJG
    3oh7qgZNcABLA=; b=OH0keyQKa485SfEUc8e1O+z2189Y9MS69y/gqK2qmvK+ny
    swd2xbZz5xgP6JBmN3wzZWAXkwjhagv9XcndOeXYcdeVvyQ4Va6d1wQepeKUXdMB
    NnMEq7eSWqViPWQ6pM101etz7Ug7vS5Q9elbRQwT55RQ2YBITs3leMUKOxZ3qZ3F
    DgJ/dknIMIPjDIiUeVPe+YUmGWGuSYZJxnb+L1ZKzbYdyIhMd+nS400LD64OmaR8
    rFoLUJ2n0nwlYVdYVO4VmBfU0beMPlr45tbnLdtW/Am43EUO+UAjAAa8MmVrbgk7
    ki0iL6X20fUez4z3bEF8NQG6CMBGAetxur7mAgLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=mBOSvIoS
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=mBOSvIoS
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAgiz/teULfjlDSdwq6PLYe7P1Pfh69kEMx2BQaaZjWGBmCNY/p/yWiTdwL/rewOTqNeG0n/e1JkCEHOv+XwtBwFwXdgjOY5EaHpJEPSvD+Pr+MGafJB
    Jx/pSbtJTet8X7lP7TTTiK61jL4/X9QSF53xbpCuQxJAGVgy0V7aIoZIE5Wt+7F7CvH5aMZColY/NKWY3veDfRRL//+jx0uDRZYqZLBCBH69FYYPO+AYfKN7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=C4-KwePKuOrHnoknaPoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbeEOQAv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 12:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeEOQAt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 15 May 2018 12:00:49 -0400
From: Matthew Wilcox <willy@infradead.org>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH 0/2] Use sbitmap instead of percpu_ida
Date: Tue, 15 May 2018 09:00:41 -0700
Message-Id: <20180515160043.27044-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

This is a pretty rough-and-ready conversion of the target drivers
from using percpu_ida to sbitmap.  It compiles; I don't have a target
setup, so it's completely untested.  I haven't tried to do anything
particularly clever here, so it's possible that, for example, the wait
queue in iscsi_target_util could be more clever, like the block layer
uses multiple wait queues to avoid pingpongs.  Or maybe we could figure
out a way to not store the CPU that the ID was allocated on, or perhaps
the options I specified to sbitmap_queue_init() are suboptimal.

Patch 2 isn't interesting; it just deletes the implementation.  Patch 1
will be where all the action is.

Matthew Wilcox (2):
  Convert target drivers to use sbitmap
  Remove percpu_ida

 drivers/scsi/qla2xxx/qla_target.c        |  16 +-
 drivers/target/iscsi/iscsi_target_util.c |  34 +-
 drivers/target/sbp/sbp_target.c          |   8 +-
 drivers/target/target_core_transport.c   |   5 +-
 drivers/target/tcm_fc/tfc_cmd.c          |  11 +-
 drivers/usb/gadget/function/f_tcm.c      |   8 +-
 drivers/vhost/scsi.c                     |   9 +-
 drivers/xen/xen-scsiback.c               |   8 +-
 include/linux/percpu_ida.h               |  83 -----
 include/target/iscsi/iscsi_target_core.h |   1 +
 include/target/target_core_base.h        |   5 +-
 lib/Makefile                             |   2 +-
 lib/percpu_ida.c                         | 391 -----------------------
 13 files changed, 74 insertions(+), 507 deletions(-)
 delete mode 100644 include/linux/percpu_ida.h
 delete mode 100644 lib/percpu_ida.c

-- 
2.17.0

