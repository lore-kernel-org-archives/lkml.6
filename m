Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D2DC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4AF2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XULen0mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfALQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 11:32:18 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:44527 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 11:32:18 -0500
Received: by mail-io1-f66.google.com with SMTP id r200so14550632iod.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmBi1Cj+MTMr1OW5SbfDBLYOLoHTuQQzqDGjnsrOA+M=;
        b=XULen0mjXXtwZ7yLlLj/D5HrC/8ymLuOvKob3MIMVxjN8Co5wogK2OHyah+Czi/u03
         ppQzJFpmNuMuG+LJmQthsqOoxYp7aXRUuLLb/FsxH544j77rLV/7G9qY8MHxSok3bAJd
         VsrwnvLO0oB6HSN8prOeTyQtBKnHkUI0KUBVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmBi1Cj+MTMr1OW5SbfDBLYOLoHTuQQzqDGjnsrOA+M=;
        b=ZFiykGNrB0Iw8BuACCRv2hm9Aqhesv2WmFEJyJJG4dwVQv/SkFrVdDqkpCNAhee7Ne
         I1nU6/pCvAWd6hpRAD93gmf29Taq6nH4gE1h6hI18vHT17U6H7X8uTKfopUoP9eHY8OE
         qFR0HxIHfKvibHjPsqXlo7umstJRwZZUGQoXFxZl3iNYL0KVkma90LAl1Y71Px4BsaFV
         B7d1IBa9CvbNBaLkuh0pDJ1f1Snk+BkR2/bCZnfc9rRulnTxUJnNQN/5Un6yx3vjzJ/m
         srlfnxoaM0Ea5y1WleBExomrcEizv17o1ag5ChdfLQiKnxXxziKpBQhggDpRnGeky8GC
         pwsA==
X-Gm-Message-State: AJcUukf/vfhdpOBqyyq4VxCBCfQqIMHBNza8eF+oyRmTIb0h/nu4XkLu
        RRN7Qwu5yMw4fDzaezE9jPhHX0xiJsPDCqCZl7pqDg==
X-Google-Smtp-Source: ALg8bN6pOZ9YNEGZJPGpix1r0rDbwQ/QFsgucHUDaNkenXPrHIYqSpZd7T5nyuNOP1yWL3yFcRY5nFam96kIVhjPHMA=
X-Received: by 2002:a6b:1411:: with SMTP id 17mr9285075iou.252.1547310737145;
 Sat, 12 Jan 2019 08:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com> <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
 <20190112101409.GA14273@ravnborg.org> <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
 <20190112120056.GA7374@ravnborg.org> <CAMty3ZAvEzatWMPbtPKUhVRMSzC9icarsxK7KfXAp+gvCR74Lw@mail.gmail.com>
 <20190112153348.GA12461@ravnborg.org>
In-Reply-To: <20190112153348.GA12461@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sat, 12 Jan 2019 22:02:05 +0530
Message-ID: <CAMty3ZDTwAx6aY=KJCWjwRo-JxBKENTfPtjV_LkY=QaSxAjRWQ@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sat, Jan 12, 2019 at 9:03 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
>
> > > But as we just assert reset (set it to 0), this timing constraint can=
 be ignored.
> >
> > But we unaware of reset pulse duration right? it's the hardware that
> > bring the reset assert if we set the line 0. am I correct or do we
> > need to explicitly wait 10us after reset initiated?
> > there is family of chip Sitronix st7789v which don't taking care of
> > this sequence (I don't know why?) in
> > drivers/gpu/drm/panel/panel-sitronix-st7789v.c with Page 48 of
> > datasheet[2]
>
>
> The prepare sequence used is:
> 1) reset
>    20 ms
> 2) regulator enable
>    20 ms
> 3) unassert reset
>    20 ms
> 4) assert reset
>    30 ms
> 4) unassert reset
>    150 ms
> 5) SOFT RESET
>    5 ms
> 6) Exit SLEEP mode
>    sleep_delay (120 ms)
> 7) COMMANDS
>
> The enable sequence is
> 1) Display ON
> 2) backlight enable
>
>
> The disable sequence is
> 1) backlight disable
> 2) Display OFF
>
> The unprepare sequence is
> 1) Exit SLEEP mode  <=3D this should be Enter SLEEP mode (covered by prev=
ious mail)
>    sleep_delay (120 ms)
> 2) assert reset
> 3) unassert reset
> 4) assert reset
> 5) regulator disable
>
>
> The implementation in simple-panel supports a long list of panels so we
> can assume this is a good reference implementation.
> Unless your combo of st7701 + panel has special requirements.
>
> Prepare sequence:
> -----------------
> - Just set reset to 1 - no need to trigger an edge.
>   But if you somehow think the edge is required keep the current code
>   but drop the delays that are not required.
>   We can assume power is OK when it is enabled, no extra waiting required=
.
> - No reason to unassert and then assert and then unassert reset.
>
> In other words:
> - Delay between 1 and 2 can be dropped.
> - step 3 and step 4 can be dropped
>
> Unprepare sequence:
> -------------------
> Enter SLEEP mode may take 120 ms so delay between 1) and 2) is OK.
> No reason to do the reset dance, drop 2) and 3)
> Make sure reset is completed, so wait before leaving the function.
> See note 3. on page 54 in datasheet:
>
>         "During the Resetting period, the display will be blanked
>          (The display is entering blanking sequence, which maximum
>          time is 120 ms, when Reset Starts in Sleep Out =E2=80=93mode.
>          The display remains the blank state in Sleep In =E2=80=93mode.) =
and
>           then return to Default condition for Hardware Reset."
>
> We have already sent an Enter SLEEP command but we have no timing constra=
ins
> when panel is in SLEEP mode, So stick to the 120 ms.
> Just use sleep_delay.

So we need this delay even after reset unlike SLEEP mode delay. OK,
thanks for the points will try to check all these points.

When did .unprepare and .disable are actually called? I turn-off the
backlight by echo 1 > /sys/class/backlight/backlight/bl_power and even
power of the board I assume the video transmission stop so it would
ended-up calling these, but I couldn't see prints. does it the same
time uart dead or something? do you have any inputs on sanity testing
of typical panels, if yes please share.

Jagan.
