Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D668C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36421532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B36421532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeIUClS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:41:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37684 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIUClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:41:18 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g35zC-0006Co-J7; Thu, 20 Sep 2018 22:55:42 +0200
Date:   Thu, 20 Sep 2018 22:55:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@intel.com>
Subject: Re: [RESEND] [PATCH] perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id
 instead of hardcorded phy id 0
In-Reply-To: <20180910144750.6782-1-msys.mizuma@gmail.com>
Message-ID: <alpine.DEB.2.21.1809202254530.1434@nanos.tec.linutronix.de>
References: <20180910144750.6782-1-msys.mizuma@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Masayoshi Mizuma wrote:

CC+ Kan

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Physical package id 0 is not always exists. We should use
> boot_cpu_data.phys_proc_id here.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 51d7c11..53b981d 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
>  
>  void bdx_uncore_cpu_init(void)
>  {
> -	int pkg = topology_phys_to_logical_pkg(0);
> +	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);

Looks correct.

>  	if (bdx_uncore_cbox.num_boxes > boot_cpu_data.x86_max_cores)
>  		bdx_uncore_cbox.num_boxes = boot_cpu_data.x86_max_cores;
> -- 
> 2.18.0
> 
> 
