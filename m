Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A1C64EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDCF20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLpfaKE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDCF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJCClx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:41:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54449 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeJCClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:41:52 -0400
Received: by mail-it1-f193.google.com with SMTP id l191-v6so5195881ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 12:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXxUV48KWyV5A7XHH/OQLd00dfNrbGqYYd2HX3l4nbM=;
        b=aLpfaKE+0qGnJN3QrECX0s7qp1hRMIhmLbGHUaSH3xwc1KarZCCUwjeA9jX+sFgtBd
         Z6bZDD4NHoHqVxR4r6AjlOYKgwFZ5WiqoIPkqPmG/A3+N1IAUrv7dz8y/yoNfQGX4d2m
         XxOl6lKvZ0GI3ycI5J25uC2xedshiZVUT2lAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXxUV48KWyV5A7XHH/OQLd00dfNrbGqYYd2HX3l4nbM=;
        b=Ofz5acD1E5DH3dLDYgDVtp4iu8FA7E7NHZr0/DGT2GeOcJKai9fDZhUP1Hio6qkRh5
         GmfPTF/8O6it1xJ99N3VIkyn88vCHlSoLYs1EeOhsLqenoJ95WKdCgOIbSEohaxtdFye
         3qyU1iF8rSDSU+pEZKW4NhMkLMq/YKWI9CbW5WBoA0LsMRdoJetA7NMFPY9PsNbCzDNC
         IFOisV5D4UIG9jUIm5Kw1tnV6VshK5Qb+SQB9XGknLbnsbR/UN1AxYrUclCrTu67jL83
         oj87DE4vu04kDIlITAtKhmB2TK23flZqFr9XNF2eDwIlKRgcbzPjIQu2GkxDp1ussgy6
         h5QQ==
X-Gm-Message-State: ABuFfoilQkFNqcVcunS9E77VN9Y7IvZlyAGL5lNuLf53r8M5gTXsl67n
        U3jmO7zuX+bhTyfwaKee3wTcWsVc2R1KZqpGhEPaXg==
X-Google-Smtp-Source: ACcGV62fgexcZ4300Oo7mjiMTOcgYPPUQ3bEDvBH3Z3fkUYmXbIJSCctecMlzSy8ljxsCn4H9CXUiwWvVx0DBmRJMBo=
X-Received: by 2002:a24:97c8:: with SMTP id k191-v6mr3237142ite.130.1538510211534;
 Tue, 02 Oct 2018 12:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
In-Reply-To: <1147be600733a1bcde194f7df61866019f34a531.1538504729.git.leonard.crestez@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 21:56:39 +0200
Message-ID: <CACRpkdajdjLUEwv8ABSBuy4dVMXqrUfxVDmu55aEiRAK877urQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx-sdb: Fix enet phy regulator
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 8:37 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:

> This issue was exposed by commit efdfeb079cc3 ("regulator: fixed:
> Convert to use GPIO descriptor only") which causes the "gpios" property
> to also be parsed. Before that commit the "gpios" property had no
> effect and PHY reset was only handled in the bootloader.

Wow that was a very interesting one.
Turning over these stones sometimes expose the weirdest
things.

This is one of the reasons why we need formal validation of
DTS files: things look OK to the human eye and get merged
but they are just syntactically wrong.

I guess I could hack to make "gpios" be ignored by the
regulator GPIO quirks in gpiolib, but I take it you probably
prefer to fix up the real issue like this.

Anyways, good job!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
