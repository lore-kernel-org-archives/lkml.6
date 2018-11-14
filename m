Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DA022360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3M0lR69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29DA022360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeKNSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:38:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45691 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeKNSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:38:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so24299000qkc.12;
        Wed, 14 Nov 2018 00:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I8ZwZgSfEu+LhAJwM7I55LK0T4bSFvYW6z9orMx18P4=;
        b=Z3M0lR69eKHYmYXZWCds0VR5GP4dPu0O8FdQnJ593geuFuUzeCeNkUwEnY8xaI3AJL
         4Xi/TJGmLEFXSnksGxq/4QFwVGHNLqHiLgG3C8028e0j8Gd1Rvp6n1t4yCzySL3mFWn8
         Ynf0wtODYwR9kWVvbUgsvol93EE378fqWwyz9ZfVBehorfqqqcZGEo+MzMiU2f2m7ITH
         Zw6r82BlcCMm5wylNAnSyBL2Dmzzqef9uePuPwi9xALgkDGga05U+7dQI3JKg37YLeRt
         TB+JGpbEPBH3zVdNE9m/eIoKTfkl8kv3Puk3w4oPH8As8DJyEvA9/oo4gZ85gruyZxOC
         hMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I8ZwZgSfEu+LhAJwM7I55LK0T4bSFvYW6z9orMx18P4=;
        b=iFwUjvrpjJSwFYd2R8S+seLzjs6VXV0MFyfCLL/5iTv5qhUk2R/mhKpPY4FTFL3WIw
         FqNbuLNY06i0IYcEFrURlbzje4XsqWGxKfiHN+xVFpqDGbeFoLMf/gTqejlRcLYpAXhx
         5Z3rVQwE7KSfEVQB1wKhdt8U728qLLs7KNJx42z6Y7CJQb53FbLYZ7pbxpv+O/Hi+OhY
         8rod8uNHEqWS+uKQJbfmBmzQPWgRwTOZTkp4tLgobb4uJICJ/kWvlGFwFxxJZRTI5Vrq
         sHGXiof+i1O9CbNhdO100suzlChFLVS/iArcY6vMVdxD+O2FQ7Ob3hYQZKlfpbHG/SeW
         gZBA==
X-Gm-Message-State: AGRZ1gJgy7Wxylj7YgHF+GiWV6tTmpqRPJBHx6dDBhu6tB87v470pfov
        iiMQjqLHqXo89BgoatMYTjKpJ4Godj7BQIy0Qn0=
X-Google-Smtp-Source: AJdET5cG3mmWy824mKCUx+Ym+croWvuQ9EMTVYKuP7Jx+LxN/xRm9QuCwQoIRsXyCrpqnYZ625fWvgu3kOcU3q/bTxE=
X-Received: by 2002:a37:1f44:: with SMTP id f65mr787715qkf.33.1542184549789;
 Wed, 14 Nov 2018 00:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
 <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
 <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
 <5BE8C821.5080002@samsung.com> <5BEB63C3.1020504@samsung.com>
In-Reply-To: <5BEB63C3.1020504@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 10:35:38 +0200
Message-ID: <CAHp75Vfe586+tr5mUdSHv4ehmpi0KwS_m+UC0tfFHrdXwKhkig@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device is
 not found
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
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

On Wed, Nov 14, 2018 at 1:53 AM Chanwoo Choi <cw00.choi@samsung.com> wrote:

> I was thinking about again to change from NULL to EPROBE_DEFER.
>
> extcon_get_extcon_dev() function was almost called in the probe function.
> But, this function might be called on other position instead of probe.

*Might be* sounds like a theoretical thing, care to share what is in you mi=
nd?
Current users and more important the new coming one are *all* doing the sam=
e.

> ENODEV is more correct error instead of EPROBE_DEFER.

So, you are proposing to continue duplicating conversion from ENODEV
to EPROBE_DEFER in *each* caller?

> Sorry. I'll withdraw my opinion related acked-by tag until we are clarify=
ing it.

I honestly don't know what to clarify here.

When we would have a real case we can change API correspondingly.
For now, the score is 5:0 with use cases in practice.

> On 2018=EB=85=84 11=EC=9B=94 12=EC=9D=BC 09:24, Chanwoo Choi wrote:
> > On 2018=EB=85=84 11=EC=9B=94 11=EC=9D=BC 03:10, Andy Shevchenko wrote:
> >> All current users of extcon_get_extcon_dev() API considers
> >> an extcon device a mandatory to appear. Thus, they all convert
> >> NULL pointer to -EPROBE_DEFER error code.
> >>
> >> There is one more caller anticipated with the same requirements.
> >>
> >> To decrease a code duplication and a burden to the callers,
> >> return -EPROBE_DEFER directly from extcon_get_extcon_dev().

--=20
With Best Regards,
Andy Shevchenko
