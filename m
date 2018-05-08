Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525778627-2-17115726592415530091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525778626; b=LP39yPhd8FL1JMTHgmT8cZZLO0QYrcvr2QoYDO0fOlgaa+NTLg
    JxQ6/9zPos3OIAGzHw/yJfizAVDXwrU3P6QGHZ4Ajqd+YOsLW1jVBe8+AHFGcJkF
    cQjlkJlnaj7z4A17OmWhKriBsWy3B9zsVqKt5AkFs87w14UkmQSO0fPVM1gGhly7
    s+AIdMlSZt7zQeJdklQkmLy27SlSe/zDfsD2gbD+TaOjUxv1yswHrN//kUPYQ1YQ
    dCEJZZtGGrlfSzo+Bv/MJ1K6ISnYYvVsRMub0TWh/POd0GoIvaszeY2uR71sxErq
    Dzdat2DK0GxiU4InHFYHphlhfWJRYg2frRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525778626; bh=zdcSBtjp+8Yc7j0D36KUn+fZhOP2bF
    ciDReUrxw8wBg=; b=YmzuSmRTY4Ey5saDsnu4uCCTiw174I2fhTFeLiYH/68fE5
    QAH613ujEYsDKPknNBUjAWrksvmuREO+Xgbi3+z3L5rqEjbrc4N8poW8ow9hPcXx
    2N5b/UJ5qH6hZqxkYUyKY9aPxuxRWAfUqtR2JZCETyjfGXCdokjxWY1UK0S1Km82
    KJWN2ehKYwCUz1PYIW6zncB2y6Kj72gAWWUarwJPYOqF5O+CUEN7U8fdQLA3BHkO
    c9xG07GN0qxG8JzQ6ritPSZ+jh8a9I0qNYh0uL8pkeBra1MFKyBshlwYDXx+LrRX
    UbwHq6y9Pf9tsoQxHx67ohnc79vXh3nrlgjDeprA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=otFQSuUK
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=otFQSuUK
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHXMYk0zS1nUNwu7QDNnFtUQhTLOQGpvTL5XmZesuaOabHwNjCBFiLG/VPIj+RuyaK63FD1P3cqcGv5Ab8XbcwZGvlQjEFeQxhy69N5cudi9oTeY7FdG
    CPkSwd7uJjBV0llZUSbESdzKQL2yv405PvV5K9tvl3gnHeOqRIao5FRTPIV4nCPO5A/2Nbu0L0WZCd+X05R2/6saTHcptpQRZK4+Wd7w8YbivneUDT4Ma9KT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=JfrnYn6hAAAA:8 a=a4gKNSpRJO0CI-hXu8UA:9 a=CjuIK1q_8ugA:10
    a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeEHLXo (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 07:23:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbeEHLXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 07:23:44 -0400
Date: Tue, 8 May 2018 04:23:21 -0700
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de,
        arnd@arndb.de, cl@linux.com, keescook@chromium.org,
        luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Message-ID: <20180508112321.GA30120@bombadil.infradead.org>
References: <e2aa9491-c1e3-4ae1-1ab2-589a6642a24a@infradead.org>
 <20180507231506.4891-1-mcgrof@kernel.org>
 <32208.1525768094@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32208.1525768094@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 09:28:14AM +0100, David Howells wrote:
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > > + * execute a critial path. We should be mindful and selective if its use.
> > 
> >                                                                  of its use.
> 
>                                                                    in its use.
								     with its use.

Nah, just kidding.  Let's go with "in".
