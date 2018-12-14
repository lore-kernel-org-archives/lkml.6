Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47724C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94D220675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P9JHmook"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbeLNOoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:44:38 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:61664
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729808AbeLNOoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/+VNbSLJtlc15Ftbl7eK/AqdOGZkKbFN5VSCo7ommU=;
 b=P9JHmooktOOMmDkmcoEdMur8IvV5RIK6GH4JCeDDQ7I/iqm1DcqZHdtC3D8sZz+jhsVOCJKDMkvtcILjohgo49K50Tq1iJUIUwCOIV5oklxQHWGPlHAHxNHJ1dAH0RYMEENVLxdDAjeoSBuOseU0FsV1TAqGQHKZu+hbjFErHgA=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB2911.eurprd04.prod.outlook.com (10.175.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Fri, 14 Dec 2018 14:44:34 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::e4fb:858:afdc:c40b%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 14:44:33 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>
Subject: Re: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Topic: [PATCH 4/5] soc: fsl: dpio: add a device_link at
 dpaa2_io_service_register
Thread-Index: AQHUkKhvJjp2Ah0odkm7dsNjIoy7zA==
Date:   Fri, 14 Dec 2018 14:44:33 +0000
Message-ID: <VI1PR0402MB3485C4800D690B2A27FAF04098A10@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <1544460591-14888-1-git-send-email-ioana.ciornei@nxp.com>
 <1544460591-14888-5-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB2911;6:Yh7y5Iss1X3Qwqr6pM9xoyTdK517kXgC8L0Neo+WA5tPU2iMZCUZ+x2KXLi6PSXHIhJ/bpkqQTXdN6cDXW1A92r6PFfhVYDH3kgrBV57yoZgPDWnxSvvkgS+Vw3U4zLU97p4Z7Rlrhf6LHW9Of1kJBuyKgGATuodl8h3bgzYgYIwg7XmJdRMZROSHNE+uN/v0JQl+S+zFJJWWzFckVrUDRXsr10Kg3uSLV0afAbT2xnpxMUwZ6DMpT9hnecNuKQyrWXGvmE5YpBOhvNABr2b5A1Jb+HFmdB0CLXxImn7DcZYtUcMFKCMsg6IH924JyZee13gxu4DViXjNBGRIw9pTJg7RVAVIOgDrJV2fkyeaF8zLwQ6r2UI8G1oSVV/3OEwqTkRz6T3bo7tG+Xa2KrmcDymg5T3uG7PDmRR67e/y/pOwYaxXjF3kScM/8LFH3LyJlWUWLssUqnsfYGfFQt7Vg==;5:jyiu9p7t36EKS6F8PQRNRNT5dU3GAc1bf4S2i4MjiYc510LIEx6arhX0wSrZEJuVsbouU578nDMSVSIYBIqJiN2ocSPz7CDpgCMxa57qwVKl8QMV/gukInHPZcaqxEo46OJA8Asit6e4ymme+JWf7s2gFMfVTQgpk4oo7yS4nxY=;7:DbPrur6GPKqCEcZXBE+TIalAQRNaK5LUERqxrSWmYV0Tt6ghwRtru7ZO3wwnG7plljKxLadStQGKEMKTu+XbIRJLG9+Cpz8rVisJo6+bjMgK/TWHecvYj+Khql99mR6PU5qOtZ+ip845ByMpD/X+GA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7884bc1a-d0b4-4ae9-e4de-08d661d2a9ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2911;
x-ms-traffictypediagnostic: VI1PR0402MB2911:
x-microsoft-antispam-prvs: <VI1PR0402MB2911B8B98FF9FD27F2C5F9D698A10@VI1PR0402MB2911.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB2911;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB2911;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(53936002)(2906002)(106356001)(229853002)(446003)(305945005)(6436002)(74316002)(6246003)(2201001)(97736004)(86362001)(478600001)(8936002)(110136005)(316002)(7736002)(26005)(4326008)(53546011)(2501003)(54906003)(76176011)(6506007)(102836004)(186003)(71190400001)(68736007)(71200400001)(81156014)(99286004)(33656002)(8676002)(66066001)(81166006)(14454004)(256004)(55016002)(3846002)(6116002)(105586002)(44832011)(5660300001)(9686003)(25786009)(486006)(7696005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2911;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x/cpXho3qIVqO7ttwQrV6xBB5RvS3v744XWiiM2Lf+cOGc1UainhIE/88a6cGu0iaWLvJetSMrX4rBZbIYQs72iSOAYKbT5dHvOSxSGjPWqVOiwnZriaXKTz5o6Klr2DgsylMrQINu13Lrp6Wt7Ll37ggfwHr/yxSEdec1UmydmHH/5pygl1ERljOOZYmQ+zLWOKD6AluLHDzFSjcljZBS7riCv6V+5cMvPVo+pq1pKMpZfBUhEw2yCeD4NTaDCz97U3+snzwYg3eSNMLk4W6WR4Q+gGxJfnQa6UGQyRjMR1FCSWjIHe0QQ+SuBRTsUU
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7884bc1a-d0b4-4ae9-e4de-08d661d2a9ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 14:44:33.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2018 6:50 PM, Ioana Ciornei wrote:=0A=
> Automatically add a device link between the actual device requesting the=
=0A=
> dpaa2_io_service_register and the underlying dpaa2_io used. This link=0A=
> will ensure that when a DPIO device, which is indirectly used by other=0A=
> devices, is unbound any consumer devices will be also unbound from their=
=0A=
> drivers.=0A=
> =0A=
> For example, any DPNI, bound to the dpaa2-eth driver, which is using=0A=
> DPIO devices will be unbound before its supplier device.=0A=
> =0A=
> Also, add a new parameter to the dpaa2_io_service_[de]register functions=
=0A=
> to specify the requesting device (ie the consumer).=0A=
> =0A=
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
