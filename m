Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A81C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BA420867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aG8VWBP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BA420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLAJan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:30:43 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeLAJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:30:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id n18so5203457lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0LGi2iESujGEKunI2ZAkwkU5dDsCuWQej/bOBBt+bU=;
        b=aG8VWBP1942Yn6o7gY33+H1xUePmN/BA0WhJSVC/9/4Lar1fvNtDozywTw/GUgePOj
         JxhUT+X+k+O6KIMfhiNc3UluChbqY5wf64vFtiv5bJoWa3tmZjwa3IxIWRlctfwzs/zJ
         ENDp3BLz51vJ+3UEKsjxI6Re939zFXki/+Wp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0LGi2iESujGEKunI2ZAkwkU5dDsCuWQej/bOBBt+bU=;
        b=NSrDFL+ttA/+vr7G/wg5V19nNZ3mK9+ialRtTccV7IVQnpn1FXc1DnwglFO5oBPXXs
         Z6VhB/ORgIEJGGQBohJN4VnhqtqlTDi0k3Ri0PNqcw+whxlMmUt/kIY7XwlwEwsAKv66
         3PXR7NNWUk8IBxrlJDDZOx5+e107R0c1TfAbn+Th8p0ZnNA7lipIL3h0HEcMXcbMpsjx
         uCYc7GoiZjHC3Vfn0YGoOT+gv+jOoVwxoVeDKVE8bqW6XfK5nYQxJ4fCUribNlOm0GAP
         cFtHBnJYCnHBo1hJPITwUbxTGTjzk1X+HdqpdMImCLoRcbqR85lJ5bbnnrFAL4JEvL8U
         5QTg==
X-Gm-Message-State: AA+aEWa/nRxstiggtEGLIjfEpyJIPDSFAV6pP/u7aUmquiioGrLOrhIR
        bJWm03xvI3PQAYeeTSEcDh6ldllyS3VgvRKZVOLIgg==
X-Google-Smtp-Source: AFSGD/UW4gWsBn1KGuRpa6AEzV+0fg919AQS/OPPNOrQjLgNNWQLh/z8gbCGY4FpisF93mTelsuC+ne+mQHrnai0r/s=
X-Received: by 2002:a19:f813:: with SMTP id a19mr4486459lff.67.1543616394698;
 Fri, 30 Nov 2018 14:19:54 -0800 (PST)
MIME-Version: 1.0
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com> <1542861179-8941-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1542861179-8941-4-git-send-email-paul.gortmaker@windriver.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Nov 2018 23:19:42 +0100
Message-ID: <CACRpkdafCor2dMB2JmCyWMnCsrXoP2X8rT4ABdPGnB5ad3OfJQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] mfd: db8500-prcmu: drop unused MODULE_ tags from
 non-modular code
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 5:35 AM Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> The Kconfig currently controlling compilation of this code is:
>
> drivers/mfd/Kconfig:config MFD_DB8500_PRCMU
> drivers/mfd/Kconfig:    bool "ST-Ericsson DB8500 Power Reset Control Management Unit"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
>
> We delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
>
> We replace module.h with init.h and export.h ; the latter since the
> file does export some symbols.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
