Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9E5C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6176421E25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6176421E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeGGM10 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:27:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:36935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932205AbeGGM1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:27:25 -0400
Received: from homer.simpson.net ([188.174.241.183]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0La3c1-1gNBoU3E2H-00lkog; Sat, 07
 Jul 2018 14:26:43 +0200
Message-ID: <1530966399.4714.9.camel@gmx.de>
Subject: Re: [PATCH 5/7] x86,tlb: only send page table free TLB flush to
 lazy TLB CPUs
From:   Mike Galbraith <efault@gmx.de>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sat, 07 Jul 2018 14:26:39 +0200
In-Reply-To: <20180629142918.26601-6-riel@surriel.com>
References: <20180629142918.26601-1-riel@surriel.com>
         <20180629142918.26601-6-riel@surriel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2nYmIBTCYh23h9po6NEMBxTjPv6xYHlw+Xx9DNTLomr0MdMW+sE
 cX176drEUiEc9h8yt+ElAIk9j6LUFBmYkmQf9XVAujV6u7OuGQP45sp0e1KAvG8Iv829VTl
 xLSwPHZRcZBydFwSNHpcwiErcYzoKNZIDDTC6EJQstY0/xbnE9l/W53obSkRlW+tZjr253B
 NBl7vL6P3z4UsQbeBe0LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r8vcEORn5Jw=:b/gBLF5f9CO9MNyecHrvui
 KsECHVvbRUar4yfUdu/gSALE+HHhLntns8Ybh58Q9bJqu4VS+gECbPfqwvgchFYmkQV4sbCNx
 NJxhpNPYvFcWhWNRfTWgWyWK85zAOdD7IOmxs0TDbOeQUs6YdE7oQHA+jBDJd6ztSUJDnG9NC
 KCNahZMOR9eKsYMhgrvLl13zCrYiMaHdlk2TB/sgt8TvqTLquE+yCwzdFVHSRAFHNX2jVVmov
 uQ0VKvs5IpKD54U5+nIUjxlDAbq9C8k6kPriktiBE8m4aMxk8xD4rZwNO09E8qSUJHli7ICb0
 wTmRRd2n+0qblcN4uJXGvQ5dWmahsbIqbQNHrGa5qYA5+9U7ZFsSknKaioxjrib0cSai/q6Sl
 5X9qRYt0w3v4QGEqEiMvUeyMPI6qga44ZuMvfq1qaniWcL1EpMtwrAodM3fpNrEnCGExnS5lH
 W2NWdqgOseXchqs9Y+da510jnMKPWPdNhIswZOYYNlVBlOhmRpu6/UcQN+C5xZbgrI3ciN4tj
 nIbGM+rhJdGxBRupKFrCzWmsHo9Ifxu11j9hBMKRwcWu3G20Ep13FOo3j2Ds7H1GG686Fva72
 53ROSo4A9F3Wef/DYemyXszyIPRsAk3xhYCarPt7cUrx2YYCffT3/5FXhX33LhW4VZb65CXZM
 yEZU4QnejBQWOfowXYjUdYzyGFYdZrW/vFK2Z0xvnTh/OPjJBfBWyiV6m221dbEopjVNjN7TV
 b5W3Sp8SiTaS8lEiAooflUupT4vbRmGp/O7BA/rJPNwHa9RhjtKgyt8ZSOIsCUW+BtuY/PwhJ
 DxE1xFm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-29 at 10:29 -0400, Rik van Riel wrote:
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e59214ec52b1..c4073367219d 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -718,14 +718,47 @@ void tlb_flush_remove_tables_local(void *arg)
>  	}
>  }
>  
> +static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
> +				      struct cpumask* lazy_cpus)
> +{
> +	int cpu;
> +
> +	for_each_cpu(cpu, mm_cpumask(mm)) {
> +		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
> +			cpumask_set_cpu(cpu, lazy_cpus);
> +	}
> +}
> +
>  void tlb_flush_remove_tables(struct mm_struct *mm)
>  {
>  	int cpu = get_cpu();
> +	cpumask_var_t lazy_cpus;
> +
> +	if (cpumask_any_but(mm_cpumask(mm), cpu) >= nr_cpu_ids)
> +		return;

A put_cpu() went missing.

> +
> +	if (!zalloc_cpumask_var(&lazy_cpus, GFP_ATOMIC)) {
> +		/*
> +		 * If the cpumask allocation fails, do a brute force flush
> +		 * on all the CPUs that have this mm loaded.
> +		 */
> +		smp_call_function_many(mm_cpumask(mm),
> +				tlb_flush_remove_tables_local, (void *)mm, 1);
> +		return;
> +	}

Ditto.

	-Mike
