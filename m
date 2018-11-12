Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3517C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC90822419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 12:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC90822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeKLWHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 17:07:33 -0500
Received: from mout.gmx.net ([212.227.17.20]:38909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeKLWHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 17:07:32 -0500
Received: from [74.104.183.64] ([74.104.183.64]) by
 msvc-mesg-gmx024.server.lan (via HTTP); Mon, 12 Nov 2018 13:14:14 +0100
MIME-Version: 1.0
Message-ID: <trinity-1cb5fd22-242b-44e5-91dc-fabf1f276bdf-1542024854775@msvc-mesg-gmx024>
From:   "Qian Cai" <cai@gmx.us>
To:     "Marc Zyngier" <marc.zyngier@arm.com>
Cc:     "linux kernel" <linux-kernel@vger.kernel.org>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>, will.deacon@arm.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH] efi: permit calling efi_mem_reserve_persistent from
 atomic context
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Nov 2018 13:14:14 +0100
In-Reply-To: <86muqeelvt.wl-marc.zyngier@arm.com>
References: <20181108180511.30239-1-ard.biesheuvel@linaro.org>
 <trinity-d366cf7f-4a38-4193-a636-b695d34d6c47-1541817914119@msvc-mesg-gmx024>
 <E591C777-E2A6-4624-ABCE-C08251F7484A@gmx.us>
 <86muqeelvt.wl-marc.zyngier@arm.com>
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:mzrsOasURh02jV/blp1hZ68XoBFJhgA59yLr6XppWVjRsfj60IHNLgMJU2cZ3oxRMVY/8
 vCVt/fqCwB1fFmxAoygch1BJ26TL5PQhN6AeR9aC0Kf5J0PMg156b5mxyRZUl/5c7VogZP3qDtOA
 88IPDQOQVo75hb6hsczt0yJAU9sLX5YyZevjMaCHZE0lpWR6lqNEXY5p1T9eYN2ZQf/lA6HebOpR
 WJwHvO0NMJ1LYEgUZMtRv1djpJuCwBb58sZvLmTDQHPOy2x5N55RvF4B9xL8C+ovjxcWde7mFkwM
 A4OixyQq52xqa6QF7QZFlb+
X-UI-Out-Filterresults: notjunk:1;V01:K0:lOldUA8Q+WU=:yKXsOMkUEJMVABah0BpXLn
 Au0nIQiFbGj36odCDR8Hpn/Dyy6zBxh/nn19UVXJ0AjWb6cVh0ZABo9PZyYxVJpFWnHHBRRbl
 UMS8Ybdn2xJbktaXHElOIQGPH0scuTpa2D0j9ccF5DHiZxHEZx69zd8CAnu6D6uVs956Led59
 tCv3qMCR8RT7daksMcSJoQMDSCV3ZvSfMR3JBezFeL3YfUjtYlrLchClKIC2z7id7zaT6atNj
 w39IjaHpDa7mE2ZKvj67fGVAq8kiQqVMrl18wDe+87aGh5HCfsMt7Dg6VYqfpstEvpvMwXJkL
 0QVBW/pC+asYiR0TpW0oDTAKw/WIyu/vvsDR7qNENuZGebFz+Cr688kS2Ls+GR663jIyC3AYq
 Q6l641GVmhcS0FZNdgRupxpsZxZLB+/4tzKJsgSEUIN2qpZ4xtiiRtJZxsFuNOkuWlYKpJITu
 hsauglhNY36SGMGOjdUCqBAu5ToYbfWdcoJA4VprDR9VUpKOkodeyfLmm1kkNeaJdNmUt8UQs
 jx7x9hb6SvRfWhNWCIRmWq+2T8oXG81xaCrLB80FC1jgwupevXaZriS0QKt2OAFiQ4myLHVNk
 WkqS24Jroif9a1tRxIxOvVTG/x7E5nk4rd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/18 at 3:32 AM, Marc Zyngier wrote:

> On Mon, 12 Nov 2018 02:45:48 +0000,
> Qian Cai <cai@gmx.us> wrote:
> > 
> > 
> > 
> > > On Nov 9, 2018, at 9:45 PM, Qian Cai <cai@gmx.us> wrote:
> > > 
> > > 
> > > On 11/8/18 at 1:05 PM, Ard Biesheuvel wrote:
> > > 
> > >> Currently, efi_mem_reserve_persistent() may not be called from atomic
> > >> context, since both the kmalloc() call and the memremap() call may
> > >> sleep.
> > >> 
> > >> The kmalloc() call is easy enough to fix, but the memremap() call
> > >> needs to be moved into an init hook since we cannot control the
> > >> memory allocation behavior of memremap() at the call site.
> > >> 
> > >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > >> ---
> > >> drivers/firmware/efi/efi.c | 31 +++++++++++++++++++------------
> > >> 1 file changed, 19 insertions(+), 12 deletions(-)
> > >> 
> > >> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > >> index 249eb70691b0..cfc876e0b67b 100644
> > >> --- a/drivers/firmware/efi/efi.c
> > >> +++ b/drivers/firmware/efi/efi.c
> > >> @@ -963,36 +963,43 @@ bool efi_is_table_address(unsigned long phys_addr)
> > >> }
> > >> 
> > >> static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
> > >> +static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
> > >> 
> > >> int efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
> > >> {
> > >> -	struct linux_efi_memreserve *rsv, *parent;
> > >> +	struct linux_efi_memreserve *rsv;
> > >> 
> > >> -	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> > >> +	if (!efi_memreserve_root)
> > >> 		return -ENODEV;
> > >> 
> > >> -	rsv = kmalloc(sizeof(*rsv), GFP_KERNEL);
> > >> +	rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);
> > >> 	if (!rsv)
> > >> 		return -ENOMEM;
> > >> 
> > >> -	parent = memremap(efi.mem_reserve, sizeof(*rsv), MEMREMAP_WB);
> > >> -	if (!parent) {
> > >> -		kfree(rsv);
> > >> -		return -ENOMEM;
> > >> -	}
> > >> -
> > >> 	rsv->base = addr;
> > >> 	rsv->size = size;
> > >> 
> > >> 	spin_lock(&efi_mem_reserve_persistent_lock);
> > >> -	rsv->next = parent->next;
> > >> -	parent->next = __pa(rsv);
> > >> +	rsv->next = efi_memreserve_root->next;
> > >> +	efi_memreserve_root->next = __pa(rsv);
> > >> 	spin_unlock(&efi_mem_reserve_persistent_lock);
> > >> 
> > >> -	memunmap(parent);
> > >> +	return 0;
> > >> +}
> > >> 
> > >> +static int __init efi_memreserve_root_init(void)
> > >> +{
> > >> +	if (efi.mem_reserve == EFI_INVALID_TABLE_ADDR)
> > >> +		return -ENODEV;
> > >> +
> > >> +	efi_memreserve_root = memremap(efi.mem_reserve,
> > >> +				       sizeof(*efi_memreserve_root),
> > >> +				       MEMREMAP_WB);
> > >> +	if (!efi_memreserve_root)
> > >> +		return -ENOMEM;
> > >> 	return 0;
> > >> }
> > >> +early_initcall(efi_memreserve_root_init);
> > >> 
> > >> #ifdef CONFIG_KEXEC
> > >> static int update_efi_random_seed(struct notifier_block *nb,
> > >> -- 
> > >> 2.19.1
> > > BTW, I won’t be able to apply this patch on top of this series [1]. After applied that series, the original BUG sleep from atomic is gone as well as two other GIC warnings. Do you think a new patch is needed here?
> > > 
> > > [1] https://www.spinics.net/lists/arm-kernel/msg685751.html
> > OK, I was able to apply this patch on top of latest mainline (ccda4af0f4b9)
> > which also include one patch (1/6) from the above series,
> > 
> > However, the efi-related patches from the series (4/6, 5/6, and 6/6) are no
> > longer able to be cleanly applied. 
> > 
> > As the results, the above patch did fix the original BUG: sleep from atomic,
> > but it introduces 2 new warnings.
> 
> [...]
> 
> These are the warnings you've already reported, aren't they? And we've
> established that if you apply the whole series, everything work as
> intended at least on the GIC side (the timer issue is a different
> story altogether).
> 
> Or am I missing something?
The problem is that I am not able to apply the whole  
series alone on top of the latest mainline (rc2) now to 
verify  it. Also, I won’t be able to apply the series and 
this patch together on top of rc1. There are conflicts 
between this patch and 4-6 of the series.

Originally, I said those GIC warnings are gone when
testing rc1 + the series, but I am not sure if it is just
dumb luck that also fix BUG: sleep from atomic. Make
sense?
