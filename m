Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77770C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A31218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfB0JFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:05:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36117 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfB0JFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:05:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id t206so12839253oib.3;
        Wed, 27 Feb 2019 01:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdHJNaWYai0FQfvlQr1TRfeUbZz8NBu3hbq0ZcPfkEA=;
        b=cMY7AGY12wCFEejbWPpasnEinnAkwLarxpex5Fi1uCrfYeXg/yMrnuW0HaXf/a4IVw
         gqZcJVOoews4a679S6sRFWPgwhQ/AvQ/18qT5Rw9QB1BSi7SH0YqpM8+bsxclUxF6ILK
         cC5hBCvPfalszzKQUDT1bZPo5TZdhtlWHLi1mw3SlcymWJaVnGWVkYfAhTsV+61fwRhq
         3skdQADc5Ar4GDc1bloD48HWQqcyIUWspdoWlmUUTGiPDB1WmBpMn4O1xzCJPrA9apIn
         8/Wk0OUFbx4DyfIK7ZPPDKwEzTa8PC8eqmPURR8M3Y9/fMpl7OgV3A9zKNATC/AA1OiU
         7lCA==
X-Gm-Message-State: APjAAAXr24gD45D97hS0H+DeX3OxwuofsYepGnftlXyPW98Qk/rb3nAX
        eT76iZqEwgfzMeoB6DTd+hxxOj2YcW7t3AVUgshvpw==
X-Google-Smtp-Source: APXvYqyLv9rqUDRdKTsyisdhaXWP5ZqEiHVsR3Z3lj5gCyF2c9V8ko/cs5Xvb41I7dj5XH2ZEL61/zHNSowpFPoj6/0=
X-Received: by 2002:aca:cc06:: with SMTP id c6mr266890oig.168.1551258349302;
 Wed, 27 Feb 2019 01:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com> <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com> <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
 <20190219172515.GC13075@lunn.ch> <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
 <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
 <9cb2f7a8-a8cf-ef80-d260-cc67c072b5c5@xilinx.com> <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
In-Reply-To: <8bb813fb-102b-00c9-fb6f-a3e928965051@xilinx.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Wed, 27 Feb 2019 14:35:38 +0530
Message-ID: <CAFcVECJPtc3VQjK4WLCz1Wc4nopXnsLTKXFFY1ZpecgC+_PhyA@mail.gmail.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Paul,

On Wed, Feb 27, 2019 at 2:15 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 21. 02. 19 12:03, Michal Simek wrote:
> > On 21. 02. 19 11:24, Paul Kocialkowski wrote:
> >> Hi,
> >>
> >> On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
> >>> Hi,
> >>>
> >>> On 19. 02. 19 18:25, Andrew Lunn wrote:
> >>>>> Thanks for the suggestion! So I had a closer look at that driver to try
> >>>>> and see what could go wrong and it looks like I found a few things
> >>>>> there.
> >>>>
> >>>> Hi Paul
> >>>>
> >>>> Yes, this driver has issues. If i remember correctly, it got merged
> >>>> while i was on vacation. I pointed out a few issues, but the authors
> >>>> never responded. Feel free to fix it up.
> >>>

Sorry for this - I've synced up with the author and got the comments from the
time this driver was upstreamed. I'll try to address those and Paul's
suggestions
going forward.

> >>> Will be good to know who was that person.
> >>>
> >>> I can't do much this week with this because responsible person for this
> >>> driver is out of office this week. That's why please give us some time
> >>> to get back to this.
> >>
> >> Understood. I think we need to start a discussion about how the general
> >> design of this driver can be improved.
> >>
> >> In particular, I wonder if it could work better to make this driver a
> >> PHY driver that just redirects all its ops to the actual PHY driver,
> >> except for read_status where it should also add some code.

Thanks, I'm looking into this option and also a way to expose the correct
interface mode setting as you mentioned below. I'll get back before the
end of the week. Please do let me know if you have any further suggestions.

Regards,
Harini

> >
> > I didn't take a look at Linux driver but it should work in a way that it
> > checks description (more below) and then wait for attached phy to do its
> > work and on the way back just setup this bridge based on that.
> >
> >> Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
> >> this way. Currently, the PHY mode has to be set to GMII for the MAC to
> >> be configured correctly, but the PHY also gets this information while
> >> it should be told that RGMII is in use. This doesn't seem to play a big
> >> role in PHY configuration though, but it's still inadequate.
> >>
> >> What do you think?
<snip>
