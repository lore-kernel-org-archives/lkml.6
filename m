Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35154C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0972086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0972086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbeIJXM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:12:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35288 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbeIJXM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:12:56 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XskYpQBOLwSN; Mon, 10 Sep 2018 20:17:35 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A46901EC01F6;
        Mon, 10 Sep 2018 20:17:35 +0200 (CEST)
Date:   Mon, 10 Sep 2018 20:17:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 05/16] perf/x86: Add Hygon Dhyana support to PMU
 infrastructure
Message-ID: <20180910181730.GF4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <1e7b20df2bb5ebca6d72339f8b4e1453325cef10.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e7b20df2bb5ebca6d72339f8b4e1453325cef10.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:16:43PM +0800, Pu Wen wrote:
> The PMU architecture for Hygon Dhyana CPU is similar to the AMD Family
> 17h one. To support Hygon Dhyana PMU, call amd_pmu_init() to share
> AMD PMU initialization flow, and change the PMU name to "HYGON".
> 
> The Hygon Dhyana CPU support both legacy and extension PMC MSRs(perf

I don't know but for some reason, you are writing "Hygon Dhyana CPU" as
being plural. But it is singular:

"The Hygon Dhyna CPU supports both ..."
			    ^
			   |||

> counter registers and event selection registers), so add Hygon Dhyana
> support to get bit offset in the similar way as AMD does.

"to get bit offset"?

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/events/amd/core.c             |  4 ++++
>  arch/x86/events/amd/uncore.c           | 20 +++++++++++++-------
>  arch/x86/events/core.c                 |  4 ++++
>  arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
>  4 files changed, 23 insertions(+), 7 deletions(-)

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
