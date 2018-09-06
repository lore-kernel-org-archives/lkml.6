Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB18C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4093206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4093206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeIFSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:21:38 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46271 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIFSVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:21:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id j7-v6so7301100qkd.13;
        Thu, 06 Sep 2018 06:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2g0T2EbTMEwCPKkfyKiIgQpN+o/UUbZymtjz0q96Lc=;
        b=D+m79WwaURigaYHOsdQ/T6aiK01nCokXPK/bkD6TBxRP+eplys+HykGMcHJ5M2zsgb
         UPxIulROoFGkQapmoyPZ6JcMeU46ufn2pZCAMC/emVPlKzZZvQ6jHX4hTAMaSyC/W+2W
         p9PkZAFmzKsWvG+Hf6bi+dM0+S+JJYciUXqlAKDcNyh90uHsanLzlUQkEy7o7RA3wqxk
         F2oimBK4wEwrpdnINfDzpc5mP+nLsrsHne8w7da7Dqwzk4ZAXu7FVwcUqLuW8CIV6p7s
         eQZbPQQBC4GHdDnJh8AnB6kA/pS742boKmAL1as6EIpkASicuPD9er2p96IkvGTinGnx
         fCBw==
X-Gm-Message-State: APzg51ChbMX8JEeCVnS5J2JnKvO75PGvIX3KdqN2ReL+Mux9MBzmcmy5
        5zeDPt8/ZNAwqRxI0OSSzCm/vyUXsS5D/7VDJsg=
X-Google-Smtp-Source: ANB0Vdbyjf0HZYZXLKfaQrtL6oInhu+NqdmWjSjYlIoGiPFyBVokOGIpwosv4NocLIr0QXSt9h9T2nqgCl3QngQ2WdI=
X-Received: by 2002:a37:6b03:: with SMTP id g3-v6mr2061403qkc.107.1536241558740;
 Thu, 06 Sep 2018 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <20180719152930.3715-2-boris.brezillon@bootlin.com> <d2f40cc2-b344-69d1-4314-83524ad7b178@synopsys.com>
 <20180824143934.6d6b6487@bbrezillon> <bdb2924f-ecfa-1da3-41db-9ac77d4d933b@synopsys.com>
 <20180824201600.7d80bca9@bbrezillon> <fe839027-c4d7-4d6f-412b-5b315cbc7a39@synopsys.com>
 <20180828140209.29155d00@bbrezillon> <4DBE768F-3CDC-41BE-9CC8-E294E7277CB1@cadence.com>
 <8abfb007-d755-36a4-5960-fddd61d04aa2@synopsys.com> <3D2681D9-1ACC-42FF-9FAB-D86B3C689003@cadence.com>
 <9584757a-e7e2-5bfe-fc2c-e9bc14ad65a8@synopsys.com> <25862F03-9823-42B0-87AC-AE36D7E9C780@cadence.com>
 <CAK8P3a3pkddD9VnogYryQKoL9Z_5qVRBXd6yr1z6CqGU692rXg@mail.gmail.com>
 <20180906151437.4259d6fc@bbrezillon> <20180906152055.5618d235@bbrezillon>
In-Reply-To: <20180906152055.5618d235@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 6 Sep 2018 15:45:41 +0200
Message-ID: <CAK8P3a1dgw5_54rdE6Emsii93VuT8msA4z79C-iCCxCZihuFJw@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Przemyslaw Gaj <pgaj@cadence.com>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 3:21 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Thu, 6 Sep 2018 15:14:37 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> > When a master is not in control of the bus, it gets informed of devices
> > present on the bus by monitoring DAA or DEFSLVS broadcast events. That
> > means the secondary master should populate the bus with I3C/I2C devices
> > on such events, but that's not enough, because DEFSLVS/DAA do not
> > provide all device info. Some of them (like read/write/ibi limitations)
> > require extra CCC commands, and, to send those CCC commands, the
> > secondary master must claim the bus. We could add a case where we
> > declare devices as partially discovered until the master acquires
> > ownership of the bus, but that means part of the data returned by
> > i3c_device_get_info() will be inaccurate, which might have an impact on
> > some i3c driver ->probe() functions.
>
> Hm, one possible solution would be to register partially discovered
> devices to the device model and let i3c_device_get_info() claim the bus
> and request missing data when needed. This way, if the driver needs to
> call i3c_device_get_info() in its probe path, it should work just fine.

I guess you could also call i3c_device_get_info() in the common i3c_probe()
function before calling into the driver.

However, either way, we may still have a problem here: if the current master
decides not to hand over master access to us at all, the probe() function
will be blocked indefinitely, and that may stop us from probing other devices
later on, or hang the module loader (depending on what context that
probe() is called from).

Using a timeout here could avoid the hang, but leads to other potential
issues, e.g. how to decide whether to retry the probe later.

       Arnd
