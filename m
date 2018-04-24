Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2307271-1524544248-2-13496446345711019761
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
    1524544247; b=ntrXLGWqo0WirgkzJmd+SZIk0NvSNTAwfU30/tWpuj7AvHtVBI
    0lzNaribD0RHk+E1mH2n0A0Uust0XlR5LsuExjnB8I4jVKCNoP45QJtN4i5ASOao
    pIOZfjO5q+dHWJClnPUutrN1uawCpWXYTR0mus8JySle8YeIidk5RMFI1jsGksyl
    ncUTE3JtiPXyaPTf5TOIVdUo8oVUCUrKjnOFz9vup1NaYFJqkNi8rKzX7v3MzF/W
    /lNx3yIyK4RdFeoUYDmpVf2uMhaGF9bMZWpJtwJvmJ34JDGQD16yNIvLpVES6M1Z
    4hjyPTiBLaIabr+55RPZ279J3gyfz4hanjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524544247;
    bh=yjJhn71VhXd4u1+/QVArq4euzxEEiJo2MlrckJOk+8I=; b=CbYwZtUG1CQ2
    DpSYZKIHL+3oFa2ZbNBBPgUl17VdMO66hK8pGmD3ZQxUSGOYFXGLKhoG1IsIzObO
    6Cty/TlYmqNmWwHrpdz43/nD8ePmjhNqPVVFYWPdMRlhSwkX8AFYmeEKB/qvBGQK
    GKgmxwRpZbvPLf+J5QcFZZaE3Y7aDkiJOcQPuadS03VxybXS2hwN0azT1xQzK6+g
    x0oZ8sY+nrQtmkTKEKHyH9IZQlQBec/tn/aEcWTyFjPneA2iA42GpZBJfL3h0aIa
    heFQ6Z1LqXjvUZkFVvSXL4bJX1XrdZFdkdj3cQNKMmR50LC17TxT6ezsBO7tlXIH
    DL7pG1LTMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pU9sSOvs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h343tLhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=pU9sSOvs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h343tLhd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFWrDkFamojDZHpB1UXHUuehTA2o4/rPNwKE03bIJHX/8bMalWeQznAFrBfpG4hpQqpxMjIvd0S9YLPnppGgj2t6SaabHBJ8axNOCbdWO3j462Gu+z8V
    BA0MCdK08G49DvUXLr/CMvMbVuFjF5GP9er5rgdGonCD6zzcgb1p4/m2QtW9zlNLAsoRJ1Mnnd/koXQ6qLHRRY1yyyBoKuc0I/rwaiP2FlPk2mJDx7EGyUtm
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=XT5P2k9a7GMA:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=p9N5fjw-SiyHJFF4F4UA:9 a=5hHddDYAzoLdgSd5:21 a=2ESy_FZP5lAK_GO3:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeDXEaj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 00:30:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:43980 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDXEah (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Apr 2018 00:30:37 -0400
X-Google-Smtp-Source: AIpwx49Jj3QxuOxiJSSKdkiXmk0gfgeB46pKx/RPp/6wKNFlA202fJ86wo33PTOMx8E2N6Nm7FxrXQ==
Subject: Re: [PATCH net-next 0/4] mm,tcp: provide mmap_hook to solve lockdep
 issue
To: Andy Lutomirski <luto@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20180420155542.122183-1-edumazet@google.com>
 <9ed6083f-d731-945c-dbcd-f977c5600b03@kernel.org>
 <d5b4dc70-6f17-d2be-a519-5ebc3f812f57@gmail.com>
 <CALCETrWOLU+P_jVpuOUQT2e_5ZShAP3OM0yJZMbC=pv5La9Cvg@mail.gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e494c904-bdd0-8c6c-0592-c4960dcf2865@gmail.com>
Date: Mon, 23 Apr 2018 21:30:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWOLU+P_jVpuOUQT2e_5ZShAP3OM0yJZMbC=pv5La9Cvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/23/2018 07:04 PM, Andy Lutomirski wrote:
> On Mon, Apr 23, 2018 at 2:38 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>> Hi Andy
>>
>> On 04/23/2018 02:14 PM, Andy Lutomirski wrote:
> 
>>> I would suggest that you rework the interface a bit.  First a user would call mmap() on a TCP socket, which would create an empty VMA.  (It would set vm_ops to point to tcp_vm_ops or similar so that the TCP code could recognize it, but it would have no effect whatsoever on the TCP state machine.  Reading the VMA would get SIGBUS.)  Then a user would call a new ioctl() or setsockopt() function and pass something like:
>>
>>
>>>
>>> struct tcp_zerocopy_receive {
>>>   void *address;
>>>   size_t length;
>>> };
>>>
>>> The kernel would verify that [address, address+length) is entirely inside a single TCP VMA and then would do the vm_insert_range magic.
>>
>> I have no idea what is the proper API for that.
>> Where the TCP VMA(s) would be stored ?
>> In TCP socket, or MM layer ?
> 
> MM layer.  I haven't tested this at all, and the error handling is
> totally wrong, but I think you'd do something like:
> 
> len = get_user(...);
> 
> down_read(&current->mm->mmap_sem);
> 
> vma = find_vma(mm, start);
> if (!vma || vma->vm_start > start)
>   return -EFAULT;
> 
> /* This is buggy.  You also need to check that the file is a socket.
> This is probably trivial. */
> if (vma->vm_file->private_data != sock)
>   return -EINVAL;
> 
> if (len > vma->vm_end - start)
>   return -EFAULT;  /* too big a request. */
> 
> and now you'd do the vm_insert_page() dance, except that you don't
> have to abort the whole procedure if you discover that something isn't
> aligned right.  Instead you'd just stop and tell the caller that you
> didn't map the full requested size.  You might also need to add some
> code to charge the caller for the pages that get pinned, but that's an
> orthogonal issue.
> 
> You also need to provide some way for user programs to signal that
> they're done with the page in question.  MADV_DONTNEED might be
> sufficient.
> 
> In the mmap() helper, you might want to restrict the mapped size to
> something reasonable.  And it might be nice to hook mremap() to
> prevent user code from causing too much trouble.
> 
> With my x86-writer-of-TLB-code hat on, I expect the major performance
> costs to be the generic costs of mmap() and munmap() (which only
> happen once per socket instead of once per read if you like my idea),
> the cost of a TLB miss when the data gets read (really not so bad on
> modern hardware), and the cost of the TLB invalidation when user code
> is done with the buffers.  The latter is awful, especially in
> multithreaded programs.  In fact, it's so bad that it might be worth
> mentioning in the documentation for this code that it just shouldn't
> be used in multithreaded processes.  (Also, on non-PCID hardware,
> there's an annoying situation in which a recently-migrated thread that
> removes a mapping sends an IPI to the CPU that the thread used to be
> on.  I thought I had a clever idea to get rid of that IPI once, but it
> turned out to be wrong.)
> 
> Architectures like ARM that have superior TLB handling primitives will
> not be hurt as badly if this is used my a multithreaded program.
> 
>>
>>
>> And I am not sure why the error handling would be better (point 4), unless we can return smaller @length than requested maybe ?
> 
> Exactly.  If I request 10MB mapped and only the first 9MB are aligned
> right, I still want the first 9 MB.
> 
>>
>> Also how the VMA space would be accounted (point 3) when creating an empty VMA (no pages in there yet)
> 
> There's nothing to account.  It's the same as mapping /dev/null or
> similar -- the mm core should take care of it for you.
> 

Thanks Andy, I am working on all this, and initial patch looks sane enough.

 include/uapi/linux/tcp.h |    7 +
 net/ipv4/tcp.c           |  175 +++++++++++++++++++++++------------------------
 2 files changed, 93 insertions(+), 89 deletions(-)


I will test all this before sending for review asap.

( I have not done the compat code yet, this can be done later I guess)


