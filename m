Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3778089-1523494324-2-15539930346627360973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523494324; b=a1dPrH8tmwfcsJpBKVhW2yR+bhFJLb5FikhIeIxvh3pxApisw5
    e9I6wvVN1mhl2MwXCBsZXma91K99x242lNWh00jb0CQOdukG//C4Z5NYk1mJCIzT
    VOfUJPPRAaiaQpnz5H+Nng08ubS8LtL85s7R3CpW4Y2OLsXK9paUHT3Sb9W1/4AP
    te4xUokHRWmN43TivKZfR2aeRP8QqXyKQje8U1LhsqkvPIle/3kFYuJtR5Guc96K
    fTJSTho1WBwBshg2I9TBsHAIPJuaP+RoaIGKuJF4P/HlN79QIdn0r3QSdTkh4/r1
    C0kDGmdJHL0Km5efzM81KFZxBhltjyCYGk2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:message-id:from:subject:date:sender
    :list-id; s=fm2; t=1523494324; bh=XdvCVmP8+sLMpEWjeALeiAHM1HEbHw
    4gNO1jvvL4Y3A=; b=vrkXLryTP9JXu5O1vNTrOwauxR/tDoB0/xb9Sqg6DfoqTv
    wR41JqwGCFRfqOHrmZOMP8A4lHiH4Yzh1Vkz4KJFNK8Z8vred1Lfv/DESiQLETXC
    Vrmi6kwN3EVPGRLpK944AvfTX+PeNtn6QnlKN9RFOwsTEcVZG9ubArN9By8QiVLh
    TOxT7Cu0p3lXbXfZyujIcr72m7/P3b36NtGVO7WUro9mivn0LAbmacPmS3nQpLu/
    pS1gXCHO1tVU3FFur2Dy5QP88vaJ+CitEknr5vvXcXE7hJwce+B2G52PgIHgGbK/
    k0j2z2bgr/h7aor1QkaaKfXCRvUYamvP1fWzJf4A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1MOrIkzlnDzsc0gaqGCwCURu2PHGYwfwrMepyE+isOGL7pZ/arkrQ+Gdw8uZU/9p9ChVgk7MR9D1/0dP1bf9ygWtIjtMgi8+NDVIq2VyR+LaEXGS9w
    0+vaX+KNn3bSt4OaDYi5xMKuj3GcWIqIYGx9RQIjD8HCC+2f9m7XKV04Jga1aAkBt5kQABzR+ya1mX4NBmw5L8vDsIFTDbQ11ylWcK3OS89s9Y0qFN9m03cp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=0SoRxNDEnYLDCN7UOsMA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeDLAuQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 20:50:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39742 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751841AbeDLAuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 20:50:14 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, stable@vger.kernel.org
Message-Id: <cover.1523493475.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 00/10] SWIM driver fixes
Date: Wed, 11 Apr 2018 20:50:14 -0400 (EDT)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series has fixes for bugs in the SWIM floppy disk controller
driver, including an oops and a soft lockup.

One way to apply these patches to v4.14+ is by first cherry-picking
these commits:
b87eaec27eca3def6c8ed617e3b1bac08d7bc715
e5f0d2e2a153b18dcf31e1a633e210c37829d759
There are of course other ways to fix the patch rejects, but this way
would be convenient for me because it would simplify my own backporting.

Changes since v1:
- Dropped the two IOP patches as they aren't simple fixes. This way,
  the entire series is suitable for stable trees.
- Added Cc, Fixes, Acked-by and Reviewed-by tags.


Finn Thain (10):
  m68k/mac: Revisit floppy disc controller base addresses
  m68k/mac: Fix SWIM memory resource end address
  m68k/mac: Don't remap SWIM MMIO region
  block/swim: Fix array bounds check
  block/swim: Remove extra put_disk() call from error path
  block/swim: Don't log an error message for an invalid ioctl
  block/swim: Rename macros to avoid inconsistent inverted logic
  block/swim: Check drive type
  block/swim: Fix IO error at end of medium
  block/swim: Select appropriate drive on device open

 arch/m68k/include/asm/macintosh.h |  10 +--
 arch/m68k/mac/config.c            | 126 ++++++++++++++++++++------------------
 drivers/block/swim.c              |  49 +++++++--------
 drivers/block/swim3.c             |   6 +-
 4 files changed, 96 insertions(+), 95 deletions(-)

-- 
2.16.1
