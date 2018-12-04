Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85095C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7BC20878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7BC20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLDJWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:22:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:56140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725770AbeLDJWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:22:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7D97B030;
        Tue,  4 Dec 2018 09:22:27 +0000 (UTC)
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
References: <20181127205737.GI16136@redhat.com>
 <87tvk1yjkp.fsf@yhuang-dev.intel.com>
 <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com>
 <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCWi/zTwUJBbOLuQAKCRAiT6fnzIKm
 ZIpED/4jRN/6LKZZIT4R2xoou0nJkBGVA3nfb+mUMgi3uwn/zC+o6jjc3ShmP0LQ0cdeuSt/
 t2ytstnuARTFVqZT4/IYzZgBsLM8ODFY5vGfPw00tsZMIfFuVPQX3xs0XgLEHw7/1ZCVyJVr
 mTzYmV3JruwhMdUvIzwoZ/LXjPiEx1MRdUQYHAWwUfsl8lUZeu2QShL3KubR1eH6lUWN2M7t
 VcokLsnGg4LTajZzZfq2NqCKEQMY3JkAmOu/ooPTrfHCJYMF/5dpi8YF1CkQF/PVbnYbPUuh
 dRM0m3NzPtn5DdyfFltJ7fobGR039+zoCo6dFF9fPltwcyLlt1gaItfX5yNbOjX3aJSHY2Vc
 A5T+XAVC2sCwj0lHvgGDz/dTsMM9Ob/6rRJANlJPRWGYk3WVWnbgW8UejCWtn1FkiY/L/4qJ
 UsqkId8NkkVdVAenCcHQmOGjRQYTpe6Cf4aQ4HGNDeWEm3H8Uq9vmHhXXcPLkxBLRbGDSHyq
 vUBVaK+dAwAsXn/5PlGxw1cWtur1ep7RDgG3vVQDhIOpAXAg6HULjcbWpBEFaoH720oyGmO5
 kV+yHciYO3nPzz/CZJzP5Ki7Q1zqBb/U6gib2at5Ycvews+vTueYO+rOb9sfD8BFTK386LUK
 uce7E38owtgo/V2GV4LMWqVOy1xtCB6OAUfnGDU2EM7ATQRbGTU1AQgAn0H6UrFiWcovkh6E
 XVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQLa1PQDUi6j00ChlcR66g9/V0sPIcSutacPKf
 dKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMhFmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCT
 sTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sfbAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZO
 rIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq+aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahK
 tQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4njQARAQABwsF8BBgBCgAmFiEEqUDUNJksLo6Z
 ED1QIk+n58yCpmQFAlsZNTUCGwwFCQPCZwAACgkQIk+n58yCpmQ83g/9Frg1sRMdGPn98zV+
 O2eC3h0p5f/oxxQ8MhG5znwHoW4JDG2TuxfcQuz7X7Dd5JWscjlw4VFJ2DD+IrDAGLHwPhCr
 RyfKalnrbYokvbClM9EuU1oUuh7k+Sg5ECNXEsamW9AiWGCaKWNDdHre3Lf4xl+RJWxghOVW
 RiUdpLA/a3yDvJNVr6rxkDHQ1P24ZZz/VKDyP+6g8aty2aWEU0YFNjI+rqYZb2OppDx6fdma
 YnLDcIfDFnkVlDmpznnGCyEqLLyMS3GH52AH13zMT9L9QYgT303+r6QQpKBIxAwn8Jg8dAlV
 OLhgeHXKr+pOQdFf6iu2sXlUR4MkO/5KWM1K0jFR2ug8Pb3aKOhowVMBT64G0TXhQ/kX4tZ2
 ZF0QZLUCHU3Cigvbu4AWWVMNDEOGD/4sn9OoHxm6J04jLUHFUpFKDcjab4NRNWoHLsuLGjve
 Gdbr2RKO2oJ5qZj81K7os0/5vTAA4qHDP2EETAQcunTn6aPlkUnJ8aw6I1Rwyg7/XsU7gQHF
 IM/cUMuWWm7OUUPtJeR8loxZiZciU7SMvN1/B9ycPMFs/A6EEzyG+2zKryWry8k7G/pcPrFx
 O2PkDPy3YmN1RfpIX2HEmnCEFTTCsKgYORangFu/qOcXvM83N+2viXxG4mjLAMiIml1o2lKV
 cqmP8roqufIAj+Ohhzs=
Message-ID: <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
Date:   Tue, 4 Dec 2018 10:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/18 11:27 PM, Linus Torvalds wrote:
> On Mon, Dec 3, 2018 at 2:04 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> so I think all of David's patch is somewhat sensible, even if that
>> specific "order == pageblock_order" test really looks like it might
>> want to be clarified.
> 
> Side note: I think maybe people should just look at that whole
> compaction logic for that block, because it doesn't make much sense to
> me:
> 
>                 /*
>                  * Checks for costly allocations with __GFP_NORETRY, which
>                  * includes THP page fault allocations
>                  */
>                 if (costly_order && (gfp_mask & __GFP_NORETRY)) {
>                         /*
>                          * If compaction is deferred for high-order allocations,
>                          * it is because sync compaction recently failed. If
>                          * this is the case and the caller requested a THP
>                          * allocation, we do not want to heavily disrupt the
>                          * system, so we fail the allocation instead of entering
>                          * direct reclaim.
>                          */
>                         if (compact_result == COMPACT_DEFERRED)
>                                 goto nopage;
> 
>                         /*
>                          * Looks like reclaim/compaction is worth trying, but
>                          * sync compaction could be very expensive, so keep
>                          * using async compaction.
>                          */
>                         compact_priority = INIT_COMPACT_PRIORITY;
>                 }
> 
> this is where David wants to add *his* odd test, and I think everybody
> looks at that added case
> 
> +                       if (order == pageblock_order &&
> +                                       !(current->flags & PF_KTHREAD))
> +                               goto nopage;
> 
> and just goes "Eww".
> 
> But I think the real problem is that it's the "goto nopage" thing that
> makes _sense_, and the current cases for "let's try compaction" that

More precisely it's "let's try reclaim + compaction".

> are the odd ones, and then David adds one new special case for the
> sensible behavior.
> 
> For example, why would COMPACT_DEFERRED mean "don't bother", but not
> all the other reasons it didn't really make sense?

COMPACT_DEFERRED means that compaction was failing recently, even with
sufficient free pages (e.g. freed by direct reclaim), so it doesn't make
sense to continue.
What are "all the other reasons"? __alloc_pages_direct_compact() could
have also returned COMPACT_SKIPPED, which means compaction actually
didn't happen at all, because there's not enough free pages.

> So does it really make sense to fall through AT ALL to that "retry"
> case, when we explicitly already had (gfp_mask & __GFP_NORETRY)?

Well if there was no free memory to begin with, and thus compaction
returned COMPACT_SKIPPED, then we didn't really "try" anything yet, so
there's nothing to "not retry".

> Maybe the real fix is to instead of adding yet another special case
> for "goto nopage", it should just be unconditional: simply don't try
> to compact large-pages if __GFP_NORETRY was set.

I think that would destroy THP success rates too much, in situations
where reclaim and compaction would succeed, because there's enough
easily reclaimable and migratable memory.

> Hmm? I dunno. Right now - for 4.20, I'd obviously want to keep changes
> smallish, so a hacky added special case might be the right thing to
> do. But the code does look odd, doesn't it?
> 
> I think part of it comes from the fact that we *used* to do the
> compaction first, and then we did the reclaim, and then it was
> re-orghanized to do reclaim first, but it tried to keep semantic
> changes minimal and some of the above comes from that re-org.

IIRC the point of reorg was that in typical case we actually do want to
try the reclaim first (or only), and the exception are those THP-ish
allocations where typically the problem is fragmentation, and not number
of free pages, so we check first if we can defragment the memory or
whether it makes sense to free pages in case the defragmentation is
expected to help afterwards. It seemed better to put this special case
out of the main reclaim/compaction retry-with-increasing-priority loop
for non-costly-order allocations that in general can't fail.

Vlastimil

> I think.
> 
>                 Linus
> 

