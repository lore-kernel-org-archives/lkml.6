Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547DC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86F621916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKlEMM/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfBHLgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:36:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41359 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBHLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:36:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id f21-v6so1262730ljj.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TmRW5kfVZGc1lVE4U1plVaFqnONmt9U4X8+fr5rtXsU=;
        b=rKlEMM/47L/rgHroJrkCNmX81JASS1935ph120G6LkUnHEEsDgnnx//pmm/eHuGNhf
         +6iGWII6CRXI6vqzQRgLkqRHAnejzxRapBjD0cPWzf8S2My08IQ90faZAAsKZb5YYxdG
         eA8Ukdjrqd8ZXbB7GYjtZg3gaWcpZqLam/4VgA7Eu/1qwzvjCC+hdm0gWGL8YN4L+UsD
         TFVxHx/cV/0ej9a5wRDuy87737kCk28xDBQdY7MwzpvpEzlmvVsxSicttbaRomoAL1Og
         nBPIeaDMVLeP6OFbjxQqfybUDlwWP/u96yJPaBAhfn6owExzilgJPBbrDt6RRXjNSN60
         UWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TmRW5kfVZGc1lVE4U1plVaFqnONmt9U4X8+fr5rtXsU=;
        b=hwftEehCSCo4u+wOsZpRaRA6HhPknThNAANphLWwUDOutCytP80MMuax4SAMecEjIJ
         RUqoX9sYsHhx85CkNqctC4sPLBGMdEdPDlvhjS7UyJ9r4AUFmQzubdpTJZ0R+uyvWFyh
         Z4zNKAVYxMmbhqOroFVe58Gei/2JZyfOktR01TWhxUvf0yHkQmI6AXUBrmdaJ1kASxqn
         oCyERq0ImGcgel6eFYmC1672tn/NHgG15sFohP+l9teQ16nMItUTB9q5SK7FtR4htnXW
         jCZOzRlujmwiK3s82bjwwLJxBsjMeEkT+M82VcutO0iypWuCXPAZbdTr6ohHEi2bLQVU
         T7ZA==
X-Gm-Message-State: AHQUAuaCUkl59rvSxLCNSGXp5oYetmzbPWkHe3wPdg0QK+BNRn8Qjw9b
        u0LbMCpL5tQr16jL7asV7rJbkSW24U2uD0Fs9r2sPA==
X-Google-Smtp-Source: AHgI3IaBow9wPkLf9Aqydpch1dV2Eri88C3ezVI9eGTx91/RWisZ8V2BXIqVsDeQOqiZArFL4LO9uyw8Bcv98DiDUR8=
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr13824371ljc.97.1549625767625;
 Fri, 08 Feb 2019 03:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20190129165530.7606-1-j.neuschaefer@gmx.net>
In-Reply-To: <20190129165530.7606-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 12:35:56 +0100
Message-ID: <CACRpkdYdmtA_O-NVCBV7=j+A+u5piRUULiV-HLEnu0dtkT0yyw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: Document the i.MX50 IOMUXC binding
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
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

i.MX people. can you please look at this patch?

Yours,
Linus Walleij
