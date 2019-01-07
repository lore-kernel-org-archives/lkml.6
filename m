Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E3DC43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8BC2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iNreabkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfAGVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:40:15 -0500
Received: from mail-eopbgr810118.outbound.protection.outlook.com ([40.107.81.118]:6065
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbfAGVkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4lArX6fA9rL5UBPlqlig+3Cs1yqcxawJrZoMMtklj4=;
 b=iNreabkVE5+95x1bWH0wuy2Ich4BRhWK78VEfV2JjDNMOgvrFhRoNc75VGX3SeoRgEdYlgxt7v6VKIdQbwuQHjnK0X2xt79Miq5RUfnkSBCpCo5HnSm3S5AvgVufhQXXzr1v3qrVca7/sWUhA6w2nDkkE9NnkaNLVl3BkOeUaN8=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1760.namprd22.prod.outlook.com (10.164.206.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 21:40:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 21:40:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Alban Bedel <albeu@free.fr>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alban Bedel <albeu@free.fr>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: ath79: Enable OF serial ports in the default config
Thread-Topic: [PATCH] MIPS: ath79: Enable OF serial ports in the default
 config
Thread-Index: AQHUpsGNAmBYrnlRvU2Ua1GGq44ORqWkVZyA
Date:   Mon, 7 Jan 2019 21:40:13 +0000
Message-ID: <MWHPR2201MB1277BABEB0E6E8771FDB92B2C1890@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190107194515.16552-1-albeu@free.fr>
In-Reply-To: <20190107194515.16552-1-albeu@free.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a02:c7f:5e43:2c00:50fd:bec4:fe7e:44e7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1760;6:llN9O+/UmIGaRC4fLTl2C+qkEgBZXxrQUwkye3miWWqpXHkn0unPLqsiED7iSCM0MtoOexx6Y1i44dPYktbdIFAPmbvUI/0B2bdxOa4jY1TUbKjUW9/TOnUBgW2d0bZNvTefCJN4puUd90lhr4uuRz9bkA09gYSC7eo0Uvkq4AtkfPXinHM+E4JXi38tVWqeXg+GIQnh29gkJ/TcUEzdosHp8PXG4R/Ns4x0pL1vXuBk1Xpbj3B8NhGKiIrTL9QRejFHntviRl3M8JH0vuqu8G6mGvcjOvPm5M1TBLzDHLS6mwgk8YDeTln9irKLr/v3M7s0yLBnvPXKKBt8OFz8q0qKnubGlsNkA3YsuC1SjjQee1wXLw0UUK6J4xdPOdgh1SwYuVgEXw8flX611CDZLL1P4gDO9VPLiADJI4VqIv3jglQvzOQRQPFaxLr6N6fYhsfNjW7CzN1elD8KvffOWA==;5:Fu8Y9jfjNNjj+zSNHsChMyec3cKycQ6VLKWQ4GwxIIa4cGAa8mcmlSpjvp+uv2z9bgHfKnj0OXZtP1X4hm4JR4HJsvw5DXByYAHDTHeo4ZYZo3C/jYELZ4x+Rsc+5PzGPOEMKaVHIDkdEEnbDioruMjU280qVDg48xfBwzYHHZ2RrL51nOBaMjkNquprB49VguBKGhnI0/3bp0+crIcMiA==;7:s2yqgYLW4ymjwhTJq6z4ff9tbPmLx0wc4/LeZKbEPsOLpqVQGLySvGKwD/Co1cgeF6LO9Zbf3K+se/qP1HX6IgcZy4z7Jhf7Kz9BwxwSOCXsg561ewOBceB4sSchMty5co3++GtzsbOX9HhsnlHykA==
x-ms-office365-filtering-correlation-id: 04f62a87-d30e-4a00-ffcc-08d674e8b4ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1760;
x-ms-traffictypediagnostic: MWHPR2201MB1760:
x-microsoft-antispam-prvs: <MWHPR2201MB1760C533CC8444606C4B02E2C1890@MWHPR2201MB1760.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(10201501046)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1760;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1760;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(396003)(39830400003)(366004)(199004)(189003)(7736002)(14454004)(305945005)(105586002)(478600001)(99286004)(4326008)(316002)(54906003)(6246003)(7696005)(52116002)(71190400001)(25786009)(106356001)(76176011)(71200400001)(74316002)(5660300001)(2906002)(186003)(386003)(42882007)(102836004)(8936002)(6506007)(55016002)(33656002)(46003)(446003)(11346002)(476003)(6916009)(6436002)(53936002)(486006)(97736004)(6116002)(256004)(68736007)(81156014)(9686003)(81166006)(8676002)(229853002)(44832011)(15866825006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1760;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lJaMDnXj9jR5x66RCDJgMmWXZ5DPa5H7+KdIb3pGv9oGsNuSNRzJ/YCRhTYOpcFz4xgOvnqPKr/dcRmWGzUJTMUo2+AgyFS6jM8QOq3WU9mTBgPBq9/38Ns7QxOWDyhb2Aln7G5b1nbwTAzdJ4eDYqDws0Jn+giwZVU4w2ScYgPjZ9IoJU7vXuyUQu4DmSj3ChrzpxbevmRusUluVLty/fwiQZC6/fddDZEFzDb97pHpkz3EKnCKOrMjNLUXAY9dIr4HDcpR6DsUTjvASEbyx84ilpiAL/YWPzfBi0c1BhTzdDisKO8c17zXF+MiDEcU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f62a87-d30e-4a00-ffcc-08d674e8b4ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 21:40:13.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alban Bedel wrote:
> CONFIG_SERIAL_OF_PLATFORM is needed to get a working console on the OF
> boards, enable it in the default config to get a working setup out of
> the box.
>=20
> Signed-off-by: Alban Bedel <albeu@free.fr>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
