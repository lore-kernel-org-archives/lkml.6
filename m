Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 08393C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A697D208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A697D208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=diasemi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932762AbeFLFhO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:37:14 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:21878 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932448AbeFLFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:37:12 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id FB/C5-09737-70C5F1B5; Tue, 12 Jun 2018 05:37:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRWlGSWpSXmKPExsUSt3OpsS5bjHy
  0wd2PJhaHF71gtLj56RurxeVdc9gcmD12zrrL7vF5k1wAUxRrZl5SfkUCa8aO1qNMBR18Fc+n
  fWNrYPzI3cXIySEksIxRYv5OVxCbTcBQYt6b94wgtoiAvsT22b+AbC4OZoHtjBKnTt9jAUkIC
  zhLLDv5hhmiyEXi9J55LBC2lcSdfavBmlkEVCWeX3rPBmLzCgRIXF8xgQViWZbE/XMLwGxOAT
  2J+8u/s4LYjAKyEl8aV4PNZBYQl7j1ZD4TiC0hICCxZM95ZghbVOLl43+sELaCxL5fK9kgbHu
  J1/feAc3kALL1JfoaiyHChhKrph1ggbDNJV7vOM0EMV5HYsHuT2wQtrbEsoWvmSHOFJQ4OfMJ
  ywRG8VlIrpiFpGUWkpZZSFoWMLKsYjRPKspMzyjJTczM0TU0MNA1NDTSNbQ00jUx0kus0k3US
  y3VLU8tLtE11EssL9YrrsxNzknRy0st2cQIjEsGINjBuPVC8iFGSQ4mJVHeNAn5aCG+pPyUyo
  zE4oz4otKc1OJDjDIcHEoSvFuigHKCRanpqRVpmTnABAGTluDgURLhLQFJ8xYXJOYWZ6ZDpE4
  xKkqJ864ASQiAJDJK8+DaYEnpEqOslDAvI9AhQjwFqUW5mSWo8q8YxTkYlYR5p4BM4cnMK4Gb
  /gpoMRPQYrMtMiCLSxIRUlINjFHvXwRvPXntxReJ2XvspFhN2A38m19Kmd55a2X/4uTia42Zk
  5Li29NyL8+3OGg1w/hZ0sKdX3KqTkic9IqKZ7IVbbBk/q3Btm0OF3Pkne+a4fVRhawiN3/+5T
  h//reW69zjjNcVTkau+Fah3c+759MZNbGNKpUJl1NXnJF9e0osWfNIysRkNSWW4oxEQy3mouJ
  EAGzPzlZFAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-268.messagelabs.com!1528781830!1689286!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22303 invoked from network); 12 Jun 2018 05:37:10 -0000
Received: from mailrelay2.diasemi.com (HELO sw-ex-cashub01.diasemi.com) (94.185.165.51)
  by server-20.tower-268.messagelabs.com with AES128-SHA encrypted SMTP; 12 Jun 2018 05:37:10 -0000
Received: from SW-EX-MBX02.diasemi.com ([169.254.4.155]) by
 sw-ex-cashub01.diasemi.com ([10.20.16.141]) with mapi id 14.03.0382.000; Tue,
 12 Jun 2018 06:37:09 +0100
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] Input: add error handling for da9052_reg_write
Thread-Topic: [PATCH] Input: add error handling for da9052_reg_write
Thread-Index: AQHUAURsBP9EaXR9t0yaKNf9vqeVLaRbQG2AgADaMMA=
Date:   Tue, 12 Jun 2018 05:37:08 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB701941AFADA@SW-EX-MBX02.diasemi.com>
References: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
 <20180611173017.GD251078@dtor-ws>
In-Reply-To: <20180611173017.GD251078@dtor-ws>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.27.121]
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-serverinfo: sw-ex-cashub01.diasemi.com, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 12/06/2018 03:12:00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 June 2018 18:30 wrote Dmitry Torokhov 

> Subject: Re: [PATCH] Input: add error handling for da9052_reg_write
> 
> Hi Zhouyang,
> 
> On Mon, Jun 11, 2018 at 01:23:39PM +0800, Zhouyang Jia wrote:
> > When da9052_reg_write fails, the lack of error-handling code may
> > cause unexpected results.
> >
> > This patch adds error-handling code after calling da9052_reg_write.
> >
> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> > ---
> >  drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/touchscreen/da9052_tsi.c
> b/drivers/input/touchscreen/da9052_tsi.c
> > index b5dfd594..60c82a0 100644
> > --- a/drivers/input/touchscreen/da9052_tsi.c
> > +++ b/drivers/input/touchscreen/da9052_tsi.c
> > @@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
> >  static int  da9052_ts_remove(struct platform_device *pdev)
> >  {
> >  	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
> > +	int error;
> >
> > -	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> > +	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
> > +	if (error < 0)
> > +		return error;
> 
> No, this does not help anything. The remove() action must not fail
> (really, having it return an int and not void was an API mistake made
> long time ago), and thus returning early in and event of error failing
> to communicate with the device is a mistake. You really want to release
> the interrupts and memory and unregister input device before returning.
> 
> >
> >  	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
> >  	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
> > --
> > 2.7.4
> >

script?
https://patchwork.kernel.org/project/LKML/list/?submitter=181001

