Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB1E21545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 02:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CZK2HpLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB1E21545
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbeIUIkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 04:40:02 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:41922 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 04:40:02 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5A2F324E0FA5;
        Thu, 20 Sep 2018 19:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537498401; bh=OGAzTmMKgoVnylZlcft7rsJ5sll0nTTeV1dBvrmYpCQ=;
        h=From:To:CC:Subject:Date:References:From;
        b=CZK2HpLadinYg2CP0Ljjy0Bm9A8/feh7rTR8w1M5oVEtNm3mSxFHEJ+jxDNS8/ydZ
         DaiKWxcyZSK8O/oHoQZuolxb3FJp0TWOzEBnr42RiHOy67sUL0y1BrNaK5o/W3DNp2
         Nufwgn/PIWmx8d2WV6OzcUItIbX4Z7ZytuLkox3/lEkC1CIaBDMNpp0oy2dTg675PK
         Q6xncAbwhilkYO6yjec71M6wmuBLc9pFr0gVsOvg++Y3TuFhYQW+LzzLLGZDLP7pXY
         /bYiewTg9GHVwF1DQAPUBWWEAOZuFAT/OtztDWUKaa12fkiR74kD5rXJclPuaaOizX
         daxJ4fg1BzM5g==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3641F32A7;
        Thu, 20 Sep 2018 19:53:21 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 20 Sep 2018 19:53:21 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri, 21
 Sep 2018 08:23:18 +0530
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "apandey@xilinx.com" <apandey@xilinx.com>
Subject: Re: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Index: AQHUTQCuzSz+NUz9VEOohRr9Kn9YIg==
Date:   Fri, 21 Sep 2018 02:53:18 +0000
Message-ID: <6DE59E7D7B09224BB10C87AEADB5972690B8E3@IN01WEMBXB.internal.synopsys.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.236]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anurag,=0A=
On 9/15/2018 8:00 PM, Anurag Kumar Vulisha wrote:=0A=
> These patch series fixes the broken BULK streaming support in=0A=
> dwc3 gadget driver.=0A=
>=0A=
> Changes in v5:=0A=
> 	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"=0A=
>=0A=
> Changes in v4:=0A=
> 	1. Corrected the commit messgae and stream timeout description=0A=
> 	   as suggested by "Thinh Nguyen"=0A=
>=0A=
> Changes in v3:=0A=
> 	1. Added the changes suggested by "Thinh Nguyen"=0A=
>=0A=
> Changes in v2:=0A=
> 	1. Added "usb: dwc3:" in subject heading=0A=
>=0A=
> Anurag Kumar Vulisha (8):=0A=
>   usb: dwc3: Correct the logic for checking TRB full in=0A=
>     __dwc3_prepare_one_trb()=0A=
>   usb: dwc3: update stream id in depcmd=0A=
>   usb: dwc3: make controller clear transfer resources after complete=0A=
>   usb: dwc3: implement stream transfer timeout=0A=
>   usb: dwc3: don't issue no-op trb for stream capable endpoints=0A=
>   usb: dwc3: check for requests in started list for stream capable=0A=
>     endpoints=0A=
>   usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl=0A=
>     fields=0A=
>   usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints=0A=
>=0A=
>  drivers/usb/dwc3/core.h   |  7 ++++=0A=
>  drivers/usb/dwc3/gadget.c | 85 +++++++++++++++++++++++++++++++++++++++++=
+-----=0A=
>  2 files changed, 84 insertions(+), 8 deletions(-)=0A=
>=0A=
Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>=0A=
=0A=
I have tested this patch series except the stream transfer timeout patch on=
 HAPS-DX platform. I am not aware of exact scenarios where I can test the t=
imeout patch, and don't have test to perform timeout testing.=0A=
=0A=
Thanks & Regards,=0A=
 Tejas Joglekar=0A=
