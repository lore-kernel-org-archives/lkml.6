Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79551ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538620831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 22:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="n1yTQjYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3538620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbeJYHQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 03:16:19 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40602 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbeJYHQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 03:16:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id z9-v6so7636955qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dn0YGRDoNbTjAH4ZG5NZaQVwCZKtUjfVuIFMEzZr3z8=;
        b=n1yTQjYdW93x9b7hcjqt4fcA/inYzLGTPFi5lYkjgaZW79nsxO7jXyDgviHR94gvvI
         NgGOtSTNtdly0C4pl57vlMFtFyHYajZcDARy8KeprtbS9YAUBW9hueXEY3zFOl8Eclj9
         a+iFVnb06UCFqodjRDGp4J+kwn57Q/xN6Q0z3lgcJkPeYOKXO2oJNWI3DPH8zNYTsbTK
         H0fYuGSND6f/UyupddzfKQOZk8LstoyKRORliyANRJf70RbKbtL54z6OMzcrgxG+UaGG
         0mVbfYTpSPGBrbFDDMkJkRlTf+KCpXgZAQfaG4z/MGrsI8ZOypQANUHFCibnkqqdxdsn
         nHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dn0YGRDoNbTjAH4ZG5NZaQVwCZKtUjfVuIFMEzZr3z8=;
        b=cu5ATnU0U2dmoYr0+XdqLqC0IWw+BnTX+tNLvHbhU6mO7Y+MIAoQWWfov2KyU6n/Ca
         ozn5apeTdsSZreScR5+u25/uXic66nspea0U9OkvOLaNvK6SmCd0SqUZ4eFmIak1YscB
         sBg173UW2JYMYhnDg62qQW9uxXbffsk1VSF5/4KLv52FZRPOqSJudVHZX2wQxSjZrYyj
         dTFHtC548yyCO+ORRIZ0M7+IhucEkpn/4F6CmjlI3ieQSxGSvXpVd4dd3gpfxeyW8fok
         hQDv/AWBLe2v+vLVDoL4sa0d1mhyC2e3zQY9Xx8UEbGjMp9hzVwkX43D6FHdSKJFMG40
         d0KA==
X-Gm-Message-State: AGRZ1gK0cGcPktzjoI7E5sbHtwSZmgTl9Hq1GA0NZTdi/s5CwGgOhdDz
        /e1Z72Z+bwgZhuRLdCu4wvFpAQ==
X-Google-Smtp-Source: AJdET5d/DrQo5+0+Im9zOPgyl3dyBtBXC6okdzwVqfQuSOTOTyt4y8EbDAJXmK4UExJ2eWUTQ3KVHg==
X-Received: by 2002:aed:26c7:: with SMTP id q65-v6mr4469873qtd.282.1540421180993;
        Wed, 24 Oct 2018 15:46:20 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i11-v6sm5688061qtc.96.2018.10.24.15.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 15:46:20 -0700 (PDT)
Date:   Wed, 24 Oct 2018 15:46:13 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org, cocci@systeme.lip6.fr,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 2/7] include: add
 setbits_leXX/clrbits_leXX/clrsetbits_leXX in linux/setbits.h
Message-ID: <20181024154613.3ecc96dc@cakuba.netronome.com>
In-Reply-To: <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
        <1540366553-18541-3-git-send-email-clabbe@baylibre.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 07:35:48 +0000, Corentin Labbe wrote:
> This patch adds setbits_le32/clrbits_le32/clrsetbits_le32 and
> setbits_le64/clrbits_le64/clrsetbits_le64 in linux/setbits.h header.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Did you have a look at all the functions defined in bitfield.h?
(including the magic macro-generated ones?)  Perhaps those could be
used here?

I also share the concerns about the non-atomic RMW.  Obviously correct
beats short IMHO.

> diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> new file mode 100644
> index 000000000000..c82faf8d7fe4
> --- /dev/null
> +++ b/include/linux/setbits.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_SETBITS_H
> +#define __LINUX_SETBITS_H
> +
> +#include <linux/io.h>
> +
> +#define __setbits(rfn, wfn, addr, set) wfn((rfn(addr) | (set)), addr)
> +#define __clrbits(rfn, wfn, addr, mask) wfn((rfn(addr) & ~(mask)), addr)
> +#define __clrsetbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) & ~(mask)) | (set)), addr)
> +#define __setclrbits(rfn, wfn, addr, mask, set) wfn(((rfn(addr) | (set)) & ~(mask)), addr)
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

