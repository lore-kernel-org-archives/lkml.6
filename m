Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-340991-1518793889-2-17933669324043857470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518793888; b=micamfojlrxFJ2naclMaXym4JgmuIZze5vW0VtNTFxyVenn
    5EL2fVJnTYviBEhj2OUSH3DajLQBTxd0+DjUNv/lK47UbWQYpg/hbqitAsMY3mrF
    kVnzMBK6FXll9EMH7knNTVldh0DbflHEECwJRF+kFitVnlzGd9UQZx5UdFJd5+mT
    2FN9CySPz8sIciBUw2R+4Ky6L9OxsKkM93bdWew0AhCX7nnmycB37jMnc2wyntHZ
    fQuEKyoO47Uq9QjGI8Ie7CctMJsEzwPyEN/IIkoGvPBfLzFKPdS/iQ318NVSfp+2
    N44WeO2dKBavcqLKr1CPnobHdrmaKAxC93/23UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518793888; bh=83gdal1HHdfDngr7uPzcs71a3nAuk8MhwD9EQ3
    Z5iLM=; b=soUUCj1tJFQeyMXmpo2uJ39JTEG1llYz/AgmMN4wQn0QwFF1maSsBi
    ueGTWuMkGr2n8oYnx50HPO6y5SmGqvxYj/B+RxtjwD+2XsCgX+sVfsWoWShAPltU
    pewvzJQJAi9jqCICe0CyiUvOhFW1+9ygNLk/RcK6VEMVZ2nDncKkqogAUZmxFTkH
    65j/Y17EHNcW98Z6WGUukzt+50Fajhtq6CtGOHyrIoED+1VPTiflXhDDODvE8dFQ
    AJVZ7SrpOTiMFf0cyHQBU3Y7zYZbFLZA/LJylRgNnKzLSn7sSduqtGpBgdF5otDQ
    OLHV2ot4ja72bQsiUVjtTLsps3R2s1lg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C+pTao9a x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fPFvglFv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=C+pTao9a x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fPFvglFv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeBPPLN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:11:13 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:34113 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966522AbeBPPLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 10:11:10 -0500
X-Google-Smtp-Source: AH8x224vQIwPLID7+kBf8ripGE9CE4iH04vd4qQHmJyag0cbn4flQQ+tqMkNmi6eZvrR0He+4h+oaR539ZOxx+Z35P0=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJwDDKKzWYszuAMP=2KL_LX=Ngvdk=_3rENJD_GJ-QmNQ@mail.gmail.com>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble> <20180214224525.esxiqt7yjjjpzyz4@treble>
 <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com>
 <20180215152521.eoz6mhgw22ekyaev@treble> <CAK8P3a1WVDLW=m0wUtsoiGjYHqvD9PpEea7n8tfbEy1A=8Ougw@mail.gmail.com>
 <CAGXu5j+WEki4wTdSFL2R1gKP+FTJi_d9+D__cekbPvNdsAe_qw@mail.gmail.com> <CAGXu5jJwDDKKzWYszuAMP=2KL_LX=Ngvdk=_3rENJD_GJ-QmNQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Feb 2018 16:11:09 +0100
X-Google-Sender-Auth: x6lLN-scY83pY2rM4Xzcler1z7M
Message-ID: <CAK8P3a2cdF1KnPuK=KFkkX=PYp26T7KEFcQquxVRD2txP4rOxg@mail.gmail.com>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
To: Kees Cook <keescook@chromium.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 4:41 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 15, 2018 at 10:06 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Thu, Feb 15, 2018 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Feb 15, 2018 at 4:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>> On Thu, Feb 15, 2018 at 04:01:57PM +0100, Arnd Bergmann wrote:
>>>>> On Wed, Feb 14, 2018 at 11:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>>>> > On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
>>>>> >> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
>>>
>>>> Ok, I expected something like that.  GCC "undefined behavior" strikes
>>>> again.
>>>>
>>>> Kees, I suppose you'll need to obfuscate the code to stay one step ahead
>>>> of GCC.
>>>>
>>>> While this may be an objtool bug, I might not fix it because it served a
>>>> useful purpose here in finding GCC crap.
>>>>
>>>>> I would have expected an actual NULL pointer dereference to remain
>>>>> in the function though, or at least another trapping instruction.
>>
>> Uuhhh... I don't see the NULL deref, and even if it was eliminating
>> later stuff, I'd still expect a pr_info() ...
>>
>> void lkdtm_CORRUPT_LIST_ADD(void)
>> {
>>         /*
>>          * Initially, an empty list via LIST_HEAD:
>>          *      test_head.next = &test_head
>>          *      test_head.prev = &test_head
>>          */
>>         LIST_HEAD(test_head);
>>         struct lkdtm_list good, bad;
>>         void *target[2] = { };
>>         void *redirection = &target;
>>
>>         pr_info("attempting good list addition\n");
>> ...
>>
>>>>> >  Can you share the config for this one?
>>>>>
>>>>> https://pastebin.com/qFV6SPWP
>>>>
>>>> Would be interesting to analyze that config to understand what options
>>>> are causing GCC to do that.  I don't see this "optimization" with my
>>>> config.
>>>
>>> This seems like a very rare combination, the flags I need to reproduce are
>>> "gcc -O2 -mno-red-zone  -mpreferred-stack-boundary=3 -march=nocona",
>>> however I do see the same behavior with every gcc version since 4.8!
>>>
>>> Aside from -march=nocona, also bonnell, atom, silvermont, slm, and knl
>>> show this, but none of the modern microarchitectures do.
>>
>> I'll see if I can reproduce this...
>
> To clarify, this is _only_ on 4.14, gcc 7.3.0, and any of
> march=nocona, bonnell, atom, silvermont, slm, or knl ?
>
> Is it present in latest Linus and/or with gcc 8?

It is with all modern gcc versions: 4.8 though 8.0.1 on those -march
values, and it still appears on latest Linus and next/master.

           Arnd
