Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A0020883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547826441;
	bh=1Miy3aFN0OHyEn0z4njGnh1OH+vjWPS6rV/qgFyz9Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lELhuIO6YV2krrCVoZNlQEK6o2ACd7HOTqidbOugsPlnqa16tZzfW9urqSFZr/TRs
	 DRHCmZeW26xLpyAw84nKszN/62hbDeUDEJPpkVSg4lJmFlNmBaDkwfyGg4m6BRPiVb
	 aNcnZFdSi424WDgglVSn2Gl3mwCu+jOx/YUlFDik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfARPrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:40154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfARPrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:47:18 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE852087E;
        Fri, 18 Jan 2019 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547826438;
        bh=1Miy3aFN0OHyEn0z4njGnh1OH+vjWPS6rV/qgFyz9Qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex4xzlo0KCjWfHsBzNmrgQ5tpK7aNZNCmDvC7YyktNxiYx5dxWrhQBpUQr/Uq3qpz
         U/nyLqHkw5DMEMJwafcidriCUITCVDZY+PlyR0Zga2c0xswUIpgpyd83lomvNj0aBS
         bJ6pOeceZ6Pyjnn+jFOM2rbxzuiQPbDSnlxBKQ88=
Date:   Fri, 18 Jan 2019 23:47:10 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     ren_guo@c-sky.com, arnd@arndb.de, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: Re: [PATCH] arch/csky/mm/fault.c: Remove duplicate header
Message-ID: <20190118154710.GA29661@guoren-Inspiron-7460>
References: <20190118095152.GA2563@hp-pavilion-15-notebook-pc-brajeswar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118095152.GA2563@hp-pavilion-15-notebook-pc-brajeswar>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Brajeswar,

Reviewed-by: Guo Ren <ren_guo@c-sky.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>

On Fri, Jan 18, 2019 at 03:21:52PM +0530, Brajeswar Ghosh wrote:
> Remove linux/kernel.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  arch/csky/mm/fault.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index 7df57f90b52c..16d8378cf12d 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -15,7 +15,6 @@
>  #include <linux/smp.h>
>  #include <linux/version.h>
>  #include <linux/vt_kern.h>
> -#include <linux/kernel.h>
>  #include <linux/extable.h>
>  #include <linux/uaccess.h>
>  
> -- 
> 2.17.1
> 
