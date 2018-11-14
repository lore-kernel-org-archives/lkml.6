Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9167A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 03:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9167A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbeKNNQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 08:16:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45081 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbeKNNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 08:16:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id d39so9070996edb.12;
        Tue, 13 Nov 2018 19:15:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLt5l5+tiU/xD6tpHDgJHsAhwGUVSEm/uoRzBY6PMzY=;
        b=WgGz6g5ZpoBwVExTEH2ato/IaRqb+hDPsn100pFvf/fuSkix7ELCy+0lP4S4pumJ6L
         xzbZ1SjLLnban23iGZyh46vWMGNsEw39OT6XeqrE/iKJ3vTsE9NhtJSZL7mx2vtlNKDJ
         dZVt0uWR3avrY1KD3urk5yeBWWCyWx+upuL0g/E45Y6oh3hCPRlHsyZrVxrCaB3TPLxR
         5SG6sfhljOBKqn/L28OWedTLImUdXT2nnZLY0BbBqRBKxPzYlwVz8wq7ms7zRLM2WG/T
         E5Q//RvbCj3BI2eu78qAvFsn9eXndKEzGu+BYLXJsmJFVEkr3Qvr9pgTGaPdulWnXYu2
         bCuA==
X-Gm-Message-State: AGRZ1gLEJydc2oMcBMGBGVPi1+g0Ixj13jbWq+R6w6O0WmeJ1vmkB7wy
        PnblU19mNXQ9Dy+37FaWk5jbfV+58G4=
X-Google-Smtp-Source: AJdET5cIF8RpXSLRRJqlhC9+ptxZuevpQ2C4tg5KI7xQd+p0G0UePouJaNNt4Oozn6Wx4bUW8ZE7KQ==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr399665ejr.154.1542165327096;
        Tue, 13 Nov 2018 19:15:27 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q3-v6sm3336757ejz.30.2018.11.13.19.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 19:15:26 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id i73-v6so8687124wmd.5;
        Tue, 13 Nov 2018 19:15:26 -0800 (PST)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr367214wme.8.1542165325650;
 Tue, 13 Nov 2018 19:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20181107101308.7626-1-wens@csie.org> <20181107101308.7626-2-wens@csie.org>
 <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com>
In-Reply-To: <5bea0ebe.1c69fb81.e15d7.98e1@mx.google.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 11:15:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
Message-ID: <CAGb2v65PqwKrRdh2_Y48zYnmJa0=hv3Bd4UdvdWvBBMfT2BfSw@mail.gmail.com>
Subject: Re: [PATCH 01/15] dt-bindings: net: broadcom-bluetooth: Fix external
 clock names
To:     Rob Herring <robh@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 7:37 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 07, 2018 at 06:12:54PM +0800, Chen-Yu Tsai wrote:
> > The Broadcom Bluetooth controllers can take up to two external clocks:
> > an external frequency reference, substituting the main crystal, and a
> > LPO clock at 32.768 kHz substituting the internal LPO clock.
> >
> > In particular, the external LPO clock must be used when the controller
> > does not have NVRAM connected, and the main reference frequency is not
> > the default 20 MHz. This is described in detail in the datasheet.
> >
> > The original "extclk" clock name is ambiguous as to which of these it
> > refers to, and some designs might even require both.
> >
> > This patch deprecates the existing name, and adds "txco" and "lpo".
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > index 4194ff7e6ee6..2535e54219af 100644
> > --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > @@ -18,7 +18,10 @@ Optional properties:
> >   - shutdown-gpios: GPIO specifier, used to enable the BT module
> >   - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
> >   - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor
> > - - clocks: clock specifier if external clock provided to the controller
> > + - clocks and clock-names: clock specifier if external clocks are provided
> > +   - "txco": external reference clock
> > +   - "extclk": deprecated, replaced by "txco"
> > +   - "lpo": external low power 32.768 kHz clock
> >   - clock-names: should be "extclk"
>
> This line should change?

Yes. Missed that.

>
> 'clocks' needs to describe how many clocks and the order of them.
>
> 'clock-names' needs to list the names. Keep them separate.

I was under the impression that when clock-names was used, the
order of clocks shouldn't matter.

Also, both clocks are optional. The controller can use a standalone
crystal instead of an external TXCO, which would not get described in
the device tree, and/or not use an LPO clock. How would one describe
a device that has an LPO clock input but not a TXCO clock input?

Last, IMHO listing them with name + description, one item per line
is more readable then having the items on one line, then having the
next line list all their respective names. If ordering and number of
items is important, I could add the requirements to the description
of "clocks and clock-names"?

Thanks
ChenYu
