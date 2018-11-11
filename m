Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE68C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C633C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wKXDtqkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C633C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeKLFr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:47:27 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46828 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeKLFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:47:26 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E87D08781F;
        Mon, 12 Nov 2018 08:57:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1541966276;
        bh=0jYLA5iNz/H/c7SmfziOyZwuZhpPdKOprtRDg3PucKo=;
        h=From:To:CC:Subject:Date:References;
        b=wKXDtqkMiU2fYwp5yOxog27YK+g6rXyGzDMq6wjAcLjUL9s7/dGsJ+6kqPC460mof
         7qkZVaLtH8+M/5QdUW/qHqVdkRCKHUu8CwQTnPSOCzbxQ883+BeLxL734Kx4KwLYK3
         YIEYWDe0jBsv8kwYzs503ozDHXa91pH/m+Lsn7P/euRWdxHCIeP1Ydo5gDs9NLSEjO
         s24Lg2Qee2pDvMCkvCHk572nK55NnDWbIumEfmsDoC7xd8TAWg4milslUPKOYNfO8N
         JKwvfmpeRnpl/0bmXfIBJIFXO++HgTzLUI35C2Sa+0t6beGXFjzrs919fIJhkldMCY
         XtZOnlN2a+caw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5be889c40000>; Mon, 12 Nov 2018 08:57:56 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 12 Nov 2018 08:57:51 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 12 Nov 2018 08:57:51 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     Borislav Petkov <bp@alien8.de>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
Thread-Topic: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable
 binding
Thread-Index: AQHUd/ptbysX25RxBUq8eaB1aF9d+w==
Date:   Sun, 11 Nov 2018 19:57:51 +0000
Message-ID: <a07fead828b8452bb37708180dd721d4@svr-chch-ex1.atlnz.lc>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
 <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
 <20181109114818.GB30658@n2100.armlinux.org.uk>
 <CAK8P3a26XmBpG3VzwUgSdd_Xo_S2ezSvA9mjKckRFr9p38j-dg@mail.gmail.com>
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

On 10/11/18 4:58 AM, Arnd Bergmann wrote:=0A=
> On Fri, Nov 9, 2018 at 12:48 PM Russell King - ARM Linux=0A=
> <linux@armlinux.org.uk> wrote:=0A=
>>=0A=
>> On Fri, Nov 09, 2018 at 12:40:06PM +0100, Arnd Bergmann wrote:=0A=
>>> On Fri, Nov 9, 2018 at 8:04 AM Chris Packham=0A=
>>> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>>>=0A=
>>>> Add documentation for the marvell,ecc-enable and marvell,ecc-disable=
=0A=
>>>> properties which can be used to enable/disable ECC on the Marvell auro=
ra=0A=
>>>> cache.=0A=
>>>>=0A=
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>>>> ---=0A=
>>>=0A=
>>> Why do you need both enable and disable? Wouldn't one of them be enough=
 here?=0A=
>>=0A=
>> It isn't an "on when ecc-enable is present, off when not" because the=0A=
>> current behaviour is to preserve these bits in the control register.=0A=
>>=0A=
>> If we were to implement it as "if no ecc-enable property, turn off=0A=
>> ECC" then that would drastically change the behaviour - systems which=0A=
>> were configured for ECC suddenly lose ECC support.=0A=
>>=0A=
>> Since we don't know which have it and which don't, we can't implement=0A=
>> the option like that.=0A=
> =0A=
> What I meant was why we need support force-disabling it. I understand=0A=
> that we need to allow leaving it at the boot-time default as well as=0A=
> force-enabling it.=0A=
=0A=
I added ecc-disable because I was modeling it after =0A=
arm,parity-enable/arm,parity-disable. The only reason I can imagine =0A=
wanting to force disable this would be some mis-behaving SoC which has =0A=
it enabled by default in hardware, to my knowledge no such system exists =
=0A=
(that would use this driver).=0A=
=0A=
I'd be happy to drop the binding an implementation and send a v7 if you =0A=
feel strongly that it marvell,ecc-disable should be removed.=0A=
