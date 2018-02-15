Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2134143-1518717971-2-9834044114716812108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518717971; b=aPdQmMH2NRS1f2uWqj2gCo1WQd6x0v6C0x5CpFdC/OTlFQ2
    QPS2WqAVJZd6wKTinwW908W+4X0aPKqfrYD8Va/tmqJ9PFj19mNpnr8JFLMvDMtu
    Pw6msrEaR51pGwNf5b8vfnTdV3kL5OfwgACReWKY0sFfwMf/ZTUfORA5evsseVLh
    Ee/RVU6wCLUJtuaJamvJNFAXvDfgLcfHAJUU7pQ+5dBq9MwNiMtVpx9cs8suiiNa
    NgACmBk98fIaB0jFDfsMukMA3TQNwAWBm2f00F9u+vZoQk9BqhLnaa3sssDt5EtX
    s0eaqGl67SZowH1UqnAt7FTGeh4igjIBmFL8tWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518717971; bh=GNC8xoA3PkQXGYFkfG9ELxUH9vUdENXPR5VH//
    U/CDY=; b=HZkvqTg8CGE9Hx5zS2Vj4gIuqvIMOL4EER2IxKEqdKFuAvYp5WnKTt
    /c5oHQ9mN41nE3Ay4+TiFyIyC3ibL5BgB2YBRuFxZQt6RtNlQ/09Rjx9yuYXinR4
    TZItIOVq10cqgmH986JXquZVeWjNJQxng1dEkDVP0932VTUM1QBY5LkOAxFshnkZ
    3XGZRWEbZiSYPpPkBMXIXmFSitT0mQVzJVw3NWkNBMLNH0FgsZb279jxTFa5VufV
    k0Pwpo2bqfElxN4XbXFdtm80zpL6dzhi0IxyoKhUcG1P6y8uU1zYXg6u0Kxo82DP
    zfdVWZH3TJwosZVdv4hrmJaDUiA+Kzig==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=HL25hldp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=dAmOaiDn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dfR7OCwF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=HL25hldp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=dAmOaiDn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dfR7OCwF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166023AbeBOSGI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:06:08 -0500
Received: from mail-ua0-f180.google.com ([209.85.217.180]:42397 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166017AbeBOSGF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 13:06:05 -0500
X-Google-Smtp-Source: AH8x224Y+Wv8wJV6xFwZ7RflCS7kJ4RGf81sX6uv27/OVMqOmb4o7awy5pf2T+d7Ba2f3Q8bSWpFY0WXRxjfjONhXzM=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1WVDLW=m0wUtsoiGjYHqvD9PpEea7n8tfbEy1A=8Ougw@mail.gmail.com>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble> <20180214224525.esxiqt7yjjjpzyz4@treble>
 <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com>
 <20180215152521.eoz6mhgw22ekyaev@treble> <CAK8P3a1WVDLW=m0wUtsoiGjYHqvD9PpEea7n8tfbEy1A=8Ougw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 15 Feb 2018 10:06:03 -0800
X-Google-Sender-Auth: dzQ7F_A8DQ2r2eusgTkToyylp_U
Message-ID: <CAGXu5j+WEki4wTdSFL2R1gKP+FTJi_d9+D__cekbPvNdsAe_qw@mail.gmail.com>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
To: Arnd Bergmann <arnd@arndb.de>
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

On Thu, Feb 15, 2018 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Feb 15, 2018 at 4:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> On Thu, Feb 15, 2018 at 04:01:57PM +0100, Arnd Bergmann wrote:
>>> On Wed, Feb 14, 2018 at 11:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>>> > On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
>>> >> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
>
>> Ok, I expected something like that.  GCC "undefined behavior" strikes
>> again.
>>
>> Kees, I suppose you'll need to obfuscate the code to stay one step ahead
>> of GCC.
>>
>> While this may be an objtool bug, I might not fix it because it served a
>> useful purpose here in finding GCC crap.
>>
>>> I would have expected an actual NULL pointer dereference to remain
>>> in the function though, or at least another trapping instruction.

Uuhhh... I don't see the NULL deref, and even if it was eliminating
later stuff, I'd still expect a pr_info() ...

void lkdtm_CORRUPT_LIST_ADD(void)
{
        /*
         * Initially, an empty list via LIST_HEAD:
         *      test_head.next = &test_head
         *      test_head.prev = &test_head
         */
        LIST_HEAD(test_head);
        struct lkdtm_list good, bad;
        void *target[2] = { };
        void *redirection = &target;

        pr_info("attempting good list addition\n");
...

>>> >  Can you share the config for this one?
>>>
>>> https://pastebin.com/qFV6SPWP
>>
>> Would be interesting to analyze that config to understand what options
>> are causing GCC to do that.  I don't see this "optimization" with my
>> config.
>
> This seems like a very rare combination, the flags I need to reproduce are
> "gcc -O2 -mno-red-zone  -mpreferred-stack-boundary=3 -march=nocona",
> however I do see the same behavior with every gcc version since 4.8!
>
> Aside from -march=nocona, also bonnell, atom, silvermont, slm, and knl
> show this, but none of the modern microarchitectures do.

I'll see if I can reproduce this...

-Kees

-- 
Kees Cook
Pixel Security
