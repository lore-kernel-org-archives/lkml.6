Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5E2C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089CA2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7EA2C34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089CA2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeIJUJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbeIJUJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:09:45 -0400
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com [209.85.216.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92ABB2086E;
        Mon, 10 Sep 2018 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536592511;
        bh=BbkFyd7FgsMeJ2O6mFzzMlcVxePjQ6y/8bpw1yEnU7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J7EA2C34aDaf744TXUX7eFexxDJX55cqmkK8/EeWbTHEnU1TtYh4wpke1i8y/nrT+
         vyOLdMZ/ypv4fUZRUjyaPH/nFVaHBNtktddr3xi023ClOwatzAUiuGEzxHs0JPM6I8
         3+0mIwnz9T/8Viee8UnHmXUUywGR+cO4X3R5uQu0=
Received: by mail-qt0-f179.google.com with SMTP id r37-v6so24570087qtc.0;
        Mon, 10 Sep 2018 08:15:11 -0700 (PDT)
X-Gm-Message-State: APzg51DAEpsUV5AnVkzJQrOe9R5LLR9Bc0oCHTYmKP3ItDj3u4fDVFQO
        ad2yY/pwt1AraM2jpSz81Fau0GeZEWwwOPcMPA==
X-Google-Smtp-Source: ANB0VdZkPh5YwgctZzCh0NwG/lO7bjngrRfs9ovApWvLGcIwHl3Ka31sLw5FSsz0kaxmq2isyY1VdaCE1blfcmShGLo=
X-Received: by 2002:a0c:e9ce:: with SMTP id q14-v6mr15226188qvo.106.1536592510804;
 Mon, 10 Sep 2018 08:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180910120243.163979-1-lkundrak@v3.sk>
In-Reply-To: <20180910120243.163979-1-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 10 Sep 2018 10:14:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
Message-ID: <CAL_JsqJ=9M9LxKjWQ7f3ARUkp_54BxCuRdJ-=JVNBefVswroew@mail.gmail.com>
Subject: Re: [PATCH] DT: marvell,mmp2: add MMC controllers
To:     lkundrak@v3.sk
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 7:02 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There's apparently four of them on a MMP2.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  arch/arm/boot/dts/mmp2.dtsi | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
> index 766bbb8495b6..51d4a2d70db9 100644
> --- a/arch/arm/boot/dts/mmp2.dtsi
> +++ b/arch/arm/boot/dts/mmp2.dtsi
> @@ -18,6 +18,10 @@
>                 serial3 = &uart4;
>                 i2c0 = &twsi1;
>                 i2c1 = &twsi2;
> +               sdhci0 = &mmc1;
> +               sdhci1 = &mmc2;
> +               sdhci2 = &mmc3;
> +               sdhci3 = &mmc4;

Please drop this. MMC nodes don't need an alias and if they did,
"sdhci" wouldn't be the name.

Rob
