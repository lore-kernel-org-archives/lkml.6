Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D40222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QvtpjMzx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JHDD7+1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733040AbfBMGb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:31:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25911 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbfBMGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550039546; x=1581575546;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zgY0C0W+/2m7wtDucSuNDsJmmd7DjD9EpKzfDF75gOY=;
  b=QvtpjMzx4RP53swqR8I3v6kSIB7OhAuHSHQWykaGvTaToae6azCRmG5S
   Q9gJ94ZmQVrINcf3xTwWLxcXDpehc6nnvxzQKMyb13tPpH8uX4FqVZzCQ
   N84AhdWcAxMywLhNKziLvlZJRhx0DhRam+YiNdIRYfKp6zVhHesO0N5RJ
   08aH6VLYdMDTHbfgnz8HE1X0cpiijgeIFfUuM3rx3JqzXVPE3GyIixaoy
   WycWkE8aM1U+i5HqXuO9tvLt1RWwmJSCIPrw1K50w4lwIv5+1XEiAJy7p
   jJUksZ7qitFHLYwTidmKLscZNqxIod1KSYUp+dBANrb/nNN/YLPxt4wjm
   w==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="199287553"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 14:32:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBFZS2yCZ2xeXn+3PyLxQ8lCtlcxVvcaboaNsE+1chk=;
 b=JHDD7+1ZW+7roliFnN9PqMR2RG0gecFRxIIUi59wPCYb/jgSETNJWb/y3RQwU2M+p5GAeE5YUOcdyyChAIDySmGmCy4nJRh/ItZXpwmfr/MrxuYMYkflmc4ewff1b9lBQ5w/Gx2XziEoYw8I+p1tpgMKfFETqCfSj+mdEt5eh6E=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5515.namprd04.prod.outlook.com (20.178.224.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Wed, 13 Feb 2019 06:31:57 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:31:57 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 0/6] Fixmap support and MM cleanups
Thread-Topic: [PATCH v4 0/6] Fixmap support and MM cleanups
Thread-Index: AQHUw2XRghsXOYeqT0GN1LpVy53Myg==
Date:   Wed, 13 Feb 2019 06:31:56 +0000
Message-ID: <20190213063127.28703-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::13) To DM6PR04MB6059.namprd04.prod.outlook.com
 (2603:10b6:5:129::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a61f71f1-bbc5-4afd-c7a0-08d6917cf367
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5515;
x-ms-traffictypediagnostic: DM6PR04MB5515:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR04MB5515;23:Bfgj999h/eSrY5/d0VgLRDWt5sLabpLq7iAnFn3?=
 =?iso-8859-1?Q?574Jr4DVk9HyNJzg34yAPlDZi6ZmJbgDMXtm8N+h2otlTDyZ6+TBBXxH4K?=
 =?iso-8859-1?Q?hFCkElNad3H1XTodEPgnVHM3zE3bL+FL/B2uzo8TsOg04gJvJMX+JiEDCC?=
 =?iso-8859-1?Q?3Qam28mv4QYuTpDdn/Fil96uk+XYNv1BJVPnAp10eBFTOizg2Kq5UNfs+T?=
 =?iso-8859-1?Q?JkQSyAosoi8h4Xy6NIba1xIqjB0/JFNat+kwGNb9vJCaiZcpJYhMDHabX4?=
 =?iso-8859-1?Q?iTu0agL4GCjUAQPvVM9bIQco/b2HjfCgLS2AtC9kBbZp/zAnmXGckN8tyb?=
 =?iso-8859-1?Q?YxSMQ+sCig1fY+HiLnRFc2jBpfOmp0QmI1Iz2bo10Nex1ZrjAkgXEYE3AV?=
 =?iso-8859-1?Q?HfaMgUF7GiUKXgeILIAywCMH5ZMWWABoTqloka/gYEaLbObzfgk97FScDs?=
 =?iso-8859-1?Q?SsP86mUUGXt3wowOeKpnuAXLvyBAwWGefvb4R5wg4lGsBzApfo5shKz02Q?=
 =?iso-8859-1?Q?dSzRTm7FwADaPMQuLwzWe6RB4dW9QdNJO4qxfQPaJCEkjlbCfj/wIsS+xz?=
 =?iso-8859-1?Q?dCLkGurB9VqOR9A3wmy8kBwqZqu3xsuKxsTq7VLMxiqmQpHMFQffnuvCiL?=
 =?iso-8859-1?Q?KgBqQ3njDTakSbuqWEz++mff4a/EnEpaVo9BnrZA91rSIhBhjnFZC9ebcp?=
 =?iso-8859-1?Q?i9L9Z8qpLgUJfkzvaCjJ2Ol46GlOFZK5T1ZT/zH01etbUP8sE85ZyT2qGz?=
 =?iso-8859-1?Q?z7ELFaY1GSGSQGW1CkJtPx0rX0bFqwyBoEOrcpY7Pn9MRORR0n8R6cOrR/?=
 =?iso-8859-1?Q?lXOGYs4Hv8TfoS8Yq7YP0PLfFNTj/0FI7aib6DB7Fi6bU2Ne2rrvTiRezm?=
 =?iso-8859-1?Q?TDkzDUdLx5F6YUAr1qG97Rpxis5cF/zqQqvPDWSmxQefVHLVjv9CJL7QKr?=
 =?iso-8859-1?Q?SOylisSU3Nq6Iiin4XDWM7MvBWjvsk92o10dTcu7gdYz8ASLxn2X79xSTQ?=
 =?iso-8859-1?Q?WQ9winJd0E+7DGm6h4+O6/YXK9SKEvMIpKkZFmvFo2MpP6hKkAw12c+kiX?=
 =?iso-8859-1?Q?tX9qyUKf0f74UumMKMZvpZJVFuVKgzr2KkefA8jwNzjbblGyRU/CS6dL0c?=
 =?iso-8859-1?Q?ZdIz4LiLhpwSnA89m1SoBpeJh1MjwWo3u7L24IY9tr/WFpBrAtZ+NkEI9R?=
 =?iso-8859-1?Q?ZkELIcFRbPR1Om5YzsqezhK4uvibXsI33fH3MbqSeQPfWs7HHtdzb8k4ZR?=
 =?iso-8859-1?Q?4CfYFX+wVeoWu4Oo7KHefpMkTxm+UdaHWwlUoF3IHMqhdMKZIqDrDajJ8w?=
 =?iso-8859-1?Q?6gujmxmpgjEp8hyFk0w5u0u?=
x-microsoft-antispam-prvs: <DM6PR04MB5515A311814BF262452FB8CC8D660@DM6PR04MB5515.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(54534003)(189003)(1076003)(6512007)(2171002)(478600001)(72206003)(966005)(386003)(6346003)(2616005)(102836004)(6506007)(476003)(2906002)(6306002)(256004)(50226002)(4326008)(97736004)(14454004)(6486002)(110136005)(25786009)(6436002)(68736007)(316002)(44832011)(486006)(99286004)(36756003)(8936002)(186003)(6116002)(106356001)(81156014)(81166006)(8676002)(3846002)(86362001)(26005)(105586002)(71200400001)(71190400001)(66066001)(305945005)(53936002)(52116002)(7736002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5515;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4dhIJV9o1F1jPoeI+FmOsSBGJJZHOThJi9ZkDinq2RiXPpj8PpfoISk2C0ADx90zGjJvNXTLmlUCItNTt+VMaUKM+/MIrxe1rXfPE8cHyUu+r0+A11NcJuuHn1S4odDZghPe2j3teuJtalmz0KpsGHll/bQtGUvbFS5xtBKEBt1mOajyGSMcVkaXvg3pDJ82MunvwouIQueVQ6TaAGi5Dv6ej51Z5nDyvwAJCiWa5qt0x7wvKYgHIT0jlOxkZ+YVV4iAor+BE/45s1b6g1iUiVBlWcJ/jrxfj/ewMUmPJPl668Ei+0iJea6IsyEuq0KKri+C3/ggaa66Q2QU3k7GYD4V74Ar0ToA9G1R3crp4L3AUPGw+FlbWGqdJqfW93OWWRs4MrYRaV/gZo4agjCYNB39ZRmgNJ/fx9geJV9x44=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61f71f1-bbc5-4afd-c7a0-08d6917cf367
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:31:53.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset does:
1. Moves MM related code from kernel/setup.c to mm/init.c
2. Implements compile-time fixed mappings

Using fixed mappings available, we can now get earlyprints
even without SBI calls. For example, we can use kernel
parameter "earlycon=3Duart8250,mmio,0x10000000" to get early
prints on QEMU virt machine without using SBI calls.

The patchset is tested on QEMU virt machine. It is based on
Linux-5.0-rc6 and can be found at riscv_fixmap_v4 branch of:
https://github.com/avpatel/linux.git.

Changes since v3:
 - Re-worked and simplified PATCH6

Changes since v2:
 - Fixed commit description of PATCH6
 - Ensured commit description of all PATCH use upto 72
   characters per line

Changes since v1:
 - Use more characters per line in changelog of PATCH3
 - Removed #ifndef __ASSEMBLY__ from PATCH5
 - Use more characters per line in commets of PATCH5
 - Added PATCH6 to implement keepinitrd kernel parameter

Anup Patel (6):
  RISC-V: Move free_initrd_mem() to kernel/setup.c
  RISC-V: Setup init_mm before parse_early_param()
  RISC-V: Move setup_bootmem() to mm/init.c
  RISC-V: Move setup_vm() to mm/init.c
  RISC-V: Implement compile-time fixed mappings
  RISC-V: Free-up initrd in free_initrd_mem()

 arch/riscv/Kconfig               |   3 +
 arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
 arch/riscv/include/asm/pgtable.h |   1 +
 arch/riscv/kernel/setup.c        | 107 +++-----------------------
 arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
 5 files changed, 180 insertions(+), 99 deletions(-)
 create mode 100644 arch/riscv/include/asm/fixmap.h

--=20
2.17.1

