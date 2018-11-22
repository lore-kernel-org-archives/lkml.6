Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C765C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666D9206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lb2fFz3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666D9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406235AbeKWDuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:50:25 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41702 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406219AbeKWDuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:50:24 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so8542217ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYDiCn4mNgKeBgCg8HVgmKexqx+tdckvx/rsj11k3pI=;
        b=Lb2fFz3gCklF0kZwM7nPIoqxdu02kc9pZ4cClaJtCmpIsXS3GRG+rNT0XpMk46ng6v
         sfoaZruYdNinptlOoOnXgYzSQ/5zAp1Sgv6cPCYm/18vdv01j4Pd5EbQimpHJBDzILyd
         eRMKziO9vBVOcF8ZjSg1ClJifqAgY4ZX4Avpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYDiCn4mNgKeBgCg8HVgmKexqx+tdckvx/rsj11k3pI=;
        b=eqAK4gTROYBqmPIfHi7CSNFHOA+c1XaziZ6nYlqwgR45Z43HM74WYohYRpH8EUiVDQ
         AVaWUhE1IMbhZbLFGTxOKMbykMGyPIDaK5nK48XVTb6HmcD5s17LKBo4EQ51qHro2KxT
         CMfmqIRPviLbSY8qNlRM5oWFr+YJ24IxwfAvJwkgGWiuz28JV3v5rtVuOjW021b1oSqV
         DrOHeCds8Yoa7GWr0eGdJBMW6nLcmTCCo7sswme6sp3mWBI2iRV9bJv/4M7mD1MD4gfd
         3F7HTi9F12Z/7z/dOvUmYyIyvAf67BNRFV74+vbGMopDaNg20RLg4CN5pVcvLj4vyVH7
         6+rA==
X-Gm-Message-State: AA+aEWa46mQOYKSl5wwZWkmFxHvRsks6dZRNO8olsf8W6JLD2Fuy69Zv
        L7fw3U48sw8P34mPB69j9HRMr6s3bee2ww==
X-Google-Smtp-Source: AJdET5eCHfTUaHCE1t09HUM1mM8sKmeq1Dx+LhAMao4sPNtyd3gDFyXE26al8ZqwZ9jlOB9nebktCg==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr7569795lji.144.1542906605087;
        Thu, 22 Nov 2018 09:10:05 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id c133sm8212297lfc.45.2018.11.22.09.10.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:10:04 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id a16so6987111lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:10:03 -0800 (PST)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr7310636lfg.117.1542906603412;
 Thu, 22 Nov 2018 09:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20181122140320.24080-1-hch@lst.de> <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
In-Reply-To: <20181122170715.GI30658@n2100.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 09:09:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
Message-ID: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To:     linux@armlinux.org.uk
Cc:     Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>, joro@8bytes.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, jdmason@kudzu.us,
        xen-devel@lists.xenproject.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 9:07 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> I'm afraid that won't work very well - 32 bit platforms with 64-bit
> addresses (LPAE) would have dma_addr_t as a 64-bit value, which
> wouldn't fit into an unsigned long.

Good point. So we'd have to have a special IS_DMA_ERR() function that
takes a dma_addr_t and checks the same "is it the top 4095 values".

Because I'd still prefer to allow people to return the _actual_ error,
and to have "return -Exyz" as the error case. That part still DTRT
even with dma_addr_t.

              Linus
