Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749DFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D59F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o9V8X1hY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D59F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeIJXpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:45:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40881 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIJXpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:45:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so23056052wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdesJRcYLshF1yugjBx6SHd6k3vtSq6RPzL+1FkgaCY=;
        b=o9V8X1hYemK7GxQHevM3fcEbE9MxU77WVxqGw2VS08czFWNa3xkkdJVNmBu96+y+Me
         bL2Wn7E/LOS+rdxsKKAe0vhNi1OmQYGRtJlT0Bhvs9EBPZr97tX5YutE1BxB9zRIDdg+
         oMm8bVPcSEqIW8eDE94feAuzcCltFh1ZCcjhT3F3kjxtJU6s01AfAw7ANzn+0kw0Jwcf
         e1x2eIzXafic2udaSVePv2Sl1E9EbFLLbQbDVYMBC07OM9IG6cvZQtg0wYbcdolrGeZz
         CLvn/Q7flnxrDtNZbxDLP+4Gpgf1IaKxuInifX/jfY313Dy6QpRj3HGlPB5pd+o0OwXL
         KU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdesJRcYLshF1yugjBx6SHd6k3vtSq6RPzL+1FkgaCY=;
        b=Vtc80N4gXm9kyUVZZ2PcmX0qHMiAnngzZtybhRXFOFjXnwWwndI+NzqaYRtEB7W7Sm
         LFn8FxlFF8rCIETobn03BnrZM90lLflDwur50mO4Y5nD8gdWigsyRaZDXvOhME0yjLVv
         Ab5o9kJKC+YYwsp8Az0kDFaLgHFHQrDuN40f8UokCizR60x1lDDsPQJJp5sLFnWsR2Zy
         ArmWYoRZysz6t9qBB4uD50wdDElLkeBxNISAyLGflQpxKvr/VGqSe400GdpyoDPp8GZy
         CWPjzyyPEAUQTAQheRowotDV9BSgbfjgFJSEq3B0g/FexpbJfAkm1hqCMdCJD3O2pfhp
         p72g==
X-Gm-Message-State: APzg51BHvq882mrPzDV7c9PXTAsSlj78U3bCv7txKnjeprOAfMC9uUf6
        khyt3ApWnKKRgtbE56B5d2Pf1LqZg8N7Ksv2
X-Google-Smtp-Source: ANB0VdYIO288OC7mSTiszF24v1KdkPl58UG7eGUfP0zRjdm2h7tCVUqZcMDETDK4UlkYPs4Qh0u8gA==
X-Received: by 2002:adf:e14f:: with SMTP id f15-v6mr16116453wri.42.1536605373998;
        Mon, 10 Sep 2018 11:49:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id o15-v6sm15551040wru.23.2018.09.10.11.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 11:49:33 -0700 (PDT)
Date:   Mon, 10 Sep 2018 20:49:29 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Scott Wood <oss@buserror.net>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, maxime.ripard@bootlin.com,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        mporter@kernel.crashing.org, nicolas.palix@imag.fr,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org, cocci@systeme.lip6.fr,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/5] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64 in
 linux/setbits.h
Message-ID: <20180910184929.GA7819@Red>
References: <1536349307-20714-1-git-send-email-clabbe@baylibre.com>
 <1536349307-20714-3-git-send-email-clabbe@baylibre.com>
 <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfa1740800ca494028350addd7c874a8b4804bb.camel@buserror.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 03:00:40PM -0500, Scott Wood wrote:
> On Fri, 2018-09-07 at 19:41 +0000, Corentin Labbe wrote:
> > This patch adds setbits32/clrbits32/clrsetbits32 and
> > setbits64/clrbits64/clrsetbits64 in linux/setbits.h header.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  include/linux/setbits.h | 55
> > +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 include/linux/setbits.h
> > 
> > diff --git a/include/linux/setbits.h b/include/linux/setbits.h
> > new file mode 100644
> > index 000000000000..3e1e273551bb
> > --- /dev/null
> > +++ b/include/linux/setbits.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_SETBITS_H
> > +#define __LINUX_SETBITS_H
> > +
> > +#include <linux/io.h>
> > +
> > +#define __setbits(readfunction, writefunction, addr, set) \
> > +	writefunction((readfunction(addr) | (set)), addr)
> > +#define __clrbits(readfunction, writefunction, addr, mask) \
> > +	writefunction((readfunction(addr) & ~(mask)), addr)
> > +#define __clrsetbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) & ~(mask)) | (set)), addr)
> > +#define __setclrbits(readfunction, writefunction, addr, mask, set) \
> > +	writefunction(((readfunction(addr) | (seti)) & ~(mask)), addr)
> > +
> > +#define setbits32(addr, set) __setbits(readl, writel, addr, set)
> > +#define setbits32_relaxed(addr, set) __setbits(readl_relaxed,
> > writel_relaxed, \
> > +					       addr, set)
> > +
> > +#define clrbits32(addr, mask) __clrbits(readl, writel, addr, mask)
> > +#define clrbits32_relaxed(addr, mask) __clrbits(readl_relaxed,
> > writel_relaxed, \
> > +						addr, mask)
> 
> So now setbits32/clrbits32 is implicitly little-endian?  Introducing new
> implicit-endian accessors is probably a bad thing in general, but doing it
> with a name that until this patchset was implicitly big-endian (at least on
> powerpc) seems worse.  Why not setbits32_le()?
> 

I believed that writel/readl was endian agnostic, but It seems that I was wrong.
So I will use _le32.

> 
> > +
> > +#define clrsetbits32(addr, mask, set) __clrsetbits(readl, writel, addr,
> > mask, set)
> > +#define clrsetbits32_relaxed(addr, mask, set) __clrsetbits(readl_relaxed, \
> > +							   writel_relaxed,
> > \
> > +							   addr, mask, set)
> > +
> > +#define setclrbits32(addr, mask, set) __setclrbits(readl, writel, addr,
> > mask, set)
> > +#define setclrbits32_relaxed(addr, mask, set) __setclrbits(readl_relaxed, \
> > +							   writel_relaxed,
> > \
> > +							   addr, mask, set)
> 
> What's the use case for setclrbits?  I don't see it used anywhere in this
> patchset (not even in the coccinelle patterns), it doesn't seem like it would
> be a common pattern, and it could easily get confused with clrsetbits.
> 

It is absent from the coccinelle script due to copy/paste error.
And absent from patchset since it is only two possible example that I can test.

If you run the next fixed coccinelle script, you will find some setclrbits.
Since I fear that mask and set could have some common bits sometimes, I prefer to keep separate clrsetbits and setclrbits.

Regards
