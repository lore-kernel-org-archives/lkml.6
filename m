Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9265C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 04:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6196D2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 04:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="O6KuvZAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6196D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeJ2NbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 09:31:05 -0400
Received: from mail-oln040092014011.outbound.protection.outlook.com ([40.92.14.11]:19110
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729094AbeJ2NbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 09:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7JsNHxV7rgEypCGxNFDrAgyioM9jitp/t4iAsM0otE=;
 b=O6KuvZAXiR5aHw02DD2vuEqu2++r/JcS0J6lMeLbv9NnBEhN/clHltySl931Imsq+LKfMNWxG8LfbtZ3kN9wfoN7Crw7sJYFWfkmkd7hOfQQFEhg7S2PXHrQyXuSDXTkwQvmU3F2hYX2hH5IIej6b830mWAvUgWPTHErQ5V9XgPAQYsWj1lb7LK7jtNV6nj6ox7eelCKbfRMRspVixnmLiqoroSrVOBiF43xv0BRo1Ii3b6BizQyQ1Kbi7hM5//uFAzhNnUL/+tonnJ1SR/PZ/Om4VeXN5D10VmcY/pXtlfiTsnhKWwTkiwZDrFLcf40Fu0ExPjyeH18mFoWzt7K/w==
Received: from DM3NAM05FT003.eop-nam05.prod.protection.outlook.com
 (10.152.98.59) by DM3NAM05HT181.eop-nam05.prod.protection.outlook.com
 (10.152.99.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.4; Mon, 29 Oct
 2018 04:44:03 +0000
Received: from BL0PR02MB4851.namprd02.prod.outlook.com (10.152.98.51) by
 DM3NAM05FT003.mail.protection.outlook.com (10.152.98.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.4 via Frontend Transport; Mon, 29 Oct 2018 04:44:03 +0000
Received: from BL0PR02MB4851.namprd02.prod.outlook.com
 ([fe80::a98d:3fd2:ebf8:5e25]) by BL0PR02MB4851.namprd02.prod.outlook.com
 ([fe80::a98d:3fd2:ebf8:5e25%3]) with mapi id 15.20.1273.025; Mon, 29 Oct 2018
 04:44:03 +0000
From:   abhja kaanlani <unidef_rogue@live.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [REQUEST FOR CODE INTEGRATION - L4.25-L5.05] Parallelization and
 binary trees with huge dimensions
Thread-Topic: [REQUEST FOR CODE INTEGRATION - L4.25-L5.05] Parallelization and
 binary trees with huge dimensions
Thread-Index: AQHUb0Hwfn99kMI7/UuWP+/4yBT/yQ==
Date:   Mon, 29 Oct 2018 04:44:03 +0000
Message-ID: <BL0PR02MB4851C51D639FB6AC1F62013983F30@BL0PR02MB4851.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:479148BC9CAA9DCAFF853F209BED22439B73AC97F706D347162A5D392E9B3330;UpperCasedChecksum:504D691DCEDF0C87E190FA4AFB3DC27009905A1A3F035229B6FDA5E74C0D9604;SizeAsReceived:7021;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [SK67lPQpATlfzeXVtw1KA1YpgF1C+mOX]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM3NAM05HT181;6:wuTWgCbyglsDLjIUlkoqbQN7NFne2/g4dRgUSiFuLQrVeqfEL+lb0fF3Wj6GhjTYldFfelBuLMBtGq46sgj81E1jOMI5HCyFeJ5Nc9f6oxIujHIwj9LIO4m0arw/6ACuqaaoGST6A7WQe/rOU+pDl2kZYytA+x4JfOdxg7yCNsxjxiRp0gUr4xWzRWUhxt5GOie4cqTruOM6S9cE3I2vU320MV5Xk1FgwlXEmpARchX8cpC4Acwv5KXIUIOrgd3Ki+ZN1T6D5UIk+uT58kBP5RO5csSt9xsXtqAUeyIb2rWfqMQyo3STLqZwQxdBFP7iMGrfvpVt2k4QuSjFiEZeVJC7Txj2sYfy+3cxG1kv9SlFV7nJ5Wst4Vb6HSWKQVZhmbUFGa5SI2tNud3a5K/odlcGzewi1wy8PpJrGXoEjhGTBlVWy0qvdCGMoSee88OXdLbE9YcxB96Ia8ctO58l5w==;5:3z08PVBCWQ2brm3DvBEyLSCuo98JtuwEGs9AO2dwB0MZgfTUEFJZ/r9c0EAcTOH8bChpIk5VzBFQVt2khWwXEtB7086s7saS9qdk7dn528X7G6ATlDQBXJA4pb78cvfCVuSvhwSnaSOdJcEyT+LSqFDfUq5MXNhLxBlgNZ0nYdU=;7:edl1iNHFECeooW5DFKBy0OPiugM4y7WGgjGEcu8P6EbRWVH9fEkZvRTn0szjF7Ldv6XKaPNyqFP0eUe71Xmmpi5+I5oYw1elpaJoRe2puQV+sgE8erL3u48ZvHAovnZ+kvE+Uo1QjxP5+QOlA8pBbQ==
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DM3NAM05HT181;
x-ms-traffictypediagnostic: DM3NAM05HT181:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DM3NAM05HT181;BCL:0;PCL:0;RULEID:;SRVR:DM3NAM05HT181;
x-microsoft-antispam-message-info: sMW/eP7hhjdjTGMxm3HBlCuUn3Mxc3Si2SKYbB6Qg9WC3oswYmWVZw8BM0KX2sIO
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-Network-Message-Id: 836f6a39-7ab2-40af-7366-08d63d592709
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 04:44:03.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3NAM05HT181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I have time I=92ll have to read a few books and dig into the latest ke=
rnel to really understand what the Linux kernel is, but during that procras=
tination=A0





I want to rewrite the Linux scheduler using my code, it=92s basically a bin=
ary tree with a bunch of fixed variables with a rotating DMA that cleans up=
 excess pointers. It can be used as an integrated SQL database (because of =
char*=92s and binary trees) and depending on what multidimension you init t=
he arrays, it will take huge amounts of ram


You can easily go up one indice by adding a number to the indice that makes=
 the array go up, im sorry its med time for me


But my intentions is to make my code its own operating system. The Quantum =
moniker is a marketing buzzword, its really made for binary trees with HUGE=
 dimensions (im talking about bt[200][200][200][200][200][200][200][200][20=
0][200][200][200][200][200][200][200][200][200][200][200][200][200][200][20=
0][200][200][200][200][200][200][200][200][200][200][200][200][200][200][20=
0][200][200][200][200][200][200][200][200]; (sorry if thats spammy)


If this isnt relevant to the Linux kernel, please disregard


My code is at GitHub, at unidef/quantum


for convenience: git clone https://github.com/unidef/quantum qwork/


I appreciate any feedback, and I would love to be actively involved in Linu=
x kernel development



Also just like in EQ2, Linux could use a really memory hungry mode, I have =
32gb of ram on all my computers and multitasking (especially in Linux) is r=
eally, really fun!


Abja




