Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F0CC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE442089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE442089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJBQ0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:26:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33562 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbeJBQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:26:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 564BCAD25;
        Tue,  2 Oct 2018 09:43:48 +0000 (UTC)
Date:   Tue, 2 Oct 2018 11:43:46 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Message-ID: <20181002114346.4bcf7927@endymion>
In-Reply-To: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
References: <20180226102000.1b76640e@endymion>
        <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 14:40:42 +0100, Bartosz Golaszewski wrote:
> 2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> > The EEPROMs which hold the SPD data on DDR4 memory modules are no
> > longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> > which use only 1 I2C address for data access. You need to switch
> > between the lower page and the upper page of data by sending commands
> > on the SMBus.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> >  drivers/misc/eeprom/Kconfig  |   11 +
> >  drivers/misc/eeprom/Makefile |    1
> >  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 293 insertions(+)
> 
> is there any reason not to use regmap as is done currently in at24? It
> would spare you a lot of code.

As it turns out, I don't have the time to look into this. The driver is
not exactly big, it is functional, and I would hate if someone else
would duplicate the work just because my driver is not upstream.

So, Greg, can we just get the driver in the kernel tree as is, and if
anyone really cares about it using regmap, that person will convert the
driver later?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
