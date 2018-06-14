Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 833A6C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F010208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2Rub5L2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F010208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964905AbeFNOGo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:06:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40764 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964804AbeFNOGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:37 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so9632974lfc.7;
        Thu, 14 Jun 2018 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFCQYcomyY0Ym3OEN+iehygz4V820MKr3msvxAaDtYU=;
        b=D2Rub5L2pbPkbBW7M0CxS/FHNvruKfh+oPtnF795OvNt6vrpScUJZ5CocXWVM4zOz2
         BdUipjjQ61iO/9mxEaOk6UiF3qiy2jcflVDxyQ1p4ZiVZAaQwvUPXijw9QkvG8sUurXu
         6LLQjeBwQ67H2Z5yTOYjZwYxhrbZ57hNaQkXRE9Grmo51d2djRHVnmmuRgvQaik9iRQ+
         Xxb7VAXtCMKsQb0DHcHnccUzUJhApsx/F1zXDyo1wCUt2OXIVt/d6bKMg3Pa8kMjxAOu
         ZIud0jKCg3IAGHUsjpfZvv4BZ24YAru0ZjcfzF30/UHFy23G/8GHZ9WU3JHZngGfzO3j
         YORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFCQYcomyY0Ym3OEN+iehygz4V820MKr3msvxAaDtYU=;
        b=S9XQnATyZmbA/gqLPRXWCZKWjma5pZbnkCthXf5XhvxfncvtFMC3G/b3oK5oITNiN5
         W69Ah1yH/cSsW1YcRjXT02W+m4mm0qdQ1qCWNysHT4wPckAe4xen66jqobgjQoLIkb9R
         inbIQvsBpgNDuWB2mVABj0l7Gdq4Q4BfCUqzJbB593LrA2zXe4Gn0sXGOFg4SPYnlsbA
         t/S1zzMMkGwBADc/msrzik/jo0TNICi1QawW0U1ve1uL8D6BoV8xQBI8R90tRp3T7qY6
         4HOgFZt4W5FwQBTzL973ObEiX2EuU5hBOMSFLChGVjc01UvovnA9i3q/hvpe7yPhSmZM
         Eg8A==
X-Gm-Message-State: APt69E3pWr9wIqsMlTdBG+cuSKgJ+QTO6ooNpjdHGGJALAtvJQ+YjkkJ
        kxMkUMgVE0JHGU4iIvJ0ZRLQmCeAIibN8zb38C4=
X-Google-Smtp-Source: ADUXVKIfEP1Vj8DzFjFo4mN/Tczv75PFsoI/ygqh8XgI+6gn2gE4RHOJ9c/vPFWSq3GnmUFCYt4tt25jkkxiMjbGt2M=
X-Received: by 2002:a19:9f95:: with SMTP id i143-v6mr6468465lfe.125.1528985195071;
 Thu, 14 Jun 2018 07:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost> <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
 <20180614133341.GD32411@localhost>
In-Reply-To: <20180614133341.GD32411@localhost>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Thu, 14 Jun 2018 16:06:18 +0200
Message-ID: <CAPybu_3=KhPB_ymtRNSZfcyP57LPD2SbLUPoFO0YdjkzAsdaTA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via sysfs*
To:     Johan Hovold <johan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,
On Thu, Jun 14, 2018 at 3:34 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Jun 14, 2018 at 01:06:59PM +0200, Ricardo Ribalda Delgado wrote:
> > Hi Johan
> > On Thu, Jun 14, 2018 at 12:48 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> > > > There are some situations where it is interesting to load/remove serdev
> > > > devices dynamically, like during board bring-up or when we are
> > > > developing a new driver or for devices that are neither described via
> > > > ACPI or device tree.
> > >
> > > First of all, this would be more appropriately labeled an RFC as this is
> > > far from being in a mergeable state. Besides some implementation issues,
> > > we need to determine if this approach is at all viable.
> >
> > From previous conversations with Greg it seemed that RFC labels was
> > something to avoid, but I do not mind reseding it as RFC on v3.
> >
> > http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-March/018844.html
>
> Yeah, Greg uses that to triage his insane workload, but RFCs still have
> their use (and are still mentioned in submitting-patches.rst).
>
> > > Second, I wonder how you tested this given that this series breaks RX
> > > (and write-wakeup signalling) for serial ports (patch 19/24)?
> >
> > I have a serdev device (led ctrls) that is dynamically enumerated with
> > something very similar to:
> >
> > https://github.com/ribalda/linux/commit/415bb3f0076c2b846ebe5409589b8e1e3004f55a
> >
> > and then I have a script that does adds and removes. For standard
> > serial port I was not testing the data path, just that the ttyS* was
> > enumerated fine.
>
> Well there's more to serial ports than just enumeration, you typically
> want to send and receive data as well. ;)
>
> > But  yesterday I believe that we found the bug that you mentioned and
> > we have fixed it (check end of mail). I will patch the series and
> > resend after I get more feedback and also implement what Marcel
> > suggested.
> >
> > WIP is at
> > https://github.com/ribalda/linux/tree/serdev3
> >
> > Besides this bug, we have used the new driver for over a week now with
> > no issues.
>
> Hmm... No issues when not testing the main functionality of serial
> ports, you mean?
>
> And there are more issues with the series which are less apparent than
> the rx (and partial tx) regression.

Any hints about this? What else should I change on the series?

>
> > > Third, and as Marcel already suggested, you need to limit your scope
> > > here. Aim at ten patches or so, and use a representative serdev driver
> > > as an example of the kind of driver updates that would be needed. It
> > > also looks like some patches should be squashed (e.g. the ones
> > > introducing new fields and the first one actually using them).
> >
> > >
> > > > This implementation allows the creation of serdev devices via sysfs,
> > > > in a similar way as the i2c bus allows sysfs instantiation [1].
> > >
> > > Note that this is a legacy interface and not necessarily something that
> > > new interfaces should be modelled after.
> >
> > I would not consider it legacy, it is the only way to use an i2c
> > module without writing your own driver and/or modifying ACPI/DT table.
>
> It's legacy as in old, and to be used for one-off hacks and such. But
> sure, that is also what this series aims at even if that doesn't mean
> you *have to* copy the interface.

It is not only one-off hack. It is the ONLY way to use i2c devices
that are not enumerated.

The same way as today we do not have any way of using serdev on non
enumerated devices.

>
> > Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > Date:   Thu Jun 14 11:30:27 2018 +0200
> >
> >     serdev-ttydev: Restore/change ttyport client ops
>
> Yep, you found the source of the broken serial port rx/tx.
>
> Johan



--
Ricardo Ribalda
