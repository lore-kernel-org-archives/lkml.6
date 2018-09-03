Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FC5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EEC20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EEC20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeICOPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:15:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43330 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeICOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:15:47 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ln5GSBWC5Eev; Mon,  3 Sep 2018 11:56:05 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6D761EC00E8;
        Mon,  3 Sep 2018 11:56:04 +0200 (CEST)
Date:   Mon, 3 Sep 2018 11:57:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 02/16] x86/cache: get cache size/leaves and setup
 cache cpumap for Dhyana
Message-ID: <20180903095711.GC10249@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff6d0392ccdd50ca747e762ae91d9c1c210b1d82.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch subject needs to be of the format:

<file path(s)>: Sentence starting with a capital letter and describing
concisely the patch

Fix all your subjects pls.

On Wed, Aug 29, 2018 at 08:43:10PM +0800, Pu Wen wrote:
> Hygon Dhyana processor has the topology extensions bit in CPUID.
> With this bit kernel can get the cache info. So add support

"With this bit, the kernel... "

> in cpuid4_cache_lookup_regs() to get the correct cache size.
> 
> Dhyana also find num_cache_leaves via CPUID leaf 0x8000001d, so

"... also discovers num_cache_leaves ..."

> add Hygon support in find_num_cache_leaves().
> 
> Also add cacheinfo_hygon_init_llc_id() and init_hygon_cacheinfo()
> functions to initialize Dhyana cache info. Setup cache cpumap in
> the same way as AMD does.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/include/asm/cacheinfo.h |  1 +
>  arch/x86/kernel/cpu/cacheinfo.c  | 31 +++++++++++++++++++++++++++++--
>  arch/x86/kernel/cpu/cpu.h        |  1 +
>  arch/x86/kernel/cpu/hygon.c      |  3 +++
>  4 files changed, 34 insertions(+), 2 deletions(-)

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
