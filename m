Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B99EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391F42087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DMy5XLW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391F42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJKCDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:03:45 -0400
Received: from mail-sn1nam01on0061.outbound.protection.outlook.com ([104.47.32.61]:56120
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbeJKCDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/kvqixpJoGYNj3RRWzjmYNS4nlx88RdPn9gGoceq1M=;
 b=DMy5XLW2OKvfR67dWG6Jm++FCDmix+1cGjMsFcatmSIlCDZWEcll1NqTEbrwN5hTRhVyoktKMC52KoIg1p6s+c/QjCMKx/Gt7sS0vR63v3P3efAr8//mfMhku2qIjt/4RSAJcLu8WEpHnsCyaQwt3cIeDvmGB2QxkVyCB1rBjvs=
Received: from BL2PR02MB2130.namprd02.prod.outlook.com (10.167.97.16) by
 BL2PR02MB417.namprd02.prod.outlook.com (10.141.94.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Wed, 10 Oct 2018 18:40:10 +0000
Received: from BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913]) by BL2PR02MB2130.namprd02.prod.outlook.com
 ([fe80::281b:9a9:7f2:2913%6]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 18:40:03 +0000
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
Subject: RE: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM
 driver
Thread-Topic: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM
 driver
Thread-Index: AQHUTGLSk9WTU3jdfUSC1P1+b0YaKKUY+HQg
Date:   Wed, 10 Oct 2018 18:40:03 +0000
Message-ID: <BL2PR02MB21301ABF94BB130154868CE8B8E00@BL2PR02MB2130.namprd02.prod.outlook.com>
References: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
In-Reply-To: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL2PR02MB417;6:Z6pur/LMQ79Ig2tZxIWmFzQbN9PneUU0ECdBKhfaV6bGzYH58edRIbWKSo2KLPfnKCp+T2eVQMdVyy5HKu2XtWNkxmGl0O+Y3i7snFF3tqCB3Io10iVXy7YcWdsEYTzcRatgBux/W6z88X3y6WJ60+f2+3lLHfd6lpb8SmWUxblQQYv6Hdq8aJsZQIvQ/gGJ+iRs3IY5allZTxAlx6VpyRT3LmE5/RC+JaMUXynh4mylAeFd+QD6knOb/umspfc+Hb2ykJpPQTJhnjJo0OoxHrtmeO/aoZ2EExvDWGG5sMhvVrXTRbI864z5UMmyE2MsHb23+fmsFs0ObthQJujnKkMnaWCKc/cGR1P1+q1UalSgejhGS67yoZ8tC6JXZKuNMPx1UFXw/d4BC/etHG/6CEh6dFQuwx2wIEU+JyyL0NNww/aozONZvRSLvUzJPjtuFoMPawRs4v9QIe8WILbj4Q==;5:ZCIcBl2aj66joBjrgo/GAuqplf1hDZe37HuZ7Ze7fxNiQIqwfkzCECTIXp/Wh6wb2f7yLcfTJDaxvVO3g+YrzTR0WXYKUyWP00bOtpQjVVH+2k2GmYz1aWACeDv9pKHyI5NqwNI1H+VndCXm6qP4y9Xq1PMEiZE1169xbbXaxcU=;7:KPHXMwCo8VKYhcjwWlb8gW1eDpdK+zYiBJzRIQyiuUX/UhcVm+LUExIH6O94iag7yYHNJSn8Qqw23jPlnoQ7z7eVk2LHkUKEJdduAksI1XgkHGuYA/09S9KZh998972PxL+kT8sA5lNrk5c+LWEtSriMb+KvY8Cy0VPVQ+SE/WddmefeyqEn1HKlI4H7WR6ui5FMF7/3btPwbSg5uMi1nO0qPrP2OEbRuyopUl64aoJOmzXOdf4AvMU4NorCb2Cw
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(13464003)(189003)(199004)(110136005)(54906003)(2900100001)(5660300001)(76176011)(7696005)(25786009)(478600001)(966005)(72206003)(53936002)(33656002)(6246003)(2906002)(6436002)(6116002)(3846002)(316002)(229853002)(6506007)(53546011)(4326008)(99286004)(55016002)(9686003)(39060400002)(6306002)(7416002)(256004)(68736007)(486006)(11346002)(476003)(446003)(26005)(102836004)(74316002)(305945005)(2201001)(8936002)(86362001)(8676002)(81156014)(81166006)(71200400001)(105586002)(14454004)(106356001)(71190400001)(2501003)(5250100002)(97736004)(66066001)(7736002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB417;H:BL2PR02MB2130.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 50c1ba78-a637-4fc3-99f5-08d62edfcab6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL2PR02MB417;
x-ms-traffictypediagnostic: BL2PR02MB417:
x-microsoft-antispam-prvs: <BL2PR02MB417ADF03A684337603849B4B8E00@BL2PR02MB417.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(7411616537696)(180628864354917)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:BL2PR02MB417;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB417;
x-forefront-prvs: 08213D42D3
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SzNd+bCmW3UYtvk2ZhCuS1um/k70372jqv71T9fpMJV6M3+dbrV/xso1mAT35sT0FuSUxJxnzOZguFtryqm1NbZjTLZiN5zNU2DSJu2990Xe29EFN4HAc2WAmE7Qdda9gUJ7LsiFAujHd86ZBedOL+TYA8XKEXOOU1tkKh6H63ue8tzfd7bVnLPrWRREBJc+6Gsn64nAaoxNynp2jF1trQlaZOCM5VtWUqBidLpoAhlBvmWdi8lgiSOo+S1OFayt2EeLdzJJFreo70kGICLJ6RvQnTBrJdqHtc2rcTZj0R8aXO3Yih201dmefOiE94k0kYstkibABvask2IM2NYzFn2vzGQ7F2j4/+Vay3mUmz4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c1ba78-a637-4fc3-99f5-08d62edfcab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 18:40:03.1303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping for comments


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Jolly Shah
> Sent: Friday, September 14, 2018 12:40 PM
> To: matthias.bgg@gmail.com; andy.gross@linaro.org; shawnguo@kernel.org;
> geert+renesas@glider.be; bjorn.andersson@linaro.org;
> sean.wang@mediatek.com; m.szyprowski@samsung.com; Michal Simek
> <michals@xilinx.com>; robh+dt@kernel.org; mark.rutland@arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; devicetree@vger.kernel.org; linux-arm=
-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM d=
river
>=20
> Add ZynqMP PM driver. PM driver provides power management support for
> ZynqMP.
>=20
> This patch series is based on top of Xilinx firmware patch set:
> https://patchwork.kernel.org/cover/10598195/
>=20
> v4:
>  - Minor fixes to address v3 review comments
>=20
> v3:
>  - Updated DT bindings as per v2 review comments
>=20
> v2:
>  - Rebased on top of latest firmware driver patch series
>  - Updated driver to use shared interrupt instead of mailbox
>=20
> Rajan Vaja (3):
>   dt-bindings: soc: Add ZynqMP PM bindings
>   firmware: xilinx: Implement ZynqMP power management APIs
>   drivers: soc: xilinx: Add ZynqMP PM driver
>=20
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     |  22 +++
>  drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
>  drivers/soc/xilinx/Kconfig                         |  11 ++
>  drivers/soc/xilinx/Makefile                        |   1 +
>  drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++=
++++++
>  include/linux/firmware/xlnx-zynqmp.h               |  20 +++
>  6 files changed, 261 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
>  create mode 100644 drivers/soc/xilinx/zynqmp_power.c
>=20
> --
> 2.7.4

