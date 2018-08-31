Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F435C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C432C2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Ob79/wSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C432C2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHaMT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:19:28 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:7148 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727334AbeHaMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:19:27 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 31 Aug 2018 17:13:10 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 4F99A7BE1B;
        Fri, 31 Aug 2018 17:13:10 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,309,1531753200"; 
   d="scan'208";a="291167533"
Received: from mail-ty1jpn01lp0180.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([23.103.139.180])
  by relmlii2.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2018 17:13:10 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfMqasoT6FFjbv7nCq2zrhdBadrDmky+VKGy/8h0mTc=;
 b=Ob79/wSisf0bDtz1tO7/5fbqXRs2EIKabDAMhqBWtNB365gNbh4jjRDGgUT0d7Tnv9p3AYAh0ZISMY79TWG2+RFQgjAiUOToDUwXU0PJENMlqLt47hTSp6A8AViLsu0MLxvT4PCFX2xM4dckNvBXAEJ0AHnJ9e8zsWtO180ckaY=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1484.jpnprd01.prod.outlook.com (52.133.161.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.15; Fri, 31 Aug 2018 08:13:07 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7c89:e594:b792:97eb%4]) with mapi id 15.20.1080.019; Fri, 31 Aug 2018
 08:13:07 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Topic: [PATCH v2 3/3] ARM: dts: r9a06g032: Add pinctrl node
Thread-Index: AQHUQGNG7Yr4GcSVxk+GvK1sSwm1YqTZCIuAgAB6u+A=
Date:   Fri, 31 Aug 2018 08:13:07 +0000
Message-ID: <TY1PR01MB1769AF7EB0152AF03B7B77C3F50F0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <1535634775-19365-4-git-send-email-phil.edworthy@renesas.com>
 <201808310827.o3GAs37i%fengguang.wu@intel.com>
In-Reply-To: <201808310827.o3GAs37i%fengguang.wu@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1484;20:c1SOuxJEoYH5LV1k3m8eKiFYRfFNIfA3XYpP16tYi7v0cJH7fubI90Xp7UMSavsLeVyENiufwmkgleqasEK23/jMFR7hSro0uPa0XPhExMakExJlXEsffYVAhPo/SgSp/FpYx6BRbhw/VEj4ehZZ/eXVgc7eC/ezrrdcW1uJIs0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 176c5c36-88ae-43de-92f5-08d60f19957a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1484;
x-ms-traffictypediagnostic: TY1PR01MB1484:
x-microsoft-antispam-prvs: <TY1PR01MB14847BD27A9E34E44FD1AA59F50F0@TY1PR01MB1484.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(275740015457677)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:TY1PR01MB1484;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1484;
x-forefront-prvs: 07817FCC2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39850400004)(136003)(376002)(199004)(189003)(6436002)(81166006)(81156014)(478600001)(86362001)(2906002)(186003)(110136005)(305945005)(74316002)(7736002)(7696005)(5250100002)(316002)(229853002)(8676002)(53936002)(68736007)(966005)(256004)(5024004)(3846002)(55016002)(14454004)(99286004)(6116002)(105586002)(106356001)(8936002)(345774005)(33656002)(25786009)(4326008)(102836004)(53546011)(6506007)(9686003)(97736004)(76176011)(486006)(26005)(5660300001)(66066001)(44832011)(11346002)(2900100001)(6306002)(54906003)(6246003)(476003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1484;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T5AyCUda0w3HEPQZ8SmYg0z/6vmbvLAw3G4go0xs1gLZ93q9R6CtVt+70EnAyhggI/BQoH8bX+0RqIPpJRw/HWZWLA5itJn5WswDVzzs1Obq9LOhLxzgDnmWKioikEXsg2HOu79JDsvWkKFohijF2JvpGn/9hqHgl1E2lnmdSRh8KGsgjALjP9yEvcxVb7fXlCBhkKZsst1+6mSj3St0kEYvTu5BHwAZsoqtKWracDITKSaeHx8dnmo3b8czeGF9ebLRD4R81IVdNEJIwSCMtpZYz8toLSFFFd21kkYqi0ijan0S6zH8PrthrqGSKQ5ByKaOhz7atOgH2B1ce4QtpmECktn+3JjuiYw7ji7WzwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c5c36-88ae-43de-92f5-08d60f19957a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2018 08:13:07.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31 August 2018 01:51 kbuild test robot wrote:
> Hi Phil,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on pinctrl/devel] [also build test ERROR on v4.19-=
rc1
> next-20180830] [if your patch is applied to the wrong git tree, please dr=
op us
> a note to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Phil-Edworthy/Renesas-
> R9A06G032-PINCTRL-Driver/20180831-050708
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-
> pinctrl.git devel
> config: arm-mvebu_v5_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.2.0 make.cross ARCH=3Darm
>=20
> All errors (new ones prefixed by >>):
>=20
> >> Error: arch/arm/boot/dts/r9a06g032.dtsi:93.23-24 syntax error
>    FATAL ERROR: Unable to parse input tree

This error is because the patch depends on a patch from Geert:
"ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions"
https://patchwork.kernel.org/patch/10578707/

BR
Phil
