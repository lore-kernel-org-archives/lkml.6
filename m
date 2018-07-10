Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D6EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22713208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBg8+luy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22713208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbeGJIOv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:14:51 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37446 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbeGJIOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:14:49 -0400
Received: by mail-it0-f67.google.com with SMTP id p17-v6so30110798itc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=msww2WyM4L2u0wMphjfznFT5RjEutm10U5J3wm7ywUs=;
        b=EBg8+luyzyl4tX7/SU6SHa2zGwd4Rr1pXNvsWBDZpVd01eBgFCtK4LUhYxTemLZe1b
         oO2g/hOAFJ9iCYHNtXd30RIX/7IMA2Dr7vv6xnz94u0zqY9cnn1l0Q1CmxlllgwslG5E
         SOJRVdTW0IhDpa/JFNG+oVyV3cJYJhNhpyuqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=msww2WyM4L2u0wMphjfznFT5RjEutm10U5J3wm7ywUs=;
        b=XwgpRnmR3UIv+G2m363LT27newR4KQyoY31/J8y5nwa1OgMr9HlILwk7XxscnUoVlC
         WwbpdTNf0afoq312HPtp7GWAuInYPB602/VLCdugOHtzSHRpI+RBCYydoBh+HDKpaPnF
         3dY5DYuAJlNpDb/z4SQjpZGH8OSzdl5a6sqJ4AJZMl6O7dXTgACewaQ+DaEJwymnwU6p
         euu7vmogMDOmqo/A/Ffqrzycng1I0nPibeb0M1QoUeCUbPC7Erc92Dh94AbnNe8HROD/
         xl+WAA+JK6+1TQRSCbQERrSJB/1hqPNbY7lZ1iiDlFpb+xrXiL5M1L4+ifaPz1tLTyJH
         4fcg==
X-Gm-Message-State: APt69E25g7Paax2O7eC2LhTtlMuaJQkg2Wpt2j6q2oIPb0FHWk3NCmED
        FDB8x1GNhA4cNe7xQJ4NPRailHZzbwPtltDs2DU/QMznYNQ=
X-Google-Smtp-Source: AAOMgpcb+2uz+WqzvbLgiDREe9xcOHDGQ08YyzSG4HF7fZewx9vWXt7TT3DyQ55A9Jwfq97agJIQHxs5KmpUsQzpbkw=
X-Received: by 2002:a24:1c09:: with SMTP id c9-v6mr19363850itc.38.1531210488621;
 Tue, 10 Jul 2018 01:14:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 01:14:48
 -0700 (PDT)
In-Reply-To: <86aa8215d6e44e578cd34f0625c5ebef@mail2012.asrmicro.com>
References: <1531118843-796-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFpzJV-UQbMa7_tHms7o3hMn9_g=H_M0jW+ZN9G=8XCqRg@mail.gmail.com> <86aa8215d6e44e578cd34f0625c5ebef@mail2012.asrmicro.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 10:14:48 +0200
Message-ID: <CAPDyKFqfwxGgVhKp-RU1Ksd2BKhxvqdqXf0JV3dzyJdgfeBV+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: improve rationality of bus width setting for HS400es
To:     =?UTF-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= 
        <hongjiefang@asrmicro.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastian Stender <bst@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 July 2018 at 07:04, Fang Hongjie(=E6=96=B9=E6=B4=AA=E6=9D=B0) <hongji=
efang@asrmicro.com> wrote:
>> On 9 July 2018 at 08:47, Hongjie Fang <hongjiefang@asrmicro.com> wrote:
>> > mmc_select_hs400es() calls mmc_select_bus_width() which will try to
>> > set 4bit transfer mode if fail to set 8bit mode. The problem is that
>> > the bus width should not be set to 4bit in HS400es mode.
>>
>> I guess it fails because there is something wrong. Can you please
>> elaborate under what circumstance the problem occurs?
>>
> This problem very occasionally occurred when system resume from
> suspend state. The card stuck in the programming state after setting
> 8bit mode. After that, mmc_select_bus_width() will continue to set
> 4bit mode and return without errors. Of course, the following R/W
> requests will be all failing.

I see. So it's the mmc_switch() operation that fails, when trying 8-bit. Hm=
m.

>
> The problem scene is hard to reproduce. Maybe it happened
> because there is something wrong about bus clock or core voltage
> stability when system do resume.

Yeah, that needs further debugging.

Don't know what host driver you are using, but potentially you could
play with a couple host specific mechanism. The ->host->card_busy()
callback, host->max_busy_timeout and MMC_CAP_WAIT_WHILE_BUSY.
Depending on these, __mmc_switch() changes its policy when polling for
busy. Have a look at __mmc_switch() and mmc_poll_for_busy(), to see
what goes on.

>
>> >
>> > Signed-off-by: Hongjie Fang <hongjiefang@asrmicro.com>
>> > ---
>> >  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++++--
>> >  1 file changed, 21 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> > index 4466f5d..94c3cc5 100644
>> > --- a/drivers/mmc/core/mmc.c
>> > +++ b/drivers/mmc/core/mmc.c
>> > @@ -1337,9 +1337,28 @@ static int mmc_select_hs400es(struct mmc_card *=
card)
>> >         if (err)
>> >                 goto out_err;
>> >
>> > -       err =3D mmc_select_bus_width(card);
>> > -       if (err < 0)
>> > +       /* Switch card to 8 bit mode */
>> > +       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> > +                        EXT_CSD_BUS_WIDTH,
>> > +                        EXT_CSD_BUS_WIDTH_8,
>> > +                        card->ext_csd.generic_cmd6_time);
>> > +       if (err) {
>> > +               pr_err("%s: switch to 8 bit mode for hs400es failed, e=
rr:%d\n",
>> > +                       mmc_hostname(host), err);
>> > +               goto out_err;
>> > +       }
>> > +
>> > +       mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
>> > +
>> > +       if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>> > +               err =3D mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
>> > +       else
>> > +               err =3D mmc_bus_test(card, MMC_BUS_WIDTH_8);
>> > +       if (err) {
>> > +               pr_err("%s: test 8 bit mode for hs400es failed, err:%d=
\n",
>> > +                       mmc_hostname(host), err);
>> >                 goto out_err;
>>
>> Lot's open coding, no I don't like it.
>>
>> Wouldn't it instead be possible to check the return value from
>> mmc_select_bus_width(), as it should tell what width it manage to
>> select. Then if it isn't 8-bit, then we should bail out. Does that
>> work?
>>
> After setting 4bit mode, it can't work because it cannot back to
> HS200 mode like the HS400 mode.
> For HS400es, if fail to set 8bit mode, maybe it is more reasonable
> that return error directly.

Yeah. Care to send a patch for that?

[...]

Kind regards
Uffe
