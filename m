Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F67C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8203A21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfAKVq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:46:29 -0500
Received: from syrinx.knorrie.org ([82.94.188.77]:43498 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfAKVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:46:27 -0500
Received: from [IPv6:2a01:4f8:1c0c:6c86:6d3:b0ff:febf:d646] (unknown [IPv6:2a01:4f8:1c0c:6c86:6d3:b0ff:febf:d646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id 51C2B34AE1A96;
        Fri, 11 Jan 2019 22:46:23 +0100 (CET)
Subject: Re: [Xen-devel] [PATCH v2] xen: Fix x86 sched_clock() interface for
 xen
From:   Hans van Kranenburg <hans@knorrie.org>
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org
Cc:     sstabellini@kernel.org, stable@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, boris.ostrovsky@oracle.com,
        tglx@linutronix.de
References: <20190111120805.24852-1-jgross@suse.com>
 <74aafdff-c7d5-b9aa-c3fb-3787d36c7bbe@knorrie.org>
 <8ec039c6-d0fc-c7f4-72a4-ae677c9bbb68@suse.com>
 <cceafa86-e7b7-6e8d-851c-1c21ada0f445@knorrie.org>
Openpgp: preference=signencrypt
Autocrypt: addr=hans@knorrie.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e4dde9d7-6f4d-c219-41e7-49ce2bded907@knorrie.org>
Date:   Fri, 11 Jan 2019 22:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <cceafa86-e7b7-6e8d-851c-1c21ada0f445@knorrie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en_US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 4:57 PM, Hans van Kranenburg wrote:
> On 1/11/19 3:01 PM, Juergen Gross wrote:
>> On 11/01/2019 14:12, Hans van Kranenburg wrote:
>>> Hi,
>>>
>>> On 1/11/19 1:08 PM, Juergen Gross wrote:
>>>> Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
>>>> sched_clock() interface") broke Xen guest time handling across
>>>> migration:
>>>>
>>>> [  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
>>>> [  187.251137] OOM killer disabled.
>>>> [  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
>>>> [  187.252299] suspending xenstore...
>>>> [  187.266987] xen:grant_table: Grant tables using version 1 layout
>>>> [18446743811.706476] OOM killer enabled.
>>>> [18446743811.706478] Restarting tasks ... done.
>>>> [18446743811.720505] Setting capacity to 16777216
>>>>
>>>> Fix that by setting xen_sched_clock_offset at resume time to ensure a
>>>> monotonic clock value.
>>>>
>>>> [...]
>>>
>>> I'm throwing around a PV domU over a bunch of test servers with live
>>> migrate now, and in between the kernel logging, I'm seeing this:
>>>
>>> [Fri Jan 11 13:58:42 2019] Freezing user space processes ... (elapsed
>>> 0.002 seconds) done.
>>> [Fri Jan 11 13:58:42 2019] OOM killer disabled.
>>> [Fri Jan 11 13:58:42 2019] Freezing remaining freezable tasks ...
>>> (elapsed 0.000 seconds) done.
>>> [Fri Jan 11 13:58:42 2019] suspending xenstore...
>>> [Fri Jan 11 13:58:42 2019] ------------[ cut here ]------------
>>> [Fri Jan 11 13:58:42 2019] Current state: 1
>>> [Fri Jan 11 13:58:42 2019] WARNING: CPU: 3 PID: 0 at
>>> kernel/time/clockevents.c:133 clockevents_switch_state+0x48/0xe0
>>> [...]
>>>
>>> This always happens on every *first* live migrate that I do after
>>> starting the domU.
>>
>> Yeah, its a WARN_ONCE().

Ok, false alarm. It's there, but not caused by this patch.

I changed the WARN_ONCE to WARN for funs, and now I get it a lot more
already (v2):

https://paste.debian.net/plainh/d535a379

>> And you didn't see it with v1 of the patch?
> 
> No.

I was wrong. I tried a bit more, and I can also reproduce without v1 or
v2 patch at all, and I can reproduce it with v4.19.9. Just sometimes
needs a dozen times more live migrating it before it shows up.

I cannot make it happen to show up with the Debian 4.19.9 distro kernel,
that's why it was new for me.

So, let's ignore it in this thread now.

>> On the first glance this might be another bug just being exposed by
>> my patch.
>>
>> I'm investigating further, but this might take some time. Could you
>> meanwhile verify the same happens with kernel 5.0-rc1? That was the
>> one I tested with and I didn't spot that WARN.
> 
> I have Linux 5.0-rc1 with v2 on top now, which gives me this on live
> migrate:
> 
> [...]
> [   51.871076] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000098
> [   51.871091] #PF error: [normal kernel read fault]
> [   51.871100] PGD 0 P4D 0
> [   51.871109] Oops: 0000 [#1] SMP NOPTI
> [   51.871117] CPU: 0 PID: 36 Comm: xenwatch Not tainted 5.0.0-rc1 #1
> [   51.871132] RIP: e030:blk_mq_map_swqueue+0x103/0x270
> [...]

Dunno about all the 5.0-rc1 crashes yet. I can provide more feedback
about that if you want, but not in here I presume.

Hans
