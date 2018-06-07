Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fxkgMmkxGVvOMQAAmS7hNA
	; Thu, 07 Jun 2018 13:24:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B02E608B8; Thu,  7 Jun 2018 13:24:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmXLUqG3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4303D601D2;
	Thu,  7 Jun 2018 13:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4303D601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeFGNYU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:24:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39485 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753047AbeFGNYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:24:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so19162271wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3jZ+Z69nIby9gaGHQ4ndjXFmjjde59vxxfSeKwNWymU=;
        b=NmXLUqG3sMM//jQm/JI/C5BHpdYyblD0J7eeqe+lvw5v5+i7S+HydLKESV4vfoUL+1
         MD2ENQyiQhnSqpMy3iqOFn6it0U4zsmvV1ilW+w1NDDKjHNQ+uiPU1vTDie8w3VRBDFP
         3VbToSZY+E/wQvZi1Tt4tuiONXEtIVuzhGs3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3jZ+Z69nIby9gaGHQ4ndjXFmjjde59vxxfSeKwNWymU=;
        b=N9MSYXTfshaikntOfMV8PEquQUyJ5tQgcJkD9BioykYwbO8LI48kjtyftjKZUvpicx
         y4y8i1W/4W8kXrr8SWwzv09wPPQy+c3UNu8Ut/gM22t8nyQcNZS48CThw+GJzB9fjd5H
         sT9wpu9G578XUXyu1f8/lGGQPlp2NVeIpU1RNL+SH4ijKl0O7OW3RlqgM2fue5hrNiIB
         vkVlGPSDmn0ZSZdvwANIXBtLSGeYswJdxRDfZBVh+wczEHkKdi8pTzvEcgab9ehrljMp
         WVCaDZa+Csz5v+kvzWFkfCEH1xOdh526DksbWi+qcUPaXhHaJXFPfSPs12QVF5Qn5Kei
         ZBCQ==
X-Gm-Message-State: APt69E343CwhHrEU4a+t79KRvaCpJIflCVWTUJ2Fcdv8TlKrUUaIpbl/
        euHUBMx0wWNM78kdeNBKLK7xhQ==
X-Google-Smtp-Source: ADUXVKJ5lodtb+urBlrz49iuEHOB6w9fu52rKWRwkhYwLPAjFycbICplcq6icerlgHkKUXzAr7TO5w==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr1824434wmi.8.1528377857392;
        Thu, 07 Jun 2018 06:24:17 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id b80-v6sm2865797wmf.2.2018.06.07.06.24.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:24:16 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:24:14 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 08/10] mfd: da9063: Register RTC only on DA9063L
Message-ID: <20180607132414.GF22841@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
 <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
 <20180606061623.GT21163@dell>
 <69893894-899f-54cd-2610-96653ec246c0@gmail.com>
 <20180607050411.GB21163@dell>
 <feeb19cc-e7df-1859-86b9-da99059d8e32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <feeb19cc-e7df-1859-86b9-da99059d8e32@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jun 2018, Marek Vasut wrote:

> On 06/07/2018 07:04 AM, Lee Jones wrote:
> > On Wed, 06 Jun 2018, Marek Vasut wrote:
> >> On 06/06/2018 08:16 AM, Lee Jones wrote:
> >>> On Tue, 05 Jun 2018, Marek Vasut wrote:
> >>
> >> [...]
> >>
> >>>>>> -static const struct mfd_cell da9063_devs[] = {
> >>>>>> +static const struct mfd_cell da9063_common_devs[] = {
> >>>>>>  	{
> >>>>>>  		.name		= DA9063_DRVNAME_REGULATORS,
> >>>>>
> >>>>> Appreciate that these are historical, but these device name defines
> >>>>> make me shudder.  They only serve to act as an obfuscation layer when
> >>>>> debugging at platform level.  Please consider getting rid of them.
> >>>>
> >>>> The macro can be shared between the core and the drivers, so the names
> >>>> never run out of sync.
> >>>
> >>> Platform driver name changes are vary rare.  Even if they are changed,
> >>> even light testing would uncover the fact that child drivers do not
> >>> .probe().
> >>
> >> Sure, while if the macro is used, this problem is avoided altogether.
> >>
> >>> Due to the current obfuscation, I currently have no idea
> >>> what this device's name is.
> >>
> >> I'm sure ctags or git grep can easily help.
> > 
> > I'm aware how to get around the 'issue', but it's an additional step
> > which is avoidable.  For me personally it comes from doing *a lot* of
> > platform level work and being irritated by the extra grepping.  Macros
> > for driver names does not sit right with me at all.  There are even
> > worse examples of people defining the MACROs *inside* the driver,
> > which doesn't even benefit from the small redeeming feature you
> > mention above.
> 
> If we follow this line of thinking, we could just run cpp and expand all
> macros. Then there's no need for grepping at all. That probably won't be
> the result anyone would like though.

Hmm ... yes, that's the same! :D

> > Anyway, I'm happy with you not wanting to change it.  Just leave them
> > as they are for now.
> >>>>>> +	{
> >>>>>> +		.name		= DA9063_DRVNAME_VIBRATION,
> >>>>>> +	},
> >>>>>
> >>>>> Place this on a single line please.
> >>>>
> >>>> This would only make the style inconsistent with the ie. LEDs entry.
> >>>>
> >>>>>         { .name	= DA9063_DRVNAME_VIBRATION },
> >>>
> >>> If that is a one line entry spaced over multiple lines, then that
> >>> should also be changed.
> >>>
> >>> Maybe I will go through and stylise this driver a bit after all (but
> >>> as time is short at the moment, maybe not!) :)
> >>
> >> You'd end up with two entries which look different then the rest, which
> >> triggers my OCD.
> > 
> > OCD or not, it's never okay to waste lines.  If ordering it not
> > important (which it should not be -- it's fragile to rely on device
> > ordering in MFD cells), the multi-line entries go at the top, followed
> > by the single line entries.  If done right, it looks the opposite of
> > bad/out of place.
> 
> My point is, the style should at least be consistent. But anyway.

It is consistent.

 - Multi-line entries go on multiple lines.
 - Single line entries go on single lines.

See drivers/mfd/max77620.c for how it should look.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
