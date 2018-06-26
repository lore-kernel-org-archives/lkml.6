Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB2DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D025265BC
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D025265BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeFZHMA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:12:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:40991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751504AbeFZHL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:11:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 00:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="49939685"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2018 00:11:56 -0700
Received: from pgsmsx101.gar.corp.intel.com ([169.254.1.103]) by
 PGSMSX108.gar.corp.intel.com ([169.254.8.114]) with mapi id 14.03.0319.002;
 Tue, 26 Jun 2018 15:11:55 +0800
From:   "Chiang, AlanX" <alanx.chiang@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
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
Subject: RE: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Thread-Topic: [PATCH v2 2/2] eeprom: at24: Add support for address-width
 property
Thread-Index: AQHUDRY+FPUzU/Sao0CCfdLUwrz3mKRxktkAgACJPHA=
Date:   Tue, 26 Jun 2018 07:11:54 +0000
Message-ID: <0772C36F3434E145A062D024A4869A09010AA12F@PGSMSX101.gar.corp.intel.com>
References: <1529994128-26770-1-git-send-email-alanx.chiang@intel.com>
 <1529994128-26770-3-git-send-email-alanx.chiang@intel.com>
 <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
In-Reply-To: <20180626064736.msxcnsi5rsnxp62k@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTg0YWNiYjYtZDQ2MS00YjBhLTg2NzQtMDc3NjE0MmEzMjZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ0I4SFJvMURJNTFoa3o5dDZyb0tlTjIxbmorSFlpQVdnVVF3TDMwV2tCNGpGWEpjY2RiZTc5ekU0M2oraFIxcSJ9
x-ctpclassification: CTP_NT
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> Sent: Tuesday, June 26, 2018 2:48 PM
> To: Chiang, AlanX <alanx.chiang@intel.com>
> Cc: linux-i2c@vger.kernel.org; Yeh, Andy <andy.yeh@intel.com>;
> Shevchenko, Andriy <andriy.shevchenko@intel.com>; Mani, Rajmohan
> <rajmohan.mani@intel.com>; andy.shevchenko@gmail.com; brgl@bgdev.pl;
> robh+dt@kernel.org; mark.rutland@arm.com; arnd@arndb.de;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] eeprom: at24: Add support for address-width
> property
> 
> Hi Alan,
> 
> On Tue, Jun 26, 2018 at 02:22:08PM +0800, alanx.chiang@intel.com wrote:
> > From: "alanx.chiang" <alanx.chiang@intel.com>
> >
> > Provide a flexible way to determine the addressing bits of eeprom.
> > Pass the addressing bits to driver through address-width property.
> >
> > Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
> > Signed-off-by: Andy Yeh <andy.yeh@intel.com>
> >
> > ---
> > since v1
> > -- Add a warn message for 8-bit addressing.
> >
> > ---
> >  drivers/misc/eeprom/at24.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> > index 0c125f2..231afcd 100644
> > --- a/drivers/misc/eeprom/at24.c
> > +++ b/drivers/misc/eeprom/at24.c
> > @@ -478,6 +478,22 @@ static void at24_properties_to_pdata(struct device
> *dev,
> >  	if (device_property_present(dev, "no-read-rollover"))
> >  		chip->flags |= AT24_FLAG_NO_RDROL;
> >
> > +	err = device_property_read_u32(dev, "address-width", &val);
> > +	if (!err) {
> > +		switch (val) {
> > +		case 8:
> > +			chip->flags &= ~AT24_FLAG_ADDR16;
> > +			dev_warn(dev, "address-width is 8, clear the ADD16
> bit\n");
> 
> Even though the default is 8 address bits, I don't see a need to issue a
> warning if the address-width property sets that to 8 explicitly. I.e. only warn
> if the flag was set.
> 

Do you mean I have to add a statement for checking if the bit has been set before?
For example:

If (chip->flags & AT24_FLAG_ADDR16)
	dev_warn(dev, "address-width is 8, clear the ADD16 bit\n");

If it is, I would like to modify it as below:

case 8:
	If (chip->flags & AT24_FLAG_ADDR16) {
		chip->flags &= ~AT24_FLAG_ADDR16;
		dev_warn(dev, "address-width is 8, clear the ADDR16 bit\n");
	}
	break;

> > +			break;
> > +		case 16:
> > +			chip->flags |= AT24_FLAG_ADDR16;
> > +			break;
> > +		default:
> > +			dev_warn(dev, "Bad \"address-width\" property:
> %u\n",
> > +				 val);
> > +		}
> > +	}
> > +
> >  	err = device_property_read_u32(dev, "size", &val);
> >  	if (!err)
> >  		chip->byte_len = val;
> 
> --
> Regards,
> 
> Sakari Ailus
> sakari.ailus@linux.intel.com
