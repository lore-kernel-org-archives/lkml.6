Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816868-1524519585-2-8965595696812616062
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524519584; b=uzW1NYv3OnCy7EWa4nAbgU+9hZvJ+flCoDCc64qQaCq4yjle6T
    WAFRH+FAmj8sI1FdgULiLE/D8oAQpoW4WHlJR8oXx8VbFTsEnKGudbQKqVNyAvLr
    iU1gbpYcOYAP0mO9kZNdt9R8fg88SOWeOr7M3dg1Q1TDSG1vCeKg8h3cOn57y9Rg
    jcmPdYfnJyGgEr3Jfkr76nzP/5DiUGD3SYahEJLJDJbRetI/b64pwyFOtrxAcCfc
    kljeqixmrl+YjaCNzZuKlAtux6h/Uxjikh4jKdNb9Yjx9uy9aKebNN4vRMj58Hhu
    BTkP4e0I0RqV0Km+F+tpB9LvXbXMEUuDluyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524519584;
    bh=ewVJkYHmFys1pwVvb2deRjutoAVDeJzD7jYJmgv0LXo=; b=qxGLqyQM31H7
    tGPfdtqLWHSW9iSJEIFzEn627/0ZXSY+mmaSgPXMzRxmHbVk+CuEKFC1AN5RaRR+
    kBLYbTx2uIo8UnWhnT8ZZOxt14nogtiS4leCkhZqE/6Iu+1QlpvUwjvET3mQ/+Q2
    ZfQinZQ/LPY+2lQbHluKEunhSfi0HL9XoRFGv5vvfNbR0WzMKNtG/EzrzrV6lDZQ
    PQ+GduzNgm5hMLdYAqs5/b3CZgcO34IFSAtzXcKwAgY830BATuDI7ABbtj5Qjxb+
    WNNJ6WUlPZdhJv0tsw4oOPsrWQ5CD7/UahsX8gbtKZMsbXpu04rA2a0/TpEmYCV6
    6S30d+oWvQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0DEejKG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gYmNkqI1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X0DEejKG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gYmNkqI1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfChbqU7f0Mmd7QDrswFNPuLPJinJ2FX/OXMfNgMnqbrfvdqJM4BybfMQjUCdJg2vOKeIZ8xvtrL4GWJokp0F85Utbr41uPkXFZHbXOx0JzWC15rbDTvW
    BV7fS4oBmwlztMy1gwcPC/nrBvzD2t+7qBidMhewwV0riwHuxyvsrWgPU2I29RFVZ7qWFIOU7Sva6xZja/vRcZ1b2pmOONkP8pXYHBagHuzvxvN9dwe3bRMe
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=XT5P2k9a7GMA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=6vbXXD89bmrGTEBvuRcA:9 a=1Y0B13z6IKarqGPx:21
    a=JJU3nbo3OnsOdfA8:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeDWVjl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 17:39:41 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33363 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeDWVir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Apr 2018 17:38:47 -0400
X-Google-Smtp-Source: AIpwx4+q0WZqlH7rdHpLU1wlFnBjIFq6T10OhOx2GeVhx9c+4XQHEAVTnL1uU5sQTkiAsZQUebSkpQ==
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep
 issue
To: Andy Lutomirski <luto@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20180420155542.122183-1-edumazet@google.com>
 <9ed6083f-d731-945c-dbcd-f977c5600b03@kernel.org>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <d5b4dc70-6f17-d2be-a519-5ebc3f812f57@gmail.com>
Date: Mon, 23 Apr 2018 14:38:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <9ed6083f-d731-945c-dbcd-f977c5600b03@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy

On 04/23/2018 02:14 PM, Andy Lutomirski wrote:
> On 04/20/2018 08:55 AM, Eric Dumazet wrote:
>> This patch series provide a new mmap_hook to fs willing to grab
>> a mutex before mm->mmap_sem is taken, to ensure lockdep sanity.
>>
>> This hook allows us to shorten tcp_mmap() execution time (while mmap_sem
>> is held), and improve multi-threading scalability.
>>
> 
> I think that the right solution is to rework mmap() on TCP sockets a bit.  The current approach in net-next is very strange for a few reasons:
> 
> 1. It uses mmap() as an operation that has side effects besides just creating a mapping.  If nothing else, it's surprising, since mmap() doesn't usually do that.  But it's also causing problems like what you're seeing.
> 
> 2. The performance is worse than it needs to be.  mmap() is slow, and I doubt you'll find many mm developers who consider this particular abuse of mmap() to be a valid thing to optimize for.
> 
> 3. I'm not at all convinced the accounting is sane.  As far as I can tell, you're allowing unprivileged users to increment the count on network-owned pages, limited only by available virtual memory, without obviously charging it to the socket buffer limits.  It looks like a program that simply forgot to call munmap() would cause the system to run out of memory, and I see no reason to expect the OOM killer to have any real chance of killing the right task.

> 
> 4. Error handling sucks.  If I try to mmap() a large range (which is the whole point -- using a small range will kill performance) and not quite all of it can be mapped, then I waste a bunch of time in the kernel and get *none* of the range mapped.
> 
> I would suggest that you rework the interface a bit.  First a user would call mmap() on a TCP socket, which would create an empty VMA.  (It would set vm_ops to point to tcp_vm_ops or similar so that the TCP code could recognize it, but it would have no effect whatsoever on the TCP state machine.  Reading the VMA would get SIGBUS.)  Then a user would call a new ioctl() or setsockopt() function and pass something like:


> 
> struct tcp_zerocopy_receive {
>   void *address;
>   size_t length;
> };
> 
> The kernel would verify that [address, address+length) is entirely inside a single TCP VMA and then would do the vm_insert_range magic.

I have no idea what is the proper API for that.
Where the TCP VMA(s) would be stored ?
In TCP socket, or MM layer ?


And I am not sure why the error handling would be better (point 4), unless we can return smaller @length than requested maybe ?

Also how the VMA space would be accounted (point 3) when creating an empty VMA (no pages in there yet)

  On success, length is changed to the length that actually got mapped.  The kernel could do this while holding mmap_sem for *read*, and it could get the lock ordering right.  If and when mm range locks ever get merged, it could switch to using a range lock.
> 
> Then you could use MADV_DONTNEED or another ioctl/setsockopt to zap the part of the mapping that you're done with.
> 
> Does this seem reasonable?  It should involve very little code change, it will run faster, it will scale better, and it is much less weird IMO.

Maybe, although I do not see the 'little code change' yet.

But at least, this seems pretty nice idea, especially if it could allow us to fill the mmap()ed area later when packets are received.

