Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2463566-1526990689-2-2750892519588989492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526990689; b=J9989LMVznh8FCd05Fw0hZrcUnvlHca7zTyJOp/27mWzvm+6mL
    ZfcWo7OPlYBA+8ALLQ3ZN4Ea2Ix3dco/AMudFw+9P2WsuUqj8GFFQTp6nSRb9wfK
    IRGDlcGbGG8z3wKZz1IEQc+ZRxhdIASEdl6AU0rPyjDLvQ7c3Yv2X7AJ0anxvIrx
    mgi9S7XOyiUB4AT9hHQqprpxwtsRPRVBcCdXN3Dn7//vr/shUwhQNvJCgEWKasSB
    uPlqREjHCERYG+j09QM7JSSuiXf+ro8SVOLEj5A+rXPKCUKgZ/Gn+uc4Lj9K+Go2
    RjYxpgqTQ2+4KZ/Cr3WqGrAUbljZtT9LjrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526990689; bh=+50stOMw/+nrvTGs4EZ04vGJ/yTaM2
    PB1eUYzmbp2+8=; b=boS1hC3pbpY6i1lFe/L5JErVtBujgaafxVc7FMdAGzivM1
    CLOXNiBrLTSu84zarldbrNl+PmVuhQ2l3TUv7TNRNRi39s76FG509i10LPaU5wlf
    uUfuzmQB+u6JcqN7RgJtUROlZKHpXCdyb3UGJK3DIsoj8t+I2zHDRuzxdIzYb8rn
    SbBk6UG8j0U911KmLZztq0VBtq5Ifwp+PoqxnUxLA0At+JOtOasFgfe77/keK9Y5
    NEE3SnPfll+rafmjDgJ6flaw05ioGF0svuzqF5eAv5I7XLeyGuvEz0/qtykrojj6
    6+UAkjSvbOn+7yTK4bdOyNNw0mP2HD0bZVdQoQUQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=XUwihSx5
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=XUwihSx5
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
X-CM-Envelope: MS4wfDwgjrkWVuV1n1sCct1hgivIkZ8qXYho50q7lGtryDpkTTkbRue8QmZ/0qaODx8484pUAfrLJS+b0vvmep+sfzBsrnPntNmc0+NGNFfbMOdVxXt9GQBk
    JKXgQo3KS8kpoOLaR7hBoT3JRB95Z1rtOKwgS/LLJz2Wq/8AKJxvKmum4BQm8I+W3UuyPFXn5/dhiTNb2A2U970axKzJu25xAY9GyGxwAq4nPjPdBn0eR9V/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=JfrnYn6hAAAA:8
    a=LuXZDtCTQf_X7ep-_PIA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEVMEr (ORCPT <rfc822;linux@kroah.com>);
        Tue, 22 May 2018 08:04:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeEVMEq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 May 2018 08:04:46 -0400
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
Subject: common non-cache coherent direct dma mapping ops v2
Date: Tue, 22 May 2018 14:04:05 +0200
Message-Id: <20180522120430.28709-1-hch@lst.de>
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

Because this series sits on top of three previously submitted series
a git tree might be useful to actually test it.  It is provided here:

    git://git.infradead.org/users/hch/misc.git generic-dma-noncoherent.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-dma-noncoherent.2

Changes since v1:
 - dropped the already merged generic, arc and c6x patches
   (with the map_single offset fix from Alexey Brodkin)
 - split various changes into smaller patches
 - dropped the arm-nommu changes for now
 - fixed a typo

Changes since RFC:
 - fix a typo accidentally disabling the device to cpu transfer sync
 - fixed a few compile failures
