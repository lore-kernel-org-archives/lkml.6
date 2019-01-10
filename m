Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51506C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143832173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547139128;
	bh=z/w9M120qfzoGFhYAoTHYRZwCnuD+5s3xDd2gbRIfto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YgsG6EOqm/LBauPOGU0crTbemSN9dmBxIyQKA50KDSR/dsgUa6EU+Y8OHsr5DUVG7
	 gOWzz4/tVkYXJCCZpflf/UDzVyYlU3JdFBxwJlHXJbmF3s1h4viG4MnTW6UZbuc5DY
	 KIl5LQ1eDZaIPe6O6Mzn8yUdQcCFoHAmZMuXQfl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfAJQwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfAJQwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:52:06 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D02214DA;
        Thu, 10 Jan 2019 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547139125;
        bh=z/w9M120qfzoGFhYAoTHYRZwCnuD+5s3xDd2gbRIfto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TThC2NrFvMV40aB1zN+uIHGOAee8v3vvtij2eyNJ4ebYH4l+Vlwf4AGTZBJ+5LE4G
         5BxHtGTNoWD8gIn+bJm8ObTgpjq17DYGUuiR5Vktc0qqnZndGjRw96k/jVGbJ9rEWt
         x5kS5NRfPCsS0CcATdG2sVT1fiSFEiCvPPdIG9JE=
Received: by mail-qt1-f181.google.com with SMTP id u47so13907565qtj.6;
        Thu, 10 Jan 2019 08:52:05 -0800 (PST)
X-Gm-Message-State: AJcUuketB9UY3PfZG548dM5MGijvyl3KfrLDmpe5/tm5FTJX+2GnoAGQ
        WxGsyTfcZUluShkHYoBzGNpm4nJ0BpxB8+u/Dg==
X-Google-Smtp-Source: ALg8bN4+f7rp46fHMGSP0y+9dv5TXnpKYQTqRQUTW3eUrTnqctsm7/H5/iCmPc7PJKZ6c14eIaKTwTJBeh2Ca5Ph2g4=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr10539706qtf.26.1547139124898;
 Thu, 10 Jan 2019 08:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110080821.30280-1-manivannan.sadhasivam@linaro.org> <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190110080821.30280-2-manivannan.sadhasivam@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 10 Jan 2019 10:51:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-=3s-7=srOOzGwzPAstLnvO2c0MzjaP4sKiuyEyDL8Q@mail.gmail.com>
Message-ID: <CAL_JsqK-=3s-7=srOOzGwzPAstLnvO2c0MzjaP4sKiuyEyDL8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH
 Vendor Prefix
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

On Thu, Jan 10, 2019 at 2:08 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Add vendor prefix for EBS-SYSTART GmbH.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389508584f48..27a3da1e3a54 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -383,6 +383,7 @@ SUNW        Sun Microsystems, Inc
>  swir   Sierra Wireless
>  syna   Synaptics Inc.
>  synology       Synology, Inc.
> +ebs-systart EBS-SYSTART GmbH

Alphabetical order

>  tbs    TBS Technologies
>  tbs-biometrics Touchless Biometric Systems AG
>  tcg    Trusted Computing Group
> --
> 2.17.1
>
