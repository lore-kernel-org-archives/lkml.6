Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAEDC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91F9206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91F9206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeI2Aki convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:40:38 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:32548 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbeI2Akh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:40:37 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 46/00-28090-8CF6EAB5; Fri, 28 Sep 2018 18:15:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRWlGSWpSXmKPExsUSt3Opse6J/HX
  RBtMXMlo0L17PZtG1eieLxeVdc9gsFi1rZbZ4svAMkwOrx7yTgR77565h99j5vYHd4/MmuQCW
  KNbMvKT8igTWjG2nzrMWdIpXTH93nLmBsV24i5GLQ0hgKaPE4tPHWboYOTnYBCwkJp94wAZii
  whESyzvPMgCUsQsMJ1J4sfFr4wgCWGBMIkvc74yQRSFS6yd8R+qwUpi3pTprCA2i4CqxNVVW8
  BqeAUCJA5fPgPWKySQLnFq1yOwZZwCRhJTmr8wg9iMArISXxpXg9nMAuISt57MB+uVEBCQWLL
  nPDOELSrx8vE/VghbQeLC/s0sELa9xOt774BsDiBbX6KvsRgibCixatoBqBJziVl9Z1kgxutI
  LNj9iQ3C1pZYtvA1M8SZghInZz5hmcAoPgvJFbOQtMxC0jILScsCRpZVjJZJRZnpGSW5iZk5u
  oYGBrqGhsa6xrpGxsZ6iVW6iXqppbrJqXklRYlAWb3E8mK94src5JwUvbzUkk2MwBhOKWR+uY
  Pxe3P6IUZJDiYlUd7LKuuihfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwLskDygkWpaanVqRl5gC
  TCUxagoNHSYR3Yi5Qmre4IDG3ODMdInWKUZej7en1GcxCLHn5ealS4rwzQGYIgBRllObBjYAl
  tkuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHk3gkzhycwrgdv0CugIJqAjRA6sATmiJBEhJ
  dXAmBViodURyuJaUqa5zf9G2tOtRsxnqlV/a+32eHMpY76+vffxiKUn5YQio+VvBO3YzToz44
  +amHWzXh1n4LNPxeVxm3eenNp8h7cwaHv+nblT3xTyJT3bOGVO8gI7z6ii62rLswVqvjFLFrT
  OnvZq28IFVTGML3f+7+/acD38wvm/Hz4VP/t5VYmlOCPRUIu5qDgRAFMmMK5nAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-20.tower-229.messagelabs.com!1538158535!469656!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31308 invoked from network); 28 Sep 2018 18:15:35 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-20.tower-229.messagelabs.com with AES128-SHA encrypted SMTP; 28 Sep 2018 18:15:35 -0000
Received: from SW-EX-MBX01.diasemi.com ([169.254.3.12]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Fri,
 28 Sep 2018 19:15:35 +0100
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] usb: typec: tcpm: Report back negotiated PPS voltage
 and current
Thread-Topic: [PATCH] usb: typec: tcpm: Report back negotiated PPS voltage
 and current
Thread-Index: AQHUV0CnAAiPl/txM0a5mHiYqzeMK6UFyoKAgAAx93A=
Date:   Fri, 28 Sep 2018 18:15:34 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337019831A3F9@SW-EX-MBX01.diasemi.com>
References: <20180928153349.DC14D3FAF0@swsrvapps-01.diasemi.com>
 <20180928160409.GA10409@roeck-us.net>
In-Reply-To: <20180928160409.GA10409@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.35.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 28/09/2018 16:15:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 September 2018 17:04, Guenter Roeck wrote:

> On Fri, Sep 28, 2018 at 04:33:49PM +0100, Adam Thomson wrote:
> > Currently when requesting a specific voltage or current through
> > the psy interface, for PPS, when reading back from that interface
> > the values will always be the same as previously given, if the
> > request was successful. However PPS only allows for 20mV voltage
> > steps and 50mA current steps, and the psy class expects microvolt
> > and micro amp requests, so inbetween values can be provided through
> > this interface. Really when reading back the true values negotiated
> > should be given, and not the ones originally asked for.
> >
> > To report the actual values negotiated with the Source, the values
> > stored are now rounded down to the relevant step units prior to
> > building the PPS request, so that those values are later correctly
> > reported through the psy interface. In addition this improves the
> > adjustments made to meet the operating power requirements of the
> > platform, which previously could have been slightly out due to not
> > using valid PPS units of voltage and current.
> >
> > Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > ---
> > Changes are based on usb-testing (ae8a2ca8a221)
> >
> >  drivers/usb/typec/tcpm/tcpm.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 4f1f421..33b3981 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2433,6 +2433,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port
> *port, u32 *rdo)
> >
> >  	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
> >
> > +	/* Round down output voltage and current to align with PPS valid steps */
> > +	out_mv = out_mv - (out_mv % RDO_PROG_VOLT_MV_STEP);
> > +	op_ma = op_ma - (op_ma % RDO_PROG_CURR_MA_STEP);
> > +
> 
> The original intent was to have out_mv (ie out_volt) set to valid values.
> Some remnants of that are still in the code.
> 
> 	out_mv += RDO_PROG_VOLT_MV_STEP - (out_mv %
> RDO_PROG_VOLT_MV_STEP);
> 
> 	port->pps_data.out_volt =
> 		min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> 
> Somehow that got lost over time. Personally I think it would be better to set
> port->pps_data.out_vol and port->pps_data.op_curr to valid step sizes instead
> of post-adjusting the values when used.

Actually, that's a fair point. Those are used beforehand in
'tcpm_pd_select_pps_apdo()' so should be updated prior to that being called,
although in reality this wouldn't change the behaviour of the code.

I'll move the adjustment to valid step sizes (out_volt and op_curr) to the
respective functions tcpm_pps_set_out_volt() and tcpm_pps_set_op_curr().

Thanks
Adam

> 
> Thanks,
> Guenter
> 
> >  	op_mw = (op_ma * out_mv) / 1000;
> >  	if (op_mw < port->operating_snk_mw) {
> >  		/*
> > --
> > 1.9.1
> >
