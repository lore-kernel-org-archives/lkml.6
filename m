Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14562C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2792075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 00:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="PxbxFwG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2792075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937129AbeFSAfH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 20:35:07 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:44832 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937090AbeFSAfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 20:35:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C70A28364F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 12:35:03 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529368503;
        bh=l3pSPKxRKib8qtqKjxJ5pLR2+QN6tVCZ50qXC7YLo4E=;
        h=From:To:CC:Subject:Date:References;
        b=PxbxFwG6gVrvOnQ+IOTd0swOnDxLUusYPsrdbR7vXk8fiZoNe1gJ74/0MJsjvMnpU
         vQbcrN0HZ+pqWop63HK8tyucRORc5n6o/WHQMxEVtMPw2bFUF0FlL1MKhGjoyFa2u/
         ywo1PjXl10dMkZcuiDwwH3/cmlrriQdWe+ivUOzI=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b284fb80000>; Tue, 19 Jun 2018 12:35:04 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Tue, 19 Jun 2018 12:35:01 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Tue, 19 Jun 2018 12:35:01 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Topic: [RFC PATCH 0/2] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Thread-Index: AQHUBsA+zZ/Rrpto/keRRl4OvggntA==
Date:   Tue, 19 Jun 2018 00:35:00 +0000
Message-ID: <f16525ea6b534123bda64b09e818ce6d@svr-chch-ex1.atlnz.lc>
References: <20180618045255.8015-1-chris.packham@alliedtelesis.co.nz>
 <20180618151450.3e740270@xps13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/18 01:15, Miquel Raynal wrote:=0A=
> Hi Chris,=0A=
> =0A=
> On Mon, 18 Jun 2018 16:52:53 +1200, Chris Packham=0A=
> <chris.packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>> Hi,=0A=
>>=0A=
>> I'm looking at adding support for the Micron MT29F1G08ABAFAWP-ITE:F chip=
=0A=
>> to one of our boards which uses the Marvell NFCv2 controller.=0A=
>>=0A=
>> This particular chip is a bit odd in that the datasheet states support=
=0A=
>> for ONFI 1.0 but the revision number field is 00 00. It also is marked=
=0A=
>> ABAFA but reports internally as ABAGA. Finally it has internal 8-bit ECC=
=0A=
>> which cannot be disabled.=0A=
> =0A=
> Boris and I agree that in this case, the chip should not be probed if=0A=
> ecc->type !=3D ON_DIE (and eventually NONE).=0A=
> =0A=
> This should be handled in the Micron driver.=0A=
> =0A=
> Also, what is the returned value of micron_supports_on_die_ecc() (with=0A=
> patch 1/2)?=0A=
=0A=
micron_supports_on_die_ecc() returns MICRON_ON_DIE_UNSUPPORTED. =0A=
Technically this chip should be MICRON_ON_DIE_MANDATORY since it can't =0A=
be disabled but that wouldn't be much help since that would still result =
=0A=
in -EINVAL. I'll dig into micron_supports_on_die_ecc() and see if I can =0A=
find something in the datasheet to use.=0A=
=0A=
> =0A=
> Regards,=0A=
> Miqu=E8l=0A=
> =0A=
=0A=
