Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32147C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D4320989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D4320989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeLGNDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:03:08 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39211 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGNDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:03:07 -0500
Received: by mail-qt1-f195.google.com with SMTP id n21so4316846qtl.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 05:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=foGqDmpa3dOJDPdCFQVOmUJRV+UC9RPIn4ulYxnGPyQ=;
        b=hUtV4MvwTT73X+ixUeWlacoN25psrG0lClKEcAtZMaR71YKMQ3jnUysPnY+OEd8QiQ
         WaIceW3ymwHa2u8lYwZqnTsTnYWst7Qou8Zd/OJ6c21sa/iHsldKizEw2eiNpxDSmA2o
         D+CEodo0Q+S3UL5qLTw03adg19NanXA8xd6cn/GohbXQwgDWRSEmrqSA1RS9YmRbGWiz
         X25pVxylDr8yuVtt0RXJfuISFXTPWB6HMZjwFXav7/CntH0EC3XelPs98BqAkC2PXBVM
         Bn/Krozo+w+KY5tEC9RFLcuFZFm66+ykVydFCYxTZiafQzUZHKFYiasW/XoQM/Zbaxe9
         sUoA==
X-Gm-Message-State: AA+aEWbFYuJAE3pBnCgu2Y43hrFQEVf9wLuebmE1ll7y9SLLoOkoJmQ/
        zeTrnemeCIfYF/AFuXfJtQiAf1UJemCw3zz9HxmLsWN7
X-Google-Smtp-Source: AFSGD/W5hlItj60oG6cQ5Dx58SRjA2YRMr7AOVdrgVAtxVWXqN1SmSVL8iVatXRWwa44LLDS/8/lBGyz8GZXfiQeYIk=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr1846294qtl.343.1544187786418;
 Fri, 07 Dec 2018 05:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20181130064617.67920-1-chiu@endlessm.com> <CAO-hwJKAnHqPi7aOGqKET+_JKnXmvdwOyhtH4nLeqS+-K8597Q@mail.gmail.com>
 <CAB4CAwfOBuAutaQdObyfrOg5Yo2M9NJGww1Ffc7o2YrAYDObEA@mail.gmail.com> <CAB4CAwf34ZvF88rVCz2H6iDKoDHF09txp1oGqvUfCt18ZH-w6w@mail.gmail.com>
In-Reply-To: <CAB4CAwf34ZvF88rVCz2H6iDKoDHF09txp1oGqvUfCt18ZH-w6w@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 7 Dec 2018 14:02:54 +0100
Message-ID: <CAO-hwJKPQP1sFmN7bukXh0DR8WdM7=sDZnyC=7va+vizRdqAsg@mail.gmail.com>
Subject: Re: [PATCH] HID: input: support Microsoft wireless radio control hotkey
To:     chiu@endlessm.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 7, 2018 at 5:07 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Dec 5, 2018 at 8:56 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 7:18 PM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
> > > >
> > > > The ASUS laptops start to support the airplane mode radio management
> > > > to replace the original machanism of airplane mode toggle hotkey.
> > > > On the ASUS P5440FF, it presents as a HID device connecting via
> > > > I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
> > > > send hid report up via I2C and switch the airplane mode indicator
> > > > LED based on the status.
> > > >
> > > > However, it's not working because it fails to be identified as a
> > > > hidinput device. It fails in hidinput_connect() due to the macro
> > > > IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
> > > > as a legit application code.
> > > >
> > > > It's easy to add the HID I2C vendor and product id to the quirk
> > > > list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> > > > can be more generic to support such kind of application on PC.
> > >
> > > Sounds good, but while you are at it, can you please:
> > > - fix the kbuild warning
> > > - rewrite the whole line to use macros,
> > > - make the macro prettier by inserting new lines were required
> > > - and define the missing macro:
> > >   0x000d0006 -> HID_DG_WHITEBOARD
> > >
> > > Maybe we should keep the ranges definitions with raw values and put a
> > > comment on the side with the names.
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
> > Hi Bejamin,
> >     Thanks for your comment, I've submitted other patches which may
> > fulfill your suggestion.
> > https://lore.kernel.org/patchwork/patch/1020373/
> > https://lore.kernel.org/patchwork/patch/1020374/
> >
> >      Please help me review and correct me if there's any modification
> > required. Thanks & Regards.
> >
> > Chris
> >
>
> Gentle ping. Any comment for the new patch? Thanks and Regards.
>

Sorry for the delay. I broke my system and it took me a few days to
get it back on its feet.

The v2 is now scheduled for 4.21.

Cheers,
Benjamin
