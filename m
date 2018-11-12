Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E002224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMs3DHgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E002224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbeKMCYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:24:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeKMCYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:24:15 -0500
Received: from jouet.infradead.org (d66-183-243-195.bchsia.telus.net [66.183.243.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF205223AE;
        Mon, 12 Nov 2018 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542040216;
        bh=uNMR4yBB5e79oODNLzvXgB/AUATzdglT1SjhCnj03gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMs3DHgYjhCOHLqZFUNXdbyUfn00esXN2rRwwz1eZ1ODdAL7/WBPu+ogzJSqlqiJf
         XeMyRN2eZtoJoD/i9+5mpUH6/eICcNanZkn/anoITdHXmYXW0n9IEqHJ6VuWMbtvC6
         3H0AjyTb4hijUWyVHNxXPMLKkcObEukMWkJUcU1g=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 8556A1443D0; Mon, 12 Nov 2018 08:30:16 -0800 (PST)
Date:   Mon, 12 Nov 2018 08:30:16 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pu Wen <puwen@hygon.cn>, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tools/perf: Add Hygon Dhyana support
Message-ID: <20181112163016.GD1111@kernel.org>
References: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
 <20181112110923.GB8167@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112110923.GB8167@zn.tnic>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 12, 2018 at 12:09:23PM +0100, Borislav Petkov escreveu:
> On Mon, Nov 12, 2018 at 03:40:51PM +0800, Pu Wen wrote:
> > The tool perf is useful for the performance analysis on the Hygon Dhyana
> > platform. But right now there is no Hygon support for it to analyze the
> > KVM guest os data. So add Hygon Dhyana support to it by checking vendor
> 
> acme, pls fix that to "OS" when applying. Thx.
> 
> > string to share the code path of AMD.
> > 
> > Signed-off-by: Pu Wen <puwen@hygon.cn>
> > ---
> >  tools/perf/arch/x86/util/kvm-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Borislav Petkov <bp@suse.de>

Thanks, applied.

- Arnaldo
 
> > diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> > index b32409a..081353d 100644
> > --- a/tools/perf/arch/x86/util/kvm-stat.c
> > +++ b/tools/perf/arch/x86/util/kvm-stat.c
> > @@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
> >  	if (strstr(cpuid, "Intel")) {
> >  		kvm->exit_reasons = vmx_exit_reasons;
> >  		kvm->exit_reasons_isa = "VMX";
> > -	} else if (strstr(cpuid, "AMD")) {
> > +	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
> >  		kvm->exit_reasons = svm_exit_reasons;
> >  		kvm->exit_reasons_isa = "SVM";
> >  	} else
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
