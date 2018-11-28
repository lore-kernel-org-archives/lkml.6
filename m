Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D8B2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 04:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeK1PWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:22:32 -0500
Received: from mout.gmx.net ([212.227.17.21]:36253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbeK1PWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 10:22:31 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MHLNn-1gEOp82xgh-00E8Pw; Wed, 28 Nov 2018 05:21:53 +0100
From:   Qian Cai <cai@gmx.us>
Subject: Re: kmemleak: Early log buffer exceeded (525980) during boot
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1541712198.12945.12.camel@gmx.us>
 <D7C9EA14-C812-406F-9570-CFF36F4C3983@gmx.us>
 <20181110165938.lbt6dfamk2ljafcv@localhost>
Message-ID: <a2a9180f-32cf-a0fa-3829-f36133e3b924@gmx.us>
Date:   Tue, 27 Nov 2018 23:21:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181110165938.lbt6dfamk2ljafcv@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:A9U4XCZVDy4Vk907K3Zn6bIvRZ5ylpUUT0wYKWXMHM3gHW3mcCb
 IcgEiPl0WIkJgadbQ9ecTJg6nUUPwBreGjYw+sH7XVC8K7MHMOKnfiUtutc3jYi1bAcRwyH
 z0eBsTt6UjGW3ZDacRqRJYjNlUp5OPIem0o4mqWDaMiM/OQ8TGm6awV3haM5eL5GJgA7u6w
 gCOR8ZMoUk/9teaIMPxsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OrSyPj44jMg=:WHMzUD0CsR6RKKGwmL0mWu
 /W+OQmdoR7ZDMZ2vMPp/kiPKcXLKeYy9samaio0qJ+GrTciLcmKSgLM/Bzvfz4EhXrsuruysa
 6exRajD6uSNE6TEG+/BQ4rCNuHBs+UUh8yiSTt8tBYOykUo+Qq8qDBwOyrfqN1G8ekXV3nzJF
 kRPmiKVZJdUN6mNWhz/uN67nl2zswyPYm72xpxJNGNzMXD2iu+OptFh2Y/SMpC+p/AYwlaTjI
 SFe07qyt8Wsd3aIow6N5fc8f3pV+ABgFv6cnjMnBC/gLkJL8G1vR1TLOG9BDSD08gfx45R/7w
 MrYo0/eW8aI0BprZODfIya5VeojPZXo/6eHVr6q72i1x/6hhrV9MCdBnb/5ojERV6VrLPUsIU
 BheS9wLv6vBOoArgf4eEflBu4soiKvjLbs8jQXDDKIHt/ZwpNqboLJGKMVOBQSKBoN16Pkrij
 f01/NDpIrKfzpldj6u5JFDVoa0Ba9/TPh7FarRLOwLQ1WXkrS7ITtITTJDScOlho/KCT3tcH0
 96jRUgh0qKrjTt/F2B7tZoSMEBm/LPntZLVv5Cb2LfRiPFW/pDaRPpQOgz46qtVPhESgL1eqp
 6KUEK9DYgO8vf7py9ERMneXqR660rROkYtCxYlJeC4oEhmUqZjPv67RRLiXU5TqlgDG179/Nl
 ZxUxEYfVUGzx/zhH0pDk6Faf3bInm/PkN/0e7sJys6eBXHOvy5cPixGim0XXq9RKDTJfOYrt7
 ElsbKbXKg8ENuTx0wCj3zLmMb/Xggwvpea23iUMxGrPfC9utplyFXv3kE6JJuJ0Ve3PWsUBou
 TlsnIZhjT8c8FZhVSqS3B8/m99M+tGSJ/cUYmiQSee4XdRY9XrmfpoOpsbyUCBqT6qng034RO
 q1NUcnsKyM+JAsDlE+s4SNNkInFaTRH0lXJzb5k3U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/18 11:59 AM, Catalin Marinas wrote:
> On Sat, Nov 10, 2018 at 10:08:10AM -0500, Qian Cai wrote:
>> On Nov 8, 2018, at 4:23 PM, Qian Cai <cai@gmx.us> wrote:
>>> The maximum value for DEBUG_KMEMLEAK_EARLY_LOG_SIZE is only 40000, so it
>>> disables kmemleak every time on this aarch64 server running the latest mainline
>>> (b00d209).
>>>
>>> # echo scan > /sys/kernel/debug/kmemleak 
>>> -bash: echo: write error: Device or resource busy
>>>
>>> Any idea on how to enable kmemleak there?
>>
>> I have managed to hard-code DEBUG_KMEMLEAK_EARLY_LOG_SIZE to 600000,
> 
> That's quite a high number, I wouldn't have thought it is needed.
> Basically the early log buffer is only used until the slub allocator
> gets initialised and kmemleak_init() is called from start_kernel(). I
> don't know what allocates that much memory so early.
> 

It turned out that kmemleak does not play well with KASAN on those aarch64 (HPE
Apollo 70 and Huawei TaiShan 2280) servers.

After calling start_kernel()->setup_arch()->kasan_init(), kmemleak early log
buffer went from something like from 280 to 260000. The multitude of
kmemleak_alloc() calls is,

for_each_memblock(memory, reg) x \
while (pgdp++, addr = next, addr != end) x \
while (ptep++, addr = next, addr != end && \ pte_none(READ_ONCE(*ptep)))

Is this expected?
