Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE68C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBCC20867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wld3TW2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBCC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeH2QDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:03:25 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:42880
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727264AbeH2QDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+39+Z/e7+ciTlp8T67xm+nhKqjt41reLyrqj7JUgnY=;
 b=Wld3TW2n+mh6SDkuE/puya9x6E2RnjQtdQrFJvGIkjP66BW6izMAON+U/oXWc8qaxlucvIUcXRJ9Osp1CUt7G1UCOamVsitMXpNl7wL1m3kqZYR8aLYaKRy4KwgkBX+AzPrSHvjFu+lvu+9JGAU5ItGVqXStfVYKRxsnf2+7BKo=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB1267.eurprd04.prod.outlook.com (10.163.6.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:06:45 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::588d:b603:b80a:5785]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::588d:b603:b80a:5785%2]) with mapi id 15.20.1080.015; Wed, 29 Aug 2018
 12:06:44 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Horia Geanta <horia.geanta@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
Thread-Topic: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
Thread-Index: AQHUP3yvN14e//Sc5UuuWanXRNdTCqTWkgWAgAAC1NA=
Date:   Wed, 29 Aug 2018 12:06:44 +0000
Message-ID: <AM3PR04MB338A141EDC007FF47B510C094090@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
 <20180829110739.3xzbdtelwjlhun2v@mwanda>
In-Reply-To: <20180829110739.3xzbdtelwjlhun2v@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-originating-ip: [213.233.88.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1267;6:2XWjtoe3nTIMvcWwLKF9qW/xx2XUMUZH+4WPZbqgiPFa3y2er2gYdxsie81daKiUbPLf7PxRJzkX6m+Xe6seTlLOmIKVo6KmlBVZcXUS0mI3ox7Bbw0Yyp4osPBveb7mH7JSa61aGthWNa9OlfxjZD1zksdzCRnLq20QoEaDWeAPeP4RasGa26wAbyIWc2IDaLzmE+7WkhqVzAWjfX+8F6EjbAOBUqXEMlhXoFa1X/W8CfJdhsCx3bHZlj/al04wUK1kgbD73mLRjBaDu5yzoak+R+1TR02iGPwGLrvmMvoF5Q3dXgaSBOXDvjmOtMCah0b6cPejqSgngcWe9euqM+SHkQmDS7e1Id0oDb8yCW//kzqZvIXX1+fbdurG/GzZCLvKjZfo/L5KevEews29Bi1LbJaIoEP01lcTVQ3L+yWTU+37rNWODrb/1PsRxIqgzZbzOQVafIv0qgZwurVl/A==;5:KGQZ7ww+dp6MQ1HLb49sNE9XnT1Z6tThEwP/H6lC70kSgOv7r+l/L2HZlV65xPrHJo133+6d9d6vcfiWhqHwlHYIYyYVK6vnGhgqtBS85zEnFk1fBUgvWvBzpocsGR+Zd5bXrygzal5R24Tt41ZrMrsJpLbBscR/9EIRHWoXLbg=;7:Ul2NgMvm+LOZOMvRDoNhhEA3wL6UVQeAia7BEddDRJd+wdMR8NHXzvcLrLGcNfSr/KVuvK7aoh171FFzX6tZ1HDkLKoIkwFIF6cmP2G7kinfXmVdCACSpStkCycqxvdkZgBrxXQBFmnRrum0whqc47WQsNSkU5/bTQH8q8qslR11qblyJIKnIgpu2s5i150IIXKlfV6yAknlcKUPyBFbxDHfcDYEpZ2t2Liet0uCX+RRdZOzYVSX0VrLk5dN3dbX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c0441d08-ebcd-4573-595d-08d60da7e3a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1267;
x-ms-traffictypediagnostic: AM3PR04MB1267:
x-microsoft-antispam-prvs: <AM3PR04MB12673B499009C5120D428BB394090@AM3PR04MB1267.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:AM3PR04MB1267;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1267;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(13464003)(199004)(51914003)(68736007)(6246003)(186003)(9686003)(8676002)(55016002)(26005)(102836004)(4326008)(478600001)(74316002)(6506007)(7736002)(14454004)(25786009)(53546011)(305945005)(5250100002)(33656002)(2900100001)(53936002)(81156014)(316002)(97736004)(81166006)(54906003)(8936002)(86362001)(99286004)(66066001)(3846002)(229853002)(6916009)(11346002)(476003)(106356001)(2906002)(446003)(5660300001)(486006)(6116002)(7696005)(256004)(76176011)(6436002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1267;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H8apcstvgVnjFs09NNU7bNpDnc0VPvwhekcVbyEVEwb51K2MtUuQlPrJLWevYBB+ip8i00vf3sW7Ezoq0qmUA/aBcH7Khh2WzYdo/hE4r7kEGM8r2bgDgNmcfUEj/bwQuhsOiY6bpUzHwj23yRVKz5FVuNyvCNV3swx/c8Y3BuStpbQfHQKU30oLMM77IGyEhaJKFUU898fWHOFgzQF900O5LjRMRjUeuV2hCzz+FJMswDulTwAIc9UZHAsC54LqMEZMdIdrVoWezTWKqaOqhdmeD0588Wfv2gCcxtNFI4gyOmWsa/1AOBBThz0s3xxx5mPAz45kTP6+CfkByYkhure8zIQqr6Mw+jZXmlIaJ2w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0441d08-ebcd-4573-595d-08d60da7e3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 12:06:44.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1267
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, August 29, 2018 2:08 PM
> To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net;
> devel@driverdev.osuosl.org; andrew@lunn.ch; Horia Geanta
> <horia.geanta@nxp.com>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; Ioana Ciornei <ioana.ciornei@nxp.com>; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>
> Subject: Re: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet
> driver
>=20
> There are a few static checker warnings for the driver but only the
> first one looks like a possibly real bug.

Thanks for the report, what tool did you use to get these warnings?

>=20
> drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c:1116 dpaa2_eth_stop()
> error: uninitialized symbol 'dpni_enabled'.

Will initialize in v3. Not actually a bug, since it's used only as an out p=
aram.

> drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c:1671 set_fq_affinity() war=
n:
> 'xps_mask' puts 1024 bytes on stack
> drivers/staging/fsl-dpaa2/ethsw/ethsw.c:742 port_vlans_add() error:
> uninitialized symbol 'err'.
> drivers/staging/fsl-dpaa2/ethsw/ethsw.c:886 port_vlans_del() error:
> uninitialized symbol 'err'.

The dpaa2 switch driver is not targeted by the current patchset, so I'll fi=
x these
in a separate patch on Greg's staging tree.

Thanks,
Ioana
