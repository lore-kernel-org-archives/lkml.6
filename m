Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C6AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D0321B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550003074;
	bh=BveQ4nP7N3gyvkFjUSr90tJMP/e9r0pbToW4MSxdXJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UUWeKG2Y34tJJjc4jUE4fDB5ONfqQZtmwfoHQxgZOtt8A7G3cjnDAMpVdIlDRgEU7
	 I9/KzLzRQosQT3BRN8YpiMdYmf2V5Ewo3yliGWvwHfF6idwQweTUJhqyI8S+9TMhlX
	 v0/LI5UnIJMICVUjq95uiDGaz9aaEYzx1VjJlMP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfBLUYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfBLUYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:24:32 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4515D222CA;
        Tue, 12 Feb 2019 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550003071;
        bh=BveQ4nP7N3gyvkFjUSr90tJMP/e9r0pbToW4MSxdXJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gRVLLXcgZ1AIYHYj00/fl4zJj5uwHFRPiSNjERGvza+b63FiOJlGAARkss3C3bqVe
         4xSpSvXckOl0xlj/QTFw+dpy/7ieM/yBbv5RtKuxEnIMrAqW/ZjmlfrqjyFVRm9s3z
         z0YNNT67Hgad3I7KnqxwKPL9kYfuWQJIEs817/Zc=
Received: by mail-qt1-f179.google.com with SMTP id n32so4522361qte.11;
        Tue, 12 Feb 2019 12:24:31 -0800 (PST)
X-Gm-Message-State: AHQUAuZwwyhz3JwrSSpKs/bubX7hW8GKBuY5AGGNTvVK1+jL305cYRmu
        uj6qRVOoJ57mK2R8ZSgndGnnrQxijys+caEawQ==
X-Google-Smtp-Source: AHgI3IZ+aYxfQi/q+LDrbNlsuqcIsAtFo4UYad7A+3Ns0Rodh50TLXP9jNafEkB5/FuiwJjwL14XDxq/b8yo4h5Ejaw=
X-Received: by 2002:ac8:2f4e:: with SMTP id k14mr4325527qta.76.1550003070462;
 Tue, 12 Feb 2019 12:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-4-hch@lst.de>
In-Reply-To: <20190211133554.30055-4-hch@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Feb 2019 14:24:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Message-ID: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
Subject: Re: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch static
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        SH-Linux <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:36 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This function is only used in of_reserved_mem.c, and never overridden
> despite the __weak marker.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/of/of_reserved_mem.c    | 2 +-
>  include/linux/of_reserved_mem.h | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

Looks like this one isn't a dependency, so I can take it if you want.

Rob
