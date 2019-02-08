Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C52217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VSk4/BiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfBHR1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:27:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfBHR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:27:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so1981799pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=A0SZoanrAhMzXgD1Yl9c3skIAdSpAApQYRd5mYRfnQI=;
        b=VSk4/BiACZ1Y/PMAdarcrBEcjeZo8welwpoRceXK8Cx5fOfYcUuPMfwmWAiAwacALi
         ccb2cyvsZpOvPqEDMsKWVd3uuDOxVp5PD7Pu50lEAxhPJb2TeLBWqCG/FY9INPsB4i7G
         lkmL3QjaQhv2J5wKV7rKaztOcl20d6wkf0wzKAHMZF00hdfCbVlm2L+oshDQ39HVTym2
         0/hV+NKocJju+qZbvd/JkKzbvWj68pDUAlBciIkdpVLkL3HKWywa95IMCmBzKaH0sQ7m
         JvS0X2xcIue2K+U3rgbsuP6NwaYLd0Y4MJtHvjTeDSpws6vXR3vtlUFCE5G+OfmXOMDB
         2sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=A0SZoanrAhMzXgD1Yl9c3skIAdSpAApQYRd5mYRfnQI=;
        b=TZh6iVKtxA7JfyfpNh8kpbwFwJVsrxTwFaFRwAgKfvYGZ0eaXt+ms/DkRsz3slEAvY
         lfJLxGt38/ZAkhTxk+j/Ea+amB/xWI2GoMpYaZF1xtYEKZOuBiXQNfgmNDTlj+XbQY7f
         /R41WckN2AphGHAEC/NkQLeJgOzbQdEWRZ5ad9NzCD48/XN+oWS06WwMRShpNNi6iOWS
         lieYTBIzsDbCxiJWd7cSoe7CUCmNGzuejnCtQ1qHLAXbwzhyKxuq0K3XVRsdPvK03VtC
         F+09GGvkmaitk8uSXkqHFNUtmo5n07Z1eQOt5Z0PpNOqCoTMEUjEgiASRWpa+0vEwDQa
         xOKA==
X-Gm-Message-State: AHQUAuY4FpVNc7SKvFuZ9Rh88yEGW12Q4CskpwIdq6D8gv2vVb/EDS+H
        yMAWcLaf3wXgANyA0Rj2yEhzjg==
X-Google-Smtp-Source: AHgI3IYoeeScEcUExZ2BexVMFqQeNiPz2KJ/io13uTDR4Zw6N7A9YTN5xoMYLZBSlVGDQ/JedtUZ1Q==
X-Received: by 2002:aa7:8281:: with SMTP id s1mr4076534pfm.120.1549646830429;
        Fri, 08 Feb 2019 09:27:10 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:551b:c3ab:6b62:8b9f])
        by smtp.googlemail.com with ESMTPSA id w12sm2564435pgp.38.2019.02.08.09.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 09:27:09 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] pinctrl: meson: g12a fixes
In-Reply-To: <CACRpkdb4105RwXhiyVd1dz5mjYO_u6CxTbCySbqUWBv=yhF1qg@mail.gmail.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com> <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com> <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com> <CACRpkdb4105RwXhiyVd1dz5mjYO_u6CxTbCySbqUWBv=yhF1qg@mail.gmail.com>
Date:   Fri, 08 Feb 2019 09:27:07 -0800
Message-ID: <7ho97mgphw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Mon, Jan 21, 2019 at 4:36 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> On Mon, 2019-01-21 at 14:53 +0100, Linus Walleij wrote:
>> > On Thu, Jan 17, 2019 at 11:23 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> >
>> > > This patchset fixes the initial pinctrl support added for th g12a SoC
>> > > family, which is mainly around the register regions claimed by the
>> > > driver.
>> > >
>> > > Linus, would it possible for you to provide a tag with these changes to
>> > > Kevin ?
>> >
>> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-meson-fixes
>> >
>> > > ATM, we can only use the devices for which the pinmux is already set by
>> > > the bootloader. Enabling the broken pinctrl driver could cause regressions
>> > > in kernelCI. Having a tag, would allow us to start using pinctrl on this
>> > > SoC in this cycle, w/o regression. It would be nice :)
>> >
>> > When you say "this cycle" do you mean I should target fixes (v5.0-rcN)
>> > or next (v5.1) with these patches?
>>
>> I was referring to the 5.1 release but it is a good question, I did not really
>> think about 5.0.
>>
>> Those changes are mainly fixes, so guess it could go in the 5.0 but support
>> for this SoC is still in its early stages, so either way is fine by me.
>>
>> Whatever is simpler for you I guess ;)
>
> I already merged it for devel and other stuff on top so it will be for v5.1
> as it looks now.

OK, assuming that tag is still valid (and immutable), that works for me.

Kevin
