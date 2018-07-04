Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B68C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F6C23DE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE9uNtNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F6C23DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeGDASz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:18:55 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33386 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbeGDASy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:18:54 -0400
Received: by mail-oi0-f42.google.com with SMTP id c6-v6so7407497oiy.0;
        Tue, 03 Jul 2018 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HoRg/Hxruz+SqWtBDbE1iBx9jr8xF+hBC2ioTWSffvk=;
        b=hE9uNtNI99ONMHKRmp4T/B3qksz+DpNO0W4illw8DB4hNkTmH32RG6JO0IbUa+o4jV
         Es+5IqusGTOUPRQIutjq97pmWO4+eWrPtasLAQGXtAXRCRMC7VAQfQGN1PHat/RaPIqM
         dlw77PTxemiNbbiXP8eL/KAtKPNRULnkr5pxJuE+L1MX0yapCJuVdultEgmU5BHPE+30
         iJNydwXEQPkbDvhV+YZYEMrINjewkv0o0P3wjq85NyT708uwLm0droCvJaUqYlriPWw3
         zrwswXBhRWyQMlZXgJKrjKrK23u7hr0zr/LUPCtQlpzgYTI5bVMy4E5TX63YGvtXXxaq
         X6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HoRg/Hxruz+SqWtBDbE1iBx9jr8xF+hBC2ioTWSffvk=;
        b=tdAg6DHzexjtGtcU4FGp6Xbf6UkW/tVx7wJ0ukCPjKnc6vR87YP7v4x+53eEfSN4Vs
         t9LjrX1anJeHT9TOFkzqXmyen9ywIOWIsqB4Hv4BOsSUc4eygVoJbsDCpoWYs72pwTqB
         0eyFjLFZa1EkfbOX1Ks5EAcob0aOt5O9493fFb00391Sg8hr1U8HCQzGIEis6fHMt8so
         mDPjI86VqSutKY5yc5r8Es/7IUd1T1Y6+YALeehLtdh4hTh1JbAfztF2TsveNGUUsW+M
         PXCFBSqvZjA55UrBNutgr6fJdX2/4u1ilbPQFWAqLN9x1DPIFlKuqdZ5c1B4R2DHq7dF
         /kdA==
X-Gm-Message-State: APt69E2rlmBzxlQ2USVvlNZzIEzwMbUzHQRrokNMnIKjrhbYEkQPO+UI
        fOfv/5HQhNXSlRcOGAtHAR3k+4BS2NQKUtNUDi0=
X-Google-Smtp-Source: AAOMgpcZBdgn37hIEQjkdx2usa5Vq9Fc1kUmTTUI/JT3SaMKcsTzsS3C6/79UwxpgQ5OxE0j/0r16c7O590ZunToiu0=
X-Received: by 2002:aca:6144:: with SMTP id v65-v6mr25328069oib.147.1530663533379;
 Tue, 03 Jul 2018 17:18:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 17:18:52 -0700 (PDT)
In-Reply-To: <20180703184117.GC5611@w540>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180531190659.xdp4q2cjro33aihq@pengutronix.de> <CAMty3ZCeR3uEx8oy18-Ur7ma7pciKUf_myDk6_SpWvxc6DvygQ@mail.gmail.com>
 <CAOMZO5AOpOSAx=L4tOU1Na6hm8Tex3PHNxCYDB81C0+NPHzTZQ@mail.gmail.com> <20180703184117.GC5611@w540>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 3 Jul 2018 21:18:52 -0300
Message-ID: <CAOMZO5AP1b-XaFC2VdGE_hX77y4jOpwS5nqhjySW6ieieEB0pg@mail.gmail.com>
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Philipp Zabel <pza@pengutronix.de>,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Discussion of the development of and with GStreamer 
        <gstreamer-devel@lists.freedesktop.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Tue, Jul 3, 2018 at 3:41 PM, jacopo mondi <jacopo@jmondi.org> wrote:

> I've been able to test on the same platform where Jagan has reported
> this issue, and the CSI-2 bus still fails to startup properly...

Last time I heard from Jagan he reported that the LP11 timeout issue
was caused by:

commit 476dec012f4c6545b0b7599cd9adba2ed819ad3b
Author: Maxime Ripard <maxime.ripard@bootlin.com>
Date:   Mon Apr 16 08:36:55 2018 -0400

    media: ov5640: Add horizontal and vertical totals

    All the initialization arrays are changing the horizontal and vertical
    totals for some value.

    In order to clean up the driver, and since we're going to need that value
    later on, let's introduce in the ov5640_mode_info structure the horizontal
    and vertical total sizes, and move these out of the bytes array.

    Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
    Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks
