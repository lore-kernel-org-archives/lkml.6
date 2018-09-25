Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A683FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3E2082C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED3E2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeIYLK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:10:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41689 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeIYLK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:10:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42K8C11yTCz9ttRd;
        Tue, 25 Sep 2018 07:05:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EBBPNS03tboP; Tue, 25 Sep 2018 07:05:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42K8C10kSMz9ttCD;
        Tue, 25 Sep 2018 07:05:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D9B708B7C0;
        Tue, 25 Sep 2018 07:05:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9vzRmtp7Xgio; Tue, 25 Sep 2018 07:05:02 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE9618B762;
        Tue, 25 Sep 2018 07:05:00 +0200 (CEST)
Subject: Re: [PATCH v2 2/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, airlied@linux.ie,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
Date:   Tue, 25 Sep 2018 07:05:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/09/2018 à 21:04, Corentin Labbe a écrit :
> This patch adds setbits32/clrbits32/clrsetbits32 and
> setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.

Fix the patch subject and description.

> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>   include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 include/linux/setbits.h
> 
> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..6e7e257134ae
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(readfunction, writefunction, addr, set) \
> +	writefunction((readfunction(addr) | (set)), addr)

You don't need so long names for parameters in a 2 lines macro (See 
Linux Kernel Codying style §4 Naming).

A single line macro would be feasible with only 3 chars names:

#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)

> +#define __clrbits(readfunction, writefunction, addr, mask) \
> +	writefunction((readfunction(addr) & ~(mask)), addr)
> +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
> +
> +#ifndef setbits_le32
> +#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
> +#endif
> +#ifndef setbits_le32_relaxed
> +#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le32
> +#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#endif
> +#ifndef clrbits_le32_relaxed
> +#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le32
> +#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le32_relaxed
> +#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le32
> +#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le32_relaxed
> +#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
> +#if defined(writeq) && defined(readq)

Take care. At least Alpha Arch defines it as a static inline without
redefining it as a #define. (see arch/alpha/kernel/io.c)

Christophe

> +#ifndef setbits_le64
> +#define setbits_le64(addr, set) __setbits(readq, writeq, addr, set)
> +#endif
> +#ifndef setbits_le64_relaxed
> +#define setbits_le64_relaxed(addr, set) __setbits(readq_relaxed, writeq_relaxed, \
> +					       addr, set)
> +#endif
> +
> +#ifndef clrbits_le64
> +#define clrbits_le64(addr, mask) __clrbits(readq, writeq, addr, mask)
> +#endif
> +#ifndef clrbits_le64_relaxed
> +#define clrbits_le64_relaxed(addr, mask) __clrbits(readq_relaxed, writeq_relaxed, \
> +						addr, mask)
> +#endif
> +
> +#ifndef clrsetbits_le64
> +#define clrsetbits_le64(addr, mask, set) __clrsetbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef clrsetbits_le64_relaxed
> +#define clrsetbits_le64_relaxed(addr, mask, set) __clrsetbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#ifndef setclrbits_le64
> +#define setclrbits_le64(addr, mask, set) __setclrbits(readq, writeq, addr, mask, set)
> +#endif
> +#ifndef setclrbits_le64_relaxed
> +#define setclrbits_le64_relaxed(addr, mask, set) __setclrbits(readq_relaxed, \
> +							   writeq_relaxed, \
> +							   addr, mask, set)
> +#endif
> +
> +#endif /* writeq/readq */
> +
> +#endif /* __LINUX_SETBITS_H */
> 
