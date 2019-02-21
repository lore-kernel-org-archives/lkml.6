Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE02085A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcb//8Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfBUMiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:38:21 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46811 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:38:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id z25so9492078qti.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TJjBpv3wqkZaFPqsxWCLVhlGDzIGQj+FsHblMIHFc9s=;
        b=wcb//8IcnASw4ClrmZkkusJa8EQ9UalaE13xioTDpPljDBfLGJUZDGGOOF57lJXcnn
         JvzKqnYSQgOnZFeS8d37s03H9Epyj6XT8UxBieu4LmaR6uZnB+hnSbBqSmk6D0WEVXwK
         8Ql+pzDv7ZtY7kgcoZAAx9nLvBi9BbGqFKzKiPTgjfJWtbGCwCs/HGTKcmY/DCjCqPcC
         LrvEiwcmBwPzNZYEPolMI9D6zqX7YzzMF1BnaNarmUzTaasAhhJSAsxIZajkY8BSOCK7
         KLkqyXG3sA9TAIKNoA+r6emztjI2DKKy6xc8Ly5+sfMcBvEBohoJrrsbRR1WsweWf0I/
         U3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TJjBpv3wqkZaFPqsxWCLVhlGDzIGQj+FsHblMIHFc9s=;
        b=qgnggH9X/QS5RlilSu5fcJYpcAHmWrN+n+D2YLcOKh7hFGOIzaMuMaR/c0dLXGstXQ
         EJ39toIVrwDUFbNrel1JPICLSeHcRviFf0Ot5VVKdjl+3vRG8JVMNLRl2j1PHknoJGND
         6BxrvoMgX6XfQUJUQU+ktYV0c1GhNmKxSnGzTFyJTYQ6mZKOR0U7/F30Zj1Q3lcyQSuA
         PJqkekiEUoZNZgQn1n7hF5ko0n/OFWpe9pA9lZFiiDN6TjCESZlFyyIORH28k4aCHJdM
         c72+p61D50sByPEf6aGS7m3WnE1vciFEKfY6Zp2WXRA39RSddr97Mvr7REQXl8uhOCv0
         5KXQ==
X-Gm-Message-State: AHQUAuZU2qp91web1R8gGcj3RTIci/8LGLLhO2QaIEeoUT7KFKXYcHMj
        iHHgbRT50jYIiiEv2I33e1c51bnmpbDeiyiyW52c7g==
X-Google-Smtp-Source: AHgI3IZFh0VVKHgEi4eo0nSIZCWMOwJTgGkv7MrbPWI9Acz38HOmFxED1r3ES0SMsSiqapqoiIV3g8gEupAUbe808iY=
X-Received: by 2002:a0c:d84e:: with SMTP id i14mr29908714qvj.134.1550752699912;
 Thu, 21 Feb 2019 04:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20190129165530.7606-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190129165530.7606-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Feb 2019 13:38:07 +0100
Message-ID: <CACRpkdbPiVvaY4W6_UMd20PG8mnQCyPHq9W+7x=ZR8+vwy=Oow@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Dong Aisheng <dong.aisheng@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 5:55 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> AFAICS from the i.MX50 Reference Manual, the i.MX50 IOMUXC works the
> same as the one in i.MX51, so I copied fsl,imx51-pinctrl.txt and changed
> the text to imx50.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Cc: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Patch applied with Fabio's review tag.

Yours,
Linus Walleij
