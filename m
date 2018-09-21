Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1829BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EA321565
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kyLOwXdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EA321565
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbeIUIR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:17:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40658 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeIUIRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:17:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id c126-v6so7395066qkd.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7s7oNbhT7E/XWLpCd7qRAG2IDeU2SwlRsyKvMpjqLc=;
        b=kyLOwXdOI8TT+kiBRzDynLAF0O2m6Vw17WPB6C5xNwkVuhtCZcOdr7MDyjG/BFiNLr
         Sx6n9wx29gBoVy3hEn+ls8nD107TPqVNn5Y5WG8tyWD/vxK60FjDyWG7wg98bpEG1QFy
         n8PdcSbN5QlcrLXMUz0CoU3Jnf6p/Zs4UAvY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7s7oNbhT7E/XWLpCd7qRAG2IDeU2SwlRsyKvMpjqLc=;
        b=XRLdVOI2tzr+Lpd3TU1S80meJo2Z7tIeJEmXVNDJEE3v2WTRrxNYXpokfsnsHf8/kP
         MSOTh0G9YbdoEWX82qqf5PrB1pX3vXBWMbBM441M9akGLHtQcz+xiN975leyuB1aAeM1
         tjTSLxgZxreIsdsrDr906gpNmtdOr8B3GNqQHe9zdNbCIjSNOJwfbjaoU3tLIZQyGBHd
         yE3dmU0g4FnDrlH7nArmUvlHCPgt32YLAEu74b/u40z3OLlFMZpY4Q44p4gSU7I2HskT
         6qYQ6Bfhs1f8Lzes3HJgoUgob/W7mVUYSEQClA402EjFPPZxglDwoQ0JSvkIL8niJ0Nh
         EWyg==
X-Gm-Message-State: APzg51AKFHBtU7pnes5b1A8e8DqYUX1CCP5C1JqQM7z+fTLbzGQ8kwt1
        9sp23ZGuRel70rYrF3MENhZ+gbhj7GMmyOEJX8s=
X-Google-Smtp-Source: ANB0Vdazxsa3KelbzNFd8QCeC6IYg3E0ca5x7y1lulmcOIjXrt30/w0X6jy2kjLksyKxOriXbuRexnVl6U2BwCci9GI=
X-Received: by 2002:a37:642:: with SMTP id 63-v6mr28805831qkg.11.1537497048398;
 Thu, 20 Sep 2018 19:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180918230756.26035-1-joel@jms.id.au> <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
In-Reply-To: <CAJKOXPd4dCyuXKxAz-V=ujtiuKcumHzAx28y5J+6m+L7ZRLsZQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 Sep 2018 12:00:36 +0930
Message-ID: <CACPK8Xcx7i_pe65PH+ECA6z0M_h5H1uW3wdUKS3RG5HYxEhgpg@mail.gmail.com>
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 at 16:09, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, 19 Sep 2018 at 01:08, Joel Stanley <joel@jms.id.au> wrote:
> >
> > This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> > polynomial").
> >
> > The cleanup added a dependency on include/linux, which broke the PowerPC
> > boot wrapper/decompresser when KERNEL_XZ is enabled:
> >
> >   BOOTCC  arch/powerpc/boot/decompress.o
> >  In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
> >                  from arch/powerpc/boot/decompress.c:42:
> >  arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
> >  linux/crc32poly.h: No such file or directory
> >   #include <linux/crc32poly.h>
> >            ^~~~~~~~~~~~~~~~~~~
> >
> > The powerpc decompressor is a hairy corner of the kernel. Even while building
> > a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> > files from include/linux.
>
> I fixed the build error here:
> https://lkml.org/lkml/2018/8/29/179
>
> If you choose to remove any includes from /linux, then go ahead but
> please use original reported-by :)

Okay. I'll try Christophe's suggestion instead.

Cheers,

Joel
