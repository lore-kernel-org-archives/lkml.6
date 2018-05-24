Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527197299-2-2986434350245708056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527197299; b=J1p2hjkTcr8Gf/UHwGZyaddOM8WELyqdlOT23IvHB9SeCmViUu
    QVhp/2UDLWjh/10AKRl/IbASOnhiCOFhdAY700LbZXpLMyCdKjIMrRtEcXv1l6EM
    38Z29TIiXhIC3t1E9KYMvYmHQ46D0u7DfZA6WpKe5hbEpdTdw2HzwT5pjkIxA/RF
    7vfGVKg9en2x+6se0pWWBCy80S+I5meRricw0AivwtM/vH7pfF8HdfsXNlmLViEJ
    WZaqh4eebnsSpdLP5vBKTLubpkC/WAljjRgBcr3surIxTTMvZtC6OU55hWq3HM27
    WQy8cK6vN6o/tSgd6m0Scq2XldtlwIFwY5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527197299; bh=16fWsZ25GRU+HvWdIw0kukY7J7+r86
    7pZon9O0LQYNU=; b=Je3r96L4qVE0DZB/Vk5yylMgj4hc7OirAjOSavIyLQiONz
    SlmZs/+4+sZUvFiVBTPB12YpkeLTAs3qO6k9l2l3FuDJ2VN9ntrw5eRDa+vyptVE
    YJ4SCx7SRyGv6wuNHBB9iAnhars0qrBbD0KqAJ6MLmIWKU+N9vKOr/A3UXTkTQvb
    hrvSP5SIMNsz1GzYJ2HYU8Fec95RPRUoBpjLwEw5uixe1Co7aEKgceUzRVMGucEs
    +CJqc72azdQaZ2M9ES9sICBwoFcIFjHbHNCzrYLhBG1s6fqflTdJTFMt/QbKPOJS
    +bJxr8DmY2MrNnEzUh3rZnp7rLzREa+yRasK5+gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJp93VgPzI8dWJMW41VHSlKF/MAfghNisZTiKUSJZj70ZZ2/SgSE06zzRhIJKYKW/dWvp2Cr3mIV7vwHfyh3TxlBid26Suj07u4R25uVaI2RD/Ui+ZYY
    1YgaaN3YY1AE2L2WUUpp5B868yXve2oKERXBRgdkEFr7Yxu+HO/NaGZtGuef9tJaYMgvWi6pSQSY5qsh5zCc3K/tpkr4wcX6sfB2Jg+ysr7HWRi4jDPwHwwk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8
    a=VwQbUJbxAAAA:8 a=bhR_KwdRyDba87x8MxkA:9 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966813AbeEXV2Q (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:28:16 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:48521 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966782AbeEXV2Q (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:16 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH -next 0/6] rhashtable: guarantee first allocation
Date: Thu, 24 May 2018 14:11:29 -0700
Message-Id: <20180524211135.27760-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This series is the result of the discussion with Linus around ipc
subsystem initialization and how it behaves with error return when
calling rhashtable_init()[1]. Instead of caring about the error
or calling the infamous BUG_ON, Linus suggested we guarantee the
rhashtable allocation.

First two patches modify rhashtable_init() to just return 0, future
patches I guess can update more callers.

patch 3 is a nit I found while reading the code and just makes use
kvmalloc_array().

patch 4+5 remove some ipc hacks we no longer need.

patch 6 updates the rhashtable test module. Trivial.

Please consider for v4.18.

Thanks!

[0] https://lkml.org/lkml/2018/5/23/758

Davidlohr Bueso (6):
  lib/rhashtable: convert param sanitations to WARN_ON
  lib/rhashtable: guarantee initial hashtable allocation
  lib/bucket_locks: use kvmalloc_array()
  ipc: get rid of ids->tables_initialized hack
  ipc: simplify ipc initialization
  lib/test_rhashtable: rhashtable_init() can no longer fail

 include/linux/ipc_namespace.h |  1 -
 ipc/msg.c                     |  9 ++++----
 ipc/namespace.c               | 20 ++++--------------
 ipc/sem.c                     | 10 ++++-----
 ipc/shm.c                     |  9 ++++----
 ipc/util.c                    | 41 ++++++++++++------------------------
 ipc/util.h                    | 18 ++++++++--------
 lib/bucket_locks.c            |  2 +-
 lib/rhashtable.c              | 49 ++++++++++++++++++++++++++++++++++---------
 lib/test_rhashtable.c         |  6 +-----
 10 files changed, 79 insertions(+), 86 deletions(-)

-- 
2.13.6

