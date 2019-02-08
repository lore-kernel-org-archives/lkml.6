Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F4C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE02146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="lyMU0iNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfBHRON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:14:13 -0500
Received: from mailout.micron.com ([137.201.242.129]:35660 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfBHROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:14:12 -0500
Received: from mail.micron.com (bowex17b.micron.com [137.201.21.210])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18HDxJw008409;
        Fri, 8 Feb 2019 10:13:59 -0700
Received: from BOWEX36G.micron.com (137.201.84.120) by bowex17b.micron.com
 (137.201.21.210) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 10:13:58 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36G.micron.com (137.201.84.120) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 10:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qplrVvwt8IUsplBEoHCvjo3Z4GCCh7+Whzpi8qrleFc=;
 b=lyMU0iNfsxPTjEdmgAVOvvP1HVrnTOynIHQdmqKV3j/M7GpaKYM0jyMHk7YtAaUQEca6XiuvNhAYt/sz7Eh8LWjS++PsojzVlMoUj9YuXSo+pa7kMOs8M2LvC0zWlotN20MrSPB8Lx1m6Zoff23tF2E6NT62WTwhs281zfVHXoM=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4776.namprd08.prod.outlook.com (20.176.255.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 17:13:52 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 17:13:52 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>
Subject: RE: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAFVpvAAAQltAAACntYg
Date:   Fri, 8 Feb 2019 17:13:52 +0000
Message-ID: <BYAPR08MB4533DB0A7F4E30543750C83FDB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
 <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
In-Reply-To: <a83a9655-0ce7-da15-ec17-80ef88764e21@microchip.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4776;6:fmOnfmfHex35mGUVO4r5Uf/M+90Kui8b4vX0inPQApKrI1S7bOpJYSwxD29RZgXR4reW0NuSPxgCxEYz3JT6wbKw26UZJcdUm8iLrbloYRWBLT+eQTO3+ix0lgmFgDBeye6WI5R8uMu++ahheAhMRKtBCA8JknXaevBYVbapdgdUej54z3Tq7x++VVoLWtzuABdMZc6625VUGv80XsFuHA50gFsV94PhzoRqxWOQkB9hj1G+mjDByXBmN8gGAQL+kE8Cfg5iS4E2nC5Z+2VU32Jf//eQgrtpySlVaz9gnc8Ha1EhMjRy4lwFE0+DVLQ6/n5dR0B1b88O1gi2iivyNxN1/0XFnWclLa6PgDZoIpgrlt/hkZalGCtMltwC9VaW0FqXFKjfayYFto6DZmX12krjnNP2Gv1h/EFA1osjQaF3bnQafoJ8gVt7VzkgELkit8yHzEbpmciXsWHxq99pPw==;5:ovLDywzChTQS+g78gpcp8/kToWxhZTxYPTC4AlyYVbXKqAEATSxd0UV01Xoczsv3es8AJLab+JkvLju1RpoLTCyRG8U65Tq5Wn1soSRP3XENUC6UuAVQLjEgLBJcLsjMwuakfpwKJispJE8vt8ALrRXz18OQY4PZqECW2LyaFV/cre+k2RNvObtotjFPVpMSbR/xvsL2ohWdSNeIkqZHyA==;7:YN5H6fe7v4p95adCi/VqjSc/omfYzaeJVDwOLYkqU3lHewyZ+SZYE65zkDezndaOCRaFiBlBGRqRvEo3IcyGC2P25v2O5wYq8cm3ewDlL9nvZObjmzB7nDZUQupU74SLMkHnb6IvJSf+dFERDvZyyQ==
x-ms-office365-filtering-correlation-id: 8a9d76d2-3b74-4823-0426-08d68de8cc88
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4776;
x-ms-traffictypediagnostic: BYAPR08MB4776:|BYAPR08MB4776:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR08MB47761685E3AAD38311E2E6F1DB690@BYAPR08MB4776.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(376002)(39860400002)(189003)(199004)(4326008)(486006)(476003)(11346002)(478600001)(7696005)(446003)(76176011)(66066001)(68736007)(99286004)(26005)(6506007)(6436002)(55236004)(9686003)(106356001)(102836004)(105586002)(86362001)(55016002)(6306002)(25786009)(110136005)(54906003)(186003)(2201001)(2906002)(316002)(229853002)(71190400001)(2501003)(14454004)(81166006)(81156014)(93886005)(8676002)(305945005)(6116002)(3846002)(71200400001)(97736004)(33656002)(19627235002)(8936002)(6246003)(74316002)(7736002)(256004)(14444005)(53936002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4776;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NvkjVivVvYPed8chZraMBMk+SL3bfsDVtees8iP4XU0uQcxirk9mikg9xY27BhMUGT87Kzfnp5kTUTbw0KIUYkATqxcxA1Gtumwa3jxjH6QrTDAhkQokzIXqBIB5SB/9ppAV5668GRfMoXOCLfM6A6QtBftVXRJPXkkT1JZxKmkwtUI9w92zHYl0j72WLrQZHnxc8anjFUVLJeXvJ1MZQYeG/3jCLlnPLU3f3FPLMGQweibQFx8xHWuD0fkg2kx78qM5nsteP8GMvdujBH0mxBv46HVGBonkYCkPJxzckU9ASXUFRQ6Xq37fLa1ouZz1Go8W7Oiy7QWB8EfYvO6nkUiI8vEIAeGehO/BLqZTqevY7kraJeIGXpO9wz2T2NI5eAR5vrIF+t1UydgYLI6e9PtmiCKq4HbGwLDxSpEuIbU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9d76d2-3b74-4823-0426-08d68de8cc88
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 17:13:52.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4776
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--13.676400-0.000000-31
X-TM-AS-MatchedID: 150567-700107-701928-701461-705388-703747-700752-780014-7
        02020-707788-106230-701236-851106-700546-139010-700075-706159-705178-703283
        -703179-703969-700756-707210-780022-701500-700839-700481-704421-700074-7037
        88-707395-184200-700648-710970-701249-139704-700047-148004-148007-148020-14
        8050-20020-20043-42000-42003-63-190014
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tutor
Thanks. unfortunately, it doesn't work on my side. Problem is on our email =
server side, not my local setting.
I followed your configuration, then git-email failed.
Please just change my S-o-b to 'Bean Huo (beanhuo) <beanhuo@micron.com>' in=
 my patch to please checkpacth.pl.  It is not huge change.=20
Thanks,

>
>On 02/08/2019 05:27 PM, Bean Huo (beanhuo) wrote:
>> Hi, Tutor
>>
>>> $ ./scripts/checkpatch.pl --strict
>>> v2-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
>>> WARNING: Missing Signed-off-by: line by nominal patch author 'Bean
>>> Huo
>>> (beanhuo) <beanhuo@micron.com>'
>>>
>> I think, this is because of our email system, it always adds '(xxx)'
>> between user name and email address.
>> If you are convenient, please help fix since it is not such hug change.
>
>I'm on a funny email server too, it keeps overwriting my email header "fro=
m field".
>I have a workaround that might work for you too. Here's part of my
>.gitconfig:
>
>[user]
>        name =3D Tudor Ambarus
>        email =3D tudor.ambarus@microchip.com [sendemail]
>        from =3D Tudor X Ambarus <tudor.ambarus@microchip.com>
>
>Because my [sendemail] from field is different than my [user] name and ema=
il, git
>send-email will add in the body of the patch the [user] name and email:
>
>From: Tudor Ambarus <tudor.ambarus@microchip.com>
>
>When the patch is applied, it takes the author name from the patch body. E=
ven if
>the server overwrites the from field from the header, it will be ignored.
>
>Let me know if this works for you.
>ta
>______________________________________________________
>Linux MTD discussion mailing list
>http://lists.infradead.org/mailman/listinfo/linux-mtd/
