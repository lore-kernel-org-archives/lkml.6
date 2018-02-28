Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835499-2-14545112191807350365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835498; b=bJv1szKu9Y60vpeLDy7Se7VOvlV52Fktc349LNxZ2jN30Hl
    5E9g9VYAlJhGgSPafrB83YyjpKdPLjd72uS7HYVDDWAiRI4Cr+2NfZY5tBDvqVEF
    uJFkCOdV6HsJ7lxhAg6pKTFPQ391uWpLPjnjdhnLuy4dK0gEbTmz4cY6zaohtyOm
    llbvzLww+GACgOzyyMqiXaJYhjzpKpv7CEeJv5JrfYx11g/i3bW9fD3MHPbv1LBk
    0tEnbItN2k5PvQzrbJmKEfa9jHVTqNU34BIkugfGiSs89dmOn979VjQZaMy6CxU0
    lAAjLjJsEjWo8nBgBwfOkm3yosBzcM5o9NAV5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519835498; bh=zHsVdfDr4bCfuGg9nMNyyWv7xx
    Leb79bCKtzsx4Yk0w=; b=FeypiF92lZDatPaB+rMjsth+VhjnhW0M83NCA2bMIw
    XZ4WXZc8m8OF6eEK7WtAqkkgpwObggmpkvP7JYOhyxt4DNNSyqQdXq1Qv+wVQmu2
    7Pj2GpXBQ/nyiCVihdpOxAJCeDPq1uuWZNfjVhTDkc5f420JUv6dpm8i/2nsdK3N
    JaVGudFwwabi+nwWEhIDgwdMo7U63p9VN3IrJTNfbdllsMATC7N86hOeWt2fxzIS
    qRT0WJpftFlqnCHtkHSHr93tETgVPQUVkP9JNoN2051T/3ZFpz8dtoB+pH5CEcUL
    mDkz0DClL9Cm4RuH8LquqvQWSZSJ9kq22sERlFRQLtsg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eO/QPk3M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=eO/QPk3M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934816AbeB1QbX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:31:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeB1QbT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 11:31:19 -0500
Date: Wed, 28 Feb 2018 08:31:16 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4] usb: core: Add "quirks" parameter for usbcore
Message-ID: <20180228163116.GA19292@bombadil.infradead.org>
References: <20180226150457.22299-1-kai.heng.feng@canonical.com>
 <20180228144729.GE20414@bombadil.infradead.org>
 <C206D522-1345-420A-90AD-FCBB4FE129B6@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C206D522-1345-420A-90AD-FCBB4FE129B6@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 12:01:40AM +0800, Kai Heng Feng wrote:
> > Also, you won't need to use a linked list for this; you can just allocate
> > an array of quirks.
> 
> I use linked list because the total quirks number is known after the entire
> string gets parsed.
> Do you suggest that I should just alloc a predefined number (like 16) quirk
> entries, instead of doing it dynamically?

I'd just do:

	unsigned int nr = 1;
	for (i = 0; i < len; i++)
		if (str[i] == ',')
			nr++;
	kcalloc(nr, sizeof(struct), GFP_KERNEL);

