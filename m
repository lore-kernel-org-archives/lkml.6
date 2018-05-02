Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeEBIIv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:08:51 -0400
Received: from mail.netline.ch ([148.251.143.178]:56977 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBIIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:08:47 -0400
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
 <CAKb7UvibaW0d3H++c4dMFgeXQUYTMVFhi1qO=5W-NFbDWVDT2w@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <d3fdbdd3-cbc8-449d-d589-e1eb0bffafb2@daenzer.net>
Date: Wed, 2 May 2018 10:08:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKb7UvibaW0d3H++c4dMFgeXQUYTMVFhi1qO=5W-NFbDWVDT2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-29 01:56 AM, Ilia Mirkin wrote:
> On Sat, Apr 28, 2018 at 7:02 PM, Michel Dänzer <michel@daenzer.net> wrote:
>>
>> Unfortunately, there was an swiotlb regression (not directly related to
>> Christian's work) shortly after this fix, also in 4.16-rc1, which is now
>> fixed in 4.17-rc1 and will be backported to 4.16.y.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.16.5&id=2c9dacf5bfe1e45d96dfe97cb71d2b717786a7b9
> 
> This guy? Didn't help. I'm running 4.16.4 right now.

Try https://patchwork.freedesktop.org/patch/219765/ .


>>> We now have *two* broken releases, v4.15 and v4.16 (anything that
>>> spews error messages and stack traces ad-infinitum in dmesg is, by
>>> definition, broken).
>>
>> I haven't seen any evidence that there's still an issue in 4.15, is
>> there any?
> 
> Well, I did have a late 4.15 rc kernel in addition to the 'suppress
> warning' patch. Now I'm questioning my memory of whether the issue was
> resolved there or not. I'm pretty sure that 'not', but no longer 100%.

It seems pretty clear it is in fact resolved in 4.15. Even if it indeed
wasn't for you, did you expect us to find out by monitoring you on IRC 24/7?


> As a user who is not in a position to debug this directly due to lack
> of time and knowledge, [...]

I have plenty of other things to do other than looking into this and
coming up with the fix above as well, and I'm no more knowledgeable
about the SWIOTLB code than you.

Anyway, nobody can track down every problem they run into. But let me
kindly ask you to more carefully look at the information available
before deciding which tree to bark up in the future.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
