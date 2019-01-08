Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45348218B0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="sJJzV2TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfAHIK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:10:27 -0500
Received: from mail-eopbgr140090.outbound.protection.outlook.com ([40.107.14.90]:54622
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfAHIK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH3oWLTzSGkEnr8YqdsOvYPDGQ1x3b7FO3FnSfVJzpo=;
 b=sJJzV2TVwQ4vfdFUo/7NpdIWWKXhqauWwTTRgCMVlL6j8iiFE/SikUAlsx4E0XJEwrwTbdwl/pV/Us+jTKKD8Fca89WRwPoL0QnDNZ8L7alNOmvmhqRgmgq7i0utHmQJS1IAmSHXyRWSAQytC3ihsAU3M3fIPy4zV59PDyDYsrE=
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com (52.133.24.160) by
 AM6PR0702MB3672.eurprd07.prod.outlook.com (52.133.24.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.4; Tue, 8 Jan 2019 08:10:21 +0000
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b]) by AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b%5]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 08:10:20 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Support for ARM Cortex A15 L2 internal asynchronous error
 detection
Thread-Topic: [PATCH 0/2] Support for ARM Cortex A15 L2 internal asynchronous
 error detection
Thread-Index: AdSCPkWA9gnkAwk6Sm+svCBlSH1vnQ==
Date:   Tue, 8 Jan 2019 08:10:20 +0000
Message-ID: <AM6PR0702MB3799317C93057F1EA6C86393FA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0702MB3672;6:DsSDouvw8e6/GgFpvUP2uD01nSInGvrhx8KsI8xTWM4ZHGoFoDWP1wlfENQlJCsG8uJjykgiRChvpjPUZGr0eTT/O2ul57OaBF8I2uoA2Eys5NoMeiQ5crNvYAHp7ohXKBucnuJyIYeGvsYghs6mz4NT+Tk76k6YIrABk75dt2KQAR4QTBD0SeQI1jjGId7CL1AcXp0EsKqvlgIukhM8tOMI59MCxusxEubUysm9M11gj5SnnGs8UBmM/EuatYhsjQSWAESnWU0F48E0kAyoGIyde/z2GoCITL/UeRyjaIYZqWVIcY8z+bxb2MP7v6YvkWggVv60TIVCuW8QzZcJKyUWcRzihExgH42jaPXrV9wJ4z1agUYQsg1mgfk2spW8PWBZWW5h1+SZ3qzuyChn0LXAwO1r4Up/WTLgiq3Z1KfJCffKXkpmkrT++ZtR+PChx7k2Fe7m85Jv2vGWzdLe5A==;5:tUMsWvbPQRt1IMrblRPjV/wuGe0YuaaNFDDXY/oNHOzPdJ3DoOwhWc/MlcvDXoUhHlMygGPk0Ap10tXBsGWXiRSHjqSnCXRmZ20WZD5xcKe4tXgS9eybsrF5g0AX/2JapOIdQ4wZZzT/NuSAhRv5gSjg7oyIGwBiX264MqZuLd0S2vBuV4vAO5wwYhf7b3UiLVKeOB9cP8jgRyYYK7HrQQ==;7:xT1Pz7Z5Gw0p5yyi7tLkhx8O7vcndx6SC5vIbH5Ya+bloYkZh99/0lWPfP4oGPEij1w+ZO8JJXd+i2P7929ZVzUGOaMgLCyCJhbpfRkvyhIwlj6pa1PKsxQQlo0U7nCCnGP9EuNSbmtPbaAAjfdLvg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(74316002)(7416002)(5660300001)(14454004)(81166006)(186003)(478600001)(68736007)(53936002)(110136005)(9686003)(316002)(6116002)(54906003)(2201001)(305945005)(486006)(2906002)(256004)(25786009)(3846002)(4326008)(99286004)(71200400001)(7736002)(26005)(33656002)(476003)(71190400001)(6636002)(66066001)(8676002)(81156014)(7696005)(86362001)(6436002)(105586002)(2501003)(55016002)(6506007)(106356001)(102836004)(97736004)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3672;H:AM6PR0702MB3799.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 097c5993-d098-4bc8-b1cd-08d67540bbaf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR0702MB3672;
x-ms-traffictypediagnostic: AM6PR0702MB3672:
x-microsoft-antispam-prvs: <AM6PR0702MB3672F99CA1EFFEC418ECC160FA8A0@AM6PR0702MB3672.eurprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(806100)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0702MB3672;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0702MB3672;
x-forefront-prvs: 0911D5CE78
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tMRRSHLZeFJBaf5c6MUze7YRj7H6vGjUCXUMonDfTBB323LsQpu/b+fR/VWUE77yy3y1uE4HnwEn8q5hInoiBDKEsdJ19pOALuhdEulLK3ZLGQg5kpOYnPlwGnafUzyo3iRNA+5gXxHqi9ceOT1aGJ56PXztotZyc/7k+qLdYR+osOBuT3GHUNqHWAvJ8gVoyC/Bpil7vePV54NJxQZ+G+VjvQrqUHMWQj/pV/Qwf/Ci9MoNsUnxKYVOzo9/He4qv/K3NxlZnL+yKTGr2IL94tiAn5kz3DcJDKV/hxbgzW9eyu/na5LP5+KFipqqPo5G
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097c5993-d098-4bc8-b1cd-08d67540bbaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 08:10:20.5593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for L2 internal asynchronous error detection
caused by L2 RAM double-bit ECC error or illegal writes to the
Interrupt Controller memory-map region on the Cortex A15.

Testing:
- works as module (loadable & unloadable) - OK
- works as build in kernel driver - OK
- interrupt registration - OK
- appears in EDAC subsystem/sysfs - OK

Wladislav Wiebe (2):
  dt-bindings: edac: ARM Cortex A15 L2 asynchronous error detection
  EDAC: add ARM Cortex A15 L2 internal asynchronous error detection driver

 .../bindings/edac/cortex_a15_l2_async_edac.txt     |  22 ++++
 MAINTAINERS                                        |   8 ++
 drivers/edac/Kconfig                               |  11 ++
 drivers/edac/Makefile                              |   1 +
 drivers/edac/cortex_a15_l2_async_edac.c            | 134 +++++++++++++++++=
++++
 5 files changed, 176 insertions(+)
 create mode 100644 .../bindings/edac/cortex_a15_l2_async_edac.txt
 create mode 100644 drivers/edac/cortex_a15_l2_async_edac.c

--=20
2.16.1
