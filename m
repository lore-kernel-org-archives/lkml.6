Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43290C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C02F2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfA2XJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:09:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:52678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726980AbfA2XJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:09:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05023AD65;
        Tue, 29 Jan 2019 23:08:58 +0000 (UTC)
Date:   Wed, 30 Jan 2019 00:08:45 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190129230845.GG28773@zn.tnic>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129225218.15441-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 05:52:18PM -0500, Johannes Weiner wrote:
> "Resource Control" is a very broad term for this CPU feature, and a
> term that is also associated with containers, cgroups etc. This can
> easily cause confusion.
> 
> Make the user prompt more specific.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  arch/x86/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> As somebody who works in "resource control", this prompt in oldconfig
> certainly had me go wtf. Can we do something more specific?

Well, since this is an interface to a hardware feature, we could call it

Hardware Resource Control

for example. I.e., HW_RESCTRL.

Linus had another suggestion - CPU_RESCTRL - which sounds ok to me too.

> Not insisting on this name, and I haven't renamed all the config
> symbols yet, but we should probably fix this before 5.0 is released.
> 
> Thanks!
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 26387c7bf305..426677b759c0 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -447,11 +447,11 @@ config RETPOLINE
>  	  support for full protection. The kernel may run slower.
>  
>  config X86_RESCTRL
> -	bool "Resource Control support"
> +	bool "x86 cache control support"

Except that it is not only cache but memory (bandwidth) control too. So I guess

	bool "CPU Resource Control support"

or so.

Let the bikeshedding begin!

:-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
