Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1849447-1524718740-2-15195335871169033083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524718740; b=pHANFJ80kcGB0seQXSNtWnW1SNGDTYxjEs4+pGQjrkZoP5gGdn
    Xg93Yb0ULrg62SdpzfV9dJI60sFaY9ye6VeUSlLXlpcsNvu37479OSzgXH+3Nlx4
    aVFcLBu9JyTmZvxIUN5t8tFinFAbQydB6dTEElTGm2vDEa7sxVV5KYH8F6Iatcrx
    I/YWc/mQsuanGcjL7EI25wV7gdPwp0iR5DyKVO1rAbF7EUvlQfe0pb0P+IPiq9o8
    mkBxUS6g8Ulmo54ioUbQu4F14xug/ISdCR++x3jDdFAm5Xh7wXPdYL8JzKRQlEqA
    0fhnZbOs52H3WvfOjrCmW7rD7uV9B2oTGukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524718740;
    bh=RaPcfMb30lxOiiPXI44r6wE9C2o46id6ADm0XjNr9rY=; b=ZS4ia5UTTRNB
    eBPw0FSiXnxjOcOWJVeswV+B/D+KFcd/Pb2u8dp58eskw/e4eH0KfnVYAFhufPQH
    e5X0BzVELPCwQIPMNkAIKyQWiTRQ387kWUPiGHYVmqzJ6BNYsGJQAwWh8/c2taXu
    4vV5IaiM7OOXuHhfIowICKb7myVzowjbbkoy/QVgQwTx4zYRggTgbVFqoMpYZtzh
    CYRFxSzK8rTKfgytMqkMn3na6+mwNnMVwqbIt5aP7K23SGsfd9T4S+YAtdP3QiEq
    SwYt1ZPVrklXxwiUC9BVMogPHFZCZ99WTtFmKNTz9ogod7W2TWR3uPDTD0/a0rQY
    j4A3TBbpMA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF1v8bdUp6taQL63Bn6pHiiPzMF0mlx5b+2zgW+uowThlvCr82eJET2NbGZzkvWiMfGuQkM1R2ieuKeBS9z1JtC2F7+FWtOayf+NXnfbSLfUs+a7Ucd6
    OR0TWWH4engDhjpQh3D3GCiEzhggB0kgKj9TxRIvO5dyh5dwwjPXHr21e0UpRJlS0IAdGJo617i/VVblUaDoG24QZIWohkT1nD5IndrTZk6+wDEN9nGffoBS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=aPT0SFRP-dzdhijSk38A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeDZE64 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 26 Apr 2018 00:58:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49162 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbeDZE6z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Apr 2018 00:58:55 -0400
Subject: Re: Moving unmaintained filesystems to staging
To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180425154602.GA8546@bombadil.infradead.org>
 <20180425203029.GQ21272@twin.jikos.cz>
From: Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a0ae4962-2149-4773-86a8-79c2dbdeac0d@suse.com>
Date: Thu, 26 Apr 2018 07:58:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425203029.GQ21272@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 25.04.2018 23:30, David Sterba wrote:
> On Wed, Apr 25, 2018 at 08:46:02AM -0700, Matthew Wilcox wrote:
>> Recently ncpfs got moved to staging.  Also recently, we had some fuzzer
>> developers report bugs in hfs, which they deem a security hole because
>> Ubuntu attempts to automount an inserted USB device as hfs.
>>
>> We have no maintainer for hfs, and no likely prospect of anyone stepping
>> up soon to become hfs maintainer.  I think it's irresponsible of us
>> to present unmaintained code on an equal basis with filesystems under
>> active maintenance like ext2.
>>
>> I therefore propose we move the following filesystems which are explicitly
>> listed as Orphaned to staging:
>>
>> affs - Amiga filesystem.
>> efs - old SGI filesystem predating XFS, used on CDs for a while.
>> hfs - Mac filesystem.
>> hfsplus - Mac filesystem.
>>
>> I further propose we move the following filesystems which have no entry
>> in MAINTAINERS to staging:
>>
>> adfs - Acorn filesystem from the 1990s.
>> minix
>> qnx6
> 
> I had similar toughts some time ago while browsing the fs/ directory.
> Access to the filesystem images can be reimplemented in FUSE, but other
> than that, I don't think the in-kernel code would be missed.
> 
> It's hard to know how many users are there. I was curious eg. about bfs,
> befs, coda or feevxfs, looked at the last commits and searched around
> web if there are any mentions or user community. But as long as there's
> somebody listed in MAINTAINERS, the above are not candidates for moving
> to staging or deletion.
> 

I think the presence of maintainers entry is necessary but insufficient.
What if the maintainer has long lost interest but just didn't bother
updating the file. In the very least maintainers should be pinged and
asked if they are still maintaining the respective piece of code.
