Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2689340-1527001720-2-783973698372537488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527001719; b=P0f9eGs5ZjWWmIB/QgUOt2r6RuyKbyQZTythjP8bpxXyx6frFs
    dtmS5HLva0D5FdpQDz8sjTtPms33QwtG291M3AmEj4de3rI39++mfzSp9+DeU07E
    hNp9JK11RVm1+ImSWQoD8CIBlSiekWokT9Iu4k50mHXegMP1JJBvQ8RihOUtTwRe
    xYCyClCGk1CRVLolMhWJfnriqqGnpNTSKidN1vwRzQSWkFwkVSEpCU5a4pDdBxGO
    TVWq8wUz9nbrRz9/0ls4aZ7C1lr1s1PKRDuxXuPKiiagI3F2shRiINAEaWdAlfRy
    C1424iGDnnXHZrgNYRuPJBEWkw4pLaSNVeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527001719; bh=ONGSfGUpuKJ1QkWc+MMCxUocywFDqM
    4au2UplpxeyDc=; b=Doqw/ixJvMdp9zGFku3kz8UCR4BT/kKe3RyZ0os4JZkgUs
    J48gNk9gHZACTR5ch1431LRONhBUe6068Pz/G9taBWgq4xzCjC0sv/z+Hv96gCaZ
    u97+NCWfjHh/NSEsmw39M5WWX7yIGdyl1kmaLZuqnmoJngX24bqzpP9fmZYsi2Fj
    syGmTh0+LVyZeYsr1+7vitDA9EUAp2rGCccPBYE78VWen40bv5YFvsWZrACqMs+3
    YnLXw7Ar2AX21abSEY+fluDpmkTEYoeuqpucjWiI5QtHF51NllMm+uO1SFFMK6c5
    QZsF3aU7N2cDlOQ6g4DrdWQNYzit5Eo0E8kCseRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=DlM5Ggb8 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=DlM5Ggb8 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=dkim.wdc.com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=wdc.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=wdc.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWmqPPmAhDDcXi0driMFvb+AVyrLu7Eg3eXTzcB4MbPHMTGZUFmZTENZitWPrKxRCP38moIFDPhEccWf+9UF+ooRbFy9xbusDQVKkeMC5YCRGiEDQoM
    efScg5UAgPxW84Pkc52+LHl4uSBYW/Z+yZ8bSxyHCFEwginZDti0Z4IQEubn3GGyj2rYHbCJm4J2mh6H7ZgUUR8dmH3Mqfk4kSn17bwz9pQhMtCEwx+bktJh
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=_QpXJ_nA6LREa76I76EA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeEVPIA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 11:08:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23233 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751597AbeEVPHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 May 2018 11:07:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520870400";
   d="scan'208";a="79548761"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: tglx@linutronix.de, mingo@kernel.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        bigeasy@linutronix.de, jack@suse.cz, darrick.wong@oracle.com,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, hch@infradread.org, jmoyer@redhat.com,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v6 0/5] AIO add per-command iopriority
Date: Tue, 22 May 2018 08:07:32 -0700
Message-Id: <20180522150737.9893-1-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

This is the per-I/O equivalent of the ioprio_set system call.
See the following link for performance implications on a SATA HDD:
https://lkml.org/lkml/2016/12/6/495

First patch factors ioprio_check_cap function out of ioprio_set system call to
also be used by the aio ioprio interface.

Second patch converts kiocb ki_hint field to a u16 to avoid kiocb bloat.

Third patch passes ioprio hint from aio iocb to kiocb and initializes kiocb
ioprio value appropriately when it is not explicitly set.

Fourth patch enables the feature for blkdev.

Fifth patch enables the feature for iomap direct IO

Note: this work is based on top of linux-vfs/for-next

v2: merge patches
    use IOCB_FLAG_IOPRIO
    validate intended use with IOCB_IOPRIO
    add linux-api and linux-block to cc

v3: add ioprio_check_cap function
    convert kiocb ki_hint to u16
    use ioprio_check_cap when adding ioprio to kiocb in aio.c

v4: handle IOCB_IOPRIO in aio_prep_rw
    note patch 3 depends on patch 1 in commit msg

v5: rename ki_hint_valid -> ki_hint_validate
    remove ki_hint_validate comment and whitespace
    remove IOCB_IOPRIO flag
    initialize kiocb to have no priority

v6: add __blkdev_direct_IO_simple ioprio support


Adam Manzanares (5):
  block: add ioprio_check_cap function
  fs: Convert kiocb rw_hint from enum to u16
  fs: Add aio iopriority support
  fs: blkdev set bio prio from kiocb prio
  fs: iomap dio set bio prio from kiocb prio

 block/ioprio.c               | 22 ++++++++++++++++------
 drivers/block/loop.c         |  3 +++
 fs/aio.c                     | 16 ++++++++++++++++
 fs/block_dev.c               |  2 ++
 fs/iomap.c                   |  1 +
 include/linux/fs.h           | 16 ++++++++++++++--
 include/linux/ioprio.h       |  2 ++
 include/uapi/linux/aio_abi.h |  1 +
 8 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.15.1

