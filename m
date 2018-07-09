Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280F42075B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gglGt5iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280F42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeGIPuV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933248AbeGIPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:50:18 -0400
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com [209.85.214.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55BE52075B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531151418;
        bh=p8DqpgUoqm9jfRUY8z0mv5IC2TQFsJlb1W8UwCvTDhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gglGt5iyENJUOwUwB1ijRftYU2bQ6yS4CcUBaNWfGX8HsIr2ICExlbesxgknj+78o
         RjihQshaOeZ2CcIGRxkKTrhnbnqHs3L5nxCYJpZ4xJl+f2mHDa6QwbGXVk8cdKFtMH
         gjErsC350oaqyu3fHBZg0cv19IQv2rfrKw+IGExM=
Received: by mail-it0-f45.google.com with SMTP id g4-v6so10014150iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:50:18 -0700 (PDT)
X-Gm-Message-State: APt69E26g5s2vs3Yte3kIKm2CPwZOFQmgFAMrxZ3a0HhxcFKatN5qovK
        p7cBxvWBPoJX8j5PaA0nR2gi1gVOBh++WXRX5A==
X-Google-Smtp-Source: AAOMgpc0OR1iyEDS8/d5Psb0lFl5fmrc9TLBkwXFiGe/DGdpMDL/9k71NgNWq3A/zLWPeURb9F7m0zgUMdcJa/53x7A=
X-Received: by 2002:a24:3ac3:: with SMTP id m186-v6mr16429527itm.106.1531151417781;
 Mon, 09 Jul 2018 08:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180619214134.20130-1-robh@kernel.org>
In-Reply-To: <20180619214134.20130-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jul 2018 09:50:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKwtxDck67QHrZSKKrEXt-ERxH6W0srdw2H5A24CdSKA@mail.gmail.com>
Message-ID: <CAL_JsqJKwtxDck67QHrZSKKrEXt-ERxH6W0srdw2H5A24CdSKA@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove unnecessary of_platform_populate call
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:41 PM Rob Herring <robh@kernel.org> wrote:
>
> The DT core will call of_platform_default_populate, so it is not
> necessary for arch specific code to call it unless there are custom
> match entries, auxdata or parent device. Neither of those apply here, so
> remove the call.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/riscv/kernel/setup.c | 5 -----
>  1 file changed, 5 deletions(-)

Ping?

>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ee44a48faf79..f0d2070866d4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -220,8 +220,3 @@ void __init setup_arch(char **cmdline_p)
>         riscv_fill_hwcap();
>  }
>
> -static int __init riscv_device_init(void)
> -{
> -       return of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -}
> -subsys_initcall_sync(riscv_device_init);
> --
> 2.17.1
>
