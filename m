Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeDLSr7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:47:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37061 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeDLSr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:47:57 -0400
X-Google-Smtp-Source: AIpwx48S5SIzqOIckvuka6bEe/6Nheuyf5opLLaWhoWEywW5uCO560FB8MdUNKQ348aQ0v9O6+p7qg==
Subject: Re: [PATCH] rapidio: fix rio_dma_transfer error handling
To: Ioan Nicu <ioan.nicu.ext@nokia.com>, Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
References: <20180412150605.GA31409@nokia.com>
From: Alexandre Bounine <alex.bou9@gmail.com>
Message-ID: <933db59f-c28d-fb2c-9423-08828621de7a@gmail.com>
Date: Thu, 12 Apr 2018 14:47:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412150605.GA31409@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-12 11:06 AM, Ioan Nicu wrote:
> Some of the mport_dma_req structure members were initialized late
> inside the do_dma_request() function, just before submitting the
> request to the dma engine. But we have some error branches before
> that. In case of such an error, the code would return on the error
> path and trigger the calling of dma_req_free() with a req structure
> which is not completely initialized. This causes a NULL pointer
> dereference in dma_req_free().
> 
> This patch fixes these error branches by making sure that all
> necessary mport_dma_req structure members are initialized in
> rio_dma_transfer() immediately after the request structure gets
> allocated.
> 
> Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
Acked-by: Alexandre Bounine <alex.bou9@gmail.com>
