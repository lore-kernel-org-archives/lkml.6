Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3791488-1525639760-2-2159673112761468314
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525639759; b=PoGBIH7yoO63r5MWyEouRDmikTQdWfPDqSDHKyZMrbiYg2+om0
    Y5veqGSa/eP+w1bd8gFneC3BfbW4IbMZ6i69y1sxwOZvEhMbZOnXuAWtmx4x34sY
    kYjZZwFV0IMNJj8QhzLHR36ofGZk341B7PVnGAlMqbpSOuJcAdKoi5lD2Y7Wi0CB
    vH11cGTchR6NgoAibxTQVaC/D2TRj6/q6tuL1+CJLP7MXUJvvR5QXaKXye6tZnkD
    5WFyq25LkC3xMFCztv/c7V87PdKPnpX/oepCCaMRRocRnvS+HthnBWU5kCTi3yvM
    Mu77fYuMDX1sUQx9e1/71mW2llAIcj5zSq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525639759;
    bh=IYeNFGg61Mc/Tdmh4XL8W6JnM3p/ys52cF5lQTy3qmI=; b=hZ9SgsQ8vZkv
    Qucagv/0QxcnhoLQl93i2PocLKJM+BcjhzFakk92bzi1aerBvYayFvKrs/34Ipf7
    xYoh51t+JbWaWuXRkqA4tpmQjDbL0fI6rrB/zAFqE9o4ZLz3syfEPQ6XzwuNEoED
    QrKKoERKN27dxXxlEamACaesbbTNxC7DlhdKW4pWNjoIetdW4JGWiiDcv+5l6CfZ
    W1ggxDfAMRMWdPTEUUuiLfhEoMJTtDZOd347B1SkG69UzY0UQ72Sgd2FI54qC11D
    U1SjHpaXFiUxTUQdLtilSy8z82IjyHv7enOB/DqRNibHGWKwVYvhrLJmHumAdwpK
    FlUdQ6W2+w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=physik.fu-berlin.de header.result=pass
    header_org.domain=fu-berlin.de header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=physik.fu-berlin.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=physik.fu-berlin.de header.result=pass
      header_org.domain=fu-berlin.de header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNAax/YYJlavGEmwP+HUywkzPdiYZbRd2f2sn3OADBUPPjhMErq0fI7HFC89HH3rdiOrAsdk8Hm1cowtUOaITX+Son69r0MKik3/IFm4CPWr8ChLld1z
    1MPLs4QIJICorjKTgNVTt5dhG3fA7l0nZ8hkg38bSYnBb4A10x8D6bFbPJrSURycaBbQweMXq2L6EeIwLxTUhJ8f8gaRIAUwQvxulCKGtI44JI7PRvIjsEcr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=sm51dqHkRZoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=xNf9USuDAAAA:8 a=slgQUhOWMigh6Kx7el4A:9 a=QEXdDO2ut3YA:10
    a=SEwjQc04WA-l_NiBhQ7s:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeEFUtR (ORCPT <rfc822;linux@kroah.com>);
        Sun, 6 May 2018 16:49:17 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:44218 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751833AbeEFUtQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 May 2018 16:49:16 -0400
Subject: Re: moving affs + RDB partition support to staging?
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Martin Steigerwald <martin@lichtvoll.de>,
        Matthew Wilcox <willy@infradead.org>, dsterba@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org,
        Debian m68k <debian-68k@lists.debian.org>
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
 <20180426025717.GA32430@bombadil.infradead.org> <1613268.lKBQxPXt8J@merkaba>
 <76ca15e2-7b43-8b02-43e1-9ee65ab85356@physik.fu-berlin.de>
 <20180506005946.GI30522@ZenIV.linux.org.uk>
 <20180506073955.GJ30522@ZenIV.linux.org.uk>
 <20180506204622.GL30522@ZenIV.linux.org.uk>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <9ff33713-9fcd-5987-971a-e88f4af89942@physik.fu-berlin.de>
Date: Sun, 6 May 2018 22:49:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180506204622.GL30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: 80.136.166.253
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Al!

On 05/06/2018 10:46 PM, Al Viro wrote:
> 	I'm fixing that pile of crap (along with the NFS exports
> one and, hopefully, rename mess as well).  HOWEVER, I am not going
> to take over the damn thing - David has violated the 11th
> commandment (Thou Shalt Never Volunteer), so he gets to joy of
> learning that codebase and taking care of it from now on.

Thanks a lot for your stab at this and fixing the worst issues.

Since we're using that code regularly in Debian, your help is highly
appreciated :-). I'm very glad this discussion has lead to the code
being improved!

Again, thank you!
Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
