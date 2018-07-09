Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BF2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864482089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RQA4Ki2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864482089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933480AbeGIPXp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:23:45 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:18826
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932898AbeGIPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2tohz2KZ5jiiwuNBNdx+HygI7TSSN89ASej+7wu01w=;
 b=RQA4Ki2y95K2aqU5ktx691Kao1WZGEmaP0v9cfc4UhALx1ELSHWu0it8CaBH6lpDEQlUzZWM1yuHE+/I3xVF7yCUV8HVfDHqlcgUtZ2POlfiF1hy2IcZEvPk81GD3nx6GfpNQ04F/JKWNUkPAy3Ll+4hZzkpFDV3IOXzk37ZnXs=
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com (20.177.54.85) by
 VI1PR04MB1199.eurprd04.prod.outlook.com (10.162.121.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Mon, 9 Jul 2018 15:23:40 +0000
Received: from VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::9089:9970:7f16:8cfd]) by VI1PR04MB4494.eurprd04.prod.outlook.com
 ([fe80::9089:9970:7f16:8cfd%3]) with mapi id 15.20.0930.022; Mon, 9 Jul 2018
 15:23:40 +0000
From:   Roy Pledge <roy.pledge@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH 1/2] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUFJguns4FeKPlNUC4EOaWb3eQ3g==
Date:   Mon, 9 Jul 2018 15:23:40 +0000
Message-ID: <VI1PR04MB44942CF2B2E5BA1C6CE8D17786440@VI1PR04MB4494.eurprd04.prod.outlook.com>
References: <20180705194113.16256-1-roy.pledge@nxp.com>
 <20180705194113.16256-2-roy.pledge@nxp.com>
 <119c6fc6-a32d-45a5-96ea-f6e9959b1e74@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [72.142.119.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1199;7:1QpkQkFbr7+kdVtsjRnRljijJPFI6uQc1QsIGH5cjlb/J4+gn7j47GN9/UdtOOj1HR64cbJt60qSlTadN8UPQGXA7Zyi7T5ozVUcENKeOpPkZyEEy/yH3YhxuVX/75UukbKKKGX4uaaAMfYqMxZiAyXbvhjenokTlMdUKTYRHSN3Gazw/1Na7qjM3YKp7Z77YFZ0zRl5aTgCpSG7SjT/oQirg3ctu4Pioh6JtC/nyQc2/ySQUyQCwzO5ZaJ51DWn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f67047de-80b0-4dd0-6397-08d5e5aff32d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1199;
x-ms-traffictypediagnostic: VI1PR04MB1199:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com; 
x-microsoft-antispam-prvs: <VI1PR04MB1199C38EDF654D171FE2038B86440@VI1PR04MB1199.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1199;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1199;
x-forefront-prvs: 07283408BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(8676002)(256004)(76176011)(66066001)(6636002)(478600001)(316002)(105586002)(6436002)(5660300001)(97736004)(55016002)(2906002)(68736007)(110136005)(54906003)(14444005)(4326008)(2900100001)(9686003)(14454004)(5250100002)(86362001)(476003)(3846002)(53546011)(6506007)(44832011)(33656002)(229853002)(106356001)(305945005)(6116002)(81166006)(2501003)(81156014)(53936002)(102836004)(99286004)(6246003)(74316002)(25786009)(8936002)(26005)(7696005)(7736002)(486006)(446003)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1199;H:VI1PR04MB4494.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6nBfdZo0XPuUKDlUcpQgxUMSFC0X6cuD6v5NnkvHfhLItJ0xun4zEnQhR2UdLwMLAL4AWFMWSgjgQjjXbWbYSqS4t3EbAe8e04QUrTwbOYX88TpSjykYpgYxJ7QYT6e2WaBr7v0J4iAKFM6uHvvEWNIO7jhfEy2/y5FsScA7YCaoXiWUiKiwwE2WfHNooRYOhdGvy1oN3bGqcPPWDPaGWVemA1AdVFDADFPyKLw68QcIyZh0Z3WNye70vks+z594xvZgIU+BQ6tx7oq1oOy5Gd2rZA5Og3A40meMSXez3lA++BB9ymleDbP6LzqHGcw4zmRI+sz84SbWaCzLDhcj+6sZFEJCPZvGcstem2gz6Os=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67047de-80b0-4dd0-6397-08d5e5aff32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2018 15:23:40.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/2018 6:37 AM, Laurentiu Tudor wrote:=0A=
> Hi Roy,=0A=
>=0A=
> Couple of comments inline.=0A=
>=0A=
> On 05.07.2018 22:41, Roy Pledge wrote:=0A=
>> Move the NXP DPIO (Datapath I/O Driver) out of the=0A=
>> drivers/staging directory and into the drivers/soc/fsl directory.=0A=
>>=0A=
>> The DPIO driver enables access to Queue and Buffer Manager (QBMAN)=0A=
>> hardware on NXP DPAA2 devices. This is a prerequisite to moving the=0A=
>> DPAA2 Ethernet driver out of staging.=0A=
>>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>   MAINTAINERS                                                    |  2 +-=
=0A=
>>   drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-=
=0A=
>>   drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-=
=0A=
>>   drivers/soc/fsl/Kconfig                                        | 10 ++=
++++++++=0A=
>>   drivers/soc/fsl/Makefile                                       |  1 +=
=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile          |  0=
=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h        |  0=
=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c     |  2 =
+-=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.txt   |  0=
=0A=
> Maybe this should be converted to .rst and go in the already existing=0A=
> Documentation/networking/dpaa2/?=0A=
=0A=
I can look into converting this to RST but I'm not sure it belongs in=0A=
the networking documentation folder since=0A=
it will be used by other non networking drivers in the near future -=0A=
compress/decompress for example.=0A=
>=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c    |  2 =
+-=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c            |  0=
=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h            |  0=
=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c    |  2 =
+-=0A=
>>   drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h    |  2 =
+-=0A=
>>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++=
--=0A=
>>   drivers/staging/fsl-mc/bus/Kconfig                             |  9 --=
-------=0A=
>>   drivers/staging/fsl-mc/bus/Makefile                            |  2 --=
=0A=
>>   {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-fd.h |  0=
=0A=
>>   .../staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-global.h  |  0=
=0A=
>>   {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-io.h |  0=
=0A=
>>   20 files changed, 20 insertions(+), 20 deletions(-)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile (100%)=
=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h (100%=
)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c (9=
9%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.txt =
(100%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c (=
99%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c (100%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h (100%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c (=
99%)=0A=
>>   rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h (=
99%)=0A=
>>   rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-fd.=
h (100%)=0A=
>>   rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-glo=
bal.h (100%)=0A=
>>   rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-io.=
h (100%)=0A=
> I received feedback in the past on mc-bus that a driver should limit to =
=0A=
> only one public header and one private one. Would it make sense to do =0A=
> the same for dpio too?=0A=
Looking at this the dpaa-2global.h file should probably be integrated=0A=
into the dpaa2-io.h file. =0A=
The dpaaa2-fd.h can be used by devices that don't need to used DPIO -=0A=
the definition of a frame descriptor=0A=
isn't DPIO specific so I would argue it should be kept in a seperate file.=
=0A=
 =0A=
>=0A=
> ---=0A=
> Best Regards, Laurentiu=0A=
=0A=
=0A=
