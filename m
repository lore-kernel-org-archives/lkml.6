Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691500-1526589511-2-3135525759327940760
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
    1526589510; b=jV9ZdYExMFWGELYL/5owDcoNGsAnyfZs9PBQocqpb115M52t4D
    XHDSKrzB8v1GgWA+ceCtrUm3lIJqhAjZyxgBulUBUXhE0H92NhzgrnkXAJgpcEbL
    un3vAKKPiBjozBWKLiOHDwqNPdT9id8tvFLuyutVF0L5G5efFleaUiwNK1cvUWjr
    7VMd+kNV+cnPtx6mw6hUVs7JRxWZzRcH+/7Fcvrg+EpkUcJMXUXcE4anQ9RpdPyj
    F+iW1in5iHlztnunipqc/bTldFHzOqlxae0d+AhdX0cyOQjMPoHqBElWgC6JTAoB
    FHeSS0itg8WOzhS9UK07FeA1q37GxGP6u1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526589510; bh=iGBP1rm0nGcfPVsgiCUAxliRjli58D
    VUqQsd19YsYcE=; b=CO7ws74BTsTQ/1q32SkwTvdW9yp/U5yxZ+sO77Zpw5gtsh
    Io6CLEGfmJqPAGjgDLgwodWMHLCQjJjiFQL8+VPpRM2SvaicX6LrHcxjjOc6KkVh
    UgtAXFqS3I9Sr4pQo4zs1AKWUXrdRuO6aoUs9T/uEWw9qCy8xBCuE5rAED+h+ptD
    +qA1z3KKmA8/1pbKnT7LuKQBgLyXOHCEfTnxzeuYcb8Zxg2BQFdA6O01KNNf2gfk
    fvRTrbLi2psFDfLWei9enGfdO2z5hLnZJglv0EX78EUKop62u6nIt8iI4qbB3TvH
    GXVXVMr54JhVVQS/cbGrBY/iCIv3TTs9qEnSnvYA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=IgAeKrmz x-bits=2048
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=IgAeKrmz x-bits=2048
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
X-CM-Envelope: MS4wfI+2DEN3LqgeatuhRfw4BvHk1QT+yOnJuDjAO9TPmQLvPVK6/hkoCdqznYWVvAaFOzaLfdnvogZ4MnpPermOqigckJNi2zVnQAoyLlr+fWlYna1pwFT6
    Vyt6p4/5O3aXoOfoh7kpCa6xSRCyrkZVwoXVLKdfxZjFyOyIsn+e7YLQljuKGGG3ijpURio7TlyzjQmF6FSDu/214mmnbum38noyyXInZSPe5Z3HpkuzCwtY
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=BO75SjoTw0CrWoTRIEkA:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbeEQUi0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 16:38:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60847 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQUiZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 16:38:25 -0400
X-IronPort-AV: E=Sophos;i="5.49,412,1520870400";
   d="scan'208";a="78199739"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, bcrl@kvack.org
Cc: mingo@kernel.org, peterz@infradead.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        rgoldwyn@suse.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v4 0/3] AIO add per-command iopriority
Date: Thu, 17 May 2018 13:38:00 -0700
Message-Id: <20180517203803.2664-1-adam.manzanares@wdc.com>
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

Third patch passes ioprio hint from aio iocb to kiocb and enables block_dev
usage of the per I/O ioprio feature.

v2: merge patches
    use IOCB_FLAG_IOPRIO
    validate intended use with IOCB_IOPRIO
    add linux-api and linux-block to cc

v3: add ioprio_check_cap function
    convert kiocb ki_hint to u16
    use ioprio_check_cap when adding ioprio to kiocb in aio.c

v4: handle IOCB_IOPRIO in aio_prep_rw
    note patch 3 depends on patch 1 in commit msg

Adam Manzanares (3):
  block: add ioprio_check_cap function
  fs: Convert kiocb rw_hint from enum to u16
  fs: Add aio iopriority support for block_dev

 block/ioprio.c               | 22 ++++++++++++++++------
 fs/aio.c                     | 16 ++++++++++++++++
 fs/block_dev.c               |  2 ++
 include/linux/fs.h           | 17 +++++++++++++++--
 include/linux/ioprio.h       |  2 ++
 include/uapi/linux/aio_abi.h |  1 +
 6 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.15.1

