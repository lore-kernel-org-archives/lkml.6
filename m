Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934064AbeCGRKk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:10:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933775AbeCGRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:10:36 -0500
X-Google-Smtp-Source: AG47ELtf+h9LUhy1VDky+K9+VEi/a7AipJjHngoMmS5TFId+lUdv0xsrQ8GzbbRhIiVR6aVhyEKJJA==
Subject: Re: [PATCH 4/6] lib/scatterlist: Unexport some trivial wrappers
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-5-tvrtko.ursulin@linux.intel.com>
 <1520439540.2890.19.camel@wdc.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <c5784bb7-bf6f-74d4-e3a2-87b78b6fcfbb@ursulin.net>
Date: Wed, 7 Mar 2018 17:10:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520439540.2890.19.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/03/18 16:19, Bart Van Assche wrote:
> On Wed, 2018-03-07 at 12:47 +0000, Tvrtko Ursulin wrote:
>> Save some kernel size by moving trivial wrappers to header as static
>> inline instead of exporting symbols for them.
> 
> Something that you may be unaware of is that the introduction of the sgl
> helper functions is only a first step. The next step will be to introduce
> a caching allocator for sg-lists. So for small sg-lists inlining won't
> help performance. But moving these definitions from a .c file into a .h
> file will (slightly) slow down kernel compilation. So I'd prefer that you
> drop this patch.

Question is how will the future work influence these trivial wrappers?

I wasn't suggesting I removed them for performance reasons, but just 
because they are really trivial and so there is no need right now to 
have them as exported symbols.

And actually in one of the earlier work I did in lib/scatterlist.c 
Andrew Morton complained a bit to the prevalence of these trivial 
wrappers. So I even had plans to remove some of the existing ones but 
never got round to it.

Regards,

Tvrtko
