Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD5120989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 04:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D1vbTaZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD5120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbeIXK54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 06:57:56 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39840 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIXK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 06:57:55 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 76DFA24E0368;
        Sun, 23 Sep 2018 21:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537765060; bh=GjSoWG9m7Hck/Xvfk0x2NofYEu/ZGkm5TYCwx0vITnY=;
        h=From:To:CC:Subject:Date:References:From;
        b=D1vbTaZv3BfLgbSM7dPBaFVw3SWE0hxyQcT2VTs6Xk7vk5/uV0M7zXQs7vAZzcYtu
         T6+XWCqQJk30kdXtE0dIPUzsflPqN5fITaYWSvB9MCgsyVgI8QHspI7TogjTIM0x1C
         VhThMU6+2GxXI/MospkR52Bp4RPDJzRs4ig2eLEmxXU+E8WeG8y70y1nm2EIsJd6Wm
         NWKikD61RS08YsR5c+Gv/xZX29/FavhRTKZPJVzpLD+PuKqqO7mjmkWIQ8is4CvvZ9
         e1aFUwQfhjR7qMSqXlh6nb+SZwt28XOHBVjC8zZgEDAiLKhIfAxDV5Wp2I0yKJHPPU
         y4r37NoQ6s+mg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5C89A3B26;
        Sun, 23 Sep 2018 21:57:40 -0700 (PDT)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Sun, 23 Sep 2018 21:57:40 -0700
Received: from IN01WEMBXB.internal.synopsys.com ([169.254.4.157]) by
 IN01WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon, 24
 Sep 2018 10:27:37 +0530
From:   Tejas Joglekar <tejas.joglekar@synopsys.com>
To:     Anurag Kumar Vulisha <anuragku@xilinx.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "Ajay Yugalkishore Pandey" <APANDEY@xilinx.com>,
        "joglekartejas@gmail.com" <joglekartejas@gmail.com>
Subject: Re: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Topic: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to
 dwc3 gadget driver
Thread-Index: AQHUTQCuzSz+NUz9VEOohRr9Kn9YIg==
Date:   Mon, 24 Sep 2018 04:57:35 +0000
Message-ID: <6DE59E7D7B09224BB10C87AEADB5972690BC7D@IN01WEMBXB.internal.synopsys.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <6DE59E7D7B09224BB10C87AEADB5972690BB1B@IN01WEMBXB.internal.synopsys.com>
 <BN3PR0201MB099350017190F7148107F51CA7120@BN3PR0201MB0993.namprd02.prod.outlook.com>
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
On 9/21/2018 7:36 PM, Anurag Kumar Vulisha wrote:=0A=
> Hi Tejas,=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: Tejas Joglekar [mailto:Tejas.Joglekar@synopsys.com]=0A=
>> Sent: Friday, September 21, 2018 7:01 PM=0A=
>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; balbi@kernel.org;=0A=
>> gregkh@linuxfoundation.org=0A=
>> Cc: v.anuragkumar@gmail.com; linux-usb@vger.kernel.org; linux-=0A=
>> kernel@vger.kernel.org; Thinh.Nguyen@synopsys.com; Ajay Yugalkishore Pan=
dey=0A=
>> <APANDEY@xilinx.com>; joglekartejas@gmail.com=0A=
>> Subject: Re: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to=
 dwc3=0A=
>> gadget driver=0A=
>>=0A=
>> Hello Anurag,=0A=
>> On 9/15/2018 8:00 PM, Anurag Kumar Vulisha wrote:=0A=
>>> These patch series fixes the broken BULK streaming support in=0A=
>>> dwc3 gadget driver.=0A=
>>>=0A=
>>> Changes in v5:=0A=
>>> 	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"=0A=
>>>=0A=
>>> Changes in v4:=0A=
>>> 	1. Corrected the commit messgae and stream timeout description=0A=
>>> 	   as suggested by "Thinh Nguyen"=0A=
>>>=0A=
>>> Changes in v3:=0A=
>>> 	1. Added the changes suggested by "Thinh Nguyen"=0A=
>>>=0A=
>>> Changes in v2:=0A=
>>> 	1. Added "usb: dwc3:" in subject heading=0A=
>>>=0A=
>>> Anurag Kumar Vulisha (8):=0A=
>>>   usb: dwc3: Correct the logic for checking TRB full in=0A=
>>>     __dwc3_prepare_one_trb()=0A=
>>>   usb: dwc3: update stream id in depcmd=0A=
>>>   usb: dwc3: make controller clear transfer resources after complete=0A=
>>>   usb: dwc3: implement stream transfer timeout=0A=
>>>   usb: dwc3: don't issue no-op trb for stream capable endpoints=0A=
>>>   usb: dwc3: check for requests in started list for stream capable=0A=
>>>     endpoints=0A=
>>>   usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl=
=0A=
>>>     fields=0A=
>>>   usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints=0A=
>>>=0A=
>>>  drivers/usb/dwc3/core.h   |  7 ++++=0A=
>>>  drivers/usb/dwc3/gadget.c | 85=0A=
>> ++++++++++++++++++++++++++++++++++++++++++-----=0A=
>>>  2 files changed, 84 insertions(+), 8 deletions(-)=0A=
>>>=0A=
>> Tested-By: Tejas Joglekar <tejas.joglekar@synopsys.com>=0A=
>> I have tested this patch series except the stream transfer timeout patch=
 on HAPS-DX=0A=
>> platform.  I am not aware of exact scenarios to test the timeout patch a=
nd don't have=0A=
>> a test for the same.=0A=
> Thanks for testing the patches. The issue mentioned in the timeout patch =
(Patch 4) will=0A=
> occur very rarely on the long runs and only when tested with stream capab=
le host. This=0A=
> issue happens only when the host & dwc3 controller go out of sync, where =
the dwc3=0A=
> controller may wait for host to issue prime transaction and host may wait=
 for the gadget=0A=
> to issue ERDY. I used controller version 2.90A  for testing this issue.  =
This issue is mentioned=0A=
> in databook section 9.5.2=0A=
>=0A=
> Thanks,=0A=
> Anurag Kumar Vulisha=0A=
>=0A=
>=0A=
I see, as it is rare so maybe it is not seen here. I have used 3.30A for te=
sting. I will keep watch on this issue during my tests.=0A=
=0A=
---=0A=
Thanks,=0A=
Tejas Joglekar=0A=
