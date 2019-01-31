Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A843620881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGJNYIwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfAaTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:18:50 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37883 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfAaTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:18:49 -0500
Received: by mail-io1-f68.google.com with SMTP id g8so3655880iok.4;
        Thu, 31 Jan 2019 11:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F7lArm+Zg+Knl9Mh6Xf+iTgOuuJHLA1Iko5WbkRJi0Y=;
        b=RGJNYIwTh4aNNYD+eKWJ+D7CqfeAIqivXRypDWbIC8zvNOQVIt4FHVg+aMyFLQufVs
         5uBPgViuMTIxxG4qSrk9ytDAMG6wEKFx3w4yElS1ITbTUySAfcCfcJuokLikXRBdexwa
         DikUi0YDPEkLSD3YvLWP571W10qWILsPfjA5fIIqv3HFF2MVZf+miUQtgOI5AcTquj1o
         DmF2Z7wmX4/sK8ASsUtL0aGHWU1cM8hFbMZU7oNX8/qstwgBDeFwMDn8OWN+K8vjCvtO
         YHHvSJMabI7JLL3sQ7IzAIHi+dYyyBgci1UqQnV2dMFTI4AjoY5xaosMryAqxlYW5zOF
         S9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F7lArm+Zg+Knl9Mh6Xf+iTgOuuJHLA1Iko5WbkRJi0Y=;
        b=NW1O0JcFWqd8OAmSsaZGzvzrC3F1sW6wqveSSKnkgF0dhNIYP9rmUXIrx1SPuDPoQl
         2daWxQBMpsaDkrjAdkHN4JF85jbT4jd2JsqGuFIKj6Da5JXwm0SelmSnVjfNKtee1zuv
         2GaugdCEWywg4Fm10bUYWh77tXpDfPyn/ngZXHSO5mfaPVFC9qQHdQPiWHPo4s+uiSaD
         QBzUrdgKfIK8VDjlBYeoFZNECWAcsYuW7lILjbyl4nG5pkaemJETwyHujEADI8TiDnHD
         lHvzLxJmJKbzvWP+FwoO3s3h6FvdUGfwvoOgmuNT6ANpTuwLRfOgtEFVHkp9TDm750lu
         ZEGQ==
X-Gm-Message-State: AHQUAua0V5eUDFKWusLTrYXmIMI0k25NxXpSm8yMj614nLhnADLvv1js
        MYQvsevV7xVQxM+pGR/p1+tIrEcYsQu3Ejjfcsc=
X-Google-Smtp-Source: AHgI3IZu24RaeFJ6HqqpVQLePCO6DfdEH6DwiIOay63aVndsWbrXsmN+irKPxjDv0vZFkjpblo1A+4QqXz3m2Hj1MKo=
X-Received: by 2002:a5d:8b83:: with SMTP id p3mr5768005iol.275.1548962327470;
 Thu, 31 Jan 2019 11:18:47 -0800 (PST)
MIME-Version: 1.0
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws> <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
 <20190131122813.GB20797@sirena.org.uk>
In-Reply-To: <20190131122813.GB20797@sirena.org.uk>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 31 Jan 2019 11:18:35 -0800
Message-ID: <CAKdAkRQUAMsT7SA7oAaEmLrkZ6hOdAqCC9RC6HGRsjJ+TvASrQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
To:     Mark Brown <broonie@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 4:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 31, 2019 at 09:15:01AM +0100, Bartosz Golaszewski wrote:
>
> > I'm not sure what the policy is on merging MFD drivers, but I'm seeing
> > that Mark Brown has already picked up the regulator part into his tree
> > (including the binding document). I think you can just pick up the
> > input patches and it will simply not show up in Kconfig until the core
> > mfd module is upstream.
>
> > @Mark: could you please confirm it?
>
> Right, as it's a new MFD the Kconfig will stop it causing build breakage
> until the MFD is merged.  I'm doing it partly just to cut down on the
> amount of mail from resends while the rest of the series gets reviewed.

Ugh, I might have pulled it in if it did not reference the new header
file. As a rule I try to enable all symbols that result in input
devices being created so as much of input code is covered... I'd
prefer input piece be merged with MFD.

Thanks.

-- 
Dmitry
