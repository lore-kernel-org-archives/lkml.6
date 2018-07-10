Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85522089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqpZ05pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85522089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeGJHrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:47:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44605 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbeGJHra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:47:30 -0400
Received: by mail-lf0-f67.google.com with SMTP id g6-v6so6756072lfb.11;
        Tue, 10 Jul 2018 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brez9X33y1AterNHq7JRaWyWV5IlwR9Mgh20hYDRQ5M=;
        b=oqpZ05pt5xiBfqnZA/yS27zyA49Xcdn7+4RwJzWiT9SQIuKhnsBv03qbSAhDywPM9o
         jzzp7wSW6pZrPiDYgOB+IDKFF7214BAQtbEoHkB36tE86iNQDNcuSNt1lgFsEs6XYnNI
         65z/KTXNclIAaw4M5GHxDOShj+5RxrcchTeQ3HrevPr/NQ2H0xUwKWaJBvK8odi+PpzK
         VQRE6IuH/JG7FNiq7rhcBF6JOAF3aDbKnfJzDTtrvnCFZ2XV275bvChGhnEXDo4gpohR
         DRgvmDsaOK1bzNMHFjQ07R9rW1zidGbN5iihvS+fN674tYqLA6C8E4AxGaNbYPpxNPS+
         f9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brez9X33y1AterNHq7JRaWyWV5IlwR9Mgh20hYDRQ5M=;
        b=qYahmVukfdiZUE87LERCEiHCATT79bUA483sdmmIbR4K9rN/4IvHPfHR9q1YGrqw+D
         cUv3a0oYcVzZ5hQTbXINVOr1kqfj8DgNWH7TeFhca+OO1oGsKwtHlFdf8dE182Kwy4fX
         yt2daPb5hOX6bemrRK4uzVstdoIKYbwodfM1+4z02MtOvWQvy3r3vMZXC85syQqEK6zx
         jSBrVmVmWgYbNVxvahXylz/mzPjUYan/yiTa/9+3WW5M6L5P67y4yg/OjvRVMRRgTCll
         yLDkzr9bcpjlx+UKVhu1Y+WmtREz+hJtEdhAQI2QG4pg86/reoA/WqqltrO2btjG83TO
         0qew==
X-Gm-Message-State: APt69E2OBoygJNqigsJXzdSAwXjIJsiHaiyGUqxeWVOTqefvsVEorstp
        23FtCWb4DMiU9oHbdTZuIcHbtMDJ
X-Google-Smtp-Source: AAOMgpdWd3O8XlDkZ/6XKr+oWmb4fD3MATb0rPxE7JSNvZuKvKK70ds9fSv5N/rfY0W1B6sqV8gLxw==
X-Received: by 2002:a19:17c2:: with SMTP id 63-v6mr1858648lfx.112.1531208849349;
        Tue, 10 Jul 2018 00:47:29 -0700 (PDT)
Received: from mobilestation ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g22-v6sm1382726lja.14.2018.07.10.00.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 00:47:28 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:48:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, okaya@codeaurora.org,
        chenhc@lemote.com, Sergey.Semin@t-platforms.ru,
        Linux-MIPS <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated()
 method
Message-ID: <20180710074815.GA30235@mobilestation>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
 <20180709135713.8083-2-fancer.lancer@gmail.com>
 <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+7wUsxDfBdiGt5tZ7dxb63oMd=3Ry4s1Xysed8RSHJi35=VxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 09:15:17AM +0200, Mathieu Malaterre <malat@debian.org> wrote:
> '
> On Mon, Jul 9, 2018 at 3:57 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Adaptive ioremap_wc() method is now available (see "mips: mm:
> > Create UCA-based ioremap_wc() method" commit). We can use it for
> > UCA-featured MMIO transactions in the kernel, so we don't need
> > it platform clone ioremap_uncached_accelerated() being declard.
> > Seeing it is also unused anywhere in the kernel code, lets remove
> > it from io.h arch-specific header then.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > Singed-off-by: Paul Burton <paul.burton@mips.com>
> 
> nit: 'Signed' (on both patches)
> 

Good catch! Thanks. Didn't notice the typo. Should have copy-pasted
both the signature and the e-mail from another letter.

I'll fix it if there will be a second version of the patchset. Otherwise
I suppose it would be easier for the integrator to do this.

Regards,
-Sergey

> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/mips/include/asm/io.h | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> > index babe5155a..360b7ddeb 100644
> > --- a/arch/mips/include/asm/io.h
> > +++ b/arch/mips/include/asm/io.h
> > @@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
> >         __ioremap_mode((offset), (size), boot_cpu_data.writecombine)
> >
> >  /*
> > - * These two are MIPS specific ioremap variant.         ioremap_cacheable_cow
> > - * requests a cachable mapping, ioremap_uncached_accelerated requests a
> > - * mapping using the uncached accelerated mode which isn't supported on
> > - * all processors.
> > + * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
> > + * requests a cachable mapping with CWB attribute enabled.
> >   */
> >  #define ioremap_cacheable_cow(offset, size)                            \
> >         __ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
> > -#define ioremap_uncached_accelerated(offset, size)                     \
> > -       __ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
> >
> >  static inline void iounmap(const volatile void __iomem *addr)
> >  {
> > --
> > 2.12.0
> >
> >
