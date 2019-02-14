Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EC2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FC0222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550135493;
	bh=bXR0zsHW/fz3vQHFQ60PpKS5AitvflLzanXTdrowseI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nwjX8tudRzrL4r4EybplM48DAZ3bSOn5xeCFq7bu3TvCp2FVZvJWLLTv7nQK0Tfoo
	 dCE+cfYMoGnKATp/HtXGh01U8J9/yYtJbu2Rd5rD7BQxogFfXqVWSlSjUYMk6HTKbE
	 7VOCrTkpXkQIW40XEOVgJmwQ6cvJ9Ndx6vhK7SAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394964AbfBNJLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:11:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34280 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbfBNJLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:11:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id l5so1149175lje.1;
        Thu, 14 Feb 2019 01:11:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qlyVzDfEA60OMhAyNzY62j15XTWQJaeweNTh+9Jieis=;
        b=Vt4x58iNvINK3zABtOFU7bXbIrDT/TJW+9I2iRUR38AufjaTct8WPvTT8+/k+WeYVc
         JgVDXQpDXQYsM+iiPF3qiW/bz1Wc5NVVqVEXbSJCorsIQRl+rMYnLWQg9vA8y0RKqVIK
         vWGiZvUdD1aRyvTeJm7auR/S5vu7NKPUJZfJYmzCrUwYafXSSU9tJ1vGUrNjI6awQBdF
         YpRZeDDprGhUp486JD0MT3eYYIwPQcxzYBeECM/0GBZ8NDzdtIOgW67erIC8ipppY4KL
         a6sQgWnmz0uircSH6O294BprIqPqdMOlOIZxxgJelX6Nn7N58TG89Av4P7ueEvue6AiY
         bd/Q==
X-Gm-Message-State: AHQUAub3BLuvu1Culgwl/4HhsBsNL6J5NbBmvohI2QhH6yVBpuo+4IsP
        coIcxnMqhfofpXn17eJNTrw=
X-Google-Smtp-Source: AHgI3Ia8DWAGct6WEUKkC+jWEuKtY9LMdSV6z8iJhbdm8yHF8nLHZ6XVyGrDF8EL5vEnUc408+gbtw==
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr1724017ljc.97.1550135489021;
        Thu, 14 Feb 2019 01:11:29 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id j12sm350468lfg.47.2019.02.14.01.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 01:11:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1guD3B-0007qD-5L; Thu, 14 Feb 2019 10:11:21 +0100
Date:   Thu, 14 Feb 2019 10:11:21 +0100
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
Message-ID: <20190214091121.GI28278@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190125090755.GB3691@localhost>
 <867eeo7pjm.fsf@baylibre.com>
 <20190211083349.GU4686@localhost>
 <86mun2v27r.fsf@baylibre.com>
 <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALZWD59e356Of+R4H2ZNHJyQcPCQNNdS+1DTc8qNDYp9ZnUpXA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 04:24:00PM +0100, Loys Ollivier wrote:
> On Mon 11 Feb 2019 at 14:17, Loys Ollivier <lollivier@baylibre.com> wrote:
> > On Mon 11 Feb 2019 at 08:33, Johan Hovold <johan@kernel.org> wrote:

> >> Right, but please do look around for other receivers using this chipset
> >> so that we can make the binding generic enough to cover those as well
> >> (e.g. by choosing representative resource names).
> >>
> > OK will have a look.
> 
> The only mt3339-based receivers I have found are:
> - [0] Globaltop
> - [1] Locosys / Pololu
> They both only provide the UART interface and do not list the I2C/SPI
> interfaces.
> 
> [0] https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6H-Datasheet-V0A.pdf
> [1] https://www.pololu.com/file/0J641/LS20030~3_datasheet_v1.3.pdf

I found tree more:

 - Globaltop PA6C

   - https://cdn-shop.adafruit.com/datasheets/GlobalTop-FGPMMOPA6C-Datasheet-V0A-Preliminary.pdf

 - Linx RM series
   - https://linxtechnologies.com/wp/wp-content/uploads/rxm-gps-rm.pdf

 - ublox IT530
   - https://www.u-blox.com/sites/default/files/products/documents/IT530_DataSheet_%28FTX-HW-12008%29.pdf

All with uart-interface only and similar pins names, although the ublox
device do have some additional features we can worry about later.

As all but the ublox device use VBACKUP for the backup supply, do you
mind if I change the binding to use "vbackup-supply" instead of
"v-bckp-supply" (which is a ublox-ism) when applying?

Thanks,
Johan
