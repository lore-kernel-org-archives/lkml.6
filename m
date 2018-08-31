Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6450420661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 12:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc2OasJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6450420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHaQPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 12:15:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43853 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 12:15:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so10990004wre.10;
        Fri, 31 Aug 2018 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kbSNbxWRBacg/sZCzBKl0VXiu3h1q2hw8VIBoYcF/H8=;
        b=Zc2OasJNdJhxQgHmkHzCw77pEiFOoDbzayyUvohaqfXAjm7is/uPjPJ/mcFWPvtd16
         kndemtNOFZzxQQZA6cjzME8Q3Tko8/ZLURb+zrtt4VPXKRfM/aP1FhVlYj0MWEGJDrv6
         sm9ur+dFQyJJX1awIt9/imf5otwOMUrTup8cBTJqhIImpnycuMvYajiqzaWuu7EgBfNd
         q9Aj2cTkBVB7DS9CdnI49bfyB8YE29zxbvGbJZmVBf4JlExkFVqZ0sF2YiUV1WoSGoHX
         9j9IqBxFhiWafKj/AoSh4wYGLGPZj8FiHXX8azu7NffBiZsk5GabooKuum6qbnhOasFT
         crhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbSNbxWRBacg/sZCzBKl0VXiu3h1q2hw8VIBoYcF/H8=;
        b=ocxjmrCKNkqzG3TWeX44Qyj4y06kkbUm/H2sG+I2jza3Ax08dcEdBFFNxYJVeQEo+n
         Vj47qJyzk8kbWn8fWpSHJFViIMmxKj+2+hvOaugikiOznm+qf6CSLLDbKP5x0ItnVm40
         lxqs+bF9fSF0dyyG1opPhgGiR80LgO0kX20zDeajGKOSWxljKAOIGl9h3uXRHQ9IiyaZ
         44k2+0pjn3U9AjMdZWeluKYegOz059xG/zQjmtMeOduaqGrLhP0Tc+b7SNTm0HMQbQUi
         x8GCkcsFA1u6c5mtpaX5RXSnAfPYE6YshEqMybSXUfLAeC2X1x0N56eH/Opfn6HXegIV
         fK7A==
X-Gm-Message-State: APzg51Aa97Rn6KcCKwbZky9k7+LRsJPCdFNwe19yfXwQtZhhVhpcdEHK
        612yyESL7tJM3OXkCB0vHpU=
X-Google-Smtp-Source: ANB0VdYyLR7DKEEKuiJ0jO30QG6xTit0g1KD7BLkI1c9nDaLLn6EEVykNpIHYLNIhIg0dxsR/0cuYw==
X-Received: by 2002:a5d:53cf:: with SMTP id a15-v6mr11048540wrw.151.1535717287550;
        Fri, 31 Aug 2018 05:08:07 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id m8-v6sm18074821wrf.93.2018.08.31.05.08.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 05:08:06 -0700 (PDT)
Date:   Fri, 31 Aug 2018 14:08:04 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>, axboe@kernel.dk,
        Hans de Goede <hdegoede@redhat.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ide@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Message-ID: <20180831120804.GA11340@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
 <20180831102021.idz42sfgldihpkrp@flea>
 <20180831105412.GD16301@Red>
 <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 07:31:37PM +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 31, 2018 at 6:54 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > On Fri, Aug 31, 2018 at 12:20:21PM +0200, maxime.ripard@bootlin.com wrote:
> > > On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> > > > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > > > R40 have a sata controller which is the same as A20.
> > > > > > This patch adds a DT node for it.
> > > > > >
> > > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > > > >  1 file changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > index 852c2ccc3268..d6b5820da850 100644
> > > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > @@ -550,6 +550,29 @@
> > > > > >                         #size-cells = <0>;
> > > > > >                 };
> > > > > >
> > > > > > +               ahci: sata@1c18000 {
> > > > > > +                       compatible = "allwinner,sun8i-r40-ahci";
> > > > > > +                       reg = <0x01c18000 0x1000>;
> > > > > > +                       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                       clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > > > +                       resets = <&ccu RST_BUS_SATA>;
> > > > > > +                       resets-name = "ahci";
> > > > > > +                       #address-cells = <1>;
> > > > > > +                       #size-cells = <0>;
> > > > > > +                       status = "disabled";
> > > > > > +
> > > > > > +                       sata_port: sata-port@0 {
> > > > > > +                               reg = <0>;
> > > > > > +                               phys = <&sata_phy>;
> > > > > > +                       };
> > > > > > +               };
> > > > > > +
> > > > > > +               sata_phy: sata-phy@1c180c0  {
> > > > > > +                       compatible = "allwinner,sun8i-r40-sata-phy";
> > > > > > +                       reg = <0x1c180c0 0x200>;
> > > > >
> > > > > Overlapping devices in the DTS is not ok.
> > > > >
> > > >
> > > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> > > > phy@e900a0)
> > > >
> > > > But since it is not a good justification, it seems that regmap is my
> > > > only solution ?
> > >
> > > I'm not even sure why you are moving the phy out of its original node
> > > (and driver).
> > >
> >
> > For using the phy-supply already handled by the code.
> > The other choice is to add another xxx-supply to ahci_platform.
> > Or to use hackily port_regulator for this regulator.
> 
> The PHY registers are in the AHCI's "vendor specific registers"
> region. Following that are the per-port registers, which the ahci
> driver will need access to. This doesn't look like it should
> deserve a separate device node.
> 
> What's wrong with handling the regulator directly in the ahci-sunxi
> PHY init code?
> 

The reason are that I didnt wanted to use the port-regulator, and I didnt want to add new code to ahci_platform.
I tried to place a phy-supply in the ahci node, but it doesnt work (with or without a phy subnode).

Moving PHy code in a dedicated driver seemed to be good, but with all your comments and Maxime's one, it seems not.

I will keep ahci_sunxi as-is and will try to found how to add the needed phy-supply.

Regards
