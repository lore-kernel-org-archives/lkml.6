Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC77C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FE72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VmQ3LaDx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n9mGz1uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FE72075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937058AbeFRXjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:39:13 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:41426 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936974AbeFRXjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:39:09 -0400
Received: by mail-vk0-f65.google.com with SMTP id 128-v6so10606264vkf.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 16:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KlBT3YKstFwk+e1OE7tvlZ0To5wwHhjmjL13nA0MBJo=;
        b=VmQ3LaDxgtq3QidnuOiGwky2jjOOERXnU4VioJBYDC5RWLOge1Ew1+JHyUJMC4Q0NG
         tkQcJsCzV1XWJetlJmk3PBebSHYuQb7nkHlqB+16baDj6sImYqJ8GcRUnQjNPZBmwO0M
         gM0ZorenApck2KxG0WMM+o1mTVhPta19xnkuaPqMiH0uclp3cBFPSXSZAXClJIqa0jnl
         1R6kGi2qGP0GoqQU19OM0K7DozM8kS9+00z78OhMnu+72+zypLYOPsLPueUvJOfEDWu7
         FkE4HLOKUXGbZVQOj+ym3i/GHFO+bg6RyjrYND+NnkKlHEV9nyd0X8hyfCCobyexHrJq
         uFXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KlBT3YKstFwk+e1OE7tvlZ0To5wwHhjmjL13nA0MBJo=;
        b=n9mGz1uLyID7Yt52CdpNE6/vUe0ZpsrngGMmUNCLBBpq5Ip91oZUim1FqdiCmKZ7EF
         Hqo4mwLUI788jxy2VQJG/ZrJCfRoTmMpKbQZz3psz286mDN181Ai5F90tFt0QTuZzpso
         dWhFv4ctZpfWnTQ6C/oQh4FB1KlGwVZcsimdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KlBT3YKstFwk+e1OE7tvlZ0To5wwHhjmjL13nA0MBJo=;
        b=hKo49du1X5tW+EaNYU13YT053MrA1ktCV0H5kyF7VkN4UYi7AAN60K/r1wxZWaBEiA
         LfX5nBTPcXwAohSNn3V345D3dJaeZSNwA8BHhR/JUUpd7ZInELIb3OPvYOndQR+fGZ4w
         H8LvXICZarbL0tZCryoPFOS5uI68ORjGqbSZ/2UtY+X7vdOy/HSsHgDbFCw/c4jXK/qh
         GCQoGZgod1HYT54xdTub4qzzVEoOTejSOmy2Igtr/rLmwYJe42bBbcv8yKZZh6bjNQRD
         f+P6aDlvNRLF2v2YQvJ/fCPgqDuCN4Hj4pzi8L0f4gIIgfv+RKnCQNgBMJum5GsUak5p
         4cdw==
X-Gm-Message-State: APt69E3UO0MGmtBvJIc6GPVGaIH6fYh6jtu55qHkOHrp654ZffE02lHi
        KSIQKoFtg/hnHQsVU38Je/w6tPLATQGidMvm6tI7Vrpd
X-Google-Smtp-Source: ADUXVKL4KlXO1fFItHkioISX93DK+F7a65e7MHybpBqEeHHo4r9452G1ZDBqe14eCMGdyJhWLxIhGkor/f5NKtOpEIk=
X-Received: by 2002:a1f:c007:: with SMTP id q7-v6mr8806848vkf.144.1529365148440;
 Mon, 18 Jun 2018 16:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 16:38:27
 -0700 (PDT)
In-Reply-To: <152936452512.16708.5405608343995548468@swboyd.mtv.corp.google.com>
References: <20180618205255.246104-1-swboyd@chromium.org> <20180618205255.246104-2-swboyd@chromium.org>
 <CAD=FV=WvsY_=Ko2QXvzmHOuy4O5Rh6+sRWZZOuSXyGC829ANag@mail.gmail.com> <152936452512.16708.5405608343995548468@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Jun 2018 16:38:27 -0700
X-Google-Sender-Auth: Pt2ayzVrn79TH3jGaAYto0kYcRU
Message-ID: <CAD=FV=UhfffG__41+5yeiDEdN1DYeTkXEoqasc23fb1YKg9F9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: msm: Really mask level interrupts to prevent latching
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 18, 2018 at 4:28 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Doug Anderson (2018-06-18 15:43:06)
>>
>> On Mon, Jun 18, 2018 at 1:52 PM, Stephen Boyd <swboyd@chromium.org> wrote:
>>
>> > +        */
>> > +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
>> > +               val &= ~BIT(g->intr_raw_status_bit);
>> > +               writel(val, pctrl->regs + g->intr_cfg_reg);
>>
>> Do you know if it's important to do a 2nd write here, or could this be
>> combined with the next writel()?
>
> I haven't tried combining the writes. It felt safer to keep them split
> up so that both bits don't toggle at the same time, but I don't know if
> it actually matters.

Maybe I'm a glutton for punishment, but I'd say go for it, unless
someone from Qualcomm says "no way".

In the very least in the "unmask" case it seems pretty safe.  IMHO if
re-enabling the "raw" status caused a glitch we'd already be hitting
problems.  Specifically the glitch would end up getting latched
(whee!) and then we'd unmask and see the glitch anyway.

...and actually for the "mask" case it seems like you've written it
the less-safe way anyway.  We know that masking can't cause some sort
of glitch (since that's the old code), but I guess we don't know
whether disabling the "raw" status could cause a glitch.  To be the
absolutely safest you'd do the new disable of the "raw" status _after_
the old masking.  ...but as per above I'd just go whole hog and
combine them.  :-P

As with everything I write, feel free to tell me I'm being stupid and
I'll try to shut up.  ;-)


-Doug
