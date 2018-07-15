Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77AECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA17208E7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 16:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a06v9yWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA17208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeGORFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 13:05:23 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39709 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeGORFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 13:05:23 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so70567080oib.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b5VTbpe7AyU6WgRKU/r7A1fMYOsGwEhORjQ0/w/rTfA=;
        b=a06v9yWmO2oluZfYc3WmeC9HMSdzzjL4HL2M9cccxFyixABFpY26lMGFMnL4isceWt
         JvDEFlnqeYuEk0FYTWO0U25sb14gh5lSlDcuhCTwslbRqnsi+Wo5QpG7ffN0ZiSlpQUO
         x9lrHCn3UYeDbcfOk+RdLbpZqCE7xLcNxVQ1+9y/6muaFd2krCjxICSTMBOuHw2Jfb9Z
         1kCTMG+3FLu9gAUzTG2r6CGexH9TlyeJAXlXRJmfEqdsDXUZlR0AhVf/ZLEAHnThm9Yn
         2rKI7IjHd25SA2IBdR3tztflMw5GvJYjUZLRx7sGiGkNmU8gPW0iw+ebB3smS6PJP75o
         xXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b5VTbpe7AyU6WgRKU/r7A1fMYOsGwEhORjQ0/w/rTfA=;
        b=WgQ9TsUaiRf0ieWjI1xE0hgduo7wXhRlimCi1PS0cN3+JCFUOCAZxQsObKvVcqcXcT
         fyh3usspLIZIJ98e/+bhIdCmVeVG+9pd3waWnTtKfoAvRtJkdwh2N/8pIKWf9F757XDO
         0JPkD/b5lqxDy+3xCbhDHvWbKubSHZbjfiI2Zf0n3smQq2CyObVjsZO39ou5ClET9R7B
         lXOJTCgc5m70UbAlBtXhh/OZ9L5n92oMYmlGOHBpeGUgdZSQaIIM2XwS6Hkfy9zKivX2
         1nWK/mtB9SkuHo8gfUrhuiQZl7pkxW0XtRoVWSlh/VwvoiQUOKKEg7bOyv0ATZEWwfq+
         Rgag==
X-Gm-Message-State: AOUpUlE16sH5JJH2Cur/q4hXTYVAgQS3oFd3L0+nE7aC1BayikoQU8Cp
        0xYKG0yGaXrNZeue9ku0ALKaLRp4W9OOuq/bc0E=
X-Google-Smtp-Source: AAOMgpf5xTk4xpRuTtZ10FG43cIS5Qz2CGEWQ0kmX3mLHJ7umPFEgpNIOTFtvbVXr1mzfLJsmuKhAoaRcxSQ1p67lcM=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr15311546oia.198.1531672912613;
 Sun, 15 Jul 2018 09:41:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 09:41:52
 -0700 (PDT)
In-Reply-To: <51acc44e6fd0458e63635b92428fe7743e18a3c7.1531474202.git.leonard.crestez@nxp.com>
References: <51acc44e6fd0458e63635b92428fe7743e18a3c7.1531474202.git.leonard.crestez@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 15 Jul 2018 13:41:52 -0300
Message-ID: <CAOMZO5CXYyxj26AYBc8QBmfwc_wPFs_iPF7FfFM+jTi6vP2doA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6sl: Add vivante gpu nodes
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Marius Vlad <marius-cristian.vlad@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 6:39 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:
> The imx6sl soc has gpu_2d and gpu_vg, no 3d support:
>
> etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
> etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
>
> The IP blocks seem to be already supported.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
