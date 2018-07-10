Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31704C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2F0208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDQikjiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2F0208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934354AbeGJPrk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:47:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37314 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeGJPr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:47:29 -0400
Received: by mail-it0-f66.google.com with SMTP id p17-v6so31971622itc.2;
        Tue, 10 Jul 2018 08:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N5oYc937BspWe+glZQkI9w0XadUA7+lEzkqHaB6z8iI=;
        b=pDQikjiuFxbnaxGci6xmSFWVicpzwe0e83k7Mb2LTpyNl+xFoGgao99dH1TK+HXFQA
         IE8NKaiivCyoXnnaj7H71lkRxOOCzd/CBuFX0xNDL4716O1I9u16aOv/njopyx+KMBiU
         zE+xWuDvKPOIrsNNtpY0nCpbv96JtjJOC5uv8C5KILrXXZRhI8MCoZqT+yRFM8doVzZt
         VfkDbQM+6TkmuGDY5i0wGmQQ9NQUmy7Uovka70bajmr/HW+++wqzrfkRZuRdaqQtB917
         DIXCtGVCyjEHZwVvEv6COJ7uuB64zW/pbgyjUc13JH2YFAfIY5JeV/D/2RFwcXXFqat7
         XD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N5oYc937BspWe+glZQkI9w0XadUA7+lEzkqHaB6z8iI=;
        b=Bw+e58/pFLdmdqgCGjGdcKzYwvn9NJcwWXPjZJ/yOF5Olj9wHUVQ2c6p9aDffUxcNd
         EnxJyH2dDBEXLS+Vt5Qxs+koMFllEJkIyRCl4WgKnrjBUN0Di/NwMkF6Zr0qa9vKoyNv
         FQ6YuVN/62fiPLMXR179Sj6/7+us/m/OZ1r6meQLcmjIvnovP9gWdopRTXNE9tLcuqOw
         qXbfcjSR3DAGsJtEKJKS8Gc6TREizINVQam/JOcYYqNPe1m4mnmDb+cSm3xggcR6MVry
         xrZlIPXWgyJuj580j1g3Okt1jtE5lo1yxug5tDKNQGfAihx7dSX7jKcoDc6NWv0yTPEC
         rt/A==
X-Gm-Message-State: APt69E1m9PktH06tFddtR8wVZnGf1Z9VE7Qff57rrCoX5+z1/MsAhkR3
        mA5OPGq6fWXGzedQtJ3yis2oNbO5wHLRPLUy+00=
X-Google-Smtp-Source: AAOMgpc0EOcTuRlEpGQw4fD+qZd9fIjCFOsWJw/cDkxFq94de7jokfF9yJXQZIBtlZ8nF7nUsoAuY9W1zZbGcS0ZfIo=
X-Received: by 2002:a02:9c33:: with SMTP id q48-v6mr20323720jak.103.1531237649261;
 Tue, 10 Jul 2018 08:47:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:d00d:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:47:28
 -0700 (PDT)
In-Reply-To: <20180707024902.439-1-andrew.smirnov@gmail.com>
References: <20180707024902.439-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Tue, 10 Jul 2018 08:47:28 -0700
Message-ID: <CAFXsbZqgc7B-YE-aFgT=Qz20u+JRvvfdQFgh77Zv-+w62GA7XA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add ZII SCU2 Mezz board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Successfully tested on an SCU2 Mezz board.

Tested-by: Chris Healy <cphealy@gmail.com>

On Fri, Jul 6, 2018 at 7:49 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Add support for the Zodiac Inflight Innovations SCU2 Mezz
> board (i.MX51-based).
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: cphealy@gmail.com
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Shawn:
>
> This is a spin-off of SCU2 Mezz board support originally found in [v0]
> as per out off-list (Fabio, Chris, Nikita, myself) to add support for
> ZII hardware fist and worry about factoring out commonalites later.
>
> Original submission was done by Andrey Gusakov, but he is too busy on
> other projects, so the honors of submitting this were delegated to me.
>
> NOTE: RAVE SP ("zii,rave-sp-mezz") node is technically supported by
> upstream, but it needs some fixes from [rave-sp-fixes] to work
> correctly. If you want me to drop that node until [rave-sp-fixes] is
> merged, let me know.
>
> Changes since [v0]:
>
>  - Patch converted to be a standalone file not dependent on any
>    ZII-specific .dtsi
>
>  - Added RAVE SP node with all the children that are currently
>    supported by upstream
>
>  - Droppped ecspi2 node. That node didn't have any child devices in
>    [v0] because none of the chips connected to that bus are supported
>    upstream. This node can be added later once anything attached to it
>    has upstream drivers.
>
>  - Dropped i2c_gpio. That bus was originally added for RAVE SP related
>    prototyping and is unused in actual product.
>
>  - Various newline fixes pointed out in [v0]
>
>  - Most of then nodes should be sorted alphabetically (I might have
>    missed some)
>
>  - Collected Reviewed-by from Fabio (Fabio, I assumed you won't mind,
>    but let me know if you want me to drop it)
>
> [v0] lkml.kernel.org/r/1529603100-31958-4-git-send-email-andrey.gusakov@cogentembedded.com
> [rave-sp-fixes] lkml.kernel.org/r/20180707024108.32373-1-andrew.smirnov@gmail.com
>
>  arch/arm/boot/dts/Makefile                |   3 +-
>  arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 448 ++++++++++++++++++++++
>  2 files changed, 450 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
