Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA50C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867E421848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfBSHyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:54:14 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36211 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfBSHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:54:14 -0500
Received: by mail-ed1-f46.google.com with SMTP id g9so5367010eds.3;
        Mon, 18 Feb 2019 23:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BHJGuzFre5EqeiGJ9VmPuQJ9pzCKiKw3d/t5MFk0qY=;
        b=p2qQTPZqLJz9Lw+gb1AjieMzRo2JrcNu3PKhQIXTsPNsro0IXmynTdRtPh1RH2ylXr
         2AfDvTn73RYi1v82+nBQc2IdP9NDvC0fgg3b7nHmxR2DgvY/2u+VmbTJJqLfMrsCM74a
         m6F3zla2pNcUXV+bmUlIYFagqoDpOrr7G0XLQP0I7IAuKHzVM4UwO5I87cfKEwwp0kYO
         OuRsPep+vIevDNG1+2BxVbkek9EyjN1QzEZjYyBuBrbZfVZGnP3pxVHhJ1AZcuS6rkqx
         fSuQV9GKjFxT1eiENMN3WDWsMDoXtCvfmht9BoLkInJs0htYLnOodInUPW3eY86Ky8Xt
         qjQQ==
X-Gm-Message-State: AHQUAubevjAYFRaANgJzK2HJOGmDCOAQLrpHUawHjJZjQ3sEyq8QdoLR
        JUx69cSTVN5rDnCb/UsUoj63hKh79f8=
X-Google-Smtp-Source: AHgI3IYdoT/nklmrAasPsKrprOhkayMvdBMQYiipzpdeRn8plD1Cd2dMMlAiPyclP7QuwOGPW9lgAA==
X-Received: by 2002:aa7:cb52:: with SMTP id w18mr11179307edt.257.1550562851822;
        Mon, 18 Feb 2019 23:54:11 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id l15sm1540750edb.79.2019.02.18.23.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 23:54:11 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id c8so21035441wrs.4;
        Mon, 18 Feb 2019 23:54:11 -0800 (PST)
X-Received: by 2002:a5d:498a:: with SMTP id r10mr20209960wrq.188.1550562850798;
 Mon, 18 Feb 2019 23:54:10 -0800 (PST)
MIME-Version: 1.0
References: <20180830154518.29507-1-embed3d@gmail.com> <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com> <20180906115114.inc6dhqhy47obo25@flea>
In-Reply-To: <20180906115114.inc6dhqhy47obo25@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Feb 2019 15:54:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
Message-ID: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
Subject: Allwinner SID THS calibration data cell representation?
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Philipp Rossak <embed3d@gmail.com>,
        Emmanuel Vadot <manu@bidouilliste.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for resurrecting an old discussion, but since someone posted patches
for H5 and H6, I thought we should resolve this. I'm working on patches to
fix / replace the big-endian issue.

On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> > On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > > +                 /* Data cells */
> > > > +                 thermal_calibration: calib@234 {
> > > > +                         reg = <0x234 0x8>;
> > > > +                 };
> > >   You are declaring 8 bytes of calibration data but to my knowledge it's
> > > only 2 bytes per sensor, so 2 bytes for H3.
> > >   Am I missing something ?
> > >
> > >   Thanks,
> >
> > Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
> > H3, but the thermal calibration data field is on all chips 64 bit wide - so
> > 8 bytes. So I'm reading here the complete calibration data field.
>
> Having one cell per channel would make more sense I guess.

Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 in
the THS. As far as the SID is concerned, their is just one consumer for this
data, the thermal sensor. How the thermal sensor uses that data is really not
its concern. And the thermal sensor is really just copying the data from the
e-fuses into its registers. Nothing more.

Furthermore, with the register access interface, the e-fuses are read/write
32 bits at a time. Seems to me it would make more sense to enforce a 32-bit
word size, so cells should be multiples of 32 bits.

Regards
ChenYu
