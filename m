Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7E0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="XZXLw5hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E076120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966097AbeFRJfr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:35:47 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:43652 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965136AbeFRJfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:35:43 -0400
Received: from si0vm1948.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 418Qv12zXkz1XLFt8;
        Mon, 18 Jun 2018 11:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1529314541;
        bh=wwUH7KrPR3BW7d2pSeeEBuCYN/Z0PHk6qsxQQ4MQOIw=; l=10;
        h=From:From:Reply-To:Sender;
        b=XZXLw5hctLmB+SQzmm+HBiyZpLnv8adNBToH1df8eqTpoptDFWNPOOmkkZkFQVnly
         XbnS/crYtqeLG6XxwdwWTtQl8bRB85/pEVBNcEuuX1VIssykFxHqQGe7POhlTbGjb2
         iugmdueMZ4oAJY5kJ4xxkI+aWslu69wvz+M8ZQy8=
Received: from si0vm2082.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTP id 418Qv12F1Gz89s;
        Mon, 18 Jun 2018 11:35:41 +0200 (CEST)
X-AuditID: 0a3aad16-be7ff70000000413-ec-5b277ce5c1d3
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2082.rbesz01.com (SMG Outbound) with SMTP id C0.48.01043.5EC772B5; Mon, 18 Jun 2018 11:35:33 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (fe-mbx2051.de.bosch.com [10.3.231.61])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 418Qv10bWZzBpBV;
        Mon, 18 Jun 2018 11:35:41 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2051.de.bosch.com (10.3.231.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Mon, 18 Jun 2018 11:35:40 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Mon, 18 Jun 2018 11:35:40 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hs@denx.de" <hs@denx.de>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>,
        "ZHANG Kevin (BT-FIR/ENG1-Zhu)" <Kevin.Zhang3@cn.bosch.com>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "zhuyi882004@126.com" <zhuyi882004@126.com>
Subject: Re: [PATCH v3] Input: add bu21029 touch driver
Thread-Topic: [PATCH v3] Input: add bu21029 touch driver
Thread-Index: AdQG5tWgIyFNjbEHQtKGjBsLB476Wg==
Date:   Mon, 18 Jun 2018 09:35:40 +0000
Message-ID: <d790eaf934274cc6a489c177d1f42674@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tb0wTdxjH+fWu7dH18Gj581gFswZHJrED3OCCczHTbU1czJyvBlm2st5K
        I21ZDwigL9xUmISRzQmpBflTKAiiZZ06oAhaUVQWGWMbNJSiAxZAMQbGUDNxVw6kL/bu+3yf
        5/M8z++5HIHJegkFoTdmM2ajJlMpkuCSlHNRWycPxabFOx9to6t77gjpa7YpRLd5xzD6xtB3
        GO2Z+0dID3ZUiuiZI3+KaPvQgIA+drlHTNv769BOiXrsslht9/yCq1uqWpC6ynoTV7dbR8Xq
        us5pgdrZfFyknndGf0CkSt7UMpn6XMb82lufSjJK//CirGFp3kDpQ/FhtBBcjIIJoF6HPtsT
        cTGSEDLKIgBbz/2VoBPB7f4OER/MIii+WoPxwRUEj29cQn5eRKVAUUMfhxBEGLUZzrj2+Gsw
        6h4O3rma5Ro5lQyDX5YI/DqMouHZSD3itQqazlUI/RrnWIvnK8yvSWo7XBs5jfs1oqKgtbV/
        2ceoSHD+tSjk96agvpP3gQqH6fEloX8HoF6GSsvbfLkKhstOingdBw2191fah8KtUxP4tyjc
        GtDVGoBYAxBrAFKD8GYUzurjcw2J8XSiypzOsAXxCarPTAYn4r9sRBs6clXrRhSBlFLSaYxN
        kwk1uWy+wY3eIATKcPJWKmeFpJu0+RkaNuMTc04mwyoVJAoKCpLJX9hsTrpBz7J6k9GNgMCU
        YWTsRo4jtZr8AsZs4jE32kDgykhyYuejVBml02QzBxgmizGvZrcThBLI6oMcGGpmdEze5/rM
        7NW0MoqfGRGYCRwrIILdaBsh5WZ7/S1INktjYPW6FXw9j8tW3TX0NtpFPCgsKcFkuNFkZBSR
        pNTPU/7KjBzjiw0UG0mVLSZNFh6QWOsygzyIu6GcnCvgYCn3A63NBrJNXvmRLHTFXIMS7RxD
        PRdDt2cQwYXCegE4lmYxmLSX4+CyeHFodz8Ww3zjRQKqLC1S6K44EQJPT5WtA1/D81D42rYQ
        Bm3lAwqwLP0eDRVdjUqY+vlODDgXi+Lg74XerWCp/UkFQw8G4qHt37MJcL61PAkczxaTwFd6
        Ohlcjd3JUOqbpOHJbFkKHG18uAN8XdO7oMcxuhtcdz3vwHyt7d0Z7rAC7rAXCpYPm63J/p/D
        rrhrr1McRu3vH9r8as8XBU3NvznSq8dC1nes6xO7jaP5O9iDJ1xNx3zHB8+MROty91/c9J47
        Txs27ugai4rdEF36ofdjx1TNeF4vGDb9cHT3FcKeLP017vrd/RHX0UL56I+z/cI9+u+7Xrlp
        eCrfV1h3MnXqpQN7h0Nimr6R35tLUuwt2jKRcEm3T4mzGZqELZiZ1fwHsgPON9oEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kbuild test robot,

> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on v4.17-rc4]
> [also build test WARNING on next-20180615]
> [cannot apply to input/next]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Mark-Jonas/Input-add-bu2=
1029-
> touch-driver/20180512-091305
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/input/touchscreen/bu21029_ts.c:293:13: sparse: restricted __be=
16
> degrades to integer
[..]
>    288		if (error < 0) {
>    289			dev_err(&i2c->dev, "failed to read HW ID\n");
>    290			goto out;
>    291		}
>    292
>  > 293		if (cpu_to_be16(hwid) !=3D SUPPORTED_HWID) {
>    294			dev_err(&i2c->dev, "unsupported HW ID 0x%x\n", hwid);
>    295			error =3D -ENODEV;
>    296			goto out;
>    297		}

Thank you for your effort. The reported problem was already fixed.
Please have a look at the most recent v5 patch posted on this list.

Greetings,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1)=20
Bosch Sicherheitssysteme GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMANY =
| www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118=20
Aufsichtsratsvorsitzender: Stefan Hartung; Gesch=E4ftsf=FChrung: Gert van I=
peren, Andreas Bartz, Thomas Quante, Bernhard Schuster=20

