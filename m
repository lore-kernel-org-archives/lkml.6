Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952B620645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 952B620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeIHBDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:03:35 -0400
Received: from baldur.buserror.net ([165.227.176.147]:48570 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIHBDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:03:34 -0400
Received: from [2601:449:8400:7293:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1fyMvq-0007Pd-9a; Fri, 07 Sep 2018 15:00:42 -0500
Message-ID: <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Corentin Labbe <clabbe@baylibre.com>, Gilles.Muller@lip6.fr,
        Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com,
        alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org,
        davem@davemloft.net, galak@kernel.crashing.org,
        joabreu@synopsys.com, khilman@baylibre.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        nicolas.palix@imag.fr, paulus@samba.org, peppe.cavallaro@st.com,
        tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org
Cc:     cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Fri, 07 Sep 2018 15:00:40 -0500
In-Reply-To: <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
         <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8400:7293:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: clabbe@baylibre.com, Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au, benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net, galak@kernel.crashing.org, joabreu@synopsys.com, khilman@baylibre.com, maxime.ripard@bootlin.com, michal.lkml@markovi.net, mpe@ellerman.id.au, mporter@kernel.crashing.org, nicolas.palix@imag.fr, paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org, wens@csie.org, cocci@systeme.lip6.fr, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-sunxi@googlegroups.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-09-07 at 19:41 +0000, Corentin Labbe wrote:
> This patch adds setbits32/clrbits32/clrsetbits32 and
> setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  include/linux/setbits.h | 55
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 include/linux/setbits.h
> 
> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..3e1e273551bb
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(readfunction, writefunction, addr, set) \
> +	writefunction((readfunction(addr) | (set)), addr)
> +#define __clrbits(readfunction, writefunction, addr, mask) \
> +	writefunction((readfunction(addr) & ~(mask)), addr)
> +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> +	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
> +
> +#define setbits32(addr, set) __setbits(readl, writel, addr, set)
> +#define setbits32_relaxed(addr, set) __setbits(readl_relaxed,
> writel_relaxed, \
> +					       addr, set)
> +
> +#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
> +#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed,
> writel_relaxed, \
> +						addr, mask)

So now setbits32/clrbits32 is implicitly little-endian?  Introducing new
implicit-endian accessors is probably a bad thing in general, but doing it
with a name that until this patchset was implicitly big-endian (at least on
powerpc) seems worse.  Why not setbits32_le()?


> +
> +#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr,
> mask, set)
> +#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)
> +
> +#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr,
> mask, set)
> +#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> +							   writel_relaxed,
> \
> +							   addr, mask, set)

What's the use case for setclrbits?  I don't see it used anywhere in this
patchset (not even in the coccinelle patterns), it doesn't seem like it would
be a common pattern, and it could easily get confused with clrsetbits.

-Scott

