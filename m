Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772A7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F69259E3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbekS076"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F69259E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeGBNRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:17:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54989 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeGBNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:16:59 -0400
Received: by mail-it0-f65.google.com with SMTP id s7-v6so1163504itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8Tyck/fpr3h2SEG8ettETXVGTj5ZjnaMd7qYmRT1Apw=;
        b=WbekS076fGz+3CSL9K8sO4qRbQpXPX9NPM3X8QIK88BGy9nOEGIpxREI5TDVmi39D2
         sR16N7dYtm4FOnQxoXW/FCQ+YUcWKy9Oo5izRd/dXMgJthVIiCd6zM85VdlesE3BMvUk
         6iJzbLPhLDiKNo8FoPaAJK/Glb2oirf+VTs88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8Tyck/fpr3h2SEG8ettETXVGTj5ZjnaMd7qYmRT1Apw=;
        b=dD6OPUnkG+Kn0opX02nkBfuuoh4pn1NLqYZ0F5xO9B836s6Y7dbj0C5f5SXCrnPR/P
         MvZWaXMD6Ihw6ZEfRp0Ex3y2gOasX0SUZwMF66V0pyYiOaODya3t0czIcANmgE+6VV4j
         wSgtzVGLsJIL0Cc4CJcRfdRNyvamlpbIxC2GiWrgO3PLhGBKtxcggsYVy/oQxXoxp78S
         RcXyyGdTceM6hKpUmehVgmLQhT7tqe/hxUyfr/xIJacvman7Dm0DvUsbNZXTPYTw/IXu
         sVKVbwfruOLn1YmbZNTILQL/Jnolcc3Hnxb1r+r2dDyS2cnKYkgfPjE0/xDWzLeNtUD0
         JIGg==
X-Gm-Message-State: APt69E29NjhWMfQTE6pHixGC95/IrYYghC6xwao59XWK3VfPL5Tfe6MF
        AhWKIVfQKOT7aLKrdfCCCCwMUMaSFBa4rQr5LGjS7A==
X-Google-Smtp-Source: AAOMgpf9tO3qjVtFGD1i/Fls0NlkGDOGk6Px008zA9kz2oOUy0gWAfuoNm/Pun4jPgyHdbPodHnwdQs+OG3+2DnTHPA=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr10582054itc.102.1530537419303;
 Mon, 02 Jul 2018 06:16:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:16:58 -0700 (PDT)
In-Reply-To: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jul 2018 15:16:58 +0200
Message-ID: <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 June 2018 at 20:43, Corentin Labbe <clabbe@baylibre.com> wrote:
> This patch fix the following build failure on m68k:
> ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 0581c199c996..77d6ba090436 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +       depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.16.4
>
