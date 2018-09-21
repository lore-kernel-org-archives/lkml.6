Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E42ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BE2154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WN/TEFSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4BE2154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbeIUTUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:20:11 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60664 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390023AbeIUTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:20:11 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7B35C24E1FB5;
        Fri, 21 Sep 2018 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537536678; bh=NRJuXr3KAigqvT8IOUPh6/kH9vKqgySiDH1awH3TwF0=;
        h=From:To:CC:Subject:Date:References:From;
        b=WN/TEFSjSl8S+0cdW/tru5+jrQiPztm6oFyS3mIgK0HE2JS/giW7GPGWQq0ljvazB
         3+UiXsq2f4HORJFwQfwuAF6FhFdkLsTY/WM14jOnZLVS88ObbrpIkvfL6fqSLQl0+o
         0bm7LWrU/ewaalFQtJ+wSJCpioY5IRIySV8bsXtwZ3pvGR4v/zyfFWWHanxXcV8Drm
         W7zcQTGpZm4X4ZThrXBioAFWV9VmpGCS4uI7OF01Hu0w1XRlMbIv+r8Yqv6bPYCtdC
         I/hDsG8xrO9grnTKlL5cwwLR5bgyXLu8KZst4YtvcXRaXjQG0Vee8pWXr3qszQ2N8R
         yzRPlHC7Zk9VA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4760156E5;
        Fri, 21 Sep 2018 06:31:18 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 21 Sep 2018 06:31:18 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri, 21
 Sep 2018 19:01:15 +0530
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "apandey@xilinx.com" <apandey@xilinx.com>,
        "joglekartejas@gmail.com" <joglekartejas@gmail.com>
Subject: Re: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Index: AQHUTQCuzSz+NUz9VEOohRr9Kn9YIg==
Date:   Fri, 21 Sep 2018 13:31:14 +0000
Message-ID: <6DE59E7D7B09224BB10C87AEADB5972690BB1B@IN01WEMBXB.internal.synopsys.com>
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
I have tested this patch series except the stream transfer timeout patch on=
 HAPS-DX platform.  I am not aware of exact scenarios to test the timeout p=
atch and don't have a test for the same.=0A=
Thanks,=0A=
Tejas Joglekar=0A=
