Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E43C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7842A2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7842A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeIJVd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:33:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59740 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727810AbeIJVd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:33:26 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RWXBFGos5i3u; Mon, 10 Sep 2018 18:38:30 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0CE31EC00F4;
        Mon, 10 Sep 2018 18:38:29 +0200 (CEST)
Date:   Mon, 10 Sep 2018 18:38:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 01/16] x86/cpu: Create Hygon Dhyana architecture
 support file
Message-ID: <20180910163821.GD4386@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <d99e831f739308221798c9939efc6e6fc1648e0c.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99e831f739308221798c9939efc6e6fc1648e0c.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:15:29PM +0800, Pu Wen wrote:
> Add x86 architecture support for new processor Hygon Dhyana Family

		"... for a new processor: Hygon... "

> 18h.

Instead of all that:

> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c)
> from the AMD one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana.


> In this way we can remove old AMD architecture support codes and
> generate a clear initialization flow for Hygon Dhyana CPU. It also
> reduce the long-term maintenance effort.

... simply say: "Carve out initialization code needed by Dhyana into a
separate compilation unit."

> Add Maintainer information
> for hygon.c in accordance.

That sentence is not needed - that fact is visible in the diff.

> 
> To identify Hygon Dhyana CPU, add a new vendor type X86_VENDOR_HYGON(9)
> for system recognition.

No need for that "(9)" - also visible from the diff and an
implementation detail.

> 
> To enable the config for Hygon Dhyana CPU, add a separated Kconfig
> entry(CPU_SUP_HYGON) in kernel config setup.

That sentence is not needed for the same reason as above.

> And select CPU_SUP_AMD
> to solve the dependency issues in kernel.

No, this should say: "Since Dhyana uses AMD functionality to a large
degree, select CPU_SUP_AMD which provides that functionality."

> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  MAINTAINERS                      |   6 +
>  arch/x86/Kconfig.cpu             |  14 ++
>  arch/x86/include/asm/processor.h |   3 +-
>  arch/x86/kernel/cpu/Makefile     |   1 +
>  arch/x86/kernel/cpu/hygon.c      | 408 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 431 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/kernel/cpu/hygon.c

With that taken care of:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
