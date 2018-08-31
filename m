Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B95C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E51E20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPNf4WcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E51E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHaNgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:36:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32966 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaNgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:36:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id r1-v6so741708wmh.0;
        Fri, 31 Aug 2018 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o+Mk+wvf9b9dAoiYpwTNAOROaF65EOrQ1ocDEhy0YkU=;
        b=LPNf4WcDL1gWzGduLfyvJKjY0EYzaQ9uMR0uF8gueKclxVRA5BfKubdGQHw8slAFM7
         LOD6mkgU0LBDReV0ZrXdUb+jTa4WeX3nb6Q5PgaNRN3mQdyL1VYc+RGAFxJbDVq3lib6
         2YlfBh9+m3vcEFRusd2xATIvdOsuSTj4DXf5gtpTsNMxvNwb9ppLxDwGx9HQYIXrg3Js
         FE7u2JXsmI2/lMpyeQGKGUtV4CQyppX+/tWN3jG2vQYAKqXl3ru3xmsAeQRuQ+KAx0tp
         5PSCe/5ofTIcE9inssdFfNn3LueR8sctx5UiZleBr96evol639fwBfmePh42xdvCApKC
         6dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+Mk+wvf9b9dAoiYpwTNAOROaF65EOrQ1ocDEhy0YkU=;
        b=ZGIXao3IEcyCqStkI24j3II1IflWeLjADQlecpnzrjYOYtY+trJxgF0RDliVpP3KKj
         tUD2Xp6JBSHgU6HmPgVgPZxvVW8rBxPr0N2J1DV0TKDlmrafJG0Cfp5orP15mSD3Iu+a
         ZbAoyzusLQklXICpj4FYbKYhEIfduLKKA8ZL7UEub7aa88LNvAtqn5aiCKOesec4R9mV
         CQF8YD0BOxKVi7OGV4SRi40fFarXx654XNGy3m0lXuh6xdn8SMombuFvtwKCRBRRqTGB
         lZKWq3RlzVyfCOymQy48XhOBLcBMV3VWq+kIzJa6SZ4cs93tz+nwTb2RD5r+bJ2cB5ON
         W7oQ==
X-Gm-Message-State: APzg51CWglLfZaTwVULatrcAxa2WQPB6+CWJkRrSxAzMUl2Fid4aFddD
        jwflyx/+qG6GIQy8g/lkEU0=
X-Google-Smtp-Source: ANB0VdbjcBMLzrBwN1aiusSuAo1ltrvnfSpXxpcagWFRVIQ7xadMe9xVYzqnjUfvuiJ+AN9lf/gF8Q==
X-Received: by 2002:a1c:9706:: with SMTP id z6-v6mr4448399wmd.0.1535707777355;
        Fri, 31 Aug 2018 02:29:37 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v1-v6sm6543243wrt.34.2018.08.31.02.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 02:29:36 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:29:34 +0200
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
Message-ID: <20180831092934.GC16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
 <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:58:34PM +0800, Chen-Yu Tsai wrote:
> On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> >
> > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > R40 have a sata controller which is the same as A20.
> > > > This patch adds a DT node for it.
> > > >
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > index 852c2ccc3268..d6b5820da850 100644
> > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > @@ -550,6 +550,29 @@
> > > >                     #size-cells = <0>;
> > > >             };
> > > >
> > > > +           ahci: sata@1c18000 {
> > > > +                   compatible = "allwinner,sun8i-r40-ahci";
> > > > +                   reg = <0x01c18000 0x1000>;
> > > > +                   interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > +                   resets = <&ccu RST_BUS_SATA>;
> > > > +                   resets-name = "ahci";
> > > > +                   #address-cells = <1>;
> > > > +                   #size-cells = <0>;
> > > > +                   status = "disabled";
> > > > +
> > > > +                   sata_port: sata-port@0 {
> > > > +                           reg = <0>;
> > > > +                           phys = <&sata_phy>;
> > > > +                   };
> > > > +           };
> > > > +
> > > > +           sata_phy: sata-phy@1c180c0  {
> > > > +                   compatible = "allwinner,sun8i-r40-sata-phy";
> > > > +                   reg = <0x1c180c0 0x200>;
> > >
> > > Overlapping devices in the DTS is not ok.
> > >
> >
> > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 phy@e900a0)
> > But since it is not a good justification, it seems that regmap is my only solution ?
> 
> Since you are effectively splitting one device node into two, you should
> adjust the original (ahci) device nodes register range.
> 

I cannot do that if I remove patch 13, iow If I keep phy init code in both place as you requested.
