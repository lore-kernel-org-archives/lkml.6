Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF652087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfAGQmd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:42:33 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.114]:28291 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbfAGQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:42:33 -0500
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-west-2.aws.symcld.net id E5/36-20373-671833C5; Mon, 07 Jan 2019 16:42:30 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRWlGSWpSXmKPExsXi5LtOQLes0Tj
  GoPmhtsXhRS8YLb5+u81ucfPTN1aLy7vmsDmweOycdZfd49e2NSwenzfJBTBHsWbmJeVXJLBm
  rF/tVbCJs2L5laQGxu/sXYxcHEICqxglbp9ZygjhrGaUuLqhiRnC2cMo0XR5F2sXIycHm4C+x
  Lc/B5lAbBEBNYlt7y6xghQxC6xllDi79A8zSEJYwFHi9O0bjBBFThLnmqZBNbhJzL88CSzOIq
  AiMb+1nR3E5hUwlFi97ScbxLZXQHc0rgTbxingIfFr6VawZkYBMYnvp9aA2cwC4hK3nswHsyU
  EBCSW7DnPDGGLSrx8/A+sVxRoQcvBPSwQcQWJzwfnsUH06kgs2P0JyjaXmPtnKtRMbYllC18z
  QxwkKHFy5hOgXg6gg5QlGq7wTmCUmIVk8ywkk2YhmTQLyaRZSCYtYGRdxWiRVJSZnlGSm5iZo
  2toYKBraGika2hsAsTmeolVukl6pcW65anFJbpGeonlxXrFlbnJOSl6eaklmxiBEZ5S0Na5g7
  GzO/0QoyQHk5Io76x84xghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxODUA5waLU9NSKtMwcYKq
  BSUtw8CiJ8GqCpHmLCxJzizPTIVKnGI053izqmMHMcbzz6xxmIZa8/LxUKXHeAyClAiClGaV5
  cINgKfASo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHeFJApPJl5JXD7gNEM9IUI70seA5BTS
  hIRUlINjMbn6qzOtjx8OfvI9eV3bCX5Zbw+rnyk1Rgrw1a0PdLE4PZSi+3Bn69EXN+8z+hRwP
  m+rV+9jV6dOJ2iff1M2wpX/s9rJ87ePuVNrdev5T+0O8RuXZkynVNLffap2cc5DTZOyDtQtyb
  vC9P544VZBe/fb/q1x35/7JbY1Y8Dn0+aa5N0Ztcmhd93lViKMxINtZiLihMBnjhYbXwDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-14.tower-345.messagelabs.com!1546879349!6342488!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22896 invoked from network); 7 Jan 2019 16:42:30 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-14.tower-345.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Jan 2019 16:42:30 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 10:42:29 -0600
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 10:42:29 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Mon, 7 Jan 2019 17:42:27 +0100
From:   "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To:     Bastien Nocera <hadess@hadess.net>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Topic: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Index: AQHUpEatvIDOh1cYWEudJPd429h/UaWfM/8AgAIFKYCAArCrgIAADMuA
Date:   Mon, 7 Jan 2019 16:42:26 +0000
Message-ID: <20190107164225.GA5394@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
In-Reply-To: <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB5ACEDF7CF4C44D90428409950F9667@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bastien,

>Given that we do have access to the datasheet, it would also be useful
>for the patch to mention where in the datasheet it says that the reset
>line can be left pulled-up,

The pin description table on section 4, on the "Reset pin" row, contains a 
remark as follows:

External 10K pull-up resistor required, active-low reset

This comes from a newer revision of the datasheet though:
http://focuslcds.com/content/GT911.pdf

I guess it's open to interpretation whether driving the reset line is 
optional. The code seemed to imply it by using devm_gpiod_get_optional() to 
obtain the GPIO.

>or mention on which shipping device this
>setup is already used (and if so, what the DTS or ACPI snippet that
>declares those is).
>

I am testing with an LCD application kit for the ConnectCore 6UL SBC Pro:

https://www.digi.com/products/models/cc-acc-lcdw-10
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts?h=v5.0-rc1#n120

This display in particular does not have the reset line available on the 
connector. The only way to make it work seems to be to use the INT line to fix 
an I2C address.

>Cheers
>
