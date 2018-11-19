Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D24FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA220817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tZfcJUim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EA220817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeKSTeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:34:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36798 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeKSTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:34:35 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so16024231ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 01:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m/AF/L5Iek1PXFvLLGx1k2NPTEP7Vz747Pg5LQ8IFj8=;
        b=tZfcJUimjSzGsLO71XG0CgygXtCLpxGvm36nENqT9PwDFyDmC6F8qKe+21V5i4oH9g
         iAacRMDHbPzXf77ffLTfDpu4LGN4jSG8tLO2BMkuhCdHI3VV5myeOVPLkl2utt3cJZk7
         ZGKq9si/IDXymvdCpd3z3aCBkxf5hbJzbxy/nn2rAM4bPn4uO3oe+pfaA8901JSusavW
         KQN1EPNQ6pBL+zcOCZ78RWebpY9Z7aSqf3TK9BnXoSLBMhSAgFYG5pPjq6bF0TxdHGNY
         td4n64T4H7dkYnfS2E25szSTb9UwzOt18F/VxNaYahJGHN380u/kferKiga6ABSuXdzH
         EM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m/AF/L5Iek1PXFvLLGx1k2NPTEP7Vz747Pg5LQ8IFj8=;
        b=eRfG2KZ4uYzjUkEKcdsHXKY3I9RlT4tnxHK5xRxACDVKSlFNB45uNsJJ+y5K6h3ohB
         cry++n85mpja66ApHWX9XgWvX+EElS6/6hIZV2aB69ubdmwN7lOkUP+vNoKoW105Zgaw
         q5h7Ev5GFHwkAe/HN48VCGDgHGku3sHDLoxIr8XM4731rhVtW0ZKGGd9VBq91Jl7zOXk
         XhF0t7YlLUdjcrvfTnZHDVKuvsX2G7MPSIK8GVWdTfqQwW2DxEBROHDhgGHO8LX57G8Q
         nJ52i+NRrQ9I7CgZ2uWw1CvPSfTmnZ+mxlIp7+Z5coC3jUjKSdQLsvuq37SgE7uK5ner
         R1Pg==
X-Gm-Message-State: AGRZ1gK5NNw6nhuXfluJ7wbWgDUGfXJEIg+rr6vmd8vX2o3WNDgLVoOT
        FghiZWCwe+nXZ+LwXpIdQ0octoTkxWTEq6ABKKPU6Q==
X-Google-Smtp-Source: AFSGD/VpCW3+/4LDO+eG7cOVNYP55VHmqaP9ft35s5Z27LEUTh9xtzgwvU917SV4clmaYJVvUc6toZcbx4UfDuVE5dQ=
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr4920024ioj.258.1542618694438;
 Mon, 19 Nov 2018 01:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20181113135051.15308-1-brgl@bgdev.pl> <CACRpkda4aarCn=PHPSWfMgtOZhcGA2ifcA7_ujYgmj+do2+N+Q@mail.gmail.com>
In-Reply-To: <CACRpkda4aarCn=PHPSWfMgtOZhcGA2ifcA7_ujYgmj+do2+N+Q@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 19 Nov 2018 10:11:23 +0100
Message-ID: <CAMRc=MeAR=aW0FKNyRm0xy075BkF=cpDJyJDiwtWpWcmkdmF2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: davinci: fix ethernet support on da850-evm
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 16 lis 2018 o 22:51 Linus Walleij <linus.walleij@linaro.org> napisa=C5=
=82(a):
>
> On Tue, Nov 13, 2018 at 2:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Ethernet doesn't work on da850-evm in legacy boot mode since v4.19. Thi=
s
> > series addresses two problems I've found. I guess with this kind of
> > intrusive changes in the GPIO driver, other boards may be broken at the
> > moment too.
> >
> > Bartosz Golaszewski (3):
> >   ARM: davinci: define gpio interrupts as separate resources
> >   gpio: davinci: restore a way to manually specify the GPIO base
> >   ARM: davinci: fix da850-evm boot in legacy mode
>
> I have some patches starting to move DaVinci over to using only
> descriptor tables, but that's not somthing we can pull off overnight
> so I guess we have to go for this solution.
>

Nice, would you mind sharing the development branch? I'm interested in
it as well and may be doing some work on that early 2019 so let's sync
to avoid duplicating the effort.

Bart

> Can we have ACKs from the DaVinci maintainers so I can merge
> all three patches through the GPIO tree fixes? Else I'm fine
> with merging through ARM SoC.
>
> Yours,
> Linus Walleij
