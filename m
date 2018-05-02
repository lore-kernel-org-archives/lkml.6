Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-840942-1525270849-2-2914108029658760895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525270848; b=FRAxwe+hRvuTOXhmB1DryGQ41+4LIfRX6WspnAvxFkTEby4/S7
    5fsf4oJ44FHLtrXISlwfPyFpXBf66MzoyPOpoRBIimLWkqxMMN56pSMRY3snbGEC
    ETntB2e4dfOOwso6JVkgOmLdOLt9r676ArXIZz8v38c/YB6nJf5ZUNZGJdOkrxCe
    mq66Zrhl0Eg8JTWizIRc/s0Dquo5jiQeXU3F4jBdEFzLQj4p7htWCNHn/0i+taH8
    mCoALYzkAZJ0m6mY0tjtnXQ4LcKVUF6Yrou+cV929Aav7ipfr+P2KS53aoOu2Diq
    7YEJ2VUvjwk0uitgh5Dx9WYnxKkKqDVxeCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525270848; bh=bE6+lGi/HIXYQgySdTdwyOvSghLI8iYPOmCAsdB/Ms
    U=; b=TaLH7LMs5roa2mjoEiWKZfx24ttgiFUsfe3pkJwGXOtu7DRuexwHOeizJf
    Bx+Vut1BT3E7WCsOH0zgmerOUFau/PKjhEOQ+fXtfr1jaUy/kRA7MCAVijI2x+N6
    zFMC+7J1zj+IwHLtCXzCayPO/crj1M+MECrXuUg0bpWlhGpUjLR1aqBuVglnwdZb
    I7XQWq0Kbzlr4bkmVopsPdY316gWtfWcvyolkiCLaZE5kMz1RI1VwghopzH/37MI
    Ff4BaOM3bEEM/bLfH9yIFzDwW3t0tqyIto4KsBeGsxXyESmvCQHyMBeKfgQW5Z6X
    auWh9FEVXJupLcWYFeEXw29OHLFQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=LHBNL27O
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=wHm3kz0E x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=GaqZauy2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=LHBNL27O
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=wHm3kz0E x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=GaqZauy2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHgmKk9MWIddAehJp7nuSjjxGXS8nclKbEyF3R/sjVeGLfd0yuZdfwBjhjoAMIo/kpuCBGODv5cwQQPBklrEUnhKlXgHWi4p5fmnKNyGUXT8zlaSogcV
    uxH+h/UgQUVKVVXN1iaPM8266zAfVZe3HEoSN9whzYI+XK5NenQRV5wvJLnBy4LK+M+iSgn6srO9t3GCj5KXONpn9YmyPh89dWnMULYcp/46pe7U24oZfHbp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=Y7Ihilc7DxF1xLn2cncA:9
    a=x3pETUjStnZlmHVM:21 a=yTkXb2pVe8stFtqQ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeEBOUV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 10:20:21 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40621 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeEBOUQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 10:20:16 -0400
X-Google-Smtp-Source: AB8JxZphaLbXpJ6bpu5x/7UJa1rE8fSYcPouRcB/BPeko+27wkAuElgw/YxB4Mvz6r7GXIts0Yk1y9CqmOPkpOMFQ6k=
MIME-Version: 1.0
In-Reply-To: <024d902c-54d7-f91e-4d71-57da4b15b3f9@linux.ibm.com>
References: <20180418071436.21392-1-tmricht@linux.ibm.com> <CAGXu5j+wnRsecDVZjOFVmLLdptfqSJ2QCLAY-x+EaiUAd0yfjA@mail.gmail.com>
 <024d902c-54d7-f91e-4d71-57da4b15b3f9@linux.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 2 May 2018 07:20:14 -0700
X-Google-Sender-Auth: MQG5Z6P65VpOubteaDuUOqIyyKw
Message-ID: <CAGXu5j+a5uQ8CCjFpz4rZRHEQZQmR-PkRPsfguV_7KVo1qAhdQ@mail.gmail.com>
Subject: Re: [PATCH v3] module: Fix display of wrong module .text address
To: Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        brueckner@linux.vnet.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 2, 2018 at 1:13 AM, Thomas-Mich Richter
<tmricht@linux.ibm.com> wrote:
> On 05/02/2018 04:20 AM, Kees Cook wrote:
>> On Wed, Apr 18, 2018 at 12:14 AM, Thomas Richter <tmricht@linux.ibm.com> wrote:
>>> Reading file /proc/modules shows the correct address:
>>> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>>> qeth_l2 94208 1 - Live 0x000003ff80401000
>>>
>>> and reading file /sys/module/qeth_l2/sections/.text
>>> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>>> 0x0000000018ea8363
>>> displays a random address.
>>>
>>> This breaks the perf tool which uses this address on s390
>>> to calculate start of .text section in memory.
>>>
>>> Fix this by printing the correct (unhashed) address.
>>>
>>> Thanks to Jessica Yu for helping on this.
>>>
>>> Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
>>> Cc: <stable@vger.kernel.org> # v4.15+
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>> Cc: Jessica Yu <jeyu@kernel.org>
>>> ---
>>>  kernel/module.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/module.c b/kernel/module.c
>>> index a6e43a5806a1..40b42000bd80 100644
>>> --- a/kernel/module.c
>>> +++ b/kernel/module.c
>>> @@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
>>>  {
>>>         struct module_sect_attr *sattr =
>>>                 container_of(mattr, struct module_sect_attr, mattr);
>>> -       return sprintf(buf, "0x%pK\n", (void *)sattr->address);
>>> +       return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
>>> +                      (void *)sattr->address : NULL);
>>
>> Errr... this looks reversed to me.
>>
>> I would expect: "kptr_restrict < 2 ? NULL : (void *)sattr->address"
>>
>> -Kees
>>
>
> I am confused:
> In my patch, if kptr_restrict == 2 it prints NULL, which kptr_restrict
> being 0 or 1 it prints the address.
>
> In your comment if kptr_restrict == 2 it prints the address, which
> kptr_restrict being 0 or 1 it prints NULL.
>
> Looking into Documentation/sysctl/kernel.txt:
>   When kptr_restrict is set to (2), kernel pointers printed using
>   %pK will be replaced with 0's regardless of privileges.
>
> With my patch, setting kptr_restrict to 0 or 1
> prints the real kernel address (format %px, unmodified address
> according to Documentation/printk-formats.txt).
>
> I have tested this on s390 (which is the only arch using file
> /sys/module/<XXX>/sections/.text) in the perf tool.
>
> root@s8360047 ~]# sysctl  kernel.kptr_restrict
> kernel.kptr_restrict = 0
> [root@s8360047 ~]# cat /proc/modules | egrep '^qeth_l2'
> qeth_l2 102400 1 - Live 0x000003ff8034d000
> [root@s8360047 ~]# cat /sys/module/qeth_l2/sections/.text
> 0x000003ff8034da68
> [root@s8360047 ~]# sysctl  -w kernel.kptr_restrict=2
> kernel.kptr_restrict = 2
> [root@s8360047 ~]# cat /proc/modules | egrep '^qeth_l2'
> qeth_l2 102400 1 - Live 0x0000000000000000
> [root@s8360047 ~]# cat /sys/module/qeth_l2/sections/.text
> 0x0000000000000000
> [root@s8360047 ~]# uname -a
> Linux s8360047 4.17.0-rc3m-perf+ #6 SMP PREEMPT Wed May 2 10:02:38 CEST 2018 s390x s390x s390x GNU/Linux
> [root@s8360047 ~]#
>
> Hope this helps.

Thanks! Yes, I was looking at too many of the %px commits in a row and
confused myself. Sorry for the noise!

-Kees

-- 
Kees Cook
Pixel Security
