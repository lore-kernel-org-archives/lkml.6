Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97605208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C5OnoMqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97605208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeGIVqd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:46:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38140 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933138AbeGIVqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:46:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so38765145oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKArEBip1XhDQZSSdZkuIR5cjf5eb7Hl4A7SCzqx0GQ=;
        b=C5OnoMqZekO01zvZFt5iE81en/j24yw3xiWSB06vSu7adShJCpswPSM4EohgcuSLPc
         DI/BpaHA3KvrWWXyrqa4ky38F7CZsYS4eGNmXa5TdTiZ58dzOhZOY8LuKFkYq5Y+nNwX
         RNgGmaZAM8/2aZOafYLEd14h0x4pvllEiRYNX35ri+1ZNT3CObYxQJz5NxLyW/sW5LbD
         H066nmIb+kZ5CavOYVjyKwGcV0qDHGXKLXQye+jNvU3hP2F5X5CdPlDzL935lHt4SmFa
         QrQhL9pxuj6zft59079eq48VeQPKnoEazek1F6MGHreanZxU8h9bR5Z1G5F4q+JAKLkc
         XxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKArEBip1XhDQZSSdZkuIR5cjf5eb7Hl4A7SCzqx0GQ=;
        b=FULaUNxoWtTCcfw8Ea/+PiV2G/hVBDmFvjGncCHEmq49ghZTmeA+nKTnnvxHUn0H5Q
         jft+t49hplX0I7QrFe7Wg92JdrXSEnZw8C+jnFWvj6CFQDkX+akVercJB+TFwlyCBrAt
         WJ+H83Tvy388GaldQ3qul0vRA9iPrRLApr2+pb1PjbaVTdcfsHP2LT9hS69ocXywZnqs
         HHgUglqbaH4oJxpdzg7xaku9TCx0fxJst/+vdiaoqP2sZfZMfRTDC/U9oKOdXsuBHthq
         crlzArtZqBMkeMNg8AiPmtI4iUyUi5sMIztolb6Cx6SB5tKTh4wiaxEnFUHzlOe1yuHR
         qMyQ==
X-Gm-Message-State: APt69E2DmEficjeiCCtiyFWtL22OYhS05S1iWuNglQZDtzSlq3wKQFoR
        S8XemvZUFV1Vy+QZ9p3L5bnlwM/QLjnKHxOnmHAitprK
X-Google-Smtp-Source: AAOMgpd2vW0oRn4Y8og4hHZdNg81hEW931zn1XgYE3tBq4DArF5bA/2SO1HCsL4/ySuDbkF3FziucLl7uJNVn/vCWxo=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr26078188oif.97.1531172791879;
 Mon, 09 Jul 2018 14:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com> <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
In-Reply-To: <CAOi56cWaeh+c9+OgpxdjTarnRdaKrNFC=ddBPT2j9v1rHT8EOg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 9 Jul 2018 23:46:20 +0200
Message-ID: <CAFBinCA6gZ9fw0yGvs_FWuGoZG-d2CL2R5qYp3_u1T=Atn8tgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "tick: Prefer a lower rating device only if
 it's CPU local device"
To:     khilman@baylibre.com
Cc:     sudeep.holla@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:24 PM Kevin Hilman <khilman@baylibre.com> wrote:
>
> On Mon, Jul 9, 2018 at 8:45 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > This reverts commit 1332a90558013ae4242e3dd7934bdcdeafb06c0d.
> >
> > The original issue was not because of incorrect checking of cpumask for
> > both new and old tick device. It was incorrectly analysed was due to the
> > misunderstanding of the comment and misinterpretation of the return
> > value from tick_check_preferred. The main issue is with the clockevent
> > driver that sets the cpumask to cpu_all_mask instead of cpu_possible_mask.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> And verified to fix a regression on the 32-bit ARM platform mesion8b-odroidc1.
I also tested it on Meson8b as well as Meson8m2


Regards
Martin
