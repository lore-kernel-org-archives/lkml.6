Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A11C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D39E218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/q7rr04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfB0Asc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:48:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39141 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0Asb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:48:31 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so6531650pgp.6;
        Tue, 26 Feb 2019 16:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ft0FA+4NTHqTeSvcJWsn7L3fQEbgpl8zmIuDm5nISvw=;
        b=r/q7rr04nrSR5NmbOcVfHrtA6shL7vv72GPVHN8eGR09TYzKd/w6vlOCZjuIMtWc/E
         uTdcHgHEZ4FBV8+y1MkjP3UTVqDeizQX9FgzWh4TJEvGRI9IhBOBJeK+vdQgyw1QSACZ
         562WWN+9jUJWfocIxwTkgIk8iVL5RUTLgJcxjZhvm15rJN/iEQuNgRoUAdr7YVLAG2Rg
         FIwjysDadzZ04TQCBvNbqy9Uq/5wLjs16snENMaqmq7k5hhIv1SwOlTUaOkhGyAl0d8S
         WVvLOVDpgGXGmrDomZxv419gz0QVUpllo3rkH2ckGE6+jYeoAjmekpSMn7zyzZH1otxB
         aTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ft0FA+4NTHqTeSvcJWsn7L3fQEbgpl8zmIuDm5nISvw=;
        b=Tlnyj4jvfa4VFVIpYuyWktEkXhcW5f2GaVctLIdFhkhok5Xmr0Udjvubp/Plv5ZXJ3
         Kos/qtWK5NsHSPeoM85lUH65cxI6MXCk9iuD7zsBGh7wDAQ2Tqw2yPAWEtvdRcf419DZ
         hGb41lv+c+oobpt0wrSmy0nM+CnosmlFuXz+VbXnHOV3l0/y8K7I2HB6yTRzdU1ZFacR
         kg2flFdk/6EoVP6l3Ln3ucLe5Edrp2ZFXq4PfbRMitaJrRJznX9SboAdlqy/XilOPRBk
         3D5lM8PeId0/71R82pdQRXsxeMSV3Y8TyVGFApBMof5y5eKdMjkrzZqxOL3a7F1+sAY1
         DDHA==
X-Gm-Message-State: AHQUAuZUO9eZnBh79gsY8XNdJY/d1aCLsaHuZCv4E9p1Dk14V7w/wvIy
        amNnBYgCVLwfAPtr1vGxrEA=
X-Google-Smtp-Source: AHgI3IYS8Vl3IqgWGYpSkAfRwYjjZlQXh8dyNZe0ySpSzlguvDRmvyztcXp8Zq2dyBAcojrcHSp1VA==
X-Received: by 2002:a63:5318:: with SMTP id h24mr275028pgb.76.1551228510466;
        Tue, 26 Feb 2019 16:48:30 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id s10sm22181352pfi.117.2019.02.26.16.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 16:48:30 -0800 (PST)
Date:   Tue, 26 Feb 2019 16:48:25 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, tony@atomide.com,
        vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tomi.valkeinen@ti.com,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] Revert "dma-contiguous: do not allocate a single page
 from CMA area"
Message-ID: <20190227004825.GA29112@Asurada-Nvidia.nvidia.com>
References: <20190226202327.5349-1-nicoleotsuka@gmail.com>
 <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3af95a-6e08-01fa-e4ef-07c1c1b6db69@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 11:35:44PM +0000, Robin Murphy wrote:
> On 2019-02-26 8:23 pm, Nicolin Chen wrote:
> > This reverts commit d222e42e88168fd67e6d131984b86477af1fc256.
> > 
> > The original change breaks omap dss:
> >      omapdss_dispc 58001000.dispc:
> >          dispc_errata_i734_wa_init: dma_alloc_writecombine failed
> > 
> > Let's revert it first and then find a safer solution instead.
> 
> Ah, I think I see the problem - once arch/arm's __dma_alloc() has decided to
> use CMA (because dev_get_cma_area(dev) returns the global area), it then
> won't fall back to trying a regular page allocation if
> dma_alloc_from_contiguous() returns NULL. Thus anything on 32-bit Arm trying
> to allocate a single-page buffer in blockable context with a CMA-enabled
> config is just going to fail. Similarly, it looks like none of the
> DMA_ATTR_FORCE_CONTIGUOUS cases are prepared to handle this change either
> (amd_iommu appears technically affected, but is already using
> dma_alloc_from_contiguous() backwards compared to everyone else, hmm).

Yea, I searched the tree and got the same results.

> I guess the question is whether to add alloc_page()/free_page() fallbacks to
> those call sites, or stuff them directly into the CMA helpers here.

Probably would be safer/easier to do the later one I feel.
