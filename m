Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744532152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744532152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbeIUAje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:39:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40849 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387865AbeIUAje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:39:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id v10-v6so10512655otk.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvHUmPg+LVOwneV25jZ5AWR93WLMwiIvr2Fn2r3/IBs=;
        b=XAfQfdFlONICwsVUC+r4093LRqYIA5qTbClw4sBVqgRlquAV9v3jSx/tAKAU7dnRQ6
         52GH87D5VVTHkwnfg45dU61FAt17swgpmhp786SbmriQf5Iowm10C82tzPxc7O0rnCSl
         9zWatEKNopW3+qaG2xXc7lc3hTFi4qqUQCeFEJIZtE056m1UJr8iKc+FUa9mfSCYDyPk
         yb85BYq57IrdQUUwR4MVQ/NgaCFZCTtYkf4vFcWaSVlNzYWXXP5Fo+L5jgX9+sfbaHSF
         HWLC7n4ZDLWjaDB16x2FnMYPtrZLZzNgEdL8BqmsbPEFkFzqzE+ieTWwJLESpZke9lin
         YD/A==
X-Gm-Message-State: APzg51AFAVQ+2ruykosL/uqZ2nkKoKDqvTAbSi5+8LNt6O3LydQoh12I
        +3av6KKHmknVM3ZJI2UCsPaMBJFU
X-Google-Smtp-Source: ANB0VdYv3jI4MJyJshIWyqo7Ewq3C8XZgD6ZjTdO5xyD9NQboCa/nq29h5LYthPhJ3+NWbH3E2ExCw==
X-Received: by 2002:a9d:4716:: with SMTP id a22-v6mr7541456otf.242.1537469681312;
        Thu, 20 Sep 2018 11:54:41 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id 31-v6sm7587637ota.23.2018.09.20.11.54.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:54:40 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id j9-v6so10531263otl.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:54:40 -0700 (PDT)
X-Received: by 2002:a9d:48a:: with SMTP id 10-v6mr21149429otm.361.1537469680529;
 Thu, 20 Sep 2018 11:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com> <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 20 Sep 2018 13:54:28 -0500
X-Gmail-Original-Message-ID: <CADRPPNSz-x1uf98+cKUjj54sSxQbJOXWk7xn_ExhbcjdAYKUpw@mail.gmail.com>
Message-ID: <CADRPPNSz-x1uf98+cKUjj54sSxQbJOXWk7xn_ExhbcjdAYKUpw@mail.gmail.com>
Subject: Re: [PATCH 2/4] soc/fsl/qbman: Add 64 bit DMA addressing requirement
 to QBMan
To:     madalin.bucur@nxp.com
Cc:     Roy Pledge <roy.pledge@nxp.com>, claudiu.manoil@nxp.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Scott Wood <oss@buserror.net>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:09 AM Madalin Bucur <madalin.bucur@nxp.com> wrote:
>
> From: Roy Pledge <roy.pledge@nxp.com>
>
> The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
> boundary so enabling 64 bit DMA addressing is needed for QBMan to
> be usable.
>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> ---
>  drivers/soc/fsl/qbman/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
> index d570cb5fd381..19d6f4621e23 100644
> --- a/drivers/soc/fsl/qbman/Kconfig
> +++ b/drivers/soc/fsl/qbman/Kconfig
> @@ -1,6 +1,6 @@
>  menuconfig FSL_DPAA
>         bool "QorIQ DPAA1 framework support"
> -       depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
> +       depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || ARM) && ARCH_DMA_ADDR_T_64BIT)

You also added ARM support here.  Actually the dependency on
ARCH_DMA_ADDR_T_64BIT is only explicitly needed by ARM(other platforms
already implies ARCH_DMA_ADDR_T_64BIT).  So I think the patch title
should be like: adding 32-bit ARM support.  The ARCH_DMA_ADDR_T_64BIT
is enabled by ARM_LPAE on ARM.  Probably we should make that
straightforward in the Kconfig, so that people better understand what
is needed for 32-bit ARM.

>         select GENERIC_ALLOCATOR
>         help
>           The Freescale Data Path Acceleration Architecture (DPAA) is a set of
> --
> 2.1.0
>
