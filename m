Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161D921927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550246458;
	bh=xJvp4OXPV/nGWMJK7iDXBnG6dnTn7TRntrSVtaOF7VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l02UF+nv8mSCgathCWztgS9Vh4G64JYd9zU/GsFUS9JjWI1fQfm84fvlEdbuLtOAs
	 gMKSn66wCgDHQY2PrrzSkRctlFsUEMiPC/IOzyBbM/3vzcQjvpZwTuXljvRCghepsL
	 3Kda9yCU2hQIVN5H+7dN7RxarKwlrGc06AUAs43g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbfBOQA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:00:57 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43108 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391106AbfBOQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:00:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id z20so7764151ljj.10;
        Fri, 15 Feb 2019 08:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+NWvoArQciybMVwCFf3cNk9+s9mCCRZ6I26Z6YLNBW4=;
        b=q2rti7W1/ZMGldm1rxpi7MD803bvAy1mHnj6PEN3opgXXZmIqTKwfDBK8e7B7+xXqW
         9X2UIFOU/RwDAHWhr1/bQCY7SqUtovO8G0sRVXyHPmMHAF2mdR7INyREHV0OvwWsVh48
         WAEXidLO6lJ9Dhk0O5e19YwaQHzNIzQeAN2c8Lh6FGXkaMVqhHeW0aQ7khmzBTXOK7/Q
         DM8GjD/zTq26lAdtvM2qCIQq47uMli/ElkJuE2nVWy92EkC8nnQMNJ24y4a2egFE5VwJ
         cTX6WRZ4a1kNaecHr4Po4X1qQiqa4T9LdWHO9YgkaJ+gJlddE6iOt8+klFVBrFav/gaB
         mniA==
X-Gm-Message-State: AHQUAuZvdpsJeeyb5STQFeeFBPpmxfFBSlEtAm/nUMUJl5J4aNmQROsk
        zQv1zyXduNAVI4vIJtuygs8=
X-Google-Smtp-Source: AHgI3Ib6oHOYfq26GpmGbR3UDfA8eUafWcK0ejrDhB+P7gDtjXX2XRyVdlZ0U5DXYITY/hlBfbmU+A==
X-Received: by 2002:a2e:4503:: with SMTP id s3-v6mr5966428lja.44.1550246453203;
        Fri, 15 Feb 2019 08:00:53 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c187sm1385203lfg.66.2019.02.15.08.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:00:52 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gufux-0000pK-2G; Fri, 15 Feb 2019 17:00:47 +0100
Date:   Fri, 15 Feb 2019 17:00:47 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190215160047.GN28278@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost>
 <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost>
 <86mun2v27r.fsf@baylibre.com>
 <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
 <20190214091121.GI28278@localhost>
 <86ef89fe10.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ef89fe10.fsf@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:10:35PM +0100, Loys Ollivier wrote:
> 
> On Thu 14 Feb 2019 at 09:11, Johan Hovold <johan@kernel.org> wrote:
> 
> > On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
> >> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
> >> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:
> >
> >> >> Right, but please do look around for other receivers using this chipset
> >> >> so that we can make the binding generic enough to cover those as well
> >> >> (e.g. by choosing representative resource names).
> >> >>
> >> > OK will have a look.
> >> 
> >> The only mt3339-based receivers I have found are:
> >> - [0] Globaltop
> >> - [1] Locosys / Pololu
> >> They both only provide the UART interface and do not list the I2C/SPI
> >> interfaces.
> >> 
> >> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
> >> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf
> >
> > I found tree more:
> >
> Ah nice.
> 
> >  - Globaltop PA6C
> >
> >    - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf
> >
> >  - Linx RM series
> >    - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf
> 
> This is a different chip: MT3337; Apparently this chip only provides an
> UART interface: https://labs.mediatek.com/en/chipset/MT3337
> However it looks interesting. I'll look for a sample to test it in the
> future :)

Bah, sorry, I used the wrong link. Here's the mt3339-based one:

	https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-fm.pdf

But hopefully we can reuse this driver for mt3337 and any other
variants too.

> >  - ublox IT530
> >    - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf
> >
> > All with uart-interface only and similar pins names, although the ublox
> > device do have some additional features we can worry about later.
> >
> > As all but the ublox device use VBACKUP for the backup supply, do you
> > mind if I change the binding to use "vbackup-supply" instead of
> > "v-bckp-supply" (which is a ublox-ism) when applying?
> 
> I don't mind. You can go ahead and change the binding.
> For reference, the v4 patch serie:
> https://lkml.kernel.org/r/1550070569-18588-1-git-send-email-lollivier@baylibre.com

Thanks, now updated and applied.

Johan
