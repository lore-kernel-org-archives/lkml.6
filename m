Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE44C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CFC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZzYsUpkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CFC20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeK3Tnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:43:53 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:53084 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeK3Tnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:43:53 -0500
Received: by mail-it1-f195.google.com with SMTP id i7so8046467iti.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j9eiA6jCR4vF3qrc+6ESjsDMd8n45FCFlDvK7Uj86g0=;
        b=ZzYsUpkKesQzi6VrgswYB/RbdL0QMFkgzjM3IquUv3isgc1DbDJI19D31WcmGvqY4V
         XQnqxGXqo4WOPzmS98n851mHNVH3hYG4Aln5tTaEbWGNHX1K3W+fGAC5Vi5fQD0NnRMx
         KXTT6+36Xb2gLIX30+N1AsreNIUVDfU3nSeZS09aMrpDrO9n/bbuVs39Xdsrm4DHPyVR
         oXWEgpXIDqg8nKPLNvqwN16WemNW4h6uQIk2dGpOFUWLQjJ3xchavQdsO5h8hsxDwVfM
         zQIeBagBF28bHOriCISNffhx4qnGeEvoxonLz8dVxIb/jq2Qyw40BsJIpp2RCe2bATP4
         LC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j9eiA6jCR4vF3qrc+6ESjsDMd8n45FCFlDvK7Uj86g0=;
        b=DDEw2a3955M0dpBXhVB93L8Hl+EHiLPsNID5LwiA3qFKsccbKrcYrISCzHtXabG5mK
         TNuGHnz3OKEpmt09NqwPXAexDf7Ka5jt3l01R2NmMt1AGJKfbrU/JPZmWNKay8bZEdcf
         BkDcgakzY8AWWx2sF3Lut1gZB4hypcv6/m8pg20hKoU57gKGyw4KR0P7OgTHtUIps4p7
         dE7lQf/Vnk78lFcX+CVbvurW3+tNu8QNA4M3rsNqS1qNl8rpRt2llLIPKEXAZU8wCxHn
         HtgYiKTCCkvqKowcPaFs8WhIzY3tOh9vSmjvMGbUwzc7uTQPb/hNcLjXN5UmUll5G/UC
         mdaw==
X-Gm-Message-State: AA+aEWa62xIaoFcdNW+dhe3FFAVc2LAHtPa8Fk5JM+2gQpLoYrsDtQIM
        BN9bY12iowgITfiPDpOec/iJ1BuaucPvFwMHRy/JZw==
X-Google-Smtp-Source: AFSGD/W1iH5oZeru+YJ00tLD/INxf08v3h/28cFmMcc5WnM7V8FekQHLARhI7NFIDoL1tG8lMwxtOLRGOPyqgY+zrU0=
X-Received: by 2002:a02:6f4d:: with SMTP id b13mr4120833jae.57.1543566919853;
 Fri, 30 Nov 2018 00:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20181128104350.31902-1-linus.walleij@linaro.org>
 <CAMpxmJUsAccSKELNxn6DEWO6_3aCbzM=hZyaXUCr30S0-Eh0mA@mail.gmail.com> <20181129190132.GM2089@sirena.org.uk>
In-Reply-To: <20181129190132.GM2089@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Nov 2018 09:35:09 +0100
Message-ID: <CAMRc=McApz-8qUo9SiqZgYXor4_DkBRY61nMhiFQ2QSSBj6gWg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Regulator ena_gpiod fixups
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>, lgirdwood@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ckeepax@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 29 lis 2018 o 20:01 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Thu, Nov 29, 2018 at 07:38:20PM +0100, Bartosz Golaszewski wrote:
>
> > I'm wondering if instead of using the non-devm variants of
> > gpiod_get_*() routines, we shouldn't provide helpers in the regulator
> > framework that would be named accordingly, for example:
> > regulator_gpiod_get_optional() etc. even if all they do is call the
> > relevant gpiolib function. Those helpers could then be documented as
> > passing the control over GPIO lines over to the regulator subsystem.
>
> > The reason for that is that most driver developers will automatically
> > use devm functions whenever available and having a single non-devm
> > function without any comment used in a driver normally using devres
> > looks like a bug. Expect people sending "fixes" in a couple months.
>
> I predict that people would then immediately start demanding devm_
> variants of that function...

At least we could document it in the code.

If I wouldn't know about the reason for not using devm and saw a stray
gpiod_get() without a corresponding put() I'd probably send a patch to
fix it, but if I saw something like regulator_gpiod_get(), I'd look at
what this routine does.

Matter of taste I guess, but I'd prefer the latter. At the very least
we could add a comment to each call saying that the regulator
framework will take care of that resource.

Bart
