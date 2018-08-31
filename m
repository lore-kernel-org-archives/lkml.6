Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A982083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKbqX6/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A982083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeHaMAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:00:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46583 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbeHaMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:00:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so10268405wrc.13;
        Fri, 31 Aug 2018 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8TdtQhgtqZGgxfijJpbg6tzO9uUQU2SwR1jOrgh9jJ4=;
        b=WKbqX6/muF7VEyRxMgAsz5DaMJF6WHNlAoYvjN623hCDyUne8HvhrJsth7JsDf3d8v
         xQgQY48ytVDNfF90ClLuUsiptu/XKwX7x1YPa+AeseUxctXS5gKSWq1frtKfZChh962J
         fQ+FbNjezZcWitk3KQVPHLeWgNW6MxyB6qM7A91eEgSfKqamuKZTtKq1Pk/rvf3edJ9A
         tV16CCLiIDvFmMNFIoN4iAayF0F40GlVDnBti5rmvnAzTGWZrD8ARYjVJzYD7BJJkZoM
         LsL2EO/0r0gBunzxy54JDgPAA3PUZiCXRw624olUBHX5KoyAp2JvAAcHI7lvSmbgJT6d
         ERtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8TdtQhgtqZGgxfijJpbg6tzO9uUQU2SwR1jOrgh9jJ4=;
        b=Zx04xiOQjDxq8NxG9I00aKCllWD9yvKOv9hRhQPIxAQmC9LR/gZciCCEkI6XZECMWf
         nd3eePvOgH1VhKgTdBMBLEaNBN+l3D4dHyl5cOvpBgLYre/MH8moY30pquksWmjm7mRw
         lUlgkYxtRkcAI/fBsOkvGWdt44zcV4rQRGbxT/ShdWWLQA8acqeJLNlm0GVW8rZwlGlc
         7orqzQR2Ed5pJdwDTHceABooQjF0AYdJ2Oik0Jh/OsBxQsbcvB1IuumpxFL7UEDbEBlX
         3X/JbFBOtv7g6Kz/gOnh8ZXVYvF110YVazOdwf1AC3wXHJaEAQl0bwYBWOGUf7mhzgnD
         a3fg==
X-Gm-Message-State: APzg51DXT8bDiiTvYisC/Fha0k5awzBdYfIKm+kOX6/QiE4Ko03foDJj
        pinZ3BoSB5ASRCXBLdR3Enm0umjx
X-Google-Smtp-Source: ANB0Vda4dkUf/ESfRQWkF4frWOyI/Hlmd9qv+5E2ONfX6CGzBBjVtbVDNrGmEmhY1ixK9x+QdKvMMQ==
X-Received: by 2002:adf:ac6a:: with SMTP id v97-v6mr9322527wrc.7.1535702033386;
        Fri, 31 Aug 2018 00:53:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id e202-v6sm4832257wma.31.2018.08.31.00.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 00:53:52 -0700 (PDT)
Date:   Fri, 31 Aug 2018 09:53:50 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     axboe@kernel.dk, hdegoede@redhat.com, kishon@ti.com,
        mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 12/13] ARM: dts: sun4i: a10: add sata-port/sata-phy
 nodes
Message-ID: <20180831075350.GA16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-13-clabbe.montjoie@gmail.com>
 <20180831073724.kuw5tb6yypb4pmkp@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831073724.kuw5tb6yypb4pmkp@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 09:37:24AM +0200, Maxime Ripard wrote:
> On Thu, Aug 30, 2018 at 09:01:19PM +0200, Corentin Labbe wrote:
> > This patch convert sun4i-a10 sata to the new binding which use a sata
> > phy node.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> > index 3d62a8950720..52d5c2e79499 100644
> > --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> > +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> > @@ -556,7 +556,20 @@
> >  			reg = <0x01c18000 0x1000>;
> >  			interrupts = <56>;
> >  			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> >  			status = "disabled";
> > +
> > +			sata_port: sata-port@0 {
> > +				reg = <0>;
> > +				phys = <&sata_phy>;
> > +			};
> > +		};
> > +
> > +		sata_phy: sata_phy@1c180c0 {
> > +			compatible = "allwinner,sun4i-a10-sata-phy";
> > +			reg = <0x01c180c0 0x200>;
> > +			#phy-cells = <0>;
> >  		};
> 
> This patch, together with the following one, breaks the DT ABI, this
> isn't something we can do anymore.
> 

So what can I do ?
Keep the DT in place and drop the patch 13 like wens suggested ?

Regards
