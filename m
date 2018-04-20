Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524248284-2-13096037595112644239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248283; b=dOnU4tl9Dpf+L09dl5KT8xSrQW6njK4l8ksrwnfF4EQuAPl1+h
    pIErBavDayVvcp0KNsbGUTyOoCxOyyqKc27+mUgge9FPQEwzo7hsCLRr2Io9LceZ
    0BkjvL4gy7X2cs3wog2hKcxM5uL0p8oKYZzSP+gME8//psto6mH/bDT0hsXarP7k
    IroqBdsIgAKMjBMtTAhD6kT9diu5wpQzqL+oyvFnlzhj32R90xPnkgCV+Vhy558y
    yOqB5i4UEWhKUlPhQdLaQa4n4+sC/5OhdXYr9Vem7NGKUuX2Od9GWT8Wk6bmCjvu
    38vLm5DCP6eTAF+YjghG9IE7mVch/urL2Yrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524248283;
    bh=3GJOBwssU2ZgUP/I5mNH5zZoeQkVvjP5sbral87B+AI=; b=asCtiQqT1XLp
    KT2WPA61f+R2rLtOgmyyzQeLv8n96UebZqD+MENvJGDVlshKr8KPSKOAqJRrSwLR
    mM2aOPil9OkLiTzf2bvItmMlG8aZHPhqHAppGakfZ3RDrOjTOaQGLBe/lpu0yyh5
    8sLizxUsKdjQkZXxqQTP5ar5ar4yjvADfIsIdsQnLinbFOAOUFBTc6fq/LDd2NsZ
    I956RacSZYmsh45poocKdqVcjeYWWSD/GvwF/dIIeOGI8pj8FIClM6y9ZzJ/tSyw
    LVjQEBot7BJs7oec8brCHrB00AVmsfiPeg5U0YjjjMeVjR8Eix8QZA0VGaaumtb7
    w2Zv+CUbFA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEo3TnhvX9ct+DpLzGpxphZ/RqubYuzrUMzb4o6Zjn1qnir2LP+MYevLmVgjim8b5HXbC/GIMa1EBa5njuX7UNvbEIHt3nB8bN+0fnSUS9PF7uljyUXh
    iPerYWwl9E57VydSUObfx+kQePAgNomkMP5FoNaZ+JIpn0z/tevvaPP9e0xEVuO8EwS/fYwc22QIAY8iCyh1vr2uqGCc4bfXUgYuFuWYE4+/MQFOayPXYdcG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=6niVsOXXeHRc7cUCZrkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeDTSSC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:18:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753514AbeDTSSB (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:01 -0400
Date: Fri, 20 Apr 2018 21:18:00 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/6] virtio-console: spec compliance fixes
Message-ID: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Turns out virtio console tries to take a buffer out of an active vq.
Works by sheer luck, and is explicitly forbidden by spec.  And while
going over it I saw that error handling is also broken -
failure is easy to trigger if I force allocations to fail.

Lightly tested.

Michael S. Tsirkin (6):
  virtio_console: don't tie bufs to a vq
  virtio: add ability to iterate over vqs
  virtio_console: free buffers after reset
  virtio_console: drop custom control queue cleanup
  virtio_console: move removal code
  virtio_console: reset on out of memory

 drivers/char/virtio_console.c | 155 ++++++++++++++++++++----------------------
 include/linux/virtio.h        |   3 +
 2 files changed, 75 insertions(+), 83 deletions(-)

-- 
MST
