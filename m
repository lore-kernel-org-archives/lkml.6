Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85530C28D1F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127022075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="MJfOR6Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127022075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757364AbeFSVWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:22:10 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47113 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755369AbeFSVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:22:08 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B7FAE8365F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:22:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529443325;
        bh=6VpkhFkCB/HDTLCxQ46Gtqhchn/nAWI8BhrWGC6XWpU=;
        h=From:To:CC:Subject:Date:References;
        b=MJfOR6FsOz8/Rik2FRH9WHmGffb3/E54TQ4kC7F6wO1/D0eXure4ns+b22zwu9nGg
         t+MVfGfBsJP8xuV8KE+8YOmwrPL2IkqySGhQeOUMxgxZtpP6usvZCcK7IT7wgJfiYN
         6ShfzO9RcM5Noo4vneFt5hLAx0OiT2IbHwZ2eRxw=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2973fe0001>; Wed, 20 Jun 2018 09:22:06 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Wed, 20 Jun 2018 09:22:01 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 20 Jun 2018 09:22:01 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: [RFC PATCH v2 5/6] mtd: rawnand: micron: add
 ONFI_FEATURE_ON_DIE_ECC to supported features
Thread-Topic: [RFC PATCH v2 5/6] mtd: rawnand: micron: add
 ONFI_FEATURE_ON_DIE_ECC to supported features
Thread-Index: AQHUB47OhL3+0ut08k++lGUqKsL1CA==
Date:   Tue, 19 Jun 2018 21:22:00 +0000
Message-ID: <b7bfe97c079e4e83bc108625224c2b16@svr-chch-ex1.atlnz.lc>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
 <20180619053125.16792-6-chris.packham@alliedtelesis.co.nz>
 <20180619074056.420d5560@bbrezillon> <20180619085244.77790406@xps13>
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

On 19/06/18 18:53, Miquel Raynal wrote:=0A=
> Hi Boris, Chris,=0A=
> =0A=
> On Tue, 19 Jun 2018 07:40:56 +0200, Boris Brezillon=0A=
> <boris.brezillon@bootlin.com> wrote:=0A=
> =0A=
>> On Tue, 19 Jun 2018 17:31:24 +1200=0A=
>> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
>>=0A=
>>> Add ONFI_FEATURE_ON_DIE_ECC to the set/get features list for Micron=0A=
>>> NAND flash.=0A=
>>>   =0A=
>>=0A=
>> Fixes: 789157e41a06 ("mtd: rawnand: allow vendors to declare (un)support=
ed features")=0A=
> =0A=
> Sorry for breaking it in my previous series.=0A=
> =0A=
>> Cc: <stable@vger.kernel.org>=0A=
>>=0A=
>> No need to send a new version, I'll add that when queuing the patch.=0A=
>>=0A=
>> Miquel, if you're okay, I'm gonna take this patch in the mtd/fixes branc=
h=0A=
>> and let you deal with other patches in this series.=0A=
> =0A=
> Yes please, take this one.=0A=
> =0A=
> * Chris, I'll take patches 1, 2, 3 with Boris comments.=0A=
=0A=
OK.=0A=
=0A=
I also got a kbuild report on=0A=
=0A=
include/linux/mtd/rawnand.h:788: warning: Function parameter or member =0A=
'fixup_onfi_param_page' not described in 'nand_manufacturer_ops'=0A=
=0A=
Do you want me to send a v3 for that? (given our timezones I'll just =0A=
send it anyway and you can choose to take it or just stick with v2).=0A=
=0A=
> * Patch 4 I think I'll just drop it as nobody can test it (and it's a=0A=
>    oneliner). I prefer people requesting a feature than complaining=0A=
>    about a bug :)=0A=
=0A=
Agreed. It's in the mailing list archive now if someone needs it we can =0A=
resurrect it from there=0A=
=0A=
> * Boris will take patch 5 in the mtd/fixes branch.=0A=
=0A=
Thanks all. Sorry our emails crossed so I couldn't just send #5 as a fix =
=0A=
on it's own.=0A=
=0A=
> * I'll let you write a v3 for patch 6 only.=0A=
=0A=
I'll have a read through the old thread and see if I can make sense of it.=
=0A=
