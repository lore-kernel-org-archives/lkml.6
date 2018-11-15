Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0F5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BADF20815
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BADF20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbeKPFQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:16:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:52807 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725741AbeKPFQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:16:43 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8369E20D7C; Thu, 15 Nov 2018 20:07:40 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id D83592084B;
        Thu, 15 Nov 2018 20:07:39 +0100 (CET)
Date:   Thu, 15 Nov 2018 20:07:39 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     vitor <vitor.soares@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        "Alicja Jurasik-Urbaniak" <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Message-ID: <20181115200739.20b22d52@bbrezillon>
In-Reply-To: <08a591ae-c75b-80b4-b608-ca92f6d932f9@synopsys.com>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <76b1d15d-232c-d8ba-5eba-8394e71be725@synopsys.com>
        <20181115135731.25f60990@bbrezillon>
        <CAK8P3a0gmCtMac7ctKZ3r=2Dxo03pYvuXkQ7c4Vnt9yMoLDMSQ@mail.gmail.com>
        <08a591ae-c75b-80b4-b608-ca92f6d932f9@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 15:25:11 +0000
vitor <vitor.soares@synopsys.com> wrote:

> Hi Arnd,
> 
> On 15/11/18 14:25, Arnd Bergmann wrote:
> > I agree about better not exposing the bus as a /dev/i3c* node, and that we
> > probably do need to expose individual devices in some form to allow
> > writing complete user space drivers that can do everything a kernel driver
> > can do.
> >
> > Can you describe what a low-level interface to the device looks like
> > in the kernel? Can this be abstracted as simply pread()/pwrite() plus
> > an interrupt mechanism, or do we need a set of ioctl() operations as
> > well?  
> 
> Like in i2c is likely to need the ioctl() too.

Yep, I think we'll need an ioctl given the various type of transfers
one case use to interact with a device.
