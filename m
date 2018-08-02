Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B4C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1216821571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fVh8X6ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1216821571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeHBXOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:14:48 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56097 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbeHBXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:14:47 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F31248365F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 09:21:49 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1533244909;
        bh=es7m7hBeR9zM8VkPM59bv4CYycDKenPnKx1IUESFQls=;
        h=From:To:CC:Subject:Date:References;
        b=fVh8X6haq4fVu85nMVSBKlBY141jAHxHn6SzNnAqRDvc8BJ6DTcQl9C3GsuHaDlfe
         uHhwIsPCxesm/HhK4Ur+riNiZopV8o5iRYyJqhXa+LfohixkTwOR1WL/FfB6y8d3dN
         uCvbmNwsSJd6TGY9CTelxxnqJ8s8gg3JUh7Z7ZUE=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b6375ec0001>; Fri, 03 Aug 2018 09:21:48 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Fri, 3 Aug 2018 09:21:49 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Fri, 3 Aug 2018 09:21:49 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Will Deacon <will.deacon@arm.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
Thread-Topic: [PATCH] arm_pmu: fix compiler warning in arm_pmu_device_probe
Thread-Index: AQHUKeD6fBh8YsNiHkuvjaW9n/Y1IA==
Date:   Thu, 2 Aug 2018 21:21:49 +0000
Message-ID: <31509165164e4e32af172a1857a2ab90@svr-chch-ex1.atlnz.lc>
References: <20180801214526.24599-1-chris.packham@alliedtelesis.co.nz>
 <20180802105705.GB14312@arm.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/18 23:05, Will Deacon wrote:=0A=
> On Thu, Aug 02, 2018 at 09:45:26AM +1200, Chris Packham wrote:=0A=
>> GCC warns=0A=
>>=0A=
>>    arm_pmu_platform.c:234:5: error: 'err' may be used uninitialized in t=
his function [-Werror=3Dmaybe-uninitialized]=0A=
>>=0A=
>> This is because we rely on the for_each_cpu loop in armpmu_request_irqs=
=0A=
>> to initialise err. The warning is a little bogus because we know if=0A=
>> there were 0 CPUs this code would not be running.=0A=
>>=0A=
>> Initialise err to 0 to avoid the warning.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>> This has been reported before in https://lkml.org/lkml/2018/3/5/508 I'm =
not=0A=
>> sure if it was dismmissed as "meh, gcc is wrong" or if it was just waint=
ing for=0A=
>> someone with some round tuits.=0A=
> =0A=
> Which version of GCC are you using? I don't see this warning locally.=0A=
> =0A=
=0A=
My local cross-compiler is=0A=
=0A=
$ arm-softfloat-linux-gnueabi-gcc --version=0A=
arm-softfloat-linux-gnueabi-gcc (crosstool-NG crosstool-ng-1.22.0) 4.9.3=0A=
=0A=
Old-ish but as far as I was aware still supported for building the kernel.=
=0A=
=0A=
I've just tried 7.3.0 and 8.1.0 neither of which complain.=0A=
=0A=
A quick look at the report linked to above seems they probably were =0A=
using 4.6.3 and it still appears in current build reports=0A=
=0A=
http://kisskb.ellerman.id.au/kisskb/buildresult/13455291/=0A=
=0A=
=0A=
=0A=
=0A=
