Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84345C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E1D20700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550589517;
	bh=8ocIakfqk5NNFo2WuTtRy1WckjPnY0q6N5mmUiwiGyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MaQVdVyIrbxmmgpF6kAhN4MzRnW5S1mnOQsCWOjMy+EGveFZgknnCr5HeMS3j7Adf
	 JRoYm2QTKuJVxmeeywnxW7WnwDJQ8E4duLXp+5tVZt+pT3WHUB2LUJWH9M8xGvqSNW
	 aRH6gMXdBeAgEmot3GikyS5eXpaHfb90uVGzNRTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfBSPSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfBSPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:18:35 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4512177E;
        Tue, 19 Feb 2019 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550589515;
        bh=8ocIakfqk5NNFo2WuTtRy1WckjPnY0q6N5mmUiwiGyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GJa5eUWuzJ6rbptYr8ytl52ViQysDpRRLUNXSBCShOCicH7NUmUHCRx5CvaMZNPrI
         lFqQv8uXRzmC32z6622Q8MVQnD0OTtGCWYNiPMLmLJUqnPdlKpPcdvi654MPzMycaJ
         Zq1RsK9TkxNQaCnB5R1ZdACSW3A75sG+aiMj4Hkc=
Received: by mail-qk1-f174.google.com with SMTP id x9so12251895qkf.0;
        Tue, 19 Feb 2019 07:18:34 -0800 (PST)
X-Gm-Message-State: AHQUAuYeGOJEJnhGsqvs9Vdt0CzX88uxOO6dNjNyFy46+Rl+Y44chdaW
        0UL/x1NBSI6m/KCOYTFT69gxfwCSPcMNZDpXIA==
X-Google-Smtp-Source: AHgI3IbjJaosuMWg8guG7pEzJIQ2UYTAImOqOHQ2aMBBC3mdnmgCDoNvU/dZ5kQ3qpOTGRVsYfTs3ZpxTDz7aJDtjSE=
X-Received: by 2002:a37:4a84:: with SMTP id x126mr21047468qka.326.1550589513982;
 Tue, 19 Feb 2019 07:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190212064353.7451-1-markz@nvidia.com> <20190212064353.7451-3-markz@nvidia.com>
 <CAL_JsqKiL8A+SBwqLzYa9djWBT1S+2kxUUB4iuKWX7EoqXouCw@mail.gmail.com> <91d3d8f8-0b96-c442-5674-3eff8209848b@nvidia.com>
In-Reply-To: <91d3d8f8-0b96-c442-5674-3eff8209848b@nvidia.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 19 Feb 2019 09:18:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJkw1Ti7Jdz_1oqGHarM1aUs3odQW37SUrKZUJq6hpDsw@mail.gmail.com>
Message-ID: <CAL_JsqJkw1Ti7Jdz_1oqGHarM1aUs3odQW37SUrKZUJq6hpDsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mfd: max77620: add documentation for backup
 battery charging
To:     Mark Zhang <markz@nvidia.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 8:07 PM Mark Zhang <markz@nvidia.com> wrote:
>
> On 2/19/2019 2:06 AM, Rob Herring wrote:
> > On Tue, Feb 12, 2019 at 12:44 AM Mark Zhang <markz@nvidia.com> wrote:
> >>
> >> Adding documentation for 3 new backup battery charging dts
> >> properties:
> >> - maxim,charging-current-microamp
> >> - maxim,charging-voltage-microvolt
> >> - maxim,output-resister-ohms
> >
> > What's the difference between the 77620 and 77650 as there's patches
> > on the list for the 77650 too. The properties are similar, but seems
> > to be main vs. backup battery charger. We should have common
> > properties for this.
>
> Rob, it's different. The RTC in max77620 is supplied from a backup
> battery and consumes 2.0uA (IBBATT) when no other power sources are
> available. So unlike max77620 battery charging, which provides features
> like:
>
> static enum power_supply_property max77650_charger_properties[] = {
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_ONLINE,
>         POWER_SUPPLY_PROP_CHARGE_TYPE
> };
>
> For backup battery charging in max77620, what we can do is just setting
> those 3 parameters. We don't know whether it's charging, whether the
> backup battery is online, the percentage of the charging progress, and
> etc. That's why I mentioned before that it's not appropriate to create
> it as a power supply driver.

Maybe so, but that's all outside the scope of the binding. Both
bindings define charging current and voltage. And other vendor's
chargers likely need the same parameters, too. So there's no reason to
have different properties.

Rob
