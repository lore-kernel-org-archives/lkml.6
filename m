Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF6C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD65214FE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD65214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeGGNkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 09:40:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:53239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752468AbeGGNkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 09:40:41 -0400
Received: from homer.simpson.net ([188.174.241.183]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MZkv0-1fNzPp3Yr8-00LW7Q; Sat, 07
 Jul 2018 15:39:47 +0200
Message-ID: <1530970783.4714.11.camel@gmx.de>
Subject: Re: [PATCH 5/7] x86,tlb: only send page table free TLB flush to
 lazy TLB CPUs
From:   Mike Galbraith <efault@gmx.de>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        songliubraving@fb.com, hpa@zytor.com
Date:   Sat, 07 Jul 2018 15:39:43 +0200
In-Reply-To: <1530966399.4714.9.camel@gmx.de>
References: <20180629142918.26601-1-riel@surriel.com>
         <20180629142918.26601-6-riel@surriel.com> <1530966399.4714.9.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NRXG5HqOZWN2G+wPlXX2p8KWz2RAiULNP+bfyz5o5+ru57N9SDt
 AuMi27Jj70hkzZBCY8itdFoYncGFOtCAKgVXJcsVl3mTBOY4SOsXiy8b6QcNW1SCMxMkm5B
 3A/Uaxm8AMEYzUjPYk/nksQQi6mA0to9QLNRreCBN2Ij+Ft0CfRso9kyXw+IvW6aZ7sr/Qr
 i9w++OndI4J2oP7H/Qo7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lS8507cbmGI=:blqz9LL3qwDgLPaWk/y8Hl
 YfDN5JNr/yFRLwCT+jYuQCo1040KhWVbKDFABESg0dSIOb1n84wFv5a7dwSP2xil4xBDN7FNn
 /L0fpQ28/rIbT1uzh1e2t8S0/2D070QpN2RO3fQqv08MDWVafodDpt77u0xjiiNGn+1AZlwTa
 giqZiQgarss4omOUBvI3C91JcYAO7gBpnXobqiuXSPQ35S+eD91F2GL1KyFqWmJPafCI+2wjt
 PyaKzz36nmGqmQCxVW0rf4n6qr7VHHym3O//GP9tQyuNdgPK0q89jkSb6Me0MQuweR+/gwTlk
 tgl514a/m0MUWnxizFc5ABvfwbHYMNlLeJwJmNGcj3gj+Vpk+IMhLNV+TgA4AkAKHVHhSORXl
 Xf7+8/rFl7jochX5QHUhA6ozgZbS54EQ5nNYU++sOTwP0ir/aDErglffOQdlaEkYFLCpkz5qC
 k4Fq3n9QAyApJVE6epdROt6SFNBTQ27KUzVzAQND++IrR90cfOy78o3ABpUH13uS9wGCrHdqq
 hCOoW8KaQqEbNZwUS7Ly8UoM4c0Asz5Qdo0aAxaSt4+6ieV4W0SvE0DlGocagsgi74FTEvPdS
 m7W83Srfx65tKX5qMlQD1+eTUAycJItYvlTfmVD+r0HVpPv4EGtwIpGNaWlDaYVAkdOgo2Enf
 G71FY7/5/03W3QyYYSpaesAjCMH0dsAA8NzLF3lu3MZjA8qr32ifzkLCZhc0c80bjDm5TMV6s
 hOTG8+D4b49EnPkxyggFI/HaIMg+5BcYCxsehjDyfM162wjfut27YdIW24w5Mbhx5WSYzCXFd
 1edfCNU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(bah, I see I replied to wrong patch version, but it's still valid)

On Sat, 2018-07-07 at 14:26 +0200, Mike Galbraith wrote:
> On Fri, 2018-06-29 at 10:29 -0400, Rik van Riel wrote:
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index e59214ec52b1..c4073367219d 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -718,14 +718,47 @@ void tlb_flush_remove_tables_local(void *arg)
> >  	}
> >  }
> >  
> > +static void mm_fill_lazy_tlb_cpu_mask(struct mm_struct *mm,
> > +				      struct cpumask* lazy_cpus)
> > +{
> > +	int cpu;
> > +
> > +	for_each_cpu(cpu, mm_cpumask(mm)) {
> > +		if (!per_cpu(cpu_tlbstate.is_lazy, cpu))
> > +			cpumask_set_cpu(cpu, lazy_cpus);
> > +	}
> > +}
> > +
> >  void tlb_flush_remove_tables(struct mm_struct *mm)
> >  {
> >  	int cpu = get_cpu();
> > +	cpumask_var_t lazy_cpus;
> > +
> > +	if (cpumask_any_but(mm_cpumask(mm), cpu) >= nr_cpu_ids)
> > +		return;
> 
> A put_cpu() went missing.
> 
> > +
> > +	if (!zalloc_cpumask_var(&lazy_cpus, GFP_ATOMIC)) {
> > +		/*
> > +		 * If the cpumask allocation fails, do a brute force flush
> > +		 * on all the CPUs that have this mm loaded.
> > +		 */
> > +		smp_call_function_many(mm_cpumask(mm),
> > +				tlb_flush_remove_tables_local, (void *)mm, 1);
> > +		return;
> > +	}
> 
> Ditto.
> 
> 	-Mike
