Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-782846-1520609946-2-4491131848620466009
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520609946; b=dohq+w+aRA+kFCCqvSfOx0kGKJoGgKx8HYfu2aUi1ZkNVNF
    Jxmty/ZVB+dpmDBR3YX3ygEtSU6FgAK7ntZrtQOTDVrehzUPNIxPZhkFuGcEwJxA
    9RnpKM37F+IwkuEaIKiYmI+0UiiJURx7FWY5Dx5Q3neMml2xStY20vajvCXKHsli
    /PVaXngGrJy4cACz5cj3VtHsx17GSDNFMpV5UczVCfx5JssmCGMQ1Jn2X3jdT2pp
    iKOYrOQUEyn9oBiXcDCER15pR3lpiCA6CHhv5go/py4xVF4tEvHXSD+iDwFxeAKW
    3mFQkLIlrqHk5Xi2XLi4ccjng4vFI9vE5kF+1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520609946; bh=JAlyFaOPl9TRkJzAv9r9WJdba9WeLQtNppkslqbh6+I=; b=t
    5XDDFwV6PI+BeVstZR2TJcdis9kGI/Zr6lb8Jn6i0/J4IMo0+Tetqp66zLY4J66s
    C+zpxEwjIHP3JpKIvu7SkhpQ6vSB2Si0reqTbKzu8eqdKpwnz31d2xG0dpLCv9+3
    mThiB0TbbzwqSymNMJw2WxfoPvI00zP0Rpk8H15pnpq162T36bZwnseuw4003Zyp
    wdV20S0+7IhuE8opSNW0l43Iw62KMW1tY3wcz75P0sKHx5neT0xTcTFHZ9CWgo5o
    oMP0ziMHxUVfCSRbnTaoVvYhQojq0cfzJiv/39rSFK8DQoLvbI0Vj/rEt4u6En6z
    72E/DcwoeMniD7MPDakEQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=gbezRqQh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fJfq3nr+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b=gbezRqQh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fJfq3nr+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.dk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932069AbeCIPjC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:39:02 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36223 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeCIPjB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 10:39:01 -0500
X-Google-Smtp-Source: AG47ELtQ/dCu5GPu8v8wpl5Hn2dR/GWiTDa+p6atONk8JkwfQI/AZkYfRvybkMBvxhqy5J2kQfnZVw==
Subject: Re: [PATCH] loop: Fix lost writes caused by missing flag
From: Jens Axboe <axboe@kernel.dk>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
References: <20180212230558.5546-1-ross.zwisler@linux.intel.com>
 <20180309002048.GA22835@linux.intel.com>
 <81204608-a436-c16b-6846-947573e6ee3c@kernel.dk>
Message-ID: <92dc07f1-dfbd-2449-ce76-502455f56136@kernel.dk>
Date: Fri, 9 Mar 2018 08:38:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <81204608-a436-c16b-6846-947573e6ee3c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 8:38 AM, Jens Axboe wrote:
> On 3/8/18 5:20 PM, Ross Zwisler wrote:
>> This has gotten Reviewed-by tags from Christoph and Ming Lei.
>>
>> Al, are you the right person to merge this?  Or is the correct person Jens,
>> whom I accidentally didn't include when I sent this out?
>>
>> Just wanted to make sure this got merged, and to see whether it was targeting
>> v4.16 or v4.17.
> 
> I'm the right guy, but I don't see patches if I'm not cc'ed on them...
> I have queued this up for 4.16, thanks.

I do see patches sent to linux-block as well, but you didn't CC that one
either.

-- 
Jens Axboe
