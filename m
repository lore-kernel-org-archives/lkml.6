Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2128120-1524535503-2-12587218185749490847
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524535502; b=hGVzkbQqM/pIZk0oQvKlwzMqUmjs4fUR5cj4WE4D8Ltd7ssgYl
    mN1ez2rzTBBZwIoFPFgqsRadIgtlvtI4A8oNC1T1peX5X3EjRQ4PAfGnEBdZLlD+
    0DBLJBkUb2qAERzHr1pNCxwSrN/Ps4t9rKh5ydDtCOiDQgjSJVxFJOeT+z05QrTu
    Nxn/E1coLIynR5kJkBcaNJt2NPTBPL5028uovGKRpKxXmONUXtGCGZIHrRahgp4/
    uUV+cafOJXz3qYZ43T+J/LtAaGB/QUARIBUHZaC3Dx1vPnW82Ucst2mQ7l+C3jj9
    WScRZJ1WKtBwG76ilLZ6CR15pewtnLRGCJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524535502;
    bh=stNgh/yKr2VNmAROML77SiA733awXUocZB5W75TXptg=; b=JqRMp0AnFSAj
    YL2Hf6UHih3bOxUuxR8eAo2kMbOF5WxKQxTl7DvAmk9PtuYeOdudW182QcwnOK06
    he5hBlvKO87ovCr8QAA5z8yzmJvuuI3tzUlkhftnou3VoZ13WcacLw6cTWtpsHbP
    ncNg7d8qmEVF+wn2iWoI1ZTvzGDquRgg20sChK7Xetkicg4rPi8EH9xwlhabm6E1
    T3DsBPALoNu7cfH+FulwstWZI5/db6YbMxh7Flcd3xZkGMQO7ZHJFUnwRjHs7whF
    agY3w4S0Da/edGr4fMgHrkCyXK31Jvui7D1dXSJTGY7kLRJNOagtNx5/qQYzZUoW
    Hj/cFdxxgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCTKLExyvAhXxKtnC3T3aW83be+5dLF4/XqEALIia/Bg2Lwi1/yydOCUyW+qLnyeSs2UYhl4Hq93DGZ0FnPNuB640MvAagV2cAOFIH08W7Y9rHUdbw7d
    kBzGeFXVNaK8uCaJ5bSnkTNCvhhfnLF0lxk1IMP7ur1dpqaOZtSQYrU/1RX71h6huE9Aw8nu0iVBkImtaMvGa8t/BUIybYBpbNKZdQwPkY+KzMl1Dj5rkazZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=y-QR_fwuz91LMhaDtOUA:9
    a=kAPk3mIfliD02ux6:21 a=PitNnT9j-nV6CYYp:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932688AbeDXCE7 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 23 Apr 2018 22:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932665AbeDXCE6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Apr 2018 22:04:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1423217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/VmILCMr6ODQXNUQPDXfnFGYJcC9kX9nQzEe8PSm3ntpgzvB1MhrfzUbVkzcIsJOplTKetUN3/WDhwdqj/T6o=
MIME-Version: 1.0
In-Reply-To: <d5b4dc70-6f17-d2be-a519-5ebc3f812f57@gmail.com>
References: <20180420155542.122183-1-edumazet@google.com> <9ed6083f-d731-945c-dbcd-f977c5600b03@kernel.org>
 <d5b4dc70-6f17-d2be-a519-5ebc3f812f57@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 23 Apr 2018 19:04:36 -0700
X-Gmail-Original-Message-ID: <CALCETrWOLU+P_jVpuOUQT2e_5ZShAP3OM0yJZMbC=pv5La9Cvg@mail.gmail.com>
Message-ID: <CALCETrWOLU+P_jVpuOUQT2e_5ZShAP3OM0yJZMbC=pv5La9Cvg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep issue
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 2:38 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> Hi Andy
>
> On 04/23/2018 02:14 PM, Andy Lutomirski wrote:

>> I would suggest that you rework the interface a bit.  First a user would call mmap() on a TCP socket, which would create an empty VMA.  (It would set vm_ops to point to tcp_vm_ops or similar so that the TCP code could recognize it, but it would have no effect whatsoever on the TCP state machine.  Reading the VMA would get SIGBUS.)  Then a user would call a new ioctl() or setsockopt() function and pass something like:
>
>
>>
>> struct tcp_zerocopy_receive {
>>   void *address;
>>   size_t length;
>> };
>>
>> The kernel would verify that [address, address+length) is entirely inside a single TCP VMA and then would do the vm_insert_range magic.
>
> I have no idea what is the proper API for that.
> Where the TCP VMA(s) would be stored ?
> In TCP socket, or MM layer ?

MM layer.  I haven't tested this at all, and the error handling is
totally wrong, but I think you'd do something like:

len = get_user(...);

down_read(&current->mm->mmap_sem);

vma = find_vma(mm, start);
if (!vma || vma->vm_start > start)
  return -EFAULT;

/* This is buggy.  You also need to check that the file is a socket.
This is probably trivial. */
if (vma->vm_file->private_data != sock)
  return -EINVAL;

if (len > vma->vm_end - start)
  return -EFAULT;  /* too big a request. */

and now you'd do the vm_insert_page() dance, except that you don't
have to abort the whole procedure if you discover that something isn't
aligned right.  Instead you'd just stop and tell the caller that you
didn't map the full requested size.  You might also need to add some
code to charge the caller for the pages that get pinned, but that's an
orthogonal issue.

You also need to provide some way for user programs to signal that
they're done with the page in question.  MADV_DONTNEED might be
sufficient.

In the mmap() helper, you might want to restrict the mapped size to
something reasonable.  And it might be nice to hook mremap() to
prevent user code from causing too much trouble.

With my x86-writer-of-TLB-code hat on, I expect the major performance
costs to be the generic costs of mmap() and munmap() (which only
happen once per socket instead of once per read if you like my idea),
the cost of a TLB miss when the data gets read (really not so bad on
modern hardware), and the cost of the TLB invalidation when user code
is done with the buffers.  The latter is awful, especially in
multithreaded programs.  In fact, it's so bad that it might be worth
mentioning in the documentation for this code that it just shouldn't
be used in multithreaded processes.  (Also, on non-PCID hardware,
there's an annoying situation in which a recently-migrated thread that
removes a mapping sends an IPI to the CPU that the thread used to be
on.  I thought I had a clever idea to get rid of that IPI once, but it
turned out to be wrong.)

Architectures like ARM that have superior TLB handling primitives will
not be hurt as badly if this is used my a multithreaded program.

>
>
> And I am not sure why the error handling would be better (point 4), unless we can return smaller @length than requested maybe ?

Exactly.  If I request 10MB mapped and only the first 9MB are aligned
right, I still want the first 9 MB.

>
> Also how the VMA space would be accounted (point 3) when creating an empty VMA (no pages in there yet)

There's nothing to account.  It's the same as mapping /dev/null or
similar -- the mm core should take care of it for you.
