Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F80AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B792075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bNloHX5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfAAUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:07:55 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:45623
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfAAUHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTMwsXER3EoAY7l2ookrpHjUuAd2LhH5QAi5kU3CmAQ=;
 b=bNloHX5WZ7XaPR1rE3JTOKg0TlE3fFsRd3/HfdpVwj243OoN/ZTRYejaLEc8gv+wpkuiQ/mYv89uwlMhDO+zWrngaYGHnZ5Rc9Kbi4ob/tK0XYwiXQmwn9jCN6PrIz3U2Og2vEqG0xQR09GZbzEilArpchYJTXbz4tYRuToa/z4=
Received: from DB6PR0501MB2183.eurprd05.prod.outlook.com (10.168.55.140) by
 DB6PR0501MB2072.eurprd05.prod.outlook.com (10.168.9.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 1 Jan 2019 20:07:49 +0000
Received: from DB6PR0501MB2183.eurprd05.prod.outlook.com
 ([fe80::95e9:6204:950c:76bf]) by DB6PR0501MB2183.eurprd05.prod.outlook.com
 ([fe80::95e9:6204:950c:76bf%7]) with mapi id 15.20.1471.019; Tue, 1 Jan 2019
 20:07:49 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     kbuild test robot <lkp@intel.com>, Michal Simek <monstr@monstr.eu>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined reference
 to `__user_bad'
Thread-Topic: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined
 reference to `__user_bad'
Thread-Index: AQHUogFn82EjZIXOn0yOobn3TJPHX6Wa10sA
Date:   Tue, 1 Jan 2019 20:07:49 +0000
Message-ID: <20190101200742.GA5757@mellanox.com>
References: <201901020245.p5MQ8v8e%fengguang.wu@intel.com>
In-Reply-To: <201901020245.p5MQ8v8e%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:102:2::36) To DB6PR0501MB2183.eurprd05.prod.outlook.com
 (2603:10a6:4:4b::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2072;6:VUq72OSfUxf6SWhw3WVcHYNS9rT5ROCBAGi1hY1Xb1ZkOrVV6Xd7uWCSvTg7IuZN0EoKRW3Gbe36rqnh7MATf5JAJaIbrVW/wKZRhnIU9cOoFche23KKvqbLlxtbANHsQxOp3IqQCZDxPjExt0RpGv/wcNM0anQQiEgpLQO6XitkJkJqLEramvUQmiBwCV+Q95zOolCC/BqhRHQICBps1cz5p+2wVkqJtPIeOvE+Q8uliXlJxPO7gnZYcFmPmIS+TpMArWyPJbgLn11AHcBmlF3ehMchPtznC/1pYEfars38x1goy+ZP+42HRVe5p5fOT3rMhSAY+T6/pOB1W4oWUW7wWeRBhk/0WCh7vFgMTHpdM5Vx78vWanQ4hu6C8lV3WTmhbhiq97SsNSiqi2lqRtAC3qGpcSSGMt21pS3qaVDNfPaFuouDhIGc+ONEj+/5MIhw5MWuQf9O85BYbs6vyw==;5:sDqwlDzWaaVcpxhMgI4KPNFfHMdhPJg+DVb5+NH3ebdug9+hkEQ55blHwLg1VUZo7i50IV6OGWHx4SaQPc+HMXkNBFDp2AIDPee0hQGwpgOHiLE57VsYVay2EpYHGrXOenjoOcF8IEHVu34e4Y6Eb5UKHyIrJhzE+Sn8R8L7z6mnOZzgiT9PxQGlRtAJreo1kNApYu+15O6EXxaJpLu4lw==;7:qkgj+EBj3q+j9W4dOPaW0dEmO0ddP3f/FnT28MPkXaORZo3HNewwcCyUsHUfu8KWXgJqZaAHf+iJ3kc96Z8T5yc9JV4A7FbIaSte2alLYtRV8QIYwRQZYyQMj7dEfJA8Tsr3Nb8GYpB/vOoGCmswWA==
x-ms-office365-filtering-correlation-id: e04b9b58-cfcf-4112-41a9-08d67024cd68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2072;
x-ms-traffictypediagnostic: DB6PR0501MB2072:
x-microsoft-antispam-prvs: <DB6PR0501MB207269888C3343EB85FDD450CFB30@DB6PR0501MB2072.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2072;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2072;
x-forefront-prvs: 0904004ECB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(69234005)(189003)(199004)(7736002)(1076003)(6116002)(86362001)(6246003)(229853002)(68736007)(305945005)(76176011)(52116002)(25786009)(316002)(66066001)(110136005)(6436002)(54906003)(53936002)(6306002)(105586002)(3846002)(6512007)(107886003)(106356001)(71190400001)(71200400001)(486006)(5660300001)(8936002)(966005)(478600001)(97736004)(8676002)(102836004)(26005)(386003)(6506007)(14444005)(6486002)(256004)(5024004)(2906002)(4326008)(476003)(2616005)(14454004)(186003)(33656002)(11346002)(446003)(99286004)(36756003)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2072;H:DB6PR0501MB2183.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EjBDvRl8jlJmKG4J85HZFxpaovGYeT/0zIEGuy5/UaLkMY+mJjI9iUljMceRrzIJSHlc8uEfBsvzx/G5M5zJKCiUvzlIIC4muGthXdKK992xZ7iuFp5D0rKv0Imo2p9DhkbDJB6gyE/NqDvUwLSxa141xffqeVRHL4tdb3vZRH+14nQrewDYXPS+WKDN1gjJFYgZ9ttuw17Q4739kNvJhSCUDDYpWhyh3yce7ehHx2LV60IT3921ZIM1LM/C9cw3mpM1V1WtgvlOSZ6+G2whbwTpqiDtqpLEWDNN9oKHghXBKfVX2/DCOqA1Yk3ZL3e/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8BE5721D6937E4E8CB904E0E797910E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04b9b58-cfcf-4112-41a9-08d67024cd68
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2019 20:07:49.0482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 02:33:41AM +0800, kbuild test robot wrote:
> Hi Jason,
>=20
> FYI, the error/warning still remains.

Like binder, DRM, etc, uverbs requires architectures to support 8 byte
get_user/put_user.

For some reason microblaze only supports 8 byte for put_user, so it
fails to compile.

I don't see a reason to change uverbs here, I think microblaze should
be fixed, then it would fix all the cases below.

Jason

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   e1ef035d272ef4dbfdda98e58699698305138856
> commit: 3a6532c9af1a7836da2d597f1aaca73cb16c3b97 RDMA/uverbs: Use uverbs_=
attr_bundle to pass udata for write
> date:   5 weeks ago
> config: microblaze-allyesconfig (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 3a6532c9af1a7836da2d597f1aaca73cb16c3b97
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D8.1.0 make.cross ARCH=3Dmicroblaze=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.=
o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    `.exit.data' referenced in section `.exit.text' of drivers/tty/n_hdlc.=
o: defined in discarded section `.exit.data' of drivers/tty/n_hdlc.o
>    drivers/infiniband/core/uverbs_main.o: In function `ib_uverbs_write':
> >> drivers/infiniband/core/.tmp_gl_uverbs_main.o:(.text+0x13a4): undefine=
d reference to `__user_bad'
>    drivers/android/binder.o: In function `binder_thread_write':
>    drivers/android/.tmp_gl_binder.o:(.text+0xda6c): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xda98): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xdf10): undefined reference t=
o `__user_bad'
>    drivers/android/.tmp_gl_binder.o:(.text+0xe498): undefined reference t=
o `__user_bad'
>    drivers/android/binder.o:drivers/android/.tmp_gl_binder.o:(.text+0xea7=
8): more undefined references to `__user_bad' follow
>=20
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion


