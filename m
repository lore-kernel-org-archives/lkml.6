Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1817484-1528131890-2-2529501646332447593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528131890; b=GwB66eC4MJbc2qopzAHoEVco908SDQTP9BGip4g1dE7Gbz6MG1
    83Wops1NeuFihwp3E+hC6otKH8BhGupJQTka9nbxznCFxKkZ9f5857VfrDtx9FnO
    NTrCr1cg1uO1XQxghLoiSYu763rENkXhY6kLYHZNEUkqmQErWB7WKwt6kGqbaDff
    WzWjSto6zx21yr6CQ/aWVfbuaS+NsO4SpPHsWmgfqUygVSadqu9qqloSV/YrQpEo
    mpiPvwNMWrsKgM7C9Gys3CoKTX05MB2RqluQxpTlT8DtJKXaDBsseLYdWwPYOkKo
    faWBTCPw54YCnD6xk5S298YKM1c6Y51jzWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528131890; bh=SHarJUfqGDzfCzTIrDEXbqHuOodG+UcVuff3zVthQ1
    w=; b=FK9KZQwa7tcWQxfgoTvcT86s40sEOTj/2miXQGX/mLEcaqAhxJ+BdrbyoH
    rF6brG27+TbS/V+EnLvBtoaJ76OZqjGHlcOon8O8XqC5VpI5EJzi7hjYreOiofxb
    VwL7JVN6ygxUxsu386FPS+B+N7H97H9CO+G6MLLFfZqwXRtng6hGzn4Eb0IIKf8k
    MjkySKEVX504f92QB7qBs8jdIimRGTwLVD+TBSNetT3WpeLmK7x2WMPDKeP+xyK9
    1gtEINKeJf4grs9PZeoWnxGj3xNki9pTqZg6LPzLUS7ddL2JH8zmAnQTtM2U/46Q
    tw0vwKnEtlcAfSOInEtYrNeaQzWw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=jbhjqI3y
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=nJa3TtZU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=jbhjqI3y
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=nJa3TtZU;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPORPazptST9f/+Rn6SBDsQk15hrZQVoO/X3gNOe1YNhYJu61Rr1+DoffgZd7qgpfGXj0yUJItP5vA/I8ipxaS3GrbGaX6Xr4bqSwZcwz6XYFTcTJJRA
    T7GaA7p3i81XWT1xVmouYxhWDZCKpJIAstAEGelQPs109StnAhvF8ea+ypu38oiSFXmjYDtwX0QBLY3W0r6/a4zwbqtow362vmoQhS/DFhwxxuGOGQLVuCMs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=rOUgymgbAAAA:8 a=VwQbUJbxAAAA:8 a=CayVG71PEulSS29KkrAA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=MP9ZtiD8KjrkvI0BhSjB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbeFDREr (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 13:04:47 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:42119 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDREq (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 13:04:46 -0400
X-Google-Smtp-Source: ADUXVKIgupTEqXlpZweN0YNUOTZepXOu/Oymm4pruFYFhZXurOn3NOfzbznkwoK1wM1NRgy+TPmZjZyvxykKzne/AjA=
MIME-Version: 1.0
References: <20180603114133.64a2cc77@canb.auug.org.au>
In-Reply-To: <20180603114133.64a2cc77@canb.auug.org.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 4 Jun 2018 12:04:32 -0500
Message-ID: <CAErSpo7VL6jajWxHVacbv-43iYZu_0H=+s=ZkGjeQd1irEkucA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the pci tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next list <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        l.subrahmanya@mobiveil.co.in
Content-Type: text/plain; charset="UTF-8"
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Jun 2, 2018 at 8:41 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> Commits
>
>   aeddc65a043f ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver DT bindings")
>   c1efa236b42b ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
>   18eb4158c840 ("PCI: mobiveil: Add MSI support")
>
> are missing a Signed-off-by from their committer.

Fixed, thanks.  I had cherry-picked those from Lorenzo's branch to fix
an issue while he's away, and neglected to add my own Signed-off-by.
