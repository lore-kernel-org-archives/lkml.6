Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519663127-2-10840337750987763718
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519663126; b=LAEaXtcF6Mfhgbiy4PeZo6ZpMphzJo/XmdHTw4IfM0TPPpW
    IMej6BMKKtXMI4URxvDwGVXG5n2yQm6zCQtxde9ydn2Z1gZRZ7J33+RhWjHEFMMw
    X+anhG2jmlH1yXQnkj5qPOqSzx7r98P+f9QFrSdLf2GZlI93u+TP2764GIYXOdlQ
    6Zz+KwWlFpC7VcFVv6ya6cX3460CiWz3VtSSQYVGMCcxfjkHhF30+mgCbe6VFTV4
    Xq5+sUDCUbe8LDF+34eOZVIzvTMFW+CdNl4jCRIo6obSrYsDvofFx6xAX/lqqD6g
    qpSVOATKnV+9zg+mTV7FftgImXygCO7lHkpg1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519663126; bh=y+ul6Sty/UrsoaRaq+Ui0TvzhIYwc8zGaM+Mem
    yW+z4=; b=TSBNGgEVQM9q/qC5Hffu1vXqrxJ7U4IRoSwDNUEuwWyIHbcbvYGifw
    y+lFLDfJ2hlr5k9xKyJI0Hth0wMqeEUihy5xTpAq2LLKJDBth77iwYQAcIJdPwBS
    MrHv5EoGbKx13JB8VL7qpXhkvR5yUCi2FXalkC1BMPnqJSkeK6Z+ZX7b5f1CV6OD
    Y6sY47NLEbwvbX2TJOszZdmudEZuJ26NvigefMqggIM1f/ym6hV5uSJr7ZK/nhcJ
    HCFz1ZpnGWAGNUr4C/09dym0R4FA+SkOWvRknXOS90XKNKT+A/V3FCFPzX/fF2B5
    ryJTlj5PfkzFQvoE6O2xVTdjiS0dtxcg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=eSZWx7Ao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LMhTowpU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=eSZWx7Ao x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=LMhTowpU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeBZQid (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 11:38:33 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33978 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeBZQic (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 11:38:32 -0500
X-Google-Smtp-Source: AG47ELvD98yxbaenETDeVtV7nOTg9ds5i6mVyfQGeii5DX2fFadJKuXs796NjdhXOrWSkf55EEfVB4PvmTHbF9vbTF8=
MIME-Version: 1.0
In-Reply-To: <CAJWu+or6oK--zi6uDUipHY42wf79aVHo3WuZXXUvzR-7Atod4A@mail.gmail.com>
References: <20180216190201.59572-1-joelaf@google.com> <20180222134832.GA1400@kroah.com>
 <CAJWu+or6oK--zi6uDUipHY42wf79aVHo3WuZXXUvzR-7Atod4A@mail.gmail.com>
From: Todd Kjos <tkjos@android.com>
Date: Mon, 26 Feb 2018 08:38:28 -0800
Message-ID: <CAD0t5oNTMaHDAHoij3GhyET5AYGWYCyyT6FZD7wRQoq7t5FrcA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: android: ashmem: Fix lockdep issue during llseek
To: Joel Fernandes <joelaf@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Arve Hjonnevag <arve@android.com>,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ack. I confirmed that the syzbot could not reproduce the issue with this patch.

On Thu, Feb 22, 2018 at 1:02 PM, Joel Fernandes <joelaf@google.com> wrote:
> (reposting in plain text, sorry for the previous HTML email, I should
> have not posted from the Phone)
>
> On Thu, Feb 22, 2018 at 5:48 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Feb 16, 2018 at 11:02:01AM -0800, Joel Fernandes wrote:
>>> ashmem_mutex create a chain of dependencies like so:
>>>
>>> (1)
>>> mmap syscall ->
>>>   mmap_sem ->  (acquired)
>>>   ashmem_mmap
>>>   ashmem_mutex (try to acquire)
>>>   (block)
>>>
>>> (2)
>>> llseek syscall ->
>>>   ashmem_llseek ->
>>>   ashmem_mutex ->  (acquired)
>>>   inode_lock ->
>>>   inode->i_rwsem (try to acquire)
>>>   (block)
>>>
>>> (3)
>>> getdents ->
>>>   iterate_dir ->
>>>   inode_lock ->
>>>   inode->i_rwsem   (acquired)
>>>   copy_to_user ->
>>>   mmap_sem         (try to acquire)
>>>
>>> There is a lock ordering created between mmap_sem and inode->i_rwsem
>>> causing a lockdep splat [2] during a syzcaller test, this patch fixes
>>> the issue by unlocking the mutex earlier. Functionally that's Ok since
>>> we don't need to protect vfs_llseek.
>>>
>>> [1] https://patchwork.kernel.org/patch/10185031/
>>> [2] https://lkml.org/lkml/2018/1/10/48
>>>
>>> Cc: Todd Kjos <tkjos@google.com>
>>> Cc: Arve Hjonnevag <arve@android.com>
>>> Cc: Greg Hackmann <ghackmann@google.com>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com
>>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>>> ---
>>> Changes since first version:
>>> Don't relock after vfs call since its not needed. Only reason we lock is
>>> to protect races with asma->file.
>>> https://patchwork.kernel.org/patch/10185031/
>>
>> I'd like some acks from others before I take this patch.
>
> GregH, Todd, could you provide Acks?
>
>>
>> Joel, did the original reporter say this patch solved their issue or
>> not?  For some reason I didn't think it worked properly...
>
> That's a different but similar issue:
> https://patchwork.kernel.org/patch/10202127/. That was related to
> RECLAIM_FS lockdep recursion. That was posted as an RFC unlike this
> one, and its still being investigated since Miles reported that the
> lockdep inode annotation doesn't fix the issue.
>
> This one on the other hand has a straightforward fix, and was verified
> by the syzbot.
>
> I can see why its easy to confuse the two issues.
>
> Thanks,
>
> - Joel
