Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3632397-1526025612-3-6481445731123577098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526025612; b=jT3rSlCg3UGrEpYhVEAnVGVNz4Icqp1tfZaULtZEruhUMopQS7
    HnWQ+qEsgzXA2xdZn1fsqbmAHTnZpE/Hs3N1oN4uLkGARz5OWW/i1zcffVi6N9Ye
    zqhaxIbRv40jqxXamwW+gBbXK5cbRawjiZs+t+ClHlp4BPAH1CSiBA7OC/4jV82J
    D9NR0wYioJQ1ZkZN9AehExNQRNQFfQHyUJsQv5uzmJwOLmB2s1Ia0lpL8Jl6kP9U
    ri9iLbz5nZwRAJuiR2rqBHbWcfssQBJvwwLWTdFaaT1vrsHLwYb+h2qhoF4xAtRU
    TavAfsfJParMZkkNC4ySwb/70UNJVgJcdzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526025612; bh=WD4YEmTLDWiMTyG4hKguROqugKwHZG
    J1sWE5bD4H65k=; b=TDic9OX3hJnfSVscdSFMcorXHkwncQyDR+d90pV3Nq8hjU
    y9mf5KX7L2j51PM2/bnswk/lf6Wn79UvW9ED+Hnh2ihTv35XPb1ZjO5xh84TNQnF
    uwtsxbuJ0FUoeV6Vrkw/7EuFbX0Lpqm9zuLMMM2YWTYlfzpGdf0CZkqYlVRS1HHF
    U37RygogNv1Qqpfq43uDGauL35xaf5rik+KFIvwo8/EjWpi+hOCQAj5E1cl09mlG
    hEm5JvrJOd8lY5HYNAU14dWOEmjBuP1R286PllDfHai3gDkR8hcsLX2Bgf5Gbaa6
    PzFF5bctRfD1mEsRYmcuqTXTkV96WRJplpEp8HDA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=mlDYQETF
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=mlDYQETF
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/JGm2/+0B6/C5FUtnbnNQjH30zX8KvzCPHi0U5bfG7OyNHr5caQgsDYoH0hywr/jPd9HwSsaucjfkfnIwQrHp1Cc5CSUwuLamaMJtk9CQuzfI6viO2
    QQl7i1C3To3zrhKHhcAc/ai2m7CoM3TxsHZC+VSy7YKRX9t63mGHeSOGJ3gZJp+b3SD15uilVuWF5hBnQoFmc6XTkSTgJ6gxVRgpQrIXnPzAdQzA2txoIMr+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=LuXZDtCTQf_X7ep-_PIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeEKIAJ (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 04:00:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeEKIAI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2018 04:00:08 -0400
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: common non-cache coherent direct dma mapping ops
Date: Fri, 11 May 2018 09:59:25 +0200
Message-Id: <20180511075945.16548-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

this series continues consolidating the dma-mapping code, with a focus
on architectures that do not (always) provide cache coherence for DMA.
Three architectures (arm, mips and powerpc) are still left to be
converted later due to complexity of their dma ops selection.

The dma-noncoherent ops calls the dma-direct ops for the actual
translation of streaming mappins and allow the architecture to provide
any cache flushing required for cpu to device and/or device to cpu
ownership transfers.  The dma coherent allocator is for now still left
entirely to architecture supplied implementations due the amount of
variations.  Hopefully we can do some consolidation for them later on
as well.

A lot of architectures are currently doing very questionable things
in their dma mapping routines, which are documented in the changelogs
for each patch.  Please review them very careful and correct me on
incorrect assumptions.

Because this series sits on top of two previously submitted series
a git tree might be useful to actually test it.  It is provided here:

    git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent

Changes since RFC:
 - fix a typo accidentally disabling the device to cpu transfer sync
 - fixed a few compile failures
