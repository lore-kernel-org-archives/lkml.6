Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1812140-1524518078-2-12252365813348702392
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524518077; b=mLgongfqjMNVHZd/HVTvCNDZ4+9FO56uVD4vDfXvg4MlGEK0NK
    Lxi8L73rokhNtI5ImJZr/qz8VTFKMx5aPtziCdbAWu8z0GnQzrdasqTHk9jDXqJu
    gQiN1+4gMZj5Mw4qCzJL5A0drvDT2SOfUAyTYtl2pyL5B8uhEjVLpGywqKYUXYzm
    gD1QzRtqXbOUfat3m01nfTXGzMzhYpwPoQc5VNeIWjOmhURGOYrvw3nVw7ZAdTeL
    WD80i4ag1917PbJarn65c8LoZOghwZJPK91WmXEXDSi87eG5uqsrQD/UfPv+Ybgu
    RDxekwzFCdIt8o0VbzqrHf1M+8lIzKcLX77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524518077;
    bh=NIr4dpBacS10o3FnjlYNaalULbBtf21XPdn0k6EI8VQ=; b=ZClG4AokaHSg
    u+IPJbtl4tlLRjbXQUMABKG50la0RYHqGhWTs7BBfCqorPkXYwYr1tcsKtuS8hwr
    HQsgMuAySiU3WsT54z7uEenjoZ7NBEP75wPITaqYw8/mYnlG8JHRfj0JWcL1y7CR
    17QiYXyTTgr79QACUhKIOyMeJr+7JYnXfTNVRikmD5ysGgY7dWF1zwIiNXYd6w89
    iD93xvUGNamQ55IjqpXVoY5lNm7aRxYU4grrJbDrtIdvGqyMJd7WMGv8rkRyHVhQ
    Qe3W9Y/yEuDGPw1PTOeZHwMtrBa9+/Yf7GkdG/j/79N0QRvRPvWI05q3Ho8agCcA
    VQ4c4F7G4w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJl5oJVVvxw8JFECKaAcNfIPzYVeuk+mg+Kq0jrqDPfiA2gq2tDhiodr1hTPAW0emUn7odrMqVBkF2dApgd+PWB4LpwYh6ierpyriyop8mdzjqz6bQOK
    rxv9/05FwOvDqrSrZWdG9ywNJYYzEje7us2nMTWUriwaZWnB73rkQ2QSXREnjT0gvkUyVW1a6T2VjQFR+P9/8pS4X+5Je71SuCouVC4Og6DP2q2rAaHE98Sv
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=oqVsKBrUHUWgOXt6CrwA:9 a=8PPO3xudaZvbh4oO:21
    a=_HmScL7LlWaT5fvZ:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932331AbeDWVOg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 17:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbeDWVOf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Apr 2018 17:14:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EF221782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep
 issue
To: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20180420155542.122183-1-edumazet@google.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <9ed6083f-d731-945c-dbcd-f977c5600b03@kernel.org>
Date: Mon, 23 Apr 2018 14:14:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420155542.122183-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/20/2018 08:55 AM, Eric Dumazet wrote:
> This patch series provide a new mmap_hook to fs willing to grab
> a mutex before mm->mmap_sem is taken, to ensure lockdep sanity.
> 
> This hook allows us to shorten tcp_mmap() execution time (while mmap_sem
> is held), and improve multi-threading scalability.
> 

I think that the right solution is to rework mmap() on TCP sockets a 
bit.  The current approach in net-next is very strange for a few reasons:

1. It uses mmap() as an operation that has side effects besides just 
creating a mapping.  If nothing else, it's surprising, since mmap() 
doesn't usually do that.  But it's also causing problems like what 
you're seeing.

2. The performance is worse than it needs to be.  mmap() is slow, and I 
doubt you'll find many mm developers who consider this particular abuse 
of mmap() to be a valid thing to optimize for.

3. I'm not at all convinced the accounting is sane.  As far as I can 
tell, you're allowing unprivileged users to increment the count on 
network-owned pages, limited only by available virtual memory, without 
obviously charging it to the socket buffer limits.  It looks like a 
program that simply forgot to call munmap() would cause the system to 
run out of memory, and I see no reason to expect the OOM killer to have 
any real chance of killing the right task.

4. Error handling sucks.  If I try to mmap() a large range (which is the 
whole point -- using a small range will kill performance) and not quite 
all of it can be mapped, then I waste a bunch of time in the kernel and 
get *none* of the range mapped.

I would suggest that you rework the interface a bit.  First a user would 
call mmap() on a TCP socket, which would create an empty VMA.  (It would 
set vm_ops to point to tcp_vm_ops or similar so that the TCP code could 
recognize it, but it would have no effect whatsoever on the TCP state 
machine.  Reading the VMA would get SIGBUS.)  Then a user would call a 
new ioctl() or setsockopt() function and pass something like:

struct tcp_zerocopy_receive {
   void *address;
   size_t length;
};

The kernel would verify that [address, address+length) is entirely 
inside a single TCP VMA and then would do the vm_insert_range magic.  On 
success, length is changed to the length that actually got mapped.  The 
kernel could do this while holding mmap_sem for *read*, and it could get 
the lock ordering right.  If and when mm range locks ever get merged, it 
could switch to using a range lock.

Then you could use MADV_DONTNEED or another ioctl/setsockopt to zap the 
part of the mapping that you're done with.

Does this seem reasonable?  It should involve very little code change, 
it will run faster, it will scale better, and it is much less weird IMO.
