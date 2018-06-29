Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD920C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64349215FB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBypDsca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64349215FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935942AbeF2AxS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:53:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40862 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbeF2AxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:53:14 -0400
Received: by mail-io0-f193.google.com with SMTP id t135-v6so6962506iof.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 17:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTbCyNoXIrhMZDNDzeD1NvBsyi/VDA/S2cYwb/a2tDs=;
        b=mBypDscaIWHvuHUgrKkjQyvuivoIKXK1SzGqqbpjRC3yF65RGxBlO1knb3cyCa2jBP
         1hMxiMQnmK/WqRa0GZuFWJlHODoGB9dgUacoJEBG1f2nXu1Wv9WEH5Qhzxf+lqARCUQ5
         D7q7DW9idBl0fHAkgwzWEHoQiT3En1SYwinpb+JRncPNuB/t/GGI7xSm8kU7+p0zFTdP
         v57XctTt+u85VriU2ANY3huN1tS6eRruk1QS3ZllQoWuGXecQrSnk0iUiwSlm1Eurp5t
         PujZTAv852ld3stKLqO1bvK7SMR62YJa4ZxxpKyIvJWo8gfR9Q2ttsIT4xfgzgHolzLg
         uU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTbCyNoXIrhMZDNDzeD1NvBsyi/VDA/S2cYwb/a2tDs=;
        b=eYarHianUxYbg+SXAPJGGAaqHWRq31aKyey9U4Bb78No/dLZI+JSa8W6Or+Xj+QhZl
         Yh+gqRSfdhKHBNNbRzzvdJfKdqmGrMdeP2ECQNiqwScD7Et/KTCjY28lKpWKBI8/XCvI
         /383aSizQDtwGwVI65Vrc/bcKXksc+r5d20VfU410/g2QCcIPRXM41G1+RMB/+3/iLg7
         WG8MvT9RMKFcTpV/2fixZmgqrXOkkbDkaxAqRQoJ/EgTC02IXZPyrc9s3Z85JEt57anA
         dp84L0e4RqTBFn5qVhgGT7za0EZlNx5A+sl7ooIqa3OEfh1c86RXLXTJF1TTaUEjfCR2
         vsKg==
X-Gm-Message-State: APt69E2cjVJjqMSybt4aIaJvP5wCigsjEXQoF6IO+FS/Ma1FD/0EMf9h
        hVhv/WOz8suVIzZINZxVwq19cpR+ZvM0tQPOZhQ=
X-Google-Smtp-Source: AAOMgpdO/eMZ6SfR6Mgnejcxp/3WCW1+8rI6eZyncJwnZJ9qa1XEBULmVPTXscLG0CBr8FgYwc+wHs06+vYmW8N5NEk=
X-Received: by 2002:a6b:c585:: with SMTP id v127-v6mr7451017iof.83.1530233594219;
 Thu, 28 Jun 2018 17:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180628043713.14425-1-andrew.smirnov@gmail.com> <CAOMZO5DqkfotddSRbibD0UE2R=QZMef2-4Gr3LaeGT=Fq9qMyw@mail.gmail.com>
In-Reply-To: <CAOMZO5DqkfotddSRbibD0UE2R=QZMef2-4Gr3LaeGT=Fq9qMyw@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 28 Jun 2018 17:53:02 -0700
Message-ID: <CAHQ1cqHysWKNnHJNym4-FXS-kXnUhrbDwaZ+Pc5=79oVM+M71A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx51-babbage: Fix reg for usbh1phy
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 6:35 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Andrey,
>
> On Thu, Jun 28, 2018 at 1:37 AM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
> > There's already a USB PHY with reg of zero on that bus - usbphy0, used
> > by usbotg (included from imx51.dtsi). Move usbh1phy to @1 avoid
> > address collision.
> >
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  arch/arm/boot/dts/imx51-babbage.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> > index b8ca73d3d379..541c6e67ad1a 100644
> > --- a/arch/arm/boot/dts/imx51-babbage.dts
> > +++ b/arch/arm/boot/dts/imx51-babbage.dts
> > @@ -175,9 +175,9 @@
> >                 #size-cells = <0>;
> >                 compatible = "simple-bus";
> >
> > -               usbh1phy: usbh1phy@0 {
> > +               usbh1phy: usbh1phy@1 {
> >                         compatible = "usb-nop-xceiv";
> > -                       reg = <0>;
> > +                       reg = <1>;
>
> We don't really need the 'reg' property here.
>
> I have sent a previous fix for this on an attempt to fix dtc warnings
> with W=1,  so let me send a v2 based on the feedback I got previously:
> https://patchwork.kernel.org/patch/10399085/

OK, cool, good to hear. Please disregard this patch in that case.

Thanks,
Andrey Smirnov
