Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1873148-1520004463-2-5759267072098538084
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
    t=1520004463; b=aleU0zbkNJd0NaCHRnNB08eDrUjLLqVkEk441mBQ3O2v0l9
    I5AIuIAdXVrWj/BXLd/lIlh9PD2/vAr7+oTQ+zJWcpc3LLMcG880MPUSW9JfDrDi
    y4foMpSdMmFa5gZPEtJL/3J2baifQyy41Z90eiIAmwp1BzROYR7svyrLFk2ZL6e5
    VFZ6JuPCQNMG/jxOKTuzv5e4KdxRT7BSQuvYEORlgo9ChsQnYwNq1Bu3KRBsIV2t
    I5qum0p6Z5M3M3+Ec7etNV1AUxdJLLBs9l6fQJaxJTiSB7bh8xukK/5YVQ7ciuUN
    N1uKc7e213SXnHX9RQZw5gfPMbY9P/WnRqlGGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520004463; bh=JcmI8BkykKGCLrn8W4nkDcltIF0XvspMtX9hjI
    NMuRI=; b=aClHeqONkiGDVvG8uYIOBDFaiQ8yr+TR/AcRKG/Km2ldCAdAC1rtbG
    26WTz2fwS9hHYu64yIC9mqETyVO52BH3lVDhSsqOT9Oj5g8YiqISfuAQ5U3p5jrf
    v9HmRvgb1Ror8W4N8aykQOMa2+CWGMaf+FjRSagpbwZqBwS8TQsIBkBOXAtG3Hn0
    hD1bQ+Znn6L1ezPc5Lq0kc7ajaW7AfcMM6n8/xUsVuyJsY9w/KPppZ6g5329nNR6
    GX2lNWbDxom9eRMSkGWE8oJk3mWB0RwLltrXSwC0ogw226OsZt7HoPmNJdtj6KuR
    d2qcwteAMc0+BnIDcgunO3AoORnzVB1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qCLDg9O0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qCLDg9O0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427780AbeCBP13 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 10:27:29 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:40473 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427701AbeCBP1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 10:27:24 -0500
X-Google-Smtp-Source: AG47ELsKb7r99rfH7mMJwlnCtloOZS5tzKCJZ1M1G1s36TAKSuq+UerRHI0poV77YT0Z+cq/XmdBPSM18HWXdsoaGBM=
MIME-Version: 1.0
In-Reply-To: <20180302130052.GN15057@dhcp22.suse.cz>
References: <1519908465-12328-1-git-send-email-neelx@redhat.com>
 <20180301131033.GH15057@dhcp22.suse.cz> <CACjP9X-S=OgmUw-WyyH971_GREn1WzrG3aeGkKLyR1bO4_pWPA@mail.gmail.com>
 <20180301152729.GM15057@dhcp22.suse.cz> <CACjP9X8hFDhkKUHRu2K5WgEp9YFHh2=vMSyM6KkZ5UZtxs7k-w@mail.gmail.com>
 <20180302130052.GN15057@dhcp22.suse.cz>
From: Daniel Vacek <neelx@redhat.com>
Date: Fri, 2 Mar 2018 16:27:23 +0100
Message-ID: <CACjP9X-Ew1mcTOCmfB+eTap0dZV2HVk9pZxuhbpuVPkQVd2nhA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: fix memmap_init_zone pageblock alignment
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Paul Burton <paul.burton@imgtec.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 2, 2018 at 2:01 PM, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 01-03-18 17:20:04, Daniel Vacek wrote:
>> On Thu, Mar 1, 2018 at 4:27 PM, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Thu 01-03-18 16:09:35, Daniel Vacek wrote:
>> > [...]
>> >> $ grep 7b7ff000 /proc/iomem
>> >> 7b7ff000-7b7fffff : System RAM
>> > [...]
>> >> After commit b92df1de5d28 machine eventually crashes with:
>> >>
>> >> BUG at mm/page_alloc.c:1913
>> >>
>> >> >         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
>> >
>> > This is an important information that should be in the changelog.
>>
>> And that's exactly what my seven very first words tried to express in
>> human readable form instead of mechanically pasting the source code. I
>> guess that's a matter of preference. Though I see grepping later can
>> be an issue here.
>
> Do not get me wrong I do not want to nag just for fun of it. The
> changelog should be really clear about the problem. What might be clear
> to you based on the debugging might not be so clear to others. And the
> struct page initialization code is far from trivial especially when we
> have different alignment requirements by the memory model and the page
> allocator.

I get it. I didn't mean to be rude or something. I just thought I
covered all the relevant details..

> Therefore being as clear as possible is really valuable. So I would
> really love to see the changelog to contain.
> - What is going on - VM_BUG_ON in move_freepages along with the crash
>   report

I'll put more details there.

> - memory ranges exported by BIOS/FW

They were not mentioned as they are not really relevant. Any e820 map
can have issues. Now I only saw reports on few selected machines,
mostly LENOVO System x3650 M5, some FUJITSU, some Cisco blades. But
the map is always fairly normal. IIUC, the bug only happens if the
range which is not pageblock aligned happens to be the first one in a
zone or following after an not-populated section.

Again, nothing of that is really relevant. What is is that the commit
b92df1de5d28 changes the way page structures are initialized so that
for some perfectly fine maps from BIOS kernel now can crash as a
result. And my fix tries to keep at least the bare minimum of the
original behavior needed to keep kernel stable.

> - explain why is the pageblock alignment the proper one. How does the
>   range look from the memory section POV (with SPARSEMEM).

The commit message explains that. "the same way as in
move_freepages_block()" to quote myself. The alignment in this
function is the one causing the crash as the VM_BUG_ON() assert in
subsequential move_freepages() is checking the (now) uninitialized
structure. If we follow this alignment the initialization will not get
skipped for that structure. Again, this is partially restoring the
original behavior rather than rewriting move_freepages{,_block} to not
crash with some data it was not designed for.

I'll try to explain this more transparently in commit message.

Alternatively you can just revert the b92df1de5d28. That will fix the
crashes as well.

> - What about those unaligned pages which are not backed by any memory?
>   Are they reserved so that they will never get used?

They are handled the same way as it used to be before b92df1de5d28.
This patch does not change or touch anything with this regards. Or am
I wrong?

> And just to be clear. I am not saying your patch is wrong. It just

You better not. My patch it totally correct :p
(I hope)

> raises more questions than answers and I suspect it just papers over
> some more fundamental problem. I might be clearly wrong and I cannot

I see. Thank you for looking into it. It's appreciated. I would not
call it a fundamental problem, rather a design of
move_freepages{,_block} which I'd vote for keeping for now. Hopefully
I explained it above.

> deserve this more time for the next week because I will be offline

Enjoy your time off.

> but I would _really_ appreciate if this all got explained.

I'll do my best.

> Thanks!
> --
> Michal Hocko
> SUSE Labs
