Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B1AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96434216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96434216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeI1Dhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:37:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeI1Dhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:37:55 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eq7CPz2HTEjE; Thu, 27 Sep 2018 23:17:40 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D8CC11EC0104;
        Thu, 27 Sep 2018 23:17:39 +0200 (CEST)
Date:   Thu, 27 Sep 2018 23:17:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] docs: kernel-parameters.txt: document
 rand_mem_physical_padding parameter
Message-ID: <20180927211747.GD19687@zn.tnic>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
 <20180927203146.12201-4-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927203146.12201-4-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:31:46PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> This kernel parameter allows to change the padding used
> for the physical memory mapping section when KASLR
> memory is enabled.
> 
> For memory hotplug capable systems, the default padding size,
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, may not be enough.
> The option is useful to adjust the padding size.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 92eb1f4..de43cdf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3529,6 +3529,13 @@
>  			fully seed the kernel's CRNG. Default is controlled
>  			by CONFIG_RANDOM_TRUST_CPU.
>  
> +	rand_mem_physical_padding=
> +			[KNL] Define the padding size in terabytes
> +			used for the physical memory mapping section
> +			when KASLR memory is enabled.
> +			The default value is
> +			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.

Yet another kernel parameter which forces me to go look at what the
code does because this help text doesn't really help. And I see that in
previous iterations ok lkml it was *actually* properly explained why
this parameter is needed.

So please summarize that explanation here so that the user can make an
informed decision when reading this help text. Always think of explaning
this to a colleague of yours who doesn't know about the memory padding
and memory hotadd problematic and try to write it in such a way so that
your colleague understands it.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
