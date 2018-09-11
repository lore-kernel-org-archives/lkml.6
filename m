Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784DCC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DC620833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbeIKPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:37:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37010 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeIKPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:37:15 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E10vu8rR-EVZ; Tue, 11 Sep 2018 12:38:30 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E06481EC0645;
        Tue, 11 Sep 2018 12:38:29 +0200 (CEST)
Date:   Tue, 11 Sep 2018 12:38:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 09/16] x86/bugs: Add mitigation to spectre and no
 meltdown for Hygon Dhyana
Message-ID: <20180911103828.GF12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <191ce6b53269e90fdc26ee49ef337b905bd7d99c.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:17:40PM +0800, Pu Wen wrote:
> The Hygon Dhyana CPU has the same speculative execution as AMD family
> 17h, so share AMD spectre mitigation code for Hygon Dhyana.
> 
> Also Hygon Dhyana is not affected by meltdown vulnerability as AMD,
> so add the exception for Hygon Dhyana.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/bugs.c   | 6 ++++--
>  arch/x86/kernel/cpu/common.c | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 40bdaea..726010d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -312,8 +312,9 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
>  	}
>  
>  	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON &&
>  	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
> -		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
> +		pr_err("retpoline,amd selected but CPU is not AMD or Hygon. Switching to AUTO select\n");

Didn't we say, no user-visible changes pls?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
