Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeEKHOG convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 03:14:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:41849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeEKHOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 03:14:05 -0400
Message-ID: <1526022830.6288.3.camel@gmx.de>
Subject: Re: kernel spew from nouveau/ swiotlb
From: Mike Galbraith <efault@gmx.de>
To: nouveau <nouveau@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, Christoph Hellwig <hch@lst.de>
Date: Fri, 11 May 2018 09:13:50 +0200
In-Reply-To: <1525948096.29445.4.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
         <1525948096.29445.4.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:TfLmtzf/9EXSGYv41bUv4Ek8hktFDG8uMQyCKDrNSyZ0sSpMYKH
 EwcB3JCUW/XDqyzsXgFxjvNF9F3GSiISX/LVBA0KjppeirzMa974PYu7LCgzcGLykL7cNXh
 qXm0XIquWRLhZsoc0lKB+/TOeYWpzR1xtpuHokYaa9Fj0KPIKwOMS7lA9WAXaCFGSrPaUwB
 Zfya1pnDSl0S+olC2DDig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bcFGEiCjmqM=:TDB2jK160VoRw7rIsTLYo2
 Zn5UduA7haiGji74NE7A3g5QojIQO4GbsGKOLhDew4J8gwXzJnXABM0ZI8KtmWO1eX2AGTp+n
 dsjcJX0f2Ev8PwKy3a3qsT5ZG8PbGnPuN4Vp76GZqSnTuv3Ig9qlKMLq2yjF5rl3daFTJqQeX
 HX5vtrT/R7JXW1Kovrty9KuNv9HNzVFGjk/BGNPtrI7bU3RJkttODVCZNwjHOgtKe8lLsN9vS
 WiWOoFxRXb3jHwc2LrAJV/XiCBTXkb9y7mlN9RUWJQMrpgKg/nwxhOB/ymzyMCkwG11z80vy/
 rCxy4S9jx2li81B7QRkXB3zBYaFZtR8nG76aKIejGN2nvjNQAaWuRm7+k/Voz0sg2Xkzod0ZL
 JyuJejCXB7gqJI4ax0Qbcxc1EDzkomu4ihxAJ8kHp3xLqDKofKXJIkkFwUIUzGJXaKEAp8fCa
 QDM2npryHRi1H/ZZE5fmsqf0dvHCZG4slh+GfQMkU0jEWiMVQJ0okLKvkYp0mzAv8zzhZtJR1
 xTOOBnoyNcBfcx/Z+UEwD8QbkX+QVjzQK1Y1IeQ95ihhCZ0sxKtxxTHQfu5tVoJlS8oGyZTOq
 aq63/f7TALioakOvOug6ug4KWQ9QcpcxZ7cTgOrypHdeIS/nHM2ljKYYbXYbDia/zD5Ws5mbQ
 KGt786Y9KDUccThNpyrnP5eK7LzXGynQ3jDDOTFue87tXbIysXZVsMtFpNS/OmrIHx4BAWblc
 oLGhcTrYENLFJDRPWt0QuAgWuLX0bEsmGstqqQzVy6fv1jWPUElrscHB9ljL43PvAHd+Ltj8n
 PP5Preu
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 12:28 +0200, Mike Galbraith wrote:
> On Thu, 2018-05-10 at 11:10 +0200, Mike Galbraith wrote:
> > Greetings,
> > 
> > When box is earning its keep, nouveau/swiotlb grumble.. a LOT.  The
> > below is from master.today.
> > 
> > [12594.640959] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12594.693000] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12594.713787] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12594.743413] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12594.796740] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12607.000774] swiotlb_tbl_map_single: 54 callbacks suppressed
> > [12607.000776] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12607.347941] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > [12608.677038] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> > homer:/novell/ssh # dmesg|grep 'swiotlb buffer is full'|wc -l
> > 2052
> > homer:/novell/ssh # dmesg|grep 'callbacks suppressed'|wc -l
> > 171
> > 
> > lib/swiotlb.c:
> >  573 not_found:
> >  574         spin_unlock_irqrestore(&io_tlb_lock, flags);
> >  575         if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
> >  576                 dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> > 
> > Does nouveau perhaps want one of those DMA_ATTR_NO_WARN thingies?
> 
> Or should ttm perhaps always use the one on hand?  (seems to work)

No it didn't, I just didn't wait long enough for spew to start...

> ---
>  drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -342,7 +342,7 @@ static struct dma_page *__ttm_dma_alloc_
>  	if (!d_page)
>  		return NULL;
>  
> -	if (pool->type & IS_HUGE)
> +	if (1 || pool->type & IS_HUGE)
>  		attrs = DMA_ATTR_NO_WARN;
>  
>  	vaddr = dma_alloc_attrs(pool->dev, pool->size, &d_page->dma,

While IS_HUGE is indeed false on my box, it just doesn't matter,
because when we get to either the old or the new alloc(), it calls
swiotlb_alloc_buffer(), which drops attrs passed to it on the floor,
making it unlikely that alloc() caller wishes are granted.

	-Mike
