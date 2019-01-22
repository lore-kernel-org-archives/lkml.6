Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FA2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E625217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548171624;
	bh=nfH17g7hT3C9Ra5eF47HzQCPANsjsPbzv8xOYv+KqBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JMDYHdF5bAIDQ94+pZmM5lFqiyh/z7ODeIYgWMjnO35e+XtsiSvN5NxW8aBc2Y6Oi
	 dy2QSauEBd0wBsE8xFb0DsWOpVjMY7qJaz4Lwoc83QgETQooF5ciw9evVk8p26QZ8o
	 yQyQh6l94oZ92wkGI8rCUjGCjND+JLRFgXPY99ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfAVPkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:40:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbfAVPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:40:22 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8F121841;
        Tue, 22 Jan 2019 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548171621;
        bh=nfH17g7hT3C9Ra5eF47HzQCPANsjsPbzv8xOYv+KqBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xPxKI8GeYoUaoGPJS3u2g5+oEGdE3U6OOyO+lmIoj4NP7nFS0eM7XPULZE47ilHC6
         px9+cGL8jU69J5pohvwtL3GlrsVuQ3MOtw8j3j7lif3EuxdzzsEZGs5SsM2GtwajOd
         a/31jOZ44VSVzqY2PdN330A17ma744Vh1n2FRO2U=
Received: by mail-qt1-f170.google.com with SMTP id r14so28127566qtp.1;
        Tue, 22 Jan 2019 07:40:21 -0800 (PST)
X-Gm-Message-State: AJcUukeqLWFdX0D0ayWTOgW/ndUhz9j+JRhX84L7MmYIfOO90MVA1hIa
        /o5yZ4UYvw1tf2C3qq47eZXEww8pVsC8x9jy3g==
X-Google-Smtp-Source: ALg8bN6mlA+b5xNplGq7vMORmB9fivFFLm4qa0hifKph63t1Dja4m93gpfYxV1gsvx4LRwoSNfuWGx3VGQQqBOLziuY=
X-Received: by 2002:ac8:2d2b:: with SMTP id n40mr30661287qta.38.1548171620633;
 Tue, 22 Jan 2019 07:40:20 -0800 (PST)
MIME-Version: 1.0
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org> <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190122042147.5424-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Jan 2019 09:40:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJR6s-EPJdvvyY=v=0RRUzee2NBXyssgeY1-YYK-C4q3g@mail.gmail.com>
Message-ID: <CAL_JsqJR6s-EPJdvvyY=v=0RRUzee2NBXyssgeY1-YYK-C4q3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: fsl: Fix bindings for LS1012A
 and LS1021A based boards
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Yang-Leo Li <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.tropschug@ebs-systart.com, m.bittner@ebs-systart.com,
        Amit Kucheria <amit.kucheria@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:22 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Fix devicetree bindings for Freescale LS1012A and LS1021A SoC based boards.
>
> Fixes: a1a38e1f4d1d ("dt-bindings: arm: Convert FSL board/soc bindings to json-schema")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
