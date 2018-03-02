Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988330-2-12996820863373628602
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988329; b=gctE9DqOuvy0DvrNcjh+enNBmQc7TpNuaP9h+Q4ccN95nym
    cLO4j7wf8gYaetXfn+fQzyAOWs8bQ3Fn4XUCN89eSjx/bYd2eHLsODDz0E3yObmk
    oP2ILlzCdUwMYYC5zP56EwnDzXprLYm2FEibo9nBZZpPpzQRcUo7UhX80LIxCbWc
    abqi0zn/HtYhjEhjavsHNrdvZOkHO3peforzSaXr1rfvDTJ/Ta1WHNPcuAWFL/lB
    8N6Obgn3l0hg9W2kaOHbG77GGtLetZd/LSQuVs6BYGMrx5m+UUDtrvbYTKTiA7DA
    6ZbqK4+gIIhU3ahgz4xc/czzsOKU+RUHQhrW05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519988329; bh=6TX2n9gnb/PPvprUuE86LCZ+f6HQ0NtLqURTvx
    6HMZc=; b=BmB08HKaXFu7wW0K9e93T6XaHOLBvJIIrWx5rqFYm5rcS4FVaEjsT8
    7hHZXJ18EBn1WSrv/Amxqtpx9Ryd5oQe8/I6pp7PV0j3q2pPBKGAFAyGuXpp8cNj
    IPNBkOjbA0+CS02eK54bu9GT6iAs8xd0iEn6gt73LRDNE+X8jfKkQ27W1C0H+dRM
    9Ymn5ZakZo5xXuOanSWm88NcwhHcWlyA8wl/GLwpOpyi1akneaJyH1ixH6SkQfjC
    k6qtRM1dL3hGtN/VDICjdbeYo9VlTcrVmTFMFmb/gjPbsp4tswYW3g2bDhHghgVa
    KbacOFlaTWf0tepRMaAHMuu6028Dy3qw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mJT8fEQK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mJT8fEQK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423817AbeCBK6I (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:58:08 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:42560 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426607AbeCBKyw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 05:54:52 -0500
X-Google-Smtp-Source: AG47ELtncbj8kOIpAac9FYDa/C0sa4JFrwX9DOY4256+9I8QDn7sOLB0LOWFTv3fifadat4JqZ5F8vJsh580bOcyxzM=
MIME-Version: 1.0
In-Reply-To: <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz> <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
 <20180301152729.GM15057@dhcp22.suse.cz> <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
From: Daniel Vacek <neelx@redhat.com>
Date: Fri, 2 Mar 2018 11:54:51 +0100
Message-ID: <CACjP9X9BVmr0wkrS5=oruQJFEs0ip7VFvD8rdWSZFcoYyiYB5A@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Michal Hocko <mhocko@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 5:20 PM, Daniel Vacek <neelx@redhat.com> wrote:
> On Thu, Mar 1, 2018 at 4:27 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> It is still not clear why not to do the alignment in
>> memblock_next_valid_pfn rather than its caller.
>
> As it's the mem init which needs it to be aligned. Other callers may
> not, possibly?
> Not that there are any other callers at the moment so it really does
> not matter where it is placed. The only difference would be the end of
> the loop with end_pfn vs aligned end_pfn. And it looks like the pure
> (unaligned) end_pfn would be preferred here. Wanna me send a v2?

Thinking about it again memblock has nothing to do with pageblock. And
the function name suggests one shall get a next valid pfn, not
something totally unrelated to memblock. So that's what it returns.
It's the mem init which needs to align this and hence mem init aligns
it for it's purposes. I'd call this the correct design.

To deal with the end_pfn special case I'd actually get rid of it
completely and hardcode -1UL as max pfn instead (rather than 0).
Caller should handle max pfn as an error or end of the loop as here in
this case.

I'll send a v2 with this implemented.

Paul> Why is it based on memblock actually? Wouldn't a generic
mem_section solution work satisfiable for you? That would be natively
aligned with whole section (doing a bit more work as a result in the
end) and also independent of CONFIG_HAVE_MEMBLOCK_NODE_MAP
availability.

>> --
>> Michal Hocko
>> SUSE Labs
