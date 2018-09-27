Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F670206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R0Wj2nL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F670206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeI0Lvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:51:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37087 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0Lvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:51:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id u12-v6so1120938wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 22:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9ihyaWkwYVGAI4CBCJ/K1tFaNvlcXqGNov625MJA9PY=;
        b=R0Wj2nL3NbXkcNRVP6blE51KpAkSRYfUR0Ns5m3DdI8HSG9LWccKrmx420/QUUthwj
         af1DNnb9HOK+sz5Ex/hN+3bgDRHZGm2P9YyvEB4wA9irezGTQgzFLJu7sUVMCDI1yVhq
         jXKBvOp46mEwqrWU4641BDhQYw0dvNbEW6G625fSMD4pt7EUK6N+dCjNIaJb6MB0KPAe
         /UItK5EFnBnLh/wOVv9UxtLSrL563vaJhlJ+5A3XwAXEJarQUi0eBYMpFU/0oAEj21DP
         +8lWqgNkGLFXjky+3nJxQXmv2UijUOyWyOl7AwDs998MFI1f4Wx60ScO/sO/bxSHt7qX
         qnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9ihyaWkwYVGAI4CBCJ/K1tFaNvlcXqGNov625MJA9PY=;
        b=HpOjYiUAAzedUJHSJSo6Ou62UnS4CbjcIHdkH+unwRmWbsTA5jWr1NXIYw/f27keNM
         gHMe/cY3kXDIxPDIsaohaKN66u92wUOjRkUJOFGUgQn9i6QZ2fAJLvRuxvnvi7qbpMqG
         ZthO2vLGAr67fd6Bkb3L4KPC16DIihw0wMGhXRvL5Z0ZXU0+VuM+RgrIlSIuCCF3owHw
         2+SrYw2oVebSXxe7Csk/P6Cn5rnSLgbNkmF2OIueWLfaOlTjBBM2TnvxBHMd41JC5pr5
         Ed8RwN77awySm3XHpwLAqGPvCDNGdmwlvGEtqJ8gOACXfjLBgO1uQdlRyckn37Gs5Vs0
         5qdA==
X-Gm-Message-State: ABuFfoh6Tit9wIQbRKIhLPBERqScXWH7nv0endtP09DB10Hn6IIF8tMR
        0AWnKDBcfw+l7JQpEuRzv9ARRA==
X-Google-Smtp-Source: ACcGV63/dk/CZHTAwN+cPTjFr4dfPGBofQbFquTAfIwQgZ7FHetefBRriFUYDUIzWDdJZjNGvA5HOQ==
X-Received: by 2002:adf:f1ce:: with SMTP id z14-v6mr7178700wro.214.1538026512111;
        Wed, 26 Sep 2018 22:35:12 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id n8-v6sm774419wrw.31.2018.09.26.22.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 22:35:11 -0700 (PDT)
Date:   Thu, 27 Sep 2018 07:35:08 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, narmstrong@baylibre.com,
        nicolas.palix@imag.fr, oss@buserror.net, paulus@samba.org,
        peppe.cavallaro@st.com, tj@kernel.org, vitb@kernel.crashing.org,
        wens@csie.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-ide@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, cocci@systeme.lip6.fr,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Message-ID: <20180927053508.GB27637@Red>
References: <1537815856-31728-1-git-send-email-clabbe@baylibre.com>
 <1537815856-31728-3-git-send-email-clabbe@baylibre.com>
 <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a63152f-9eca-f7d9-8fe6-59caaab33666@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 07:05:00AM +0200, Christophe LEROY wrote:
> 
> 
> Le 24/09/2018 à 21:04, Corentin Labbe a écrit :
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> 
> Fix the patch subject and description.
> 
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   include/linux/setbits.h | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 include/linux/setbits.h
> > 
> > diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> > new file mode 100644
> > index 000000000000..6e7e257134ae
> > --- /dev/null
> > +++ b/include/linux/setbits.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_SETBITS_H
> > +#define __LINUX_SETBITS_H
> > +
> > +#include <linux/io.h>
> > +
> > +#define __setbits(readfunction, writefunction, addr, set) \
> > +	writefunction((readfunction(addr) | (set)), addr)
> 
> You don't need so long names for parameters in a 2 lines macro (See 
> Linux Kernel Codying style §4 Naming).
> 
> A single line macro would be feasible with only 3 chars names:
> 
> #define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
> 

Thanks I will fix all reported problem.

> > +#define __clrbits(readfunction, writefunction, addr, mask) \
> > +	writefunction((readfunction(addr) & ~(mask)), addr)
> > +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> > +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) | (set)) & ~(mask)), addr)
> > +
> > +#ifndef setbits_le32
> > +#define setbits_le32(addr, set) __setbits(readl, writel, addr, set)
> > +#endif
> > +#ifndef setbits_le32_relaxed
> > +#define setbits_le32_relaxed(addr, set) __setbits(readl_relaxed, writel_relaxed, \
> > +					       addr, set)
> > +#endif
> > +
> > +#ifndef clrbits_le32
> > +#define clrbits_le32(addr, mask) __clrbits(readl, writel, addr, mask)
> > +#endif
> > +#ifndef clrbits_le32_relaxed
> > +#define clrbits_le32_relaxed(addr, mask) __clrbits(readl_relaxed, writel_relaxed, \
> > +						addr, mask)
> > +#endif
> > +
> > +#ifndef clrsetbits_le32
> > +#define clrsetbits_le32(addr, mask, set) __clrsetbits(readl, writel, addr, mask, set)
> > +#endif
> > +#ifndef clrsetbits_le32_relaxed
> > +#define clrsetbits_le32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> > +							   writel_relaxed, \
> > +							   addr, mask, set)
> > +#endif
> > +
> > +#ifndef setclrbits_le32
> > +#define setclrbits_le32(addr, mask, set) __setclrbits(readl, writel, addr, mask, set)
> > +#endif
> > +#ifndef setclrbits_le32_relaxed
> > +#define setclrbits_le32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> > +							   writel_relaxed, \
> > +							   addr, mask, set)
> > +#endif
> > +
> > +/* We cannot use CONFIG_64BIT as some x86 drivers use non-atomicwriteq() */
> > +#if defined(writeq) && defined(readq)
> 
> Take care. At least Alpha Arch defines it as a static inline without
> redefining it as a #define. (see arch/alpha/kernel/io.c)

In fact, it does in arch/alpha/include/asm/io.h along with a gentle comment.
But fixing their comment will be another interesting patch serie.

Regards
Corentin Labbe
