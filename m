Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeC2Rjx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 13:39:53 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42356 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeC2Rjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 13:39:52 -0400
X-Google-Smtp-Source: AIpwx4+6bmOsYWcEqfnzJF7hP8iC1TwiNIOp7Yz3XOc0cluDzHXk5n71VjXhDq+p0T3AYLYzKgTtBg==
Subject: Re: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for requests
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-5-logang@deltatee.com>
 <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com>
 <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <aef7b203-a16b-738f-4ca2-d50768d70ca0@broadcom.com>
Date: Thu, 29 Mar 2018 10:39:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 10:02 AM, Logan Gunthorpe wrote:
> Per the bug in the previous patch, I don't think that was ever a valid
> assumption. It doesn't have anything to do with the sgl_alloc change
> either. The dma_map interface is allowed to merge SGLs and that's why it
> can return fewer nents than it was passed. I'm not sure how many or
> which DMA ops actually do this which is why it hasn't actually
> manifested itself as a bug; but it is part of how the interface is
> specified to work.

Argh.. yep. I'll have to correct that assumption. The bug would have 
only shown up on i/o sizes beyond a particular length.

>
> I think we need to store the sg_map_cnt separately and use it instead of
> the calculation based on the transfer length. But this is really a fix
> that should be rolled in with the previous patch. If you can point me to
> where this needs to change I can update my patch, or if you want to fix
> it yourself go ahead.
I'll fix it as it's part of the assumption fix.

With the nulling/zeroing, I'm good with your patch.

-- james.
