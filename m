Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2379707-1519371750-2-18158229987264763248
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519371750; b=RgHF5e0pdLgU+p/VJPcOoX/CtCx1w8lI7xQvdI+OdqCq84e
    EF/Z2UaZlJQKgBCvliLTQ2BxdGxQY/82rpPXQiyc97TnuqtFIPTV6GbGGEA6wHCX
    rsolPXn/DmNLTAaH/wK7o7RUPVQAotGT0sUWKcZzzkrqKOrXbHNpyt/wfKSQbfYr
    zOMPi+ARrF8IrVtMaguAxfgWSKJ3nA96Qkmcf+SqK2UB3JhKPNNFy3qbFTkoS6YQ
    sJhBdwAszzbzSgD5Dz1Z70EjnnEUe12Lrn6coe6BA+X2lUB/YXq9yRqV7Pphuf8F
    7qB09TK6A29+kVcj8FX+nPkXj6ZSFRBBIhk9uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519371750; bh=lR28veYvPYBGxeS1z68mS5BQHY
    8XJP/s7jUzE4Pe2Sc=; b=wvJZGZnWiRaN6rPMGY8pPpTMkJlb9rmpmpU2AOITv9
    i2RdI/eWgbxTTpQMcW3IaDVDT491ERHXyZ5ft649yoOvYUTx7cIKueiatNwZS/39
    kJZeA9YDaOQvr+1o0dG4n+/wDlyvFJFlDguRO/IcQtcPtJwKz43YRwkLho0xrZAz
    ux42mNWTGmgZ6r5XDFWw6yoh0mjHHRMYnNYHSmApB2wfpKwQesp42SapzrPQYHIH
    XOupt4LTTO9Ln33DtHneiE0Y/MP1U4CCOHsD0CHVLVWIE22/SPNyh3KZa1GYois5
    85Y6xp2lwWJ86rFoXfmj/1yuCJrsrSN7R2S7Fzo0OmUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeBWHm2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 02:42:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeBWHm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 02:42:27 -0500
Date: Fri, 23 Feb 2018 08:42:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v4.15-stable] arm64: dts: add #cooling-cells to CPU
 nodes
Message-ID: <20180223074227.GC327@kroah.com>
References: <20180221162934.2728048-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221162934.2728048-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 05:29:19PM +0100, Arnd Bergmann wrote:
> commit acbf76ee05067c3942852019993f7beb69a0f45f upstream.

Now applied, thanks.

greg k-h
