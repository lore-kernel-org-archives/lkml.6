Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3496597-1523892164-2-763102439440890766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523892163; b=ZOS6SxogkAZ0Rp0itPFwUdavkhmDeLuFtk+0mihaFgr814hDZ8
    1LIUvR7lmsXTCxpjE1Jtm77bgZIB/xFSpt0KtEBdf665uKeWOSdBsX9b83cUGa+Y
    B8sbrTfMIWiUu5MUARM1b23hGMDCWaUjSmnS62ga/8cUhg1JnUzIcfok3v/BAYXQ
    k3u3wDB+4DqMNLVaq4Xk7sWeb0pl5ALCYjEGAJ1ig0NYTp06O0lYt0c4JVbTKz2b
    mQdH9SBy9EiJoHQSgPZyziHiuIsXCTwEQb0xMbzWKzFNgVY2pLIthFqYd6b3tbZc
    wQ8yu7YxRPRCmoeK+LPl+LvMXdueCp8xU61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523892163; bh=AXazXNle5r253NWfKbW9z6d6atjWOW
    N8VtR6K9yYLGc=; b=bTxZljvAMoHRDH4S5qg7s0Ws3fMzcL+N3V7Xqo8fY5RCtA
    bHxGrOnQMnVefbCdgvcCA9vEbfoRyvR/SwFABXR/pyfFT51HNRpkBHvGAi+JvmdC
    KWswui8ixwS/qlFIcVbOHgpFnH/dN6eXJQsJYjJKPFxwj+260XxSJICgHEq2Nf8H
    +e/EGiLJT6w3jStwaoMghkj/gYW5ZcHW6a3sYx9ZnFTMXaJ7Jnmce3FA7nhmZOoy
    A93Je8hI7tTW2+9jYvWaYoJQX11gAeHFpzQSveAYvDvpdOd1xJFQEVs6ewp/NrHk
    QpD0R1s4UJQYdaaX1/8JSqfdqOJeY4EqhCR67/tA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R1E/DyjQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=R1E/DyjQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBRgcA4mN1ARyqG165bGjE5/k/AUkLxzJ+l+7+4li+LCiyH0uvCqYB0E9cmRXl80q3yxvxqaTM4seKdIqLkXWii3NqK7QQW4A1fpoKTpsQubXUerj5bd
    7WJTH0IRo0zPcHTYgFtq9hNrBcF2eDIau3uCS5if+4Yi5NJH9FnxV7w0G5wwj49Yv2d4Mt4Pk7iZU/RuTm/cXfHUbF8zv//chCfCXTdTRGDEhdQnGhcfLVkj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=xIEnxEUKAAAA:8 a=VwQbUJbxAAAA:8 a=_3iAN5dmJPxjh_Nw_akA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=JpDqF-G6Ufas406PgLIE:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeDPPWl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:22:41 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:46007 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeDPPWk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Apr 2018 11:22:40 -0400
X-Google-Smtp-Source: AIpwx4+Osjmjd6h2PrC9JVwhePmQSew6dIrYrUqtEBixuFGaMIrrtokTY9CAw1VYqcEKoHJnPK+nyw==
Date: Mon, 16 Apr 2018 10:22:38 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Add support for r8a77965
 (H)SCIF
Message-ID: <20180416152238.mbz4vktzvrjnavdt@rob-hp-laptop>
References: <1523886928-14535-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523886928-14535-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 03:55:28PM +0200, Jacopo Mondi wrote:
> Add documentation for r8a77965 compatible string to Renesas sci-serial
> device tree bindings documentation.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> 
> Renesas R-Car M3-N support has been merged for v4.17.
> Document the missing device tree bindings.
> 
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied.

Rob
