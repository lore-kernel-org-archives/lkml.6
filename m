Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966079AbeEJObi convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965516AbeEJObg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:31:36 -0400
Date: Thu, 10 May 2018 10:31:36 -0400 (EDT)
From: Jerome Glisse <jglisse@redhat.com>
To: Mike Galbraith <efault@gmx.de>
Cc: nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>
Message-ID: <474293973.18773550.1525962696189.JavaMail.zimbra@redhat.com>
In-Reply-To: <1525943427.8013.11.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
Subject: Re: [Nouveau] kernel spew from nouveau/ swiotlb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.10.124.156, 10.4.195.27]
Thread-Topic: kernel spew from nouveau/ swiotlb
Thread-Index: 74MORyPBTRtlaOhpmhaDpIhmgrEWRQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Greetings,
> 
> When box is earning its keep, nouveau/swiotlb grumble.. a LOT.  The
> below is from master.today.
> 
> [12594.640959] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12594.693000] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12594.713787] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12594.743413] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12594.796740] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12607.000774] swiotlb_tbl_map_single: 54 callbacks suppressed
> [12607.000776] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12607.347941] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> [12608.677038] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152
> bytes)
> homer:/novell/ssh # dmesg|grep 'swiotlb buffer is full'|wc -l
> 2052
> homer:/novell/ssh # dmesg|grep 'callbacks suppressed'|wc -l
> 171
> 
> lib/swiotlb.c:
>  573 not_found:
>  574         spin_unlock_irqrestore(&io_tlb_lock, flags);
>  575         if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  576                 dev_warn(hwdev, "swiotlb buffer is full (sz: %zd
>  bytes)\n", size);
> 
> Does nouveau perhaps want one of those DMA_ATTR_NO_WARN thingies?
> 

Could you bisect ? I would love to point finger upstream to the DMA
folk who made changes to that API without testing with GPU.

Cheers,
Jérôme
