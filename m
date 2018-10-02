Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D885AC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A202C20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202C20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJCFNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:13:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJCFNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:13:04 -0400
Received: from localhost (unknown [64.124.202.226])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3DC32BA3;
        Tue,  2 Oct 2018 22:27:28 +0000 (UTC)
Date:   Tue, 2 Oct 2018 15:27:27 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Message-ID: <20181002222727.GB19204@kroah.com>
References: <20180226102000.1b76640e@endymion>
 <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
 <20181002114346.4bcf7927@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002114346.4bcf7927@endymion>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:43:46AM +0200, Jean Delvare wrote:
> On Mon, 26 Feb 2018 14:40:42 +0100, Bartosz Golaszewski wrote:
> > 2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> > > The EEPROMs which hold the SPD data on DDR4 memory modules are no
> > > longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> > > which use only 1 I2C address for data access. You need to switch
> > > between the lower page and the upper page of data by sending commands
> > > on the SMBus.
> > >
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > ---
> > >  drivers/misc/eeprom/Kconfig  |   11 +
> > >  drivers/misc/eeprom/Makefile |    1
> > >  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 293 insertions(+)
> > 
> > is there any reason not to use regmap as is done currently in at24? It
> > would spare you a lot of code.
> 
> As it turns out, I don't have the time to look into this. The driver is
> not exactly big, it is functional, and I would hate if someone else
> would duplicate the work just because my driver is not upstream.
> 
> So, Greg, can we just get the driver in the kernel tree as is, and if
> anyone really cares about it using regmap, that person will convert the
> driver later?

Fine with me, but someone needs to resend it as it is no longer in my
patch queue at all...

thanks,

greg k-h
