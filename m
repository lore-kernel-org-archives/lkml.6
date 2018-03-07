Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933741AbeCGRbZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:31:25 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36752 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933533AbeCGRbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:31:14 -0500
X-Google-Smtp-Source: AG47ELuxwcfoHSJ6CQFSBjFHrZzC5a4vV2kdYvRKX7p/ca0hlvdCZUYnJUKDuzx8yybtWsQSxKcE9A==
Subject: Re: [PATCH 2/6] lib/scatterlist: Skip requesting zeroed allocations
 in sgl_alloc_order
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-3-tvrtko.ursulin@linux.intel.com>
 <CAHp75VeF-qVGVxzrc8w-Cg58msn4TF1GYFzsOuQ_+0QZV1PfGQ@mail.gmail.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <90d6f5e3-7480-46a9-8803-12ffe7db4343@ursulin.net>
Date: Wed, 7 Mar 2018 17:31:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeF-qVGVxzrc8w-Cg58msn4TF1GYFzsOuQ_+0QZV1PfGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/03/18 15:35, Andy Shevchenko wrote:
> On Wed, Mar 7, 2018 at 2:47 PM, Tvrtko Ursulin <tursulin@ursulin.net> wrote:
> 
>> +       sgl = kmalloc_array(nent, sizeof(struct scatterlist), (gfp & ~GFP_DMA));
> 
> The parens now become redundant.

True thanks! I am also not sure that re-using the same gfp_t for 
metadata is backing store is the right approach. At least I think 
__GFP_HIGHMEM needs also to be cleared for kmalloc.

Regards,

Tvrtko
