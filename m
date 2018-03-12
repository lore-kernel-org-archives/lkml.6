Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-584461-1520866159-2-836501932683105358
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520866158; b=L09TLpYpOUjswumYKE3ExzvHpZe9hF/gPWEIFBkViQuIhlP
    L8aI24kLQEG19pEjS9JaSSAhDrzYnmVuTfMVrZ6WBR6MKcp6h41EEyQ4SFP4Ch1K
    jZlqsLLjgriar6Nx+/bz/uzzB3HHd5Qdfs0g1UUdJY/lD881QSYWBReRXBRFOdT8
    h6mWyfb0s+hyQEFA+Hv6XTQfU5op5et/vCYaQYZ5635YrCPXe/3wOwUQrXlfGcFR
    icdDyezmFDdjhU8jQE8pQwQOOIfwOLr0CLuDgFfYjAPCSn9vDHVHZng5jDvK5e9d
    GiJrTURLCPZSxyVHKrE/EvlObfRcoIC7cgXpqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520866158; bh=aNIq5i1PVdPr19QYBM1B4KUSwY3KeW19wS//Zs
    wJuls=; b=XIDH4i4bAanQYi0z3K4H54Mmv6NqCvcONPTVLCOMqvSTPcWMHnzYkA
    LFZ4J5OcQwJOX7Br2NtFcVCMFg+07nNOgRbOkAiVluk/bZgLFPozLaA+cgACevrL
    v2IggbSNeSLJ8hQfS2qdwoXdBHtMOtFyI6W2L4aUWOcKqxJ/3ViIA3dnQzFL733d
    T16vaQZSqAzIh92DjaFmio0tKXePqdg18G8uo4ZjIdVJGNDzPFoOIEiosLy+kinC
    pggdrghA2wacUoTuJhAdA2viWNKdRLPdV/z35Zo8oye1JcEDi9HxkMBPV/OvgSPk
    tGqdOrNawiWTCgroHFfiOv6QENoYkr1Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ixcbBVwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G82DxGUy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=ixcbBVwU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G82DxGUy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeCLOtP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 10:49:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34764 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLOtO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 10:49:14 -0400
X-Google-Smtp-Source: AG47ELuvgdsCC1rBCK8nFQb9glcPb0vxyVd9MkOQME8lZP4QkHxOT5JlPxQ6pizjSo7p36nbsqrJfh4BusiuUhjeZfg=
MIME-Version: 1.0
In-Reply-To: <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <cover.1520011944.git.neelx@redhat.com> <0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com>
 <20180302164052.5eea1b896e3a7125d1e1f23a@linux-foundation.org>
 <CACjP9X_tpVVDPUvyc-B2QU=2J5MXbuFsDcG90d7L0KuwEEuR-g@mail.gmail.com> <CAPKp9ubzXBMeV6Oi=KW1HaPOrv_P78HOXcdQeZ5e1=bqY97tkA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Mar 2018 20:19:11 +0530
Message-ID: <CA+G9fYvWm5NYX64POULrdGB1c3Ar3WfZAsBTEKw4+NYQ_mmddA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Vacek <neelx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 March 2018 at 17:56, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi,
>
> I couldn't find the exact mail corresponding to the patch merged in v4.16-rc5
> but commit 864b75f9d6b01 "mm/page_alloc: fix memmap_init_zone
> pageblock alignment"
> cause boot hang on my ARM64 platform.

I have also noticed this problem on hi6220 Hikey - arm64.

LKFT: linux-next: Hikey boot failed linux-next-20180308
https://bugs.linaro.org/show_bug.cgi?id=3676

- Naresh

>
> Log:
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000000000000-0x00000009ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x9fffcb480-0x9fffccf7f]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000f8f9afff]
> [    0.000000]   node   0: [mem 0x00000000f8f9b000-0x00000000f908ffff]
> [    0.000000]   node   0: [mem 0x00000000f9090000-0x00000000f914ffff]
> [    0.000000]   node   0: [mem 0x00000000f9150000-0x00000000f920ffff]
> [    0.000000]   node   0: [mem 0x00000000f9210000-0x00000000f922ffff]
> [    0.000000]   node   0: [mem 0x00000000f9230000-0x00000000f95bffff]
> [    0.000000]   node   0: [mem 0x00000000f95c0000-0x00000000fe58ffff]
> [    0.000000]   node   0: [mem 0x00000000fe590000-0x00000000fe5cffff]
> [    0.000000]   node   0: [mem 0x00000000fe5d0000-0x00000000fe5dffff]
> [    0.000000]   node   0: [mem 0x00000000fe5e0000-0x00000000fe62ffff]
> [    0.000000]   node   0: [mem 0x00000000fe630000-0x00000000feffffff]
> [    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
> [    0.000000]  Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
>
> On Sat, Mar 3, 2018 at 1:08 AM, Daniel Vacek <neelx@redhat.com> wrote:
>> On Sat, Mar 3, 2018 at 1:40 AM, Andrew Morton <akpm@linux-foundation.org> wrote:
>>> On Sat,  3 Mar 2018 01:12:26 +0100 Daniel Vacek <neelx@redhat.com> wrote:
>>>
>>>> Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
>>>> where possible") introduced a bug where move_freepages() triggers a
>>>> VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
>>>
>>> b92df1de5d28 was merged a year ago.  Can you suggest why this hasn't
>>> been reported before now?
>>
>> Yeah. I was surprised myself I couldn't find a fix to backport to
>> RHEL. But actually customers started to report this as soon as 7.4
>> (where b92df1de5d28 was merged in RHEL) was released. I remember
>> reports from September/October-ish times. It's not easily reproduced
>> and happens on a handful of machines only. I guess that's why. But
>> that does not make it less serious, I think.
>>
>> Though there actually is a report here:
>> https://bugzilla.kernel.org/show_bug.cgi?id=196443
>>
>> And there are reports for Fedora from July:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1473242
>> and CentOS: https://bugs.centos.org/view.php?id=13964
>> and we internally track several dozens reports for RHEL bug
>> https://bugzilla.redhat.com/show_bug.cgi?id=1525121
>>
>> Enough? ;-)
>>
>>> This makes me wonder whether a -stable backport is really needed...
>>
>> For some machines it definitely is. Won't hurt either, IMHO.
>>
>> --nX
