Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0687AC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27C820861
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDY4k0PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27C820861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeICAPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 20:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICAPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 20:15:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69A720856;
        Sun,  2 Sep 2018 19:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535918333;
        bh=YV2HPBf55y4TN07XJm4bf/yZoG2j1XR0w+TNETOaihE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QDY4k0PDlgH4c2nSVm/nCcevSsmqYvi/l9emxb1e0Ev6usOUSrKBMCY7C0IWorPze
         bMXbGWtIOUPsTaBMYB6aJ5IlWmybTqciEG/4FDOjJmL+QhVaeb+RTuCnPa83+Dj5gd
         3oDP2bbXiQLmL+JvTD5qR97leDWHzL3ww4Iu14Ro=
Date:   Sun, 2 Sep 2018 20:58:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Philipp Rossak <embed3d@gmail.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux@armlinux.org.uk, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 01/30] mfd: Makefile: Remove build option for
 MFD:sun4i-gpadc
Message-ID: <20180902205846.7a08846c@archlinux>
In-Reply-To: <20180831082545.z6oilsmizliin3li@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
        <20180830154518.29507-2-embed3d@gmail.com>
        <20180831082545.z6oilsmizliin3li@flea>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 10:25:45 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi Philipp,
> 
> First, thanks for doing that rework. It was needed, and it's very much
> appreciated :)
> 
> As you can imagine though, I have a bunch of comments.
> 
> On Thu, Aug 30, 2018 at 05:44:49PM +0200, Philipp Rossak wrote:
> > Since we are merging the mfd driver into the sun4i-gpadc driver we need
> > to remove the build options for the sun4i-gpadc driver.
> > 
> > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > ---
> >  drivers/mfd/Makefile | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index e9fd20dba18d..c680994db988 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -220,7 +220,6 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> >  obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
> >  
> >  obj-$(CONFIG_MFD_ALTERA_A10SR)	+= altera-a10sr.o
> > -obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o  
> 
> One of the things we should strive for is bisectability, which means
> being able to have a working driver at every point in time while
> introducing the features.
> 
> In this particular case, this isn't really a problem since you're
> removing part of code that were never really enabled, but you should
> at least document why in your commit log.
> 
Agreed. I for one don't know / can't remember why this would make sense!

Jonathan
> Thanks!
> Maxime
> 

