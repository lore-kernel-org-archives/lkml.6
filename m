Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E9FC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3A2217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548171644;
	bh=B2XFXAWSrodLlyMYuL3pcYBGQlu1ddIEURSRi5qMhME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eToAQN/5s3CCxfMzVtEGD2wV4bdbwPRJizFwaW9m7bKlbe9Mq0nBPXijxBedobWyN
	 jPC2Vr6ICyaRuYHa/4C3tV7se3lSOgu3JATHox+tRZN9Lw2HreMZcNrwci+Y/dpMLC
	 xcUy4/Djepp5q4YpTmzCcTxWNXRRsLa9fc7ecKmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfAVPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbfAVPkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:40:41 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98689217FA;
        Tue, 22 Jan 2019 15:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548171640;
        bh=B2XFXAWSrodLlyMYuL3pcYBGQlu1ddIEURSRi5qMhME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Apr1Ap8Fw0l8pFNdSLb7Unhsmb3eWCvuQcCQfFTqBKtaD1CvRYyOjt35xS/nwUVXi
         l59l2E1UBkhg099+ZQhABVVH7zSaVV2/I9mi+CbtcaJdsO4UWBdBoIk0GNfJHPmhhg
         EUJCLaJ3I4iKWykBtOXWxIN+72X08dpXRAbk74vQ=
Received: by mail-qt1-f171.google.com with SMTP id e5so27967756qtr.12;
        Tue, 22 Jan 2019 07:40:40 -0800 (PST)
X-Gm-Message-State: AJcUukelAZlX2R7esRevOfJykvgqhPkevCFuAmQtUa1V+r1xkx7CIn2I
        1Y9LxKLdxLAscXvkdX8x935f8KgFFnmsDvjVXA==
X-Google-Smtp-Source: ALg8bN7u9VzInwA+up54dRdt1EDxNbFttwJEDD4AxCVTSRhzj835gxCLUeBq6LeajKuGVRcdcdOgkwzjzmFvdA9PfK0=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr30675063qvl.77.1548171639855;
 Tue, 22 Jan 2019 07:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20190122042147.5424-1-manivannan.sadhasivam@linaro.org> <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190122042147.5424-5-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 22 Jan 2019 09:40:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ_bG5=LA0FedY9EAgP=4hww-JJ06XwqTrj3mTOyN9Xwg@mail.gmail.com>
Message-ID: <CAL_JsqJ_bG5=LA0FedY9EAgP=4hww-JJ06XwqTrj3mTOyN9Xwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: arm: fsl: Add devicetree binding for Oxalis
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
> Add devicetree binding for LS1012A SoC based Oxalis board.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
