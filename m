Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E580C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D2020837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YmHlXfSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D2020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbeLGObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:31:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45462 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLGObg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:31:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so2025215pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pQvrTvbt5ZlQ1ucq18V0+cEkB9byjzVJXmwH6c2GtJc=;
        b=YmHlXfSfWSnjXLfwbC7Ak6E0eZZK1vdJ08PFmlH2+wNupk0plHS15KD5XobbGw9g26
         DNLjhZdW0hfhhi0wWdHfjCUzOlsDekNHIaaimm/x2d09VkUx4skYog+CvRIPiO1LVqz5
         D3SWZUp+JNDupIYw7Ld7bO6cx0Bai+z9Pl7cjPUUgnqogpXWt3Si9Lans1d485AhaPUi
         pc+97LN26bnrF/+Obkp/3s2CzLYMm0bOFlCtOYUosg80f2L+xS+Dxhy8hXiVDgK5i+zS
         QwFq4FM7xrdJUm1Fl3hrAhk4EVhHHTodMV5JhO288aVBZheat7o1CnuLS3VH3AKUa7TO
         rFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=pQvrTvbt5ZlQ1ucq18V0+cEkB9byjzVJXmwH6c2GtJc=;
        b=SVxUr+7WXSZnzOEgxSYo4cbmfpYZxCfM6TRTMCKYuB2sttq65+VAtLrY4XUlJR9AdF
         VdOslxKKtKXQapsCnomXB9v31G64VsKJonyVnPfFNN4P1EHCuGGM2d2lt2eDDLB7/UnQ
         uL7m2RU6ALmJuCL4xh4OVO7BK2EVAqPhvbJ229XRmRgJCVyzWVlw8zeNFrSMRyut1y98
         01xIR7AmfIMZC2KZ07Rw04tj5arY674m1CIAH3scoSDRUKwiXQgaad/+jPbWXy/L8XVG
         AMnlVxePLAOyhAeHwfBHFiZLM1u1lUUnDS3LLkxpOSK3PhAe9eQE8A/fGZBKZKcjfSjJ
         dPLg==
X-Gm-Message-State: AA+aEWYR/iaCj+Shx2aBCHMtc//EMsS21hVfbi8+VaygjHp7y5AuG/1i
        3aDUa9rdBt9hhCpE9NEA6+F09A==
X-Google-Smtp-Source: AFSGD/W4rz+ItvPt0+2xVpF39KYu2QCPOrHC1dKJby4nrZxQ0gBxahGgarhJWP8BtaUPLQ263iSePg==
X-Received: by 2002:a62:9419:: with SMTP id m25mr2566759pfe.147.1544193095301;
        Fri, 07 Dec 2018 06:31:35 -0800 (PST)
Received: from localhost ([2607:f598:b382:d300::14ef])
        by smtp.gmail.com with ESMTPSA id d25sm5609037pfe.40.2018.12.07.06.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 06:31:34 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 7 Dec 2018 06:31:33 -0800 (PST)
To:     Rob Herring <robh@kernel.org>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <CAL_JsqJgt3VxHLcxY54Ojpqz_bLwGSySZ9meowgy6pnLPdXuLQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1812070624180.16511@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1811211704520.16271@viisi.sifive.com> <20181207000104.GA10814@bogus> <alpine.DEB.2.21.9999.1812061645070.29609@viisi.sifive.com> <CAL_JsqJgt3VxHLcxY54Ojpqz_bLwGSySZ9meowgy6pnLPdXuLQ@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Dec 2018, Rob Herring wrote:

> On Thu, Dec 6, 2018 at 6:46 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> > On Thu, 6 Dec 2018, Rob Herring wrote:
> > > On Wed, Nov 21, 2018 at 05:06:56PM -0800, Paul Walmsley wrote:
> > >
> > > >  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
> > > >  1 file changed, 38 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> > >
> > > Use the path that was suggested.
> >
> > Could you remind me which one that is?
> 
> In this thread: bindings/riscv/sifive/

SiFive also produces ARM-based SoCs.  Some of those ARM SoCs may use these 
IP blocks from sifive-blocks as well.  As far as I know, there's nothing 
RISC-V-specific about most of these IP blocks.  (As an example, there's 
nothing CPU architecture-specific about a UART.)

I'm fine with putting these bindings under bindings/riscv/, if that's 
where you need them to go.  But I'd like to understand the rationale 
better - could you describe that?

thanks,

- Paul
