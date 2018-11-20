Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776EC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E060A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E4CPpLzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E060A206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeKTXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:20:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57082 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbeKTXUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RXt0H+C/9LjdmgoCE38nD3tQGNQsl0pifO6VCuu8L6M=; b=E4CPpLzQsm50KxwadWqvnpI3f
        iNiDrRVU1AVDCLcmTeBiQ6vlNXqW32gy+PX9EBq8Demuv8SYbrl0pBYD1bVPh0UFYUujomISMWgQW
        R01+jFbJcpKNkm65j05TpLidTNwS1ED71XKNJdqs3ywQDM6CleuFOhc+l23c54vJY4O98VjBxCuih
        LokwOB7SNe4nlWX+Kykt21NroVqlSATFHjUMt4X3/GyjiPAngm/TysKSf3Htvot9asa4RuwCONO0l
        lu73469af9Rwv7m5isbwkB4UVt3LJeIDE1svWkfcMCkBOH8vNF7aBzHBskDi/umFV1VsogZW5UMr6
        rTFdWEKJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP5UN-0007eQ-PT; Tue, 20 Nov 2018 12:50:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6870E2029F87F; Tue, 20 Nov 2018 13:50:40 +0100 (CET)
Date:   Tue, 20 Nov 2018 13:50:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com,
        Petri Latvala <petri.latvala@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf/x86: Bump INTEL_PMC_MAX_FIXED for Icelake
Message-ID: <20181120125040.GN2131@hirez.programming.kicks-ass.net>
References: <20181114142518.15380-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114142518.15380-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:25:18PM +0000, Chris Wilson wrote:

> I am not aware of what the consequences are of bumping this limit, so
> please take the patch with a pinch of salt and more of a heads up!

Yeah, this will only make your warning go away, but is not suitable for
upstream. The upstream icelake enablement would be a much larger patch
that actually enables the new PMU features.

So I suggest you carry this in your CI tree until the icelake patches
are allowed to go public.

> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 8bdf74902293..ab4cf7c12c40 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -7,7 +7,7 @@
>   */
>  
>  #define INTEL_PMC_MAX_GENERIC				       32
> -#define INTEL_PMC_MAX_FIXED					3
> +#define INTEL_PMC_MAX_FIXED					4
>  #define INTEL_PMC_IDX_FIXED				       32
>  
>  #define X86_PMC_IDX_MAX					       64
> -- 
> 2.19.1
> 
