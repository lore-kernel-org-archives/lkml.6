Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966568AbeEJRBh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 13:01:37 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34170 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966267AbeEJRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 13:01:35 -0400
X-Google-Smtp-Source: AB8JxZoswo5l+oI0bqzDeSNdtMKScieWrtHsf/+2RzwIcb6wfIgTHmlVB/xeeds8tQwH/+HTZxKHsQ==
Subject: Re: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
To: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org, alex_gagniuc@dellteam.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org
References: <20180510164645.19559-1-mr.nuke.me@gmail.com>
 <20180510170038.GA4556@localhost.localdomain>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <5ca7d8f1-d983-0379-b98f-2d5bb17e0a85@gmail.com>
Date: Thu, 10 May 2018 12:01:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180510170038.GA4556@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2018 12:00 PM, Keith Busch wrote:
> On Thu, May 10, 2018 at 11:46:33AM -0500, Alexandru Gagniuc wrote:
>> This patch started as a challenge from Keith relating to code
>> structuring with goto vs return. I think the final result improves
>> readability on two counts:
>> First, it clarifies the separation between work struct and nvme_dev.
>> Second, it makes it clearer what error is being passed on:
>> 'return -ENODEV' vs 'goto out', where 'result' happens to be -ENODEV
>>
>> CC: Keith Busch <keith.busch@intel.com>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> Ah, that's just wrapping a function that has a single out. The challenge
> is to find a better mechanism than 'goto' to unwind a failure that has
> multiple outs, like nvme_probe().

The same principle applies there too. It might have to be wrapped in
several chunks, and it will likely be more readable. Am I supposed to
bite and refactor that too?

Alex
