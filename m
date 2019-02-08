Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84110C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C78420857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G06yJn1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfBHN5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:57:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfBHN5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:57:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so2566291lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mW8qhamNDM9m+LnCLsuX8f8uOJ/Eq/Fz3JqxK7IP2ic=;
        b=G06yJn1w71aUJD32fkTiHf0UUBOzIHrE4Gu/+/WzhKBEm5MIWb09azIw7Zdy/iN1tk
         zBFYoveDXJOjICogGlCr+HbM3q7wpwXnP+L5gQ2oR1gtN0O8Oqnvylq3qF0tobHcwIbC
         T4AG4KHCUqFxPIY8zS8wj0fWms5UfH+p1lznjw/cDLfokdJhbdceytR4fwM+IphS/IRN
         1FlKT5WSxi2JntszyTi9JoT9kzybxl0A7864jXXY/8biFhkYygNpnm9jIjtZczKy7iFm
         Xs/1TyF8xbIaHstfJinQQ7h+mwIC1eHlNJSOsYykGqLuDMuwBeyzqEgecUpFMJzFf4Eo
         aynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mW8qhamNDM9m+LnCLsuX8f8uOJ/Eq/Fz3JqxK7IP2ic=;
        b=B291+Ei09g3iASwxWrjIi8xr0IgUOk9XLVodMAHSHft++1NgBZCnbD+I9zlvvTxRQg
         9ompBRESObxOiF1EVOsNbXeBzoiNOSyWp+BfUa/d/rnPA3TheXFPakVAGdXu4OAXOuo1
         2YBR5AO2Al60o3tQXOZSb77HRZe3vRc4Hk9JkWyAIa1W7RKAOr8tZ81kMWxUpLH1b1vb
         klsblDKnAq/lptZ/P02teKZvWrmbyYs/mO9mpiPPZwpSNcmcEBnZWQrhCMp4A12LPRmK
         Qs5FSBsDcomABR5BzAsxBZZGAnVs9tWn82vPHB3nY6MEwaZxfAQBiRTY3x/sAX8ewlCW
         4/cQ==
X-Gm-Message-State: AHQUAubHYyYnJJxrkfOH5laycslBIFp5LkkuQqe3lFmuKkM6IDlUZcfH
        ucpl+H14NPOawiPTaVZX/7C2Q9y69npRB/swlh2TIg==
X-Google-Smtp-Source: AHgI3IaxyMA3sZoPmEh2BA6fJPJGU8OCooELrE5wmjrkXcP9D1J4xuzMFvAfh/0v2bGkv4WkIUVxI2WTqgj0nFmrn/c=
X-Received: by 2002:ac2:4219:: with SMTP id y25mr13455801lfh.130.1549634265412;
 Fri, 08 Feb 2019 05:57:45 -0800 (PST)
MIME-Version: 1.0
References: <20190117102315.1833-1-jbrunet@baylibre.com> <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com>
 <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com>
In-Reply-To: <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 14:57:33 +0100
Message-ID: <CACRpkdb4105RwXhiyVd1dz5mjYO_u6CxTbCySbqUWBv=yhF1qg@mail.gmail.com>
Subject: Re: [PATCH 0/3] pinctrl: meson: g12a fixes
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 4:36 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Mon, 2019-01-21 at 14:53 +0100, Linus Walleij wrote:
> > On Thu, Jan 17, 2019 at 11:23 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> > > This patchset fixes the initial pinctrl support added for th g12a SoC
> > > family, which is mainly around the register regions claimed by the
> > > driver.
> > >
> > > Linus, would it possible for you to provide a tag with these changes to
> > > Kevin ?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-meson-fixes
> >
> > > ATM, we can only use the devices for which the pinmux is already set by
> > > the bootloader. Enabling the broken pinctrl driver could cause regressions
> > > in kernelCI. Having a tag, would allow us to start using pinctrl on this
> > > SoC in this cycle, w/o regression. It would be nice :)
> >
> > When you say "this cycle" do you mean I should target fixes (v5.0-rcN)
> > or next (v5.1) with these patches?
>
> I was referring to the 5.1 release but it is a good question, I did not really
> think about 5.0.
>
> Those changes are mainly fixes, so guess it could go in the 5.0 but support
> for this SoC is still in its early stages, so either way is fine by me.
>
> Whatever is simpler for you I guess ;)

I already merged it for devel and other stuff on top so it will be for v5.1
as it looks now.

Yours,
Linus Walleij
