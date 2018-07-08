Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A07208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FV8r9NZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A07208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933457AbeGHX5B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:57:01 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36742 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeGHX5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:57:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2972C8365A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jul 2018 11:56:58 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1531094218;
        bh=Wxa5McDD4EEHh/CnrLbp1tEoiIWBqvu2Fatac8kB7mU=;
        h=From:To:CC:Subject:Date:References;
        b=FV8r9NZDHp6Z+TJZyIUVlwHAJhCzo7XiL1buiFIHpIMHjgveIGTGGT88nnU/ZQUWc
         oxyC9tOWvM1v03mFcm+Y8dtrXX15rCpT6EjwblEB5inl4nX7o9X7RMCvVdIhAZFhLY
         EZymukDDGV0+31x9Hb8xmZhoNS2ZefmumU9Bjyqc=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b42a4c80000>; Mon, 09 Jul 2018 11:56:56 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 9 Jul 2018 11:56:53 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 9 Jul 2018 11:56:53 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Topic: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Index: AQHUDAz7Ft0gL2AzJEuev8VL5BoQ1g==
Date:   Sun, 8 Jul 2018 23:56:52 +0000
Message-ID: <da6f03d541e24e008f84f6f18fc8e77a@svr-chch-ex1.atlnz.lc>
References: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
 <20180706212720.0e9dacb8@bbrezillon> <20180706233701.05da0666@bbrezillon>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,=0A=
=0A=
On 07/07/18 09:37, Boris Brezillon wrote:=0A=
> On Fri, 6 Jul 2018 21:27:20 +0200=0A=
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:=0A=
> =0A=
>> On Mon, 25 Jun 2018 10:44:42 +1200=0A=
>> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>>> Hi,=0A=
>>>=0A=
>>> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chi=
p=0A=
>>=0A=
>> Hm, it's even worse than I thought. The model name does not include the=
=0A=
>> -ITE suffix (E means ECC can't be disabled), which means we have no way=
=0A=
>> to detect the version with forced on-die ECC.=0A=
>>=0A=
>> I see 2 solutions to this problem:=0A=
>> 1/ Bean provides us a solution to reliably detect when ECC can be=0A=
>>     de-actived and when it can't=0A=
>> 2/ We only ever expose 64 bytes of OOB to the user and consider that=0A=
>>     ECC can be disabled, even if it can't in reality=0A=
>>=0A=
> =0A=
> After reading the doc again, I forgot one thing you can try before=0A=
> deciding to go for option #2.=0A=
> =0A=
> 8th bit in byte 5 of READID's result encodes whether the on-die ECC=0A=
> state (enabled or not). I remember we had a discussion with Bean where=0A=
> he told us this was a runtime status reflecting the on-die ECC state,=0A=
> which is crazy, since READID might return different values depending on=
=0A=
> the NAND state, and most of the code in the core assumes READID=0A=
> provides a fixed ID that encodes the chip characteristics/capabilities,=
=0A=
> not its state.=0A=
> =0A=
> Anyway, if this bit is actually reflecting the on-die ECC state and=0A=
> on-die cannot be disabled on your chip, it should stay at 1 even after=0A=
> you have sent the SET_FEATURES(DISABLE_ECC) command. Let's hope this=0A=
> works as I expect, otherwise we're back to option #2 until Bean suggest=
=0A=
> something else.=0A=
> =0A=
=0A=
I'm away from work this week so I don't have access to that system. But =0A=
I can take a look when I get back. From memory though there was very =0A=
little that you could tell from the id/params on this chip (FYI we've =0A=
decided to use a chip from a different vendor for production).=0A=
