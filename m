Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeD0EL7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 00:11:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44112 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeD0EL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 00:11:58 -0400
X-Google-Smtp-Source: AB8JxZp4BVeRICyzx31EB/0kFol2PW0Az6pwae/OBFgJgqY+SYgkuc8qbhElK44ALx2e6XzWDCBR7A==
Subject: Re: random: GFP_KERNEL from irq context
To: "Theodore Y. Ts'o" <tytso@mit.edu>, jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <c10e7248-4463-59d4-a977-1e4433c7231f@kernel.dk>
 <20180426210357.GF5965@thunk.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <323b0878-1352-90ab-6ada-b686750fd635@kernel.dk>
Date: Thu, 26 Apr 2018 22:11:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180426210357.GF5965@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/18 3:03 PM, Theodore Y. Ts'o wrote:
> On Thu, Apr 26, 2018 at 10:28:13AM -0600, Jens Axboe wrote:
>> during boot. We end up doing the numa_crng_init() from interrupt context, which
>> makes things unhappy since you do GFP_KERNEL | __GFP_NOFAIL allocations from
>> there.
> 
> I've already sent a pull request to Linux to fix this; see the
> random.git tree.
> 
> Apologies for not noticing this earlier.  My test environment had
> virtio-rng enabled by default, and while I did test the CONFIG_NUMA
> case, the call to add randomness doesn't happen from interrupt context
> with virtio-rng so I missed it in my testing.

OK, all good, just wanted to ensure it was known.

-- 
Jens Axboe
