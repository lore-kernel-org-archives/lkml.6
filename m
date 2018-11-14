Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026E9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A56223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSt0gxXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A56223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbeKNVU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:20:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43309 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:20:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id r71so24962778qkr.10;
        Wed, 14 Nov 2018 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5R5R/K7nuIycToQkxWlXuKp4h7yvntH8REYpXFPi/HA=;
        b=rSt0gxXVoTrhRK2WCJmgZDFZlhIhm6t+OzAi4LlmL23+L0lSd5eoZ51ynAwUVHcR/u
         w5rlz4lnCkdvbPdyf4dfCVpHI+g6xPQIzeRz8b2tXYPOaJ+rO3Y11Nd52W9erj9gPF8H
         8YDbHvCf2vNFqDHpBAWw4crIcHXfyuYQjsdT1UNrJ9VfgxoqUsSsQut8CZrQ/3Z9S4vq
         9sKJmQplh4oE3azpljW4JfhNyX2i7FsuYeDlqU+ie2rsu/VywoHnmPBscItvvAh9tQXp
         AWKlMYyZp/7xeqKvpFyv6Qqp1ydZ03Q/OiHWos30e9fhzLpIpY7Gq4dgeh6zC0dYn7fA
         aBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5R5R/K7nuIycToQkxWlXuKp4h7yvntH8REYpXFPi/HA=;
        b=WCcM04neOuFngFJA3XSHObzwEigr91hyp/toKgTkiywMFiTJRczRLORBkXec452ZEE
         TnycphmTHqbImKnM14m/WCEpOV7bzdHCTTr2N0GU4MY28kw4S98PS9paRPJyOXVn2Ogx
         GEo/5XstC2JCA91okD84HUrZAke1MNzsKQd9lCoDmUnuMCdFq904mrJVQTPuYBgQnTy/
         GoM3AFhahnvlS/st/apr4pEduAGCTTgE7JwiZn0KfceeYaPGHyIs0vBA4vNP31bkdGxc
         Saj+d/1/OfTOwmziQPinOL6I/wPFFKKsGy50RN4jYC3tqMpradsVB+IJxvNmnxG8F6UU
         9hpw==
X-Gm-Message-State: AGRZ1gIzs3SQDb7YEHY9VCfLd5h5Lz38dwgW1oPFYW67wxqK6CgUuGOb
        cWv62kqEphhOJgmsRvny7Ynd6fbfxv7VnKT0CGk=
X-Google-Smtp-Source: AJdET5dh7gfeq7LBjHfUWuNPEXXD9CTSwXBob3/7+gln1OGxu28W/lCugmnWWMAMfnGuj/s7pwGIwKPMQ9D/clVsH4Y=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr1338653qvh.136.1542194255302;
 Wed, 14 Nov 2018 03:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
 <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
 <5BEBE741.6050101@samsung.com> <20181114093652.GK10650@smile.fi.intel.com>
 <5BEBEF7C.7060003@samsung.com> <CAHp75VcJwR7S8t2jSyRvtjKCwaUA5Pu=EL3+MjCgf3SVWnChEQ@mail.gmail.com>
 <5BEC018E.8020102@samsung.com>
In-Reply-To: <5BEC018E.8020102@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 13:17:23 +0200
Message-ID: <CAHp75Vc3NC95Wt9T2qx9SCGtwoR2hA7azGAHhqz7LO-yKz=mew@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        USB <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        rogerq@ti.com, Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 1:05 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 19:20, Andy Shevchenko wrote:
> > On Wed, Nov 14, 2018 at 11:48 AM Chanwoo Choi <cw00.choi@samsung.com> w=
rote:
> >> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 18:36, Andy Shevchenko wrote:
> >>> On Wed, Nov 14, 2018 at 06:13:37PM +0900, Chanwoo Choi wrote:
> >>>> On 2018=EB=85=84 11=EC=9B=94 14=EC=9D=BC 17:35, Andy Shevchenko wrot=
e:
> >>>>> On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com=
> wrote:
> >>>>>
> >>>>>> I was thinking about again to change from NULL to EPROBE_DEFER.
> >>>>>>
> >>>>>> extcon_get_extcon_dev() function was almost called in the probe fu=
nction.
> >>>>>> But, this function might be called on other position instead of pr=
obe.
> >>>>>
> >>>>> *Might be* sounds like a theoretical thing, care to share what is i=
n you mind?
> >>>>> Current users and more important the new coming one are *all* doing=
 the same.
> >>>>>
> >>>>>> ENODEV is more correct error instead of EPROBE_DEFER.
> >>>>>
> >>>>> So, you are proposing to continue duplicating conversion from ENODE=
V
> >>>>> to EPROBE_DEFER in *each* caller?
> >>>>
> >>>> The extcon core don't know the caller situation is in either probe()=
 or other position
> >>>> in the caller driver. The caller driver should decide the kind of er=
ror value
> >>>> by using the return value of extcon_get_extcon_dev().
> >>>>
> >>>> extcon_get_extcon_dev() function cannot be modified for only one cas=
e.
> >>>> If some device driver call extcon_get_extcon_dev() out of probe() fu=
ction,
> >>>> EPROBE_DEFER is not always correct.
> >>>
> >>> I agree with this, but look at the current state of affairs. All user=
s do the same.
> >>> If we need to have another case we may consider this later.
> >>
> >> Because we know the potential wrong case of this change, I can't agree=
 this change.
> >> If extcon_get_extcon_dev() returns ENODEV instead of EPROBE_DEFER,
> >> it is clear and then there are no problem on both current and future.
> >
> > Changing NULL to -ENODEV is a trading bad to worse.
> > I would not go that way, so, it's your call.
>
> If you think that this change is not necessary, just keep the current cod=
e
> without the modification.

Not only this, the useless churn for no benefit to anyone, except some
*theoretical* cases no one saw.

> Please drop this patch on next version.

I will.

> >>> API inside the kernel are not carved in the stone.
> >
> > Only can repeat myself (see above). While I see *theoretical*
> > rationale on your side, mine has *practical* proofs.
> > So, I'm giving up on this and will duplicate same what it's done in 4
> > current callers.
> >
>
> I think that it is more important for removing the potential wrong case
> instead of removing the duplicate code. The many device drivers already
> decided the proper error value by using the return value of function of
> kernel framework.

The API has been introduced back in 2012.

commit 74c5d09bd562edc220d6e076b8f1e118819c178f
Author: Donggeun Kim <dg77.kim@samsung.com>
Date:   Fri Apr 20 14:16:24 2012 +0900

So, you are insisting that 6.5 years of use in a way people are using
it is wrong?

I don't know what might change your mind, but for me it's a clear
win-win to switch to deferred probe error code based on the
*practical* evidence.
But as I said, I gave up now.

P.S. I still disagree with your arguments in relation to de facto use of an=
 API.

--=20
With Best Regards,
Andy Shevchenko
