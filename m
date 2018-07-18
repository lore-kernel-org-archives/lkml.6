Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690962075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690962075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbeGRKOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:14:46 -0400
Received: from ozlabs.org ([203.11.71.1]:43253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbeGRKOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:14:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41VsWV4hd2z9s0w;
        Wed, 18 Jul 2018 19:37:42 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
In-Reply-To: <20180712171904.18971-1-muriloo@linux.ibm.com>
References: <20180712171904.18971-1-muriloo@linux.ibm.com>
Date:   Wed, 18 Jul 2018 19:37:37 +1000
Message-ID: <87a7qoq3z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Murilo,

Thanks for the patch.

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> This property was added in 2004 by
>
>     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
>
> and the only use of it, which was already inside `#if 0`, was removed a month
> later by
>
>     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
>
> Fixes: https://github.com/linuxppc/linux/issues/125

That is going to confuse some scripts that are expecting that to be a
"Fixes: <some commit>" tag :)

The proper tag to use there would be "Link:".

But, I'd prefer we didn't add github issue links to the history, as I'm
not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
conspiracy person but just because it's a repo I set up and manage and
there's no long term plan for it necessarily.

> ---
>  arch/powerpc/kernel/prom_init.c | 2 --
>  1 file changed, 2 deletions(-)

Including the link here would be ideal, as it means it doesn't end up in
the commit history, but it does end up in the mail archive. So if we
ever really need to find it, it should be there.

cheers

> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 5425dd3d6a9f..c45fb463c9e5 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -2102,8 +2102,6 @@ static void __init prom_init_stdout(void)
>  	stdout_node = call_prom("instance-to-package", 1, 1, prom.stdout);
>  	if (stdout_node != PROM_ERROR) {
>  		val = cpu_to_be32(stdout_node);
> -		prom_setprop(prom.chosen, "/chosen", "linux,stdout-package",
> -			     &val, sizeof(val));
>  
>  		/* If it's a display, note it */
>  		memset(type, 0, sizeof(type));
> -- 
> 2.17.1
