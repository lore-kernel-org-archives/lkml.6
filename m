Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE50C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F2218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549427992;
	bh=zjyxnq/4wO1M/nstObZR1mFaFA1BaQW5Vhu0ytEEHlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TJIj+IbJuvnYQsTwg+h7KE/Zsc0EY/8Loxb1AvB8M0usfyBLmbIk/JNgMrcSdc1AA
	 2msb4pdBH2z4QMs1Wt7u8PfQF97sW0FmJY39mtKqQTjikf5W/HDXn72r2dD6PPWYk3
	 QwGUG6AlU8jkAJZHSerHKdSNyJ4S3AdnB1lEdQ8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBFEjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 23:39:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBFEjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 23:39:46 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14296218A1;
        Wed,  6 Feb 2019 04:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549427985;
        bh=zjyxnq/4wO1M/nstObZR1mFaFA1BaQW5Vhu0ytEEHlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g2jGmtOsPjn0JWEAUeXsHiWZOKrqoFBMLdw/Z9+8cEph0g/npRazWYUnZ40i9HzGq
         sftgdK72q4vJxIvEkk2O2fps0YmVJUEwDORbuhkxLtmgftGkr5C2SSG9Wf1wnv/NKa
         xlu6Srfxt+6NspbAGPClvW3TulNS0XM+pmFCVY60=
Date:   Wed, 6 Feb 2019 13:39:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     patches@armlinux.org.uk, linux-kernel@vger.kernel.org,
        Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "# v4 . 14+" <stable@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal
 instruction
Message-Id: <20190206133941.80be666ffac89205f57b9edf@kernel.org>
In-Reply-To: <20190205153740.20942-1-mathieu.desnoyers@efficios.com>
References: <20190205153740.20942-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Feb 2019 10:37:40 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> FORTIFY_SOURCE") introduced a regression in optimized kprobes. It
> triggers "invalid instruction" oopses when using kprobes instrumentation
> through lttng and perf. This commit was introduced in kernel v4.20, and
> has been backported to stable kernels 4.19 and 4.14.
> 
> This crash was also reported by Hongzhi Song on the redhat bugzilla
> where the patch was originally introduced.

Thank you for fixing this.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
> Link: https://bugs.lttng.org/issues/1174
> Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
> Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> CC: Masami Hiramatsu <mhiramat@kernel.org>
> CC: William Cohen <wcohen@redhat.com>
> CC: Laura Abbott <labbott@redhat.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Russell King <rmk+kernel@armlinux.org.uk>
> CC: <stable@vger.kernel.org> # v4.14+
> CC: linux-arm-kernel@lists.infradead.org
> CC: patches@armlinux.org.uk
> ---
> KernelVersion: 5.0.0-rc5
>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 2c118a6ab358..0dc23fc227ed 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, (unsigned char *)optprobe_template_entry,
> +	memcpy(code, (unsigned long *)&optprobe_template_entry,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
