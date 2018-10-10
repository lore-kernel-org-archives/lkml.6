Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A7AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EB82087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yqTPI7xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EB82087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeJKCFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:05:53 -0400
Received: from mail-co1nam03on0072.outbound.protection.outlook.com ([104.47.40.72]:12637
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726791AbeJKCFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTZ9kybPWkyxsi59T9YnNQNPzvhhlD3RAq90vgNSWI8=;
 b=yqTPI7xq0LcZOOX2IWFcv2ILdIPFZFmoZhU+D0SQjqZBuSqQGrH6NV8hRrVH14gwQXMxOptVnhTle3DKKw+dVFHAfTXkUVho3DT8yK7gARRlfFC4208T8AjoCxtZqg+xSKd2cnNKXf9gxn98eH61HgT8PSuxYrFbYSRCXeXlp1I=
Received: from BL2PR02MB2130.namprd02.prod.outlook.com (10.167.97.16) by
 BL2PR02MB2146.namprd02.prod.outlook.com (10.167.97.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 10 Oct 2018 18:41:46 +0000
Received: from BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913]) by BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913%6]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 18:41:45 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Jolly Shah <JOLLYS@xilinx.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
 domain driver
Thread-Topic: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP
 power domain driver
Thread-Index: AQHUXCiXjmE+vCtxy0SnyZbe+Ca6y6UY2Wjg
Date:   Wed, 10 Oct 2018 18:41:44 +0000
Message-ID: <BL2PR02MB2130719D4A82F429745DDBEEB8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
References: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
In-Reply-To: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2PR02MB2146;6:ZlvvKCtzuyMezMHm365TVeRQsWZlevSv76wAuveBFkazfoVu/K3itskcmJsHPcTesQtEsopP9mPPkEO0+/w1qiJ3stXo/1SZbSzls0qFi4b1aMumq3ySxk126cQStc2YD2paBG/sUwhI3vyQT/MN2g0oEdz7IeTTuRDDIeWvvEjKAVnL6xdV6FDvez0CfwsM8NxmnpsTtXHPamQvTDZiYyj5/ZLCETYEZkahK7IJk2j0fXz0gOkDKuir3IaK6hXli2oDDdhegaCKIsenFM8BSL1YXmB+6Xh5/p2gk8150AEAb19mpbahN+6SpeCd3ONPVpbV1l8k6bynGeTstjLuL2IkL+WA9xTdz+MgKF4mh9bnYh0sk9PJak1QyOS3uFe1Q+YHlM4lxkYnLk3VGck6kcYcfdn8k6fXG6hiM5FmZ4mCXH2jtJm5fIaHSFxcsNjcKDOTuTjM3ad4hLn0xDB53g==;5:FoVNxA5mBzvxcBE19q0ADd3gNEY+JmG4EWWdrB7jWqgxeTWcD8ZwnqkdXrYogXNrvaRNumex5PVC2tOPVYs0j0MGVSo8LmGwx68PwVGOHKtz/DVEc9KA5oit6rLxjyb8PKTeSSbaf2J9g7VSKsnv2+g4almesnycOIC6l+4DrwE=;7:sLE6+igm2NW9oKqRKYVgyRKpoq9aguWpSdiexUZTEtUfk1COKvL2f4NmXAzp1Lrqt379IvOhHPwiv5jTjALTvtdINrlMtVHm4OVtyj5msnUZrSwWgI6NUWVJq5ackEEtLRHNqSCuNpFPMvxMuPJLNqqJw2vxDoD4lBtGHme+IysOg6zTRnHyqCYkjh4aE5UCV9qq7QtdzK2iaBPLypSU+j8rYEYE5PEKPOfTj5F1BdftrxZTjJCFVINk4m5rvBvB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(13464003)(189003)(199004)(5250100002)(2900100001)(2501003)(478600001)(72206003)(966005)(97736004)(2201001)(102836004)(446003)(476003)(26005)(99286004)(11346002)(6436002)(2906002)(7696005)(486006)(186003)(33656002)(7416002)(55016002)(8676002)(110136005)(6306002)(6246003)(86362001)(74316002)(53936002)(54906003)(9686003)(81156014)(81166006)(7736002)(8936002)(305945005)(71190400001)(71200400001)(105586002)(5660300001)(316002)(229853002)(76176011)(66066001)(14444005)(256004)(14454004)(6506007)(4326008)(39060400002)(53546011)(68736007)(106356001)(3846002)(6116002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB2146;H:BL2PR02MB2130.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: fb9cd176-3a00-4560-2c96-08d62ee0076b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL2PR02MB2146;
x-ms-traffictypediagnostic: BL2PR02MB2146:
x-microsoft-antispam-prvs: <BL2PR02MB21461B2D900A8106A67DA994B8E00@BL2PR02MB2146.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(192813158149592)(85827821059158)(7411616537696)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BL2PR02MB2146;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB2146;
x-forefront-prvs: 08213D42D3
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ONCP/DiFo5VWL1loJ9qMvhoZ0AiYAQCwGczWGrzGqD244kZqTpywuYhSoeIGIJRR6Ayg8ptJXM6quPRbcWZbVh+Lra36TRP00tYFKVsnGRSwhgLY30oTJRZhE/GhjtCSc3Mc98WQQF658fwIx7ZvZzL64MwD+cHeUML+yxinstvhuseNO4X715ro/I+t8MH+IUyFt7lsd5j7HxR6Lsc6zfYjhUHp1IecD/y2PtQdar/3Lh+8lhFMGOMa1GvCvyyUSQ1kgrmhoQ0oe7dKDu61DaG52YnrCO6QwIQKWYwkDifCZMbaDAMCT6gV/xmL3helgPKN07RfE6VADhKKQCqEPaBhQCttys5jOrP3aQC7se0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9cd176-3a00-4560-2c96-08d62ee0076b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 18:41:45.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for comments

Thanks,
Jolly Shah

> -----Original Message-----
> From: Jolly Shah [mailto:jolly.shah@xilinx.com]
> Sent: Thursday, October 04, 2018 2:24 PM
> To: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm=
-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP powe=
r
> domain driver
>=20
> The zynqmp power domain driver communicates the usage requirements for
> logical power domains / devices to the platform FW.
> FW is responsible for choosing appropriate power states, taking Linux' us=
age
> information into account.
>=20
> This patch series is based on top of Xilinx firmware patch set:
> https://patchwork.kernel.org/cover/10555405/
>=20
> v3:
>  - Changed binding to have FW node as a power controller as suggested by =
Rob
>  - Updated FW driver to register it as mfd child devices from firmware pr=
obe
>  - Move bindings location as suggested
>=20
> v2:
>  - Rebased on top of latest firmware driver patch series
>  - Updated driver name from zynqmp-genpd to zynqmp-power-controller
>  - Updated device tree bindings to move power controller node under firmw=
are
> node
>=20
> Jolly Shah (1):
>   drivers: soc: xilinx: Add ZynqMP power domain driver
>=20
> Rajan Vaja (3):
>   dt-bindings: power: Add ZynqMP power domain bindings
>   firmware: xilinx: Add APIs to control node status/power
>   firmware: xilinx: Add node IDs for zynqmp firmware
>=20
>  .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
>  drivers/firmware/xilinx/Kconfig                    |   1 +
>  drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
>  drivers/soc/xilinx/Kconfig                         |   9 +
>  drivers/soc/xilinx/Makefile                        |   2 +
>  drivers/soc/xilinx/zynqmp_pm_domains.c             | 403
> +++++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
>  include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
>  8 files changed, 659 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-
> genpd.txt
>  create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
>  create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h
>=20
> --
> 2.7.4

