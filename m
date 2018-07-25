Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D04C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A0120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hrYhXO8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A0120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeGYWkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:40:11 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41283 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbeGYWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:40:11 -0400
Received: by mail-oi0-f68.google.com with SMTP id k12-v6so16496813oiw.8;
        Wed, 25 Jul 2018 14:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y+xx+GA1LTeImInLahpdvMqNOJw73OSxBvE5dyNakVU=;
        b=hrYhXO8H+jWfTrL3QVUp8g5CbWrDmFdGWMQ5bXMSCfJ8vnITRhxRFvV7f25YpIn8Bt
         P7sZxVxP9PyhVIJJGsRNekT6jia+D5kN5d2wkP/rfc5torzRLweuENEBO9RqPiakzjc0
         fq8vSjqd9AGJcTVxHQ/tP8PMApt5r2VNNbm/TRmI8gYQbPK8K/l+h1ykF0HV62AfGVri
         1MYUto0esr6dbxQWHGnrjTbFwdlZbGVIL4v+KAKBuDEb+NWY+qzK00A/njmuJ/0yoi7y
         VzgJd0Oqnn+p2D7H7UTZjuVU+ssc9oh+d7eVZ2aMndcFZDICv6SZeAKmfax6xvyaEqE5
         gtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y+xx+GA1LTeImInLahpdvMqNOJw73OSxBvE5dyNakVU=;
        b=jgzHb8YjUv9AJco9aKVXcmouRXKwxVBBQ6ZofEvQYuO6OuophjqtkG1IoBU1a0sLCD
         j6e6GGuc1R5lFQ8gnOvF52fCmM/G1aSKkq6pzXtYOmjgBEgpYwJ66AN6sjpZlS+deYB4
         mVA7Y5qWhD3Xg5nFr2sI7KJonI718/YP1KU6BuGd2oa6bR6eLz0Zd4Gc3AW3o5aj5FT4
         ciU1DcwJp6MIlDEysyK8MxkPk2jZzA4J2Q+2RTAtnvB/yrVwzokmaQErBrKkHB54uw9m
         cv5cpjgk5EEoC+pCSDbBTbG6toXAx4ksrnaosUYBajUAZZWb8aJSQFYPP46bBvJarRBk
         13Ag==
X-Gm-Message-State: AOUpUlG3pv1QmYK/DkaFMhBoUS/3rexAHM2tP55PBC+xvLurydKbqxzO
        rIh60s7kQm6hTmQJh8TnsTw59pcMso7ihruIhBM=
X-Google-Smtp-Source: AAOMgpcJ16TSsqXfUoOy7HVVsvJNAFDozr9qnbKhtEyPkcyd1N6tg1JdYMnrUTvE4ub0OzsfRc/wjWOxPQZ1DRMuSBY=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr5560960oib.116.1532553998814;
 Wed, 25 Jul 2018 14:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180724125238.14567-1-jbrunet@baylibre.com> <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
 <705e31bf0d978b7d356b2f077179ab0e3db6f092.camel@baylibre.com>
In-Reply-To: <705e31bf0d978b7d356b2f077179ab0e3db6f092.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 25 Jul 2018 23:26:27 +0200
Message-ID: <CAFBinCB_fULnmrpyzNwnfAiL9QGco_6QW957Wroj8o6ZhNwmWA@mail.gmail.com>
Subject: Re: [PATCH 00/14] arm64: dts: meson-axg: add audio support
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, carlo@caione.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, Jul 25, 2018 at 11:19 PM <jbrunet@baylibre.com> wrote:
>
> On Wed, 2018-07-25 at 21:11 +0200, Martin Blumenstingl wrote:
> > nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
> > while other patches that are touching the s400 board aren't
> > if you have to re-send this series: can you please use the "arm64:
> > dts: meson-axg: s400:" prefix for all patches touching the s400 board?
>
> hum, do we really have such rule, or do you think we should add one ?
looking at the git history in arch/arm64/boot/dts/amlogic: it seems
that we don't have a rule yet, even though some (some of
your's/Neil's/my) patches were using that naming schema in the past

> Kevin, do you have opinion ?
>
> Not that I really mind either way, but prefixes rules are usually there to help
> maintainer filter the patches. Will such rule help in any way ?
maybe it's just a problem of a false initial impression
I read "arm64: dts: meson-axg: add usb power regulator" in the
cover-letter and came to the conclusion that this patch must be wrong
since meson-axg.dtsi should not have any regulators (unless they're
built into the SoC). only when looking at the patch itself I realized
that it's fine because it patches the s400.dts


Regards
Martin
