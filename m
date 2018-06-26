Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5EEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB72265F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB72265F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeFZH0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:26:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:13815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752007AbeFZH0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:26:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 00:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="51942343"
Received: from cblaim-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.34.55])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2018 00:26:32 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id BA59221E18; Tue, 26 Jun 2018 10:26:25 +0300 (EEST)
Date:   Tue, 26 Jun 2018 10:26:25 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Chiang, AlanX" <alanx.chiang@intel.com>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Yeh, Andy" <andy.yeh@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Message-ID: <20180626072625.jspoadjqf37pet34@kekkonen.localdomain>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
 <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
 <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:11:54AM +0000, Chiang, AlanX wrote:
> Hi Sakari,
> 
> > -----Original Message-----
> > From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> > Sent: Tuesday, June 26, 2018 2:48 PM
> > To: Chiang, AlanX <alanx.chiang@intel.com>
> > Cc: linux-i2c@vger.kernel.org; Yeh, Andy <andy.yeh@intel.com>;
> > Shevchenko, Andriy <andriy.shevchenko@intel.com>; Mani, Rajmohan
> > <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com; brgl@bgdev.pl;
> > robh+dt@kernel.org; mark.rutland@arm.com; arnd@arndb.de;
> > gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
> > property
> > 
> > Hi Alan,
> > 
> > On Tue, Jun 26, 2018 at 02:22:08PM +0800, alanx.chiang@intel.com wrote:
> > > From: "alanx.chiang" <alanx.chiang@intel.com>
> > >
> > > Provide a flexible way to determine the addressing bits of eeprom.
> > > Pass the addressing bits to driver through address-width property.
> > >
> > > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> > >
> > > ---
> > > since v1
> > > -- Add a warn message for 8-bit addressing.
> > >
> > > ---
> > >  drivers/misc/eeprom/at24.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > > index 0c125f2..231afcd 100644
> > > --- a/drivers/misc/eeprom/at24.c
> > > +++ b/drivers/misc/eeprom/at24.c
> > > @@ -478,6 +478,22 @@ static void at24_properties_to_pdata(struct device
> > *dev,
> > >  	if (device_property_present(dev, "no-read-rollover"))
> > >  		chip->flags |= AT24_FLAG_NO_RDROL;
> > >
> > > +	err = device_property_read_u32(dev, "address-width", &val);
> > > +	if (!err) {
> > > +		switch (val) {
> > > +		case 8:
> > > +			chip->flags &= ~AT24_FLAG_ADDR16;
> > > +			dev_warn(dev, "address-width is 8, clear the ADD16
> > bit\n");
> > 
> > Even though the default is 8 address bits, I don't see a need to issue a
> > warning if the address-width property sets that to 8 explicitly. I.e. only warn
> > if the flag was set.
> > 
> 
> Do you mean I have to add a statement for checking if the bit has been set before?
> For example:
> 
> If (chip->flags & AT24_FLAG_ADDR16)
> 	dev_warn(dev, "address-width is 8, clear the ADD16 bit\n");
> 
> If it is, I would like to modify it as below:
> 
> case 8:
> 	If (chip->flags & AT24_FLAG_ADDR16) {
> 		chip->flags &= ~AT24_FLAG_ADDR16;
> 		dev_warn(dev, "address-width is 8, clear the ADDR16 bit\n");
> 	}
> 	break;

Seems good to me.

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
