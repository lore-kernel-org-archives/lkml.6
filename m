Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ED0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AD12087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfAGKOD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:14:03 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.209]:25833 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbfAGKOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:14:03 -0500
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-west-2.aws.symcld.net id 3E/86-20272-866233C5; Mon, 07 Jan 2019 10:14:00 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRWlGSWpSXmKPExsXi5LtOQDdDzTj
  GYOM+XYvDi14wWnz9dpvd4uanb6wWl3fNYXNg8dg56y67x69ta1g8Pm+SC2COYs3MS8qvSGDN
  ePPiN2vBVp6KOY3f2BsYW7i6GLk4hARWMUrM6frDCuGsZpT4eeUwI4Szh1Hi+slVLF2MnBxsA
  voS3/4cZAKxRYDs7bN/gRUxC6xklFgybRJYQljAUeL07RuMEEVOEueapjHB2L+3f2QDsVkEVC
  SWtH5mBbF5BQwl5h3+wwSxbS2jxM25v4GaOTg4Bcwk1ra4gNQwCohJfD+1BmwOs4C4xK0n88F
  sCQEBiSV7zjND2KISLx//A5spCjS/5eAeFoi4gsTng/PYIHp1JBbs/gRlm0vMmHKIFcLWlli2
  8DUzxD2CEidnPmEBOUFIQFmi4QrvBEaJWUg2z0IyaRaSSbOQTJqFZNICRtZVjOZJRZnpGSW5i
  Zk5uoYGBrqGhka6hsbmuiYmeolVusl6pcW65anFJbpGeonlxXrFlbnJOSl6eaklmxiBEZ5S0K
  mzg3HeivRDjJIcTEqivHZHjGKE+JLyUyozEosz4otKc1KLDzHKcHAoSfC+VDGOERIsSk1PrUj
  LzAGmGpi0BAePkgivlCpQmre4IDG3ODMdInWK0ZLjzaKOGcwcp948n8nMcbzz6xxmIZa8/LxU
  KXFeQZAGAZCGjNI8uHGwdHiJUVZKmJeRgYFBiKcgtSg3swRV/hWjOAejkjCvBsgUnsy8Eritr
  4AOYgI66CWPAchBJYkIKakGRsPP2ndengi96Tr9YrpYiH39b8Yr/qHcO1OnhtxpuGJgXlrQXl
  j0aGuc7+7Jk6dlmkTVd7y3O67sYthQLBBfIHDrIKvlR54z9o5PNpV58Loosx4Ju786KEFVdob
  U52LrnTd0byXOL6qIburO1VuQKXvC5L75ym0Mcxe8nuf3gIUnJ3mx6TI3JZbijERDLeai4kQA
  GCOES4IDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-28.tower-365.messagelabs.com!1546856038!1204892!3
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21687 invoked from network); 7 Jan 2019 10:14:00 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-28.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Jan 2019 10:14:00 -0000
Received: from MTK-SMS-XCH05.digi.com (10.10.8.199) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 04:13:59 -0600
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH05.digi.com
 (10.10.8.199) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 04:13:58 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Mon, 7 Jan 2019 11:13:57 +0100
From:   "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "hadess@hadess.net" <hadess@hadess.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Topic: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Index: AQHUpEatvIDOh1cYWEudJPd429h/UaWfM/8AgAIFKYCAAlDrgA==
Date:   Mon, 7 Jan 2019 10:13:56 +0000
Message-ID: <20190107101355.GA3117@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
In-Reply-To: <20190105225147.le5fgpnvq7sctxe5@penguin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2644DA3EE3E44B41AB3E287569C08B39@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for your quick reply.

>
>I do not have a datasheet for the device, so I am not sure if reset line
>is actually needed to put the device into sleep mode. As far as I can
>see from the code we suspend it by pulsing INT line and then sending a
>command to the controller, and resuming by pulsing the INT line again.
>So it sounds to me INT only designs _could_ place device in sleep mode.
>

The way I read the gt911 dataheet I also understand that only the INT line is
required to enter sleep mode but I don't other for the other supported 
controllers.  My comment is based on both the suspend() and resume() functions 
returning in the absence of either gpiod_int or gpiod_rst and not progressing 
to the sleep sequence.

>As far as the patch goes, if you do not need to execute reset or put
>device into low power mode, you do not need to specify any of the GPIOs
>as GPIO resources. Simply specify the INT GPIO as your interrupt source
>(GpioInt() in ACPI world or "interrupts = <&gpio NNN
>IRQF_TRIGGER_WHATEVER>" in DT world and be done with it.
>

That was my first impression too. However this does not work for my device. My
hypothesis is that the touch controller I2C address setting sequence is not 
happening as it should, so I need at least the control of the INT line in 
order to fix the I2C address.

I am unsure though whether this is a problem specific to the design I am 
testing with or all designs will have problems setting the I2C address without 
controlling the INT GPIO line.

Regards,
Alex


>Thanks.
>
>--
>Dmitry
