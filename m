Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EE02192B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYQGDJKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfBIRPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:15:34 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43634 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfBIRPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:15:33 -0500
Received: by mail-ot1-f49.google.com with SMTP id a11so11081496otr.10;
        Sat, 09 Feb 2019 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9qChTi8SMBRLveg4fnNK/KJaekdRnZ4Y1/Qtmevu4po=;
        b=iYQGDJKIi6yDRqyzS8+OE/Kuyehsr0k9FGiuwPrhae7zCTglVdwQpBj49ixSZiIGUN
         2+6uq0/zR2rcklOcD/UGJdt21qSxl5Wyob4hz+84XgnWLoUTTxRQSnyUGaMouqXozo6l
         jZCoBcl90BOpNTdh4+4RwehQgX/5H20i47bfcmizyi0ZbvF0zAqV7U7MVKIFV95W8wdC
         uq3roS1P9PLuB7v4CIJFuVfPlaZpyhq/XTl7p6fU9YoQIv87WKYaIsWeVAnQhB/R8B04
         WRgQaN5iYFNNMKJ2SRonwQWJtjn7rvR/UYsgawYksQCH78QFo4bbKAfoc0RcebpBqyMz
         rB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9qChTi8SMBRLveg4fnNK/KJaekdRnZ4Y1/Qtmevu4po=;
        b=jbvS7zQkpKh1AZ3Nyyh0kniymgSOWjNq7iCTvD5Sat2gENYTBTuAOPoAWQxybhHTNW
         TtygdvL264Ua0z0q9pnP779wBzmcbF6ZAxFZk+u6MC58hNAg/ZApP9lFtHpRi5CpG/gR
         Vz3b5Il7lOlZI3QyxpIukI7T8jhGmPnzP4U1LUcFRDeL0wcTqzTpB4LN8XlYCzkNdM61
         CyC83aJZbKq7Mq/85p9mVNGeftv5pvVgU6NdQyNi9UeumZZwbtcK8zbENuXyusaBRo0f
         66FVS9frsv29T5kHACZiGBt3KcKD+TUDtmHSd/Jqinwpzp+tWr4NaFUqODhrbYRQ8spP
         QQrg==
X-Gm-Message-State: AHQUAuYn2/fB1ZMnMGAGIq92YPXFUuxdkQNb8aSR8Bcn5chVl68g/uCv
        KrI52ZwuQ8Ahce7xe6LWxP0C5ZqlVOFkwPMwHRw=
X-Google-Smtp-Source: AHgI3IaA970Ri472vY8MkUlG+2VTHxFxWhi9aTOtj7gH6nRmvJHl6WmbPWb4qjoave8CTBhtaeq3oXA0p56R+2NcVMI=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr11361589otl.196.1549732532189;
 Sat, 09 Feb 2019 09:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20190207225211.GA17552@latitude> <CAOMZO5BH1Su=tKD8vV8+-i_0a_4fNDQKbk0q6DX5TZWYezeH9Q@mail.gmail.com>
 <20190209162449.GB2061@latitude>
In-Reply-To: <20190209162449.GB2061@latitude>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Feb 2019 15:15:20 -0200
Message-ID: <CAOMZO5DrtgQzjY7_9SCM_NKbKPxQyHBQNN+pmUPrqtFkARPdUg@mail.gmail.com>
Subject: Re: sdhci-esdhc-imx/v5.0-rc5: i.MX50 system hangs when "per" clock is disabled
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 2:25 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> On Thu, Feb 07, 2019 at 10:50:28PM -0200, Fabio Estevam wrote:
> > On Thu, Feb 7, 2019 at 8:52 PM Jonathan Neusch=C3=A4fer
> [...]
> > > I tried to compare the CCM's clocks between i.MX50 and i.MX53, but
> > > unfortunately, the i.MX50 reference manual doesn't have the table cal=
led
> > > "Output clocks from CCM".
> >
> > Please check Table 5-10. CCM_CCGR3 Gated Clock Mapping to Target
> > Module from the MX50 Referene Manual.
>
> Ok, the tables show:
>
> For i.MX50:
> [1:0] 0 ipg_clk_root    eSDHCv2_1

and it also shows that ahb_clk_root is controlled by these same bits.

That's why I added the ahb entry in my suggestion.

> [3:2] 1 esdhc1_clk_root eSDHCv2_1
>
> For i.MX53:
> 1=E2=80=930 CG0 esdhc1_ipg_hclk: affects ipg_clk and hclk inputs of ESDEH=
C-1 (esdhc1_clk_enable)
> 3=E2=80=932 CG1 esdhc1_perclk:   affects ipg_clk_perclk   input  of ESDEH=
C-1 (esdhc1_serial_clk_enable)
>
> Table 18-3 (Output clocks from CCM) in the iMX53RM shows that
> ESDHCv2-1's ipg_clk_perclk is esdhc1_clk_root, so the clock structure
> does seem to be the same here, between i.MX50 and i.MX53=E2=80=A6

That's correct. The esdhc clocks seem to differ.
