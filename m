Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA57AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7120B21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHraBigd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7120B21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeIZXMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:12:46 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37688 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeIZXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:12:45 -0400
Received: by mail-it1-f193.google.com with SMTP id m9-v6so3840326ita.2;
        Wed, 26 Sep 2018 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk4phsQMsWm/uLqtYjyTCCVZkWmOftfD6xEiXH8xJ4U=;
        b=oHraBigdw5BEX0LUXs9GlUBIE7zHK53SIga1HWIx81sxIHv+NoQQonTbfj0UDv0Z+J
         EQSG24+ZrTq2bjXRoMcoLR9rgJsgajjfUmZPLqE2bDOYvYgnz360+UkBGbEDzcJnF0tq
         6K5wSTz3jRyehlYV6yPMPvwuOsdYapx5l6cpXY8Mkbi6V3d1SE8CtJm9K5lGwAdAUrlN
         acztf9YRzQth69K5a8XlkVNbBBuLDtkA07DrDWyTfFom8LBLIbsW7dzc+R1LcNm7lpk9
         76Exn3TO6BvTde5ueWmipdKNRWdyh+ywfJROOPd3cOVszLtHI3cLSo+bqjdR/FhrC/tH
         cEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk4phsQMsWm/uLqtYjyTCCVZkWmOftfD6xEiXH8xJ4U=;
        b=eQzfdLBGDx2n0RyapX5cjmYJ6twjOf21ab3Na8fORT88gMohtfChtvK2j2jb8kaCFg
         qBy1NOUEdapiPkRhj+99ntmdJS20v87ywnkRvwMD2gjs9qY80DvWBclNgm5FRlFNW2qx
         uR8ia+5odEbahxf+PGsx1IdnhXq7go19xxeDYKHO6LM7ilakUmVuPU2y4rurKWe9TZqR
         yWcKYoQRm5i8sg93l1fPxIOV4xSoqF2vrGVpJliFrGd74BZXR6jZpiJLeRPHiraUo1uy
         VCnJgQl+AadzmK+sIjGE+zo+ZxBmuPV3QLSqxNet8eopIlQo7c4vOmFqsmSeUTElyQHq
         WZvg==
X-Gm-Message-State: ABuFfoiBFkcSiP6X7uOUmVJG8DjPR4YUGNYpxyULUGXXwbvpAVQ5Lq00
        0nkYczvV4CA4Sh6uQX4EMy5qs68ZuMOHuhGk3yo=
X-Google-Smtp-Source: ACcGV61r76+3aUI+rvs9VbR2N0bAv7M/QbDxsEezQCK5N1Ftrt8LN0aVWm4RPYDKt2cA/F5iz5Vl4HGEmxZqV8pRXgw=
X-Received: by 2002:a24:9a83:: with SMTP id l125-v6mr6225072ite.76.1537981132489;
 Wed, 26 Sep 2018 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com> <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 26 Sep 2018 09:58:41 -0700
Message-ID: <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com>
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn,
        Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org,
        jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>,
        lftan@altera.com, msalter@redhat.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mattst88@gmail.com, mpe@ellerman.id.au,
        Michal Hocko <mhocko@suse.com>, monstr@monstr.eu,
        palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org,
        richard@nod.at, dalias@libc.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, vgupta@synopsys.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> All architecures use memblock for early memory management. There is no need
> for the CONFIG_HAVE_MEMBLOCK configuration option.
>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

<snip>

> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 5169205..4ae91fc 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -2,7 +2,6 @@
>  #define _LINUX_MEMBLOCK_H
>  #ifdef __KERNEL__
>
> -#ifdef CONFIG_HAVE_MEMBLOCK
>  /*
>   * Logical memory blocks.
>   *
> @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
>  {
>         return 0;
>  }
> -#endif /* CONFIG_HAVE_MEMBLOCK */
>
>  #endif /* __KERNEL__ */

There was an #else above this section and I believe it and the code
after it needs to be stripped as well.
