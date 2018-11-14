Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06908C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C704222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbeKNT2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:28:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32895 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbeKNT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:28:36 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gMrQw-0007ik-3B; Wed, 14 Nov 2018 10:26:02 +0100
Message-ID: <1542187561.4095.1.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Add reset_control_get_count()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>, uli@fpond.eu
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 14 Nov 2018 10:26:01 +0100
In-Reply-To: <CAMuHMdV=1GL43ogU3PO6u8x6f2gX-vdgBVON2+t+1QUJtj=Tkg@mail.gmail.com>
References: <20181113124744.7769-1-geert+renesas@glider.be>
         <1090034354.41357.1542177021922@webmail.strato.com>
         <CAMuHMdV=1GL43ogU3PO6u8x6f2gX-vdgBVON2+t+1QUJtj=Tkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 09:58 +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 14, 2018 at 7:30 AM Ulrich Hecht <uli@fpond.eu> wrote:
> > On November 13, 2018 at 1:47 PM Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > Currently the reset core has internal support for counting the number of
> > > resets for a device described in DT.  Generalize this to devices using
> > > lookup resets, and export it for public use.
> > > 
> > > This will be used by generic drivers that need to be sure a device is
> > > controlled by a single, dedicated reset line (e.g. vfio-platform).
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > See https://lore.kernel.org/lkml/1539003437.11512.20.camel@pengutronix.de/
> > > for the rationale to ensure a single, dedicated reset line.
> > > 
> > >  drivers/reset/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/reset.h |  7 +++++++
> > >  2 files changed, 48 insertions(+)
> > > 
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 654e20ff2d5da9d4..c32b755ec373c338 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > +/**
> > > + * of_reset_control_get_count - Count number of resets available with a device
> > 
> > Should be "reset_control_get_count", without of_ prefix.
> 
> Oops, thanks for catching!
> 
> Philipp: Do you want a v2 or incremental, or can you fix it up yourself?

No need, I'll fix it up.

thanks
Philipp
