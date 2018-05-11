Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3324562-1526017252-2-2670417851270778360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526017252; b=M0k98AzfN83w0aCWQJ0wWWMklrv9uTYG5O0e7a5WYG5rhMUfBF
    yAY422saYA73L2zGxiHBbH1d6DHbFr0xhtxBmDhin6QkitGSa9Djzu5ByPAoFIDI
    tBDUN7R14NXUfwoqkQVgzD0m5loguApVUtToHR1dF+ZsFBpD1u8vudpn3T/ZkMkr
    0kQRDG9aane7riEoDQ5o0S2dn+DI4B/VydJ+I4DVUuVJf9wu3HLW3dxBpxQ6dlCv
    KmUyLkDhoZzLSYdeEFQ1uSqPAWhdckzPXe7jSbS9L1yB8Cu2P+nljRzJWrOL70gH
    3rl5WZ8El1A2Ra9rr40Y5kaWQSMVyuoihDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526017252; bh=OCcij5lfwm2lBJQ8IRrrWV7Yrqo9bSs3SDlQD4UWey
    c=; b=lxm0S9T1FP+TFbeOcfJ9LMi1fIkxIs0hhY+bcMLqns9wguYD8DwmZCCDpH
    0UVOeb9OAfA1bbA3stCcRNTY+vezHLCEG1T0xBjn8+Red3zMhHElX2LKEk7lq7cA
    TsiWmxMBi1YbcGrM8CrzJ5xt0xewWB2BQdmVOOZFupRk7Q8tryNuuEeBlEtAsXfp
    OI/Bj96x8HIaMWXS2DgL22VtwE7+4PtmmNMeYIQq//327MJlkq86sZqSkTaugSxN
    VJqQIMDyPaoW8l5fuMtw/Agm0Kt4s6ZKLYmaEc7daC6d/jPI27GeKt7ajc1kl/RN
    EFXfkSwonYc6s34rVdhF2CHKBLpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=wRmHbmLp x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=CB9y4zAu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=wRmHbmLp x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=CB9y4zAu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFY7HuosLYAITEJ2hRiDw/V3Zy5BTGQK6LdF6I/NK1r+k23nGZf0ajF430yX3rG7PjmDJj92vwzTDAz5TjHVADL+U8hBhd4sohScVUg72bxmdkn+aQxu
    2toB0usJyjxyh3izYRbaeua/kmM+PiTSMZN56gOBMqMoaO32x83f2JzY1NuQgCp7m/oFJh6Au4lBDpcgo1dNlKC5By4h5SYsemSQv2CaBj++Cb8a0bPnMo2+
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=hSkVLCK3AAAA:8 a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8
    a=fpm-lzRwSnRKyCWKtRsA:9 a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeEKFkt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 01:40:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44634 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEKFks (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 May 2018 01:40:48 -0400
X-Google-Smtp-Source: AB8JxZo+q3zG74IUlGroqv09HiNQxp6QDioNYt9roWjSaeUEYeUjEnjwkitEbZJt9zpPYAX/hqfKH2Vomr7jcSh6Bvc=
MIME-Version: 1.0
In-Reply-To: <52bd5b0b-a4bb-5426-3c92-edd7085faea3@redhat.com>
References: <20180510191634.18796-1-rkagan@virtuozzo.com> <52bd5b0b-a4bb-5426-3c92-edd7085faea3@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 11 May 2018 07:40:26 +0200
Message-ID: <CACT4Y+bZaW6NN-RdVd+EL1pXQs42Nb-dWUn733=eEORT_3NjUA@mail.gmail.com>
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Cathy Avery <cavery@redhat.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 1:54 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 10/05/2018 21:16, Roman Kagan wrote:
>> If an IDR contains a single entry at index==0, the underlying radix tree
>> has a single item in its root node, in which case
>> __radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
>> addition to returning NULL).
>>
>> However, the tree itself is not empty, i.e. the tree root doesn't have
>> IDR_FREE tag.
>>
>> As a result, on an attempt to remove an index!=0 entry from such an IDR,
>> radix_tree_delete_item doesn't return early and calls
>> __radix_tree_delete with invalid parameters which are then dereferenced.
>>
>> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
>> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
>> ---
>>  lib/radix-tree.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
>> index da9e10c827df..10ff1bfae952 100644
>> --- a/lib/radix-tree.c
>> +++ b/lib/radix-tree.c
>> @@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
>>       void *entry;
>>
>>       entry = __radix_tree_lookup(root, index, &node, &slot);
>> -     if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
>> -                                             get_slot_offset(node, slot))))
>> +     if (!entry && (!is_idr(root) || !node ||
>> +                    node_tag_get(root, node, IDR_FREE,
>> +                                 get_slot_offset(node, slot))))
>>               return NULL;
>>
>>       if (item && entry != item)
>>
>
> I cannot really vouch for the patch, but if it is correct it's
> definitely stuff for stable.  The KVM testcase is only for 4.17-rc but
> this is a really nasty bug in a core data structure.
>
> Cc: stable@vger.kernel.org
>
> Should radix-tree be compilable in userspace, so that we can add unit
> tests for it?...

Good point.

For my education, what/where are the tests that run as user-space code?
