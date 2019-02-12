Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4CE21B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550002300;
	bh=3jUa/zunVYEZn+DyMnsy8KXouqEiFYqtXTvcx6an4qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZWxempdzs7El04cqw3SaadqDKiodscwD+QdKA/PHdC/Vd5Zpz9T4jhbbVNByab3rc
	 hNJi61hAQx27Pmp/Nd5ig7dwWI8oouEDsUK24wumbjttvbRbYLer5vsV8jQtrRz7rC
	 K7f1CDnwksIcSI0e/pNSfnFc5r9n3YUbk8mEhsAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfBLULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfBLULi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:11:38 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7437D222CA;
        Tue, 12 Feb 2019 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550002297;
        bh=3jUa/zunVYEZn+DyMnsy8KXouqEiFYqtXTvcx6an4qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rS1bcNk+w8HmhmSC51+HlkPK92wtM4VYvSp1r6hov6nO+UgUiVmNcSMLjdzccAjIS
         CGfD1WLWCgx6ETbf06Bs3l5HGaxPcdQTrOW4X3yWLL/uX4LMGl6JioWcOF3ro1y/xl
         I2QY4V+JzHuYKiqSYoL+o1vgv+BgF3yQob+EZwW4=
Received: by mail-qt1-f181.google.com with SMTP id e5so4466337qtr.12;
        Tue, 12 Feb 2019 12:11:37 -0800 (PST)
X-Gm-Message-State: AHQUAuYHDVKz7udbIuxufKEVo3rgI3XMhLPtxZxI4/zxAH5jEYMFPu6D
        T4K8FTTbTttRCOuoQPjVbjaauaNQqEfNcS4GtQ==
X-Google-Smtp-Source: AHgI3IbkdyI3kKb4Rqp5UgWWae9Pz2hV3loOAoVLCgrxJ3QQUi58Dd1hLL5El9rPrWVkYWU9ykNePmU2n4HW1F2r7SM=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr4072679qve.246.1550002296610;
 Tue, 12 Feb 2019 12:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-5-hch@lst.de>
In-Reply-To: <20190211133554.30055-5-hch@lst.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Feb 2019 14:11:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
Message-ID: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux IOMMU <iommu@lists.linux-foundation.org>,
        linux-xtensa@linux-xtensa.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        SH-Linux <linux-sh@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The OF_RESERVED_MEM can be used if we have either CMA or the generic
> declare coherent code built and we support the early flattened DT.
>
> So don't bother making it a user visible options that is selected
> by most configs that fit the above category, but just select it when
> the requirements are met.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig     | 1 -
>  arch/arm/Kconfig     | 1 -
>  arch/arm64/Kconfig   | 1 -
>  arch/csky/Kconfig    | 1 -
>  arch/powerpc/Kconfig | 1 -
>  arch/xtensa/Kconfig  | 1 -
>  drivers/of/Kconfig   | 5 ++---
>  7 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
