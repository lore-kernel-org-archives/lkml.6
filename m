Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047E1222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RccGW8EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437682AbfBNIvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:51:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44161 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436834AbfBNIvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:51:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id v16so5481737wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fDMH0mSbWpAU4X1k7pWwZT7rdlth2wQud66s1RtyLzM=;
        b=RccGW8EPfyEksjHA3p9Zqk60lN4KRmwbQcm0m+kcA4RD8X/B6OB9IzBTBFc3g2Keq6
         z9tWHmKk4MnXTqvfp9TPvNzUGopi7STXVbMijdsEUGt4eBLRigDmQnvUeoPR1VD2abCy
         DtNJA+CAOXfllJ604HAa0XxeUZdTpWtu10Zb8cR+FDNbZs8/bF1/7tuGc2L/Ha2q/hGw
         JSmQbE296xtt/d3FANCBmod8Ruz6p6WnpYiY0cZiSNkDpcNuDsxBHex7SrYXBZYohXZR
         C+JloG+Lr/+Tbk4czloPgmHxLwf4zW5KiNhg9b1hhxwbUGlCMaJzu3lMc+5IcIe/AZeF
         tTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fDMH0mSbWpAU4X1k7pWwZT7rdlth2wQud66s1RtyLzM=;
        b=WfuaaImOjnaySsHnr/8g0/WqHPDDVrp7DCK1gsLypsqncs+HjVHM/aQMuHf0JVwmr+
         Vv6Q58ynMnQNQ9STShoNw8Y091xex1O/kK2g5LDKoMDeqHwrIggi5m6M4H1d2layLHKB
         Kr2Vm2T8j5OMJpBMNb4wFx90VXKCFTSx2sgPT2SfxpM4ejQ/hujFD7I0kOcHD+yl5TLI
         8qRL2mPrpBPeRxj2egBOBRFsFsZBI0STRNTTxy/9W0zYuQWJBhCuti1zw5Fc1tBBXTEV
         en8cetd2GNejJWv3mYgPdTD8RYpvNmNloLSPgosWM/pTK/Esny4/74LCZpiqIgSWxbNA
         tOvA==
X-Gm-Message-State: AHQUAuaBD5hsDqMulwe/NA736fd8tIo9+Tu4Jhnma1NNgi71F4H8EIW7
        FcQO8gqCXD388PUgL3b7reM1JQ==
X-Google-Smtp-Source: AHgI3IZOAq7DPGZI6nu1PIxsqjoc44H4+lOo3lwERJlXPn5IeiOzFOsEslu5/MV7rBtGvLc961qDmA==
X-Received: by 2002:a5d:5492:: with SMTP id h18mr1919077wrv.322.1550134268932;
        Thu, 14 Feb 2019 00:51:08 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id x18sm1266356wrw.61.2019.02.14.00.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 00:51:08 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:51:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH -next 2/3] mfd: pm8xxx: select IRQ_DOMAIN_HIERARCHY in
 Kconfig
Message-ID: <20190214085106.GJ1863@dell>
References: <20190214013641.9740-1-masneyb@onstation.org>
 <20190214013641.9740-2-masneyb@onstation.org>
 <CACRpkdbYiwu6Bbd6uMaWUc2AzDZPve5_bq=_9RwRhadaMBf+dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbYiwu6Bbd6uMaWUc2AzDZPve5_bq=_9RwRhadaMBf+dQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019, Linus Walleij wrote:

> On Thu, Feb 14, 2019 at 2:36 AM Brian Masney <masneyb@onstation.org> wrote:
> 
> > Select IRQ_DOMAIN_HIERARCHY for pm8xxx in Kconfig since this driver uses
> > the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN,
> > so it can be removed from here.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> > Linus: For your ib-qcom-ssbi branch.
> 
> OK applied it there (might fold it in with the original patch, let's see).

Ah, we're applying patches from different SS without Acks now? ;)

FWIW:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
