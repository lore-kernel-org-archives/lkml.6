Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196F8223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196F8223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeKLVCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:02:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37266 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbeKLVCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:02:11 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PSROG3yU7bP9; Mon, 12 Nov 2018 12:09:24 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AA741EC037D;
        Mon, 12 Nov 2018 12:09:24 +0100 (CET)
Date:   Mon, 12 Nov 2018 12:09:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>, acme@kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tools/perf: Add Hygon Dhyana support
Message-ID: <20181112110923.GB8167@zn.tnic>
References: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542008451-31735-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:40:51PM +0800, Pu Wen wrote:
> The tool perf is useful for the performance analysis on the Hygon Dhyana
> platform. But right now there is no Hygon support for it to analyze the
> KVM guest os data. So add Hygon Dhyana support to it by checking vendor

acme, pls fix that to "OS" when applying. Thx.

> string to share the code path of AMD.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  tools/perf/arch/x86/util/kvm-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Borislav Petkov <bp@suse.de>

> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index b32409a..081353d 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -156,7 +156,7 @@ int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
>  	if (strstr(cpuid, "Intel")) {
>  		kvm->exit_reasons = vmx_exit_reasons;
>  		kvm->exit_reasons_isa = "VMX";
> -	} else if (strstr(cpuid, "AMD")) {
> +	} else if (strstr(cpuid, "AMD") || strstr(cpuid, "Hygon")) {
>  		kvm->exit_reasons = svm_exit_reasons;
>  		kvm->exit_reasons_isa = "SVM";
>  	} else
> -- 
> 2.7.4
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
