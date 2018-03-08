Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeCHRGl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:06:41 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44017 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeCHRGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:06:39 -0500
X-Google-Smtp-Source: AG47ELt/v6HQIxTVmBHGafB0C5FElfuh6hzqjgY2wFCKyHkIuf+xIPy6CvUG/iAEZ5WbP6UJeYq0Pw==
Subject: Re: [PATCH 6/6] lib/scatterlist: Drop order argument from
 sgl_free_n_order
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "James.Bottomley@HansenPartnership.com"
        <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tvrtko.ursulin@intel.com" <tvrtko.ursulin@intel.com>,
        "hare@suse.com" <hare@suse.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
References: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
 <20180307124712.14963-7-tvrtko.ursulin@linux.intel.com>
 <1520447415.5558.12.camel@HansenPartnership.com>
 <faa56419-bdce-c539-5eee-5e180c62b0a5@ursulin.net>
 <1520524591.2809.0.camel@wdc.com>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <b07f8f6b-4264-d1d1-1e14-b22932130ac4@ursulin.net>
Date: Thu, 8 Mar 2018 17:06:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520524591.2809.0.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/03/18 15:56, Bart Van Assche wrote:
> On Thu, 2018-03-08 at 07:59 +0000, Tvrtko Ursulin wrote:
>> However there is a different bug in my patch relating to the last entry
>> which can have shorter length from the rest. So get_order on the last
>> entry is incorrect - I have to store the deduced order and carry it over.
> 
> Will that work if there is only one entry in the list and if it is a short
> entry?

Yeah, needs more work. I especially don't like that case (as in any 
other with a final short chunk) wasting memory. So it would need more 
refactoring to make it possible.

It did work in my internal tree where sgl_alloc_order was extended to 
become sgl_alloc_order_min_max, and as such uses a smaller order for 
smaller chunks.

This patch can be dropped for now but the earlier ones are still valid I 
think. On those one I think we have some opens on how to proceed so if 
you could reply there, where applicable, that would be great.

Regards,

Tvrtko
