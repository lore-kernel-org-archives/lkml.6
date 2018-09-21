Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA125ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4617421533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY4I7LYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbeIUF4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:56:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34101 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeIUF4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:56:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id y80-v6so139398ywd.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WllNu+pbRdF2q98vs6KDwSMbulmE+Xe6lJIGoge+JCA=;
        b=iY4I7LYaqIUVAzl/+XDn5YjkQDFEl5w/6FG4pWenCpJT9Q6WKeDXU1VtswEEXxyiPl
         UkgNuqQdiVnEX9+7A+vwhZyr49ri6xW9JCGRZdVYdh+4EBZu63yQcfdHkORTojNKXXGT
         EOCF9ENVdvsp8+4YiwNVlcMDK2+sjTyhtdFWnW5lZ5oW6TNTUdgIePmXyelQHX1yAigT
         wmKnae11xRMRiykglWaqCndF7apayv3lpiXYSwUZdJdCThJsGTfqjQuwwxZ0a0jELmMG
         9WT5VOec1KwhQmSSbEhmrsCYV4mKY+6uiRwl2995r3K/OB2tKGd3tbbkr0lHdA44a2Ea
         q26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WllNu+pbRdF2q98vs6KDwSMbulmE+Xe6lJIGoge+JCA=;
        b=kvYrPKnAyYy4RYbX2wofoEHOzEzw/C3eY1QYWjAOZcydgvr5Vb6D5lVmF4nQUt0Td3
         043HDLq8v4CzDXyvNHjyrrvTc/G/3p548RRDYlShl+hQPH6/SMgPePjToMdqVFFVdr1i
         48Qg5f0qFF7/HcOgAiXexwrghK9zOGiAf3Fu8HJJ29zq5AGvFLUQyeAV+midsFICp5ia
         MoIFqrk1Id8GGBskTJYheQFbra79njMLyJTo2d+tly07ySP7uIkK8Hd0rILifVAUGlD1
         YehwWTLtjC0B77QPLdfzROayVAp9S0Q9XWE+GO01KuBDhWrix/5QqLVzjoqb9deGfXIQ
         Fd9A==
X-Gm-Message-State: APzg51DRsCGdpawpmEy5FwQe3/eJ555eNhIYznzGIZdpVkcH8dmofitE
        PMYIpFqdMiOJGcsD3QqN1A==
X-Google-Smtp-Source: ANB0VdZ5ozA9aizsTdIQuTjC36uoCTgu+jLA/bdfaWjLmoaTSpcyPR+726ZwxVGwp0fQ/j3/10iZ6A==
X-Received: by 2002:a81:3507:: with SMTP id c7-v6mr18763209ywa.162.1537488617680;
        Thu, 20 Sep 2018 17:10:17 -0700 (PDT)
Received: from gabell ([2601:18f:600:d880:b4e9:4651:58aa:d5a3])
        by smtp.gmail.com with ESMTPSA id m82-v6sm13281070ywm.19.2018.09.20.17.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 17:10:16 -0700 (PDT)
Date:   Thu, 20 Sep 2018 20:10:09 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@intel.com>
Subject: Re: [RESEND] [PATCH] perf/x86/intel/uncore: Use
 boot_cpu_data.phys_proc_id instead of hardcorded phy id 0
Message-ID: <20180921001008.juiscfeq32blygi5@gabell>
References: <20180910144750.6782-1-msys.mizuma@gmail.com>
 <alpine.DEB.2.21.1809202254530.1434@nanos.tec.linutronix.de>
 <7fb7e563-d911-d325-ec48-8b153bece071@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb7e563-d911-d325-ec48-8b153bece071@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 05:10:18PM -0400, Liang, Kan wrote:
> 
> 
> On 9/20/2018 4:55 PM, Thomas Gleixner wrote:
> > On Mon, 10 Sep 2018, Masayoshi Mizuma wrote:
> > 
> > CC+ Kan
> > 
> > > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > 
> > > Physical package id 0 is not always exists. We should use
> > > boot_cpu_data.phys_proc_id here.
> > > 
> > > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > > ---
> > >   arch/x86/events/intel/uncore_snbep.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> > > index 51d7c11..53b981d 100644
> > > --- a/arch/x86/events/intel/uncore_snbep.c
> > > +++ b/arch/x86/events/intel/uncore_snbep.c
> > > @@ -3061,7 +3061,7 @@ static struct event_constraint bdx_uncore_pcu_constraints[] = {
> > >   void bdx_uncore_cpu_init(void)
> > >   {
> > > -	int pkg = topology_phys_to_logical_pkg(0);
> > > +	int pkg = topology_phys_to_logical_pkg(boot_cpu_data.phys_proc_id);
> 
> I think it's better to use logical_proc_id directly.
> 
> +	int pkg = boot_cpu_data.logical_proc_id;

Thanks! I'll send the v2.

- Masa
