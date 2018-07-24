Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7757C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s+t3jJVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7757C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388730AbeGXPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:41:59 -0400
Received: from mail-db5eur01on0073.outbound.protection.outlook.com ([104.47.2.73]:54784
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388373AbeGXPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQmrkn+xqWRJpUyQ7kOMoOCi/0VTufhJ5eGVcbfZvY8=;
 b=s+t3jJVLVADSqKm7vH05nkJNLg21wjxbfVw0z6CTAUOARH7xRxL8BcL8UEmoAIXi0dJW2Y2pZ2M49BRlsu8zcKXK70r2Fhe+32t6y7E8Vn3IJtLKdldGoJPGpQaOZSB/SNXFxzZwyWaBkojIXj4b622A1bOr1E3W5TRmt+TlHDA=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3901.eurprd04.prod.outlook.com (52.134.17.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 14:35:09 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::197e:c4f9:bb4d:e560%2]) with mapi id 15.20.0973.018; Tue, 24 Jul 2018
 14:35:09 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Subject: Re: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Topic: [PATCH v3 0/4] staging/fsl-mc/bus: Move DPIO from staging to
 drivers/soc/fsl
Thread-Index: AQHUI1mrEl9vWR1sTE+GgmvQr4KFqg==
Date:   Tue, 24 Jul 2018 14:35:09 +0000
Message-ID: <VI1PR0402MB3485147A99F219D5FA1B668B98550@VI1PR0402MB3485.eurprd04.prod.outlook.com>
References: <20180724142131.28970-1-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3901;6:2vA/HLgDWPqzYWKINhYDSKMkDSf69YNI+V6XLr4Wub+L2IjyD8OUBjMdTl/f6iDGWKrMrYvldt/krhN7QJtoYnwuoj+7Tf3DYqfmEWgDyRT7iwGUY6lKMqM7DvRZaBsB1aqVkGhNsGn0uOBRYSRXH6CBDkNC2v13spwiBC3m29K5w4KLZkAXmQhSBJPfEg65nhqNlJMdpTylFYu2QpYYEhfIW5zUO0ciWzOHq52zXufjZ/9MDKaG6XhQjd8Lt2dK3LhRbHUbpBF6w2GP8BlPDe8/BXeX72jITZhDqLOyEkBP5HoA3wvkUUq8L6/43tfd+ohW0Lpc04DjJ0TiGDV1LIYeqtJv3IAgXyGpAr5FO2o6vAqZ15fxmBVYPs9v6IH21BItR+muVlugUxDRcTv8ikp2daW9FrKLeFtziO7keFvvQtf2fPpPf462aVB+YwsU6j3S4+Xu84hNwyXG+2q7ZA==;5:19aaJ9QRI7l1VbKgqZ0rGoVndE4Z47MZHKr8n8sZoiesQkNUA7zuVw3y6oB4Smy39pwSG75KysxXSXeadf5nt3HYEDJdsbDLa9KO6T/+Z5DPKfFq84CIEVtg3tZ18eS/pszonSO2cWRYFyjY7Zxbh9aCKka2uZyMhA5BrqlEoqU=;7:h/zPcb580G6Ltqmn5RVxdg/WTYVSRPUyXr1dRblbw3rJjvsMUzIwsw8mOVegGUAfBMzoQOBfzPr/53RTUDSxeY6SA6p2GY1Xm7ZCeFFAmfjAqUVKmJD78HK3o7xXNRTvgmkvEAhLA8j9zAIj/rERbdexgnORMtKgyzr0IU6yri6OKde+oug7SSdana7lET5/YYJ8ReD+VRfMy7TNlniSJYsMHMYHrxAQUxuUekd6GXbRmSHM7bmnhEidCO9CxAMu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6193e5ca-dba2-478c-856c-08d5f172a88e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3901;
x-ms-traffictypediagnostic: VI1PR0402MB3901:
x-microsoft-antispam-prvs: <VI1PR0402MB3901424F57983936C01A9CBB98550@VI1PR0402MB3901.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0402MB3901;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3901;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(189003)(199004)(256004)(14444005)(66066001)(478600001)(53546011)(6436002)(6506007)(5250100002)(25786009)(33656002)(26005)(102836004)(99286004)(229853002)(7696005)(2900100001)(316002)(5660300001)(3846002)(74316002)(55016002)(6636002)(2501003)(97736004)(14454004)(54906003)(8676002)(8936002)(81166006)(81156014)(6116002)(110136005)(2201001)(305945005)(106356001)(7736002)(4326008)(6246003)(68736007)(2906002)(446003)(53936002)(76176011)(476003)(9686003)(44832011)(105586002)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3901;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Rm2GAcYhykwGvEy05Af0nmNS7w2xyxkYNZC2jfOHNJNhjdkTHeJ173ete1p+sZC3x4HxKE3sjh49piB0vYdEbclZFKd6k+j3dH6cbWMRXb0PcEL02Nv6kK1YuMig9PQNrO3kdrst0ZV1D/jTaamywYJe6B/pGghd26qdOOrGPn2n7qp9B+OoE0SFmclPLcz2U2tx2eOjqp5z+wLaCwLYz94+OHd78EA7xqYvZiG9QmPIR9B7qCGsxgW3Jwngz6I12Wulx+Mc1QgDcp+S3vBQKlX1KhERl985lQGLvVaz+sDSMi6CwTgkgRhLXkAxbSbkaBlKCbT3X5v2ySKWn0svc8iqXIceQa06NKkT5cPtpro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6193e5ca-dba2-478c-856c-08d5f172a88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 14:35:09.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2018 5:21 PM, Roy Pledge wrote:=0A=
> Move the NXP DPIO (Datapath I/O driver) from the staging/fsl-mc/bus/dpio=
=0A=
> directory to the drivers/soc/fsl directory.=0A=
> =0A=
> The DPIO driver enables access to the Queue and Buffer Managemer (QBMAN)=
=0A=
> hardware of NXP DPAA2 devices. This is a prerequiste for moving the DPAA2=
=0A=
> Ethernet device driver from the staging directory.=0A=
> =0A=
For the series:=0A=
Reviewed-by: Horia Geant=E3 <horia.geanta@nxp.com>=0A=
=0A=
Thanks,=0A=
Horia=0A=
=0A=
> Horia Geant=E3 (1):=0A=
>   staging: fsl-dpaa2/eth: move generic FD defines to DPIO=0A=
> =0A=
> Roy Pledge (3):=0A=
>   staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl=0A=
>   drivers/staging: Remove fsl-mc driver from staging=0A=
>   drivers/soc/fsl/dpio: Convert DPIO documentation to .rst=0A=
> =0A=
>  .../networking/dpaa2/dpio-driver.rst               | 29 ++++++++++++++++=
+++---=0A=
>  Documentation/networking/dpaa2/index.rst           |  1 +=0A=
>  MAINTAINERS                                        |  2 +-=0A=
>  drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-=0A=
>  drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-=0A=
>  drivers/soc/fsl/Kconfig                            | 10 ++++++++=0A=
>  drivers/soc/fsl/Makefile                           |  1 +=0A=
>  .../{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile  |  0=0A=
>  .../fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h         |  0=0A=
>  .../fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c      |  2 +-=0A=
>  .../fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c     |  2 +-=0A=
>  .../{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c    |  0=0A=
>  .../{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h    |  0=0A=
>  .../fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c     |  2 +-=0A=
>  .../fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h     |  2 +-=0A=
>  drivers/staging/Kconfig                            |  2 --=0A=
>  drivers/staging/Makefile                           |  1 -=0A=
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     |  4 +--=0A=
>  drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 22 ++++++----------=
=0A=
>  drivers/staging/fsl-mc/Kconfig                     |  2 --=0A=
>  drivers/staging/fsl-mc/Makefile                    |  3 ---=0A=
>  drivers/staging/fsl-mc/bus/Kconfig                 | 16 ------------=0A=
>  drivers/staging/fsl-mc/bus/Makefile                |  9 -------=0A=
>  .../fsl-mc/include =3D> include/soc/fsl}/dpaa2-fd.h  | 12 +++++++++=0A=
>  .../include =3D> include/soc/fsl}/dpaa2-global.h     |  0=0A=
>  .../fsl-mc/include =3D> include/soc/fsl}/dpaa2-io.h  |  0=0A=
>  26 files changed, 66 insertions(+), 60 deletions(-)=0A=
>  rename drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt =3D> Documentatio=
n/networking/dpaa2/dpio-driver.rst (95%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/Makefile (100%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-cmd.h (100%)=
=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-driver.c (99%=
)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio-service.c (99=
%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.c (100%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/dpio.h (100%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.c (99=
%)=0A=
>  rename drivers/{staging/fsl-mc/bus =3D> soc/fsl}/dpio/qbman-portal.h (99=
%)=0A=
>  delete mode 100644 drivers/staging/fsl-mc/Kconfig=0A=
>  delete mode 100644 drivers/staging/fsl-mc/Makefile=0A=
>  delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig=0A=
>  delete mode 100644 drivers/staging/fsl-mc/bus/Makefile=0A=
>  rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-fd.h =
(97%)=0A=
>  rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-globa=
l.h (100%)=0A=
>  rename {drivers/staging/fsl-mc/include =3D> include/soc/fsl}/dpaa2-io.h =
(100%)=0A=
> =0A=
