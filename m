Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525801435-2-5793763821789892860
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525801435; b=VES3AFBYb8JCbXNENQkwhjQR3LMvkvTjohZNDTIZ1949VE086B
    Xz0ekTHiw4qEkDlZLd2KIGxt55ttovL05KGOfY/JThe3B2K2MaQgURbqqgPjCNZO
    +BrFBK4/oyL6O6NGaw41ghsuJNE3dZ0+TXtuPWQsfX2h3Gjsa2zLmEwwf1w+C1kB
    MfKul7weyJCfgNZb1MgPZM+REX/EglJaXEL9btBoSe2PkrcXwEwmxyAicDBbpLCS
    eQ+V1rVvY5r3OS7Qd98Ln+5G7Za/sbyNh1PeWUDdxmZ4FSpONHa56dbb+/ZOh29Y
    oJa9KXALlFI4Y3o53JikMFOtAXvjnb7JKwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525801435; bh=QlgFM8OHZRhHRBgw/2QlDOW/rrZiPN
    6+SxbIjA1m0kc=; b=fLM+2JGa9g7U+ojHQpUcj57s7me4oz6HDc2a5kvMzNo/Yx
    z5XNiKHQAwH0/xkGZdBW6yNVhX3AMceQKIG1XdnOpPp4x2vtkucqXD7BsffVZyKO
    sd7NwKDIym7669HIEmtN9vjzuKs9RJ1otyz0n1yJ+HJpPh6wkWtdFyb4OvuBHwX/
    ZZXeR6DKPTZmwWDxwKmUT0ZBIL/bUh6LxByn2I+GveeVQ6tmZHQOHl89l9CXFzYD
    BkzkmeACTvw1UB84XaLVbxN3tjnjJIX8SI2qxoaFmpCM+U/HsuNpus3GYGLqyleE
    ljdaP5V2a3tYR1LwrlH34Yi0T0UKNWfYmDAy14ZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=wdc.com header.i=@wdc.com header.b=QS+D+4+Z x-bits=2048
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=wdc.com header.i=@wdc.com header.b=QS+D+4+Z x-bits=2048
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
X-CM-Envelope: MS4wfARg/WDwj7YCXDe+l9bSHD8V0vJVIPoW5kRqFmfAhW5MqoBwDztN80pMkXrLx9xMm0t8j8HvZlVJ9vkLX6kwr1DBUWcuU4vJaMu0Tx3gP+OtP1sJrvIP
    mDEbhWt//5TKs7cFbo/WDFVxMeZ/E5mRxx7XlZf9XI7tMQ8peZPNjN3Im7Mr4SsUGxsjuPyLhOGCrj3MxJYxjLzfXasY3i7M+29mUHT3tSDVMlWDqoAZ8Z7E
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8
    a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=we6vpJ_Xl7ZQkdBZ6E0A:9 a=x8gzFH9gYPwA:10
    a=xVlTc564ipvMDusKsbsT:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755152AbeEHRni (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:43:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39537 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbeEHRmh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 May 2018 13:42:37 -0400
X-IronPort-AV: E=Sophos;i="5.49,379,1520870400";
   d="scan'208";a="180732629"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v3 0/3] AIO add per-command iopriority
Date: Tue,  8 May 2018 10:41:59 -0700
Message-Id: <20180508174202.2537-1-adam.manzanares@wdc.com>
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

