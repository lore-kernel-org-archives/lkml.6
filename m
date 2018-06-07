Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id taLKDMa8GFvjEQAAmS7hNA
	; Thu, 07 Jun 2018 05:04:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 781726089E; Thu,  7 Jun 2018 05:04:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyMJ99Dm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB15560115;
	Thu,  7 Jun 2018 05:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB15560115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeFGFER (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:04:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40635 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeFGFEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:04:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so16016804wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6eek0NZ9krX3TcMn4gpkdDpYErmiVYLX/PLdJHJigqI=;
        b=FyMJ99Dm9fQN/Y09dabfMRq7+KT5qV1Z0xPctTZPHszM/AjmS3/wrhj3nzdBveXQMi
         jIkL9XWnq1UG9wybLVBwuxL1WHwkzlBH71Z4tvKNXre4pEwn3oui94uoZyIT/0UGZp6e
         8FRJHbRWqGjM7rKZAIXulA5CwrjzGwIaPoCJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6eek0NZ9krX3TcMn4gpkdDpYErmiVYLX/PLdJHJigqI=;
        b=c3U9GO9D3na89b3SAOwHJsTlVbDznciWWtOyi7/IJ3RELBvzVHWbxxAJztpaBUUXe4
         VMGEmcZMy3UPoiK5iWdfDd2qdfZbl+P6aTf7c4JRN+bDGNKZJ5E0xmiAL/HRMm7B2Bfi
         8B89TxQWqiCstRNBaix8NGr8E3tybul5Dt5H9oW1QXTlly7b/VXnFFwkeGBK7gGgvleP
         HBR4yURxGgFQD3kgnTCzovzKIugjN02w8MHuoEZj/LAwmEppE4K7KlHOEfif3av48AHN
         pKcUUTGpneZKjTV2J6bqq494Ly3V+T+mamc8ckb1yYKGEIy3fZCvzLfrj4MQU1ILty0Q
         0GWA==
X-Gm-Message-State: APt69E2nhbDgmXGG56iLEg3wKasAYdVfKsg49ecRWluYZI8LnlUtC3x4
        YApDQ3z+53JCT7k3L/QZs50aCg==
X-Google-Smtp-Source: ADUXVKISBOdvgDMHOwuMk+bf/G4gpaSkhT1JgoAvbGs3WSY8su2QoqprmOpM34SiaRvFh5kmzWt/Yg==
X-Received: by 2002:a1c:9b04:: with SMTP id d4-v6mr426390wme.8.1528347853772;
        Wed, 06 Jun 2018 22:04:13 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id q81-v6sm670560wmd.14.2018.06.06.22.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:04:12 -0700 (PDT)
Date: Thu, 7 Jun 2018 06:04:11 +0100
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
Message-ID: <20180607050411.GB21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
 <20180602101155.26375-8-marek.vasut+renesas@gmail.com>
 <20180605075321.GM21163@dell>
 <ac43842f-7d8a-1d6d-7077-9fb58ab852b7@gmail.com>
 <20180606061623.GT21163@dell>
 <69893894-899f-54cd-2610-96653ec246c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69893894-899f-54cd-2610-96653ec246c0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Jun 2018, Marek Vasut wrote:
> On 06/06/2018 08:16 AM, Lee Jones wrote:
> > On Tue, 05 Jun 2018, Marek Vasut wrote:
> 
> [...]
> 
> >>>> -static const struct mfd_cell da9063_devs[] = {
> >>>> +static const struct mfd_cell da9063_common_devs[] = {
> >>>>  	{
> >>>>  		.name		= DA9063_DRVNAME_REGULATORS,
> >>>
> >>> Appreciate that these are historical, but these device name defines
> >>> make me shudder.  They only serve to act as an obfuscation layer when
> >>> debugging at platform level.  Please consider getting rid of them.
> >>
> >> The macro can be shared between the core and the drivers, so the names
> >> never run out of sync.
> > 
> > Platform driver name changes are vary rare.  Even if they are changed,
> > even light testing would uncover the fact that child drivers do not
> > .probe().
> 
> Sure, while if the macro is used, this problem is avoided altogether.
> 
> > Due to the current obfuscation, I currently have no idea
> > what this device's name is.
> 
> I'm sure ctags or git grep can easily help.

I'm aware how to get around the 'issue', but it's an additional step
which is avoidable.  For me personally it comes from doing *a lot* of
platform level work and being irritated by the extra grepping.  Macros
for driver names does not sit right with me at all.  There are even
worse examples of people defining the MACROs *inside* the driver,
which doesn't even benefit from the small redeeming feature you
mention above.

Anyway, I'm happy with you not wanting to change it.  Just leave them
as they are for now.

> >>>> +	{
> >>>> +		.name		= DA9063_DRVNAME_VIBRATION,
> >>>> +	},
> >>>
> >>> Place this on a single line please.
> >>
> >> This would only make the style inconsistent with the ie. LEDs entry.
> >>
> >>>         { .name	= DA9063_DRVNAME_VIBRATION },
> > 
> > If that is a one line entry spaced over multiple lines, then that
> > should also be changed.
> > 
> > Maybe I will go through and stylise this driver a bit after all (but
> > as time is short at the moment, maybe not!) :)
> 
> You'd end up with two entries which look different then the rest, which
> triggers my OCD.

OCD or not, it's never okay to waste lines.  If ordering it not
important (which it should not be -- it's fragile to rely on device
ordering in MFD cells), the multi-line entries go at the top, followed
by the single line entries.  If done right, it looks the opposite of
bad/out of place.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
