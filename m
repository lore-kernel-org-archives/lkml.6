Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BFC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9426F21536
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjv2N5Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9426F21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeI0Ej7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:39:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33229 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0Ej7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:39:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id l19-v6so547872ljb.0;
        Wed, 26 Sep 2018 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzcVG/Mf+cuP9UTR2TjQ8mjXaZfdGMXeyXqqt9MkOeY=;
        b=bjv2N5JvcS1FlCM9W6gnMsSx10TSdlH6pWkcRc/wJgpG9eecZFCrlEwVy+HLyuqd6I
         YZSJecNUFDIHM/SaxaYSwM1Rva941q+ZzfXizNO7ed7NpI3RxI1IWPrGEPBF3OQXM2GD
         qYqHhcRS2Q3mASqKf6iW0GJ7punfQ3oLyVAcBA8DQ+0Laj8SR7Mx4foyniuXIad+YfvQ
         vUQ4RdVvf3QcnokAp1fjUSkFTGCVB+x6gR+xnOdcL+H0ItwJcFFg8AZ0GwyipT7YcJkM
         0eD75/vG4Pcoy0iRNyu+p4lcNOgibIK7kt0CDDlzk6dDY13Qju9MEwR1rQQsHkGkYVtO
         Ud7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzcVG/Mf+cuP9UTR2TjQ8mjXaZfdGMXeyXqqt9MkOeY=;
        b=nfvHd3JS0mVX0JPX3TYhCBR8UYX/n+oPmMQJGpEndKNRXj0CB3MZJBy/CTpEbms5yi
         UHtfte+IRcCLwBsqmy/owiZi9Olzz3ZfJZotR41Knc1K/xa3eht8tLOc6lkCORWSny0/
         fU4qrcxagitsmxLR50YB0hwDD4HhkNy4DGC7to/X8mJszqLysl/F0jKOncJegYlgb4xz
         Z07PQFEGX/pyv+bC96wZZOYU0IoaSNbLrUCKOa7yafQOpSCaEWo0fxzh45luzgzpb96T
         3fJ/aN4qq2QKxDtZmhDOz7N8SXbAYg6h+rjtM9RnzDHaYGe9D64HQzKmv986N3x7N0HO
         BzyA==
X-Gm-Message-State: ABuFfog03HpweOWSMc8tS/DPsCRmXUXx3f7lxpfLTwQcHAZ2gjqdd468
        t+XFUdwFj5urNKxj8GTc8r/uU5fiHhkwRPhK7m8=
X-Google-Smtp-Source: ACcGV61gPCfoItKtCdbL0ykpXpBpQulau/DMGdQayD9HnPKCB+Mp6KOgiCPoUW5q4CbrQBDzsD8g2xfaGgR3QxzPdoo=
X-Received: by 2002:a2e:914e:: with SMTP id q14-v6mr4028006ljg.23.1538000690542;
 Wed, 26 Sep 2018 15:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk> <20180924164531.GB4988@localhost.localdomain>
In-Reply-To: <20180924164531.GB4988@localhost.localdomain>
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
Date:   Wed, 26 Sep 2018 23:24:39 +0100
Message-ID: <CACfOrNd=1_YqUqr_sKp4DnKR8DQe8k-e8fKU7ogpi0MgaxXBxA@mail.gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: remove early break
To:     edubezval@gmail.com
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is called at initialization when power_allocator
governor is set, and used to parametrize how the thermal
manager shoud work.
By reading its documentation, this function fix a switch_on
trip point (i.e. first passive trip point seen during a scan of
all trip points for that thermal_zone_device) and a
max_desired_temperature trip point (i. e. last seen passive
or active trip point during the scan). At last, if there is neither
a passive nor an active trip point, the governor does nothing.

If a critical trip point is defined before a passive trip point, the
governor will not work, even if there is a
passive or active trip point declared after the critical point.
For instance, on an Odroid-XU3/4 with a Samsung Exynos
5422 CPU, trip points are set as "active" first, "critical", then
"passive". https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi?h=linux-4.18.y#n53
There is no documentation constraining to an order in the
definition of trip points neither in the thermal manager nor in
power_allocator.
Thus, dts contributors could choose any order to define a
thermal-zones, and set the "critical" trip point first, breaking this
thermal governor.
On Mon, 24 Sep 2018 at 17:45, Eduardo Valentin <edubezval@gmail.com> wrote:
>
> Hey,
>
> On Fri, Sep 21, 2018 at 02:06:09PM +0100, Willy Wolff wrote:
> > If a trip of type critical is defined before any trip of passive
> > or active type, power_allocator governor will not switch on.
>
>
> But, if a critical trip is reached, the expectation is to perform a
> thermal shutdown. Why would you expect to have power allocator
> to be activated during the process of a shutdown?
>
> >
> > Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > ---
> >  drivers/thermal/power_allocator.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
> > index 3055f9a12a17..6544b68e3ebf 100644
> > --- a/drivers/thermal/power_allocator.c
> > +++ b/drivers/thermal/power_allocator.c
> > @@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_device *tz,
> >                       }
> >               } else if (type == THERMAL_TRIP_ACTIVE) {
> >                       last_active = i;
> > -             } else {
> > -                     break;
> >               }
> >       }
> >
> > --
> > 2.11.0
> >
