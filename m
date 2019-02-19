Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1445C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4318217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Sx8ZvC/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfBSEAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:00:18 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:32462
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfBSEAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un3mQYPMz55g1YndHs7PQZERw/ex9kbSionblgCbXzI=;
 b=Sx8ZvC/YbFmvokuczsbHVzHEV3rqVd5Lx2xBgT989owSTkjzKDIK+f3Dq2dzdHDckJoHfWVwaNxE8HarNLJ1tcY2OXU7PUsCoUXaPFg7CuMpDLAzrQY6v5vdrV/Z8tMN32ut+WRXOrPZbDBEPCuTM74vWkJo3496ek0OpcHEQfw=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6332.eurprd05.prod.outlook.com (20.179.41.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 19 Feb 2019 04:00:14 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 04:00:14 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined reference
 to `__user_bad'
Thread-Topic: drivers/infiniband/core/.tmp_gl_uverbs_main.o:undefined
 reference to `__user_bad'
Thread-Index: AQHUxzuB7RlmTvCP6UKI9lHONSr5EqXmgLyA
Date:   Tue, 19 Feb 2019 04:00:14 +0000
Message-ID: <20190219040007.GC738@mellanox.com>
References: <201902181136.npHNYgNH%fengguang.wu@intel.com>
In-Reply-To: <201902181136.npHNYgNH%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:300:6c::33) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8afb9f51-9268-4ed9-d0ff-08d6961ec095
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6332;
x-ms-traffictypediagnostic: DBBPR05MB6332:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6332;23:WAUxCmiB1iiP0zHn+p6r0wvUf1M+QLVoAhDQuYv1t?=
 =?us-ascii?Q?Brv+rDUf6tofctP+xpkRIEriW+z+il1hw8TfA3mUIInhWbvWmvLs7srNQsSP?=
 =?us-ascii?Q?FnFwzz+P7O6VoWG9UiHtR3vx5mg4uvzo4aT6ZSl4GaU/ay8YFY40AopCpZmO?=
 =?us-ascii?Q?sl+9cn/hE9cB8E9POM+NdPKxUqj+E2akS6yKm/cvZq/w3qKdpeHA3rzBjF2u?=
 =?us-ascii?Q?w7ZHhWqh3Ld3Lw9kfbyDzxUpp44tvGUqRe/lRO0B/HZGB/annWKR8UAXfjsZ?=
 =?us-ascii?Q?3E3u+giJD1VjMNea0xHfKvSs6kEiyFOXzQTqlU31OajE+K0pvA4fTsTz+ikQ?=
 =?us-ascii?Q?VycLcXFhuPIii7sVxAywsXZMuhKLxcmpmClZ2NbEuKglNTj9Xa3WMA4Pyx6R?=
 =?us-ascii?Q?W+GgwNiFZZv2ji0a3FA/bz8Oa0NuwcDJpfKNCQOhhGkVi5CAkUDqwunYHJIs?=
 =?us-ascii?Q?vQkVtrvCknkq5yCSjADfe7+htSq84/PM7nF9xbpUpZa2ACxKGCxc4k22RYN6?=
 =?us-ascii?Q?U2wZfE6A/Z2i5ndvHIdE/X2wyay3u6YWuuk+0vVEPvsCgS+Fz5AIVE6DSngD?=
 =?us-ascii?Q?M0sEtHoxcrs4vNym+xpoe4eTayZpWRecK3llJmPE7K4WB6GIdWsC3uRVuHeW?=
 =?us-ascii?Q?TQreIZ0feAEZpIo42DWEarUzZuSr1zXb1NrIVy7RQd4y0CgsN6KcVuAKPXBB?=
 =?us-ascii?Q?GyopbXTJ9f9PTqOacqy6qZ6A6T9lmmSCNeogJuQSwMfWko6Ys/rXt5vUZ9H3?=
 =?us-ascii?Q?zPpooVHoA3w0Af5AVCPYEqRy1NxhlB7j7FyMbES2NDLWB6dpoXZQtqUM2R8P?=
 =?us-ascii?Q?RLpCspowrSZrhxZwzFtsMh0qrci1td0JnMDenzhjO7EtUtNHx4zZ9sKaGloh?=
 =?us-ascii?Q?v6a3f6pvOY+NvBN5e8fig8q0ZuEYkUc2pv1uUpjy4xZjwsI5iBGhBq13lFwN?=
 =?us-ascii?Q?QD2dCjZ+q3+Y5knAqM/TnH2o+NVQLgXLcdqHVsed5WigI2FqmpfUYdsaGKtd?=
 =?us-ascii?Q?xxj6hjS9kLTNgqIg61qfHMeYiRPRFxompKZ36+89ZtVMb+oLlGC4ORiMoWRg?=
 =?us-ascii?Q?uDrm9iRuPc163Gr7GcsMT3mdwD6lfzw3NKYZbM1lJQb433bRnaP+pRi0nQQl?=
 =?us-ascii?Q?kETpLeDel6zaUHV6OO2DiTdKzsKgr85Hmjnifxxb9RBum0IKcL+MwfFGbdmt?=
 =?us-ascii?Q?TXayMRE5/wi8mZPWV1QNdCWoRpQmqf2kf4X9moGwyUyeBCqD2N40AqD6AD1n?=
 =?us-ascii?Q?Rx10dcHX5L9VajSiX2a/soQHjsPiZMvuvFQfm++Q3FJysZCaQSVgfuv338SR?=
 =?us-ascii?Q?tf8Q/qAVA45avoKK8NCKZ4=3D?=
x-microsoft-antispam-prvs: <DBBPR05MB633242DA8F4425196974489DCF7C0@DBBPR05MB6332.eurprd05.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(99286004)(68736007)(107886003)(53936002)(446003)(6436002)(36756003)(14444005)(2616005)(5660300002)(14454004)(6506007)(3846002)(106356001)(6512007)(8676002)(33656002)(386003)(102836004)(52116002)(558084003)(478600001)(6116002)(105586002)(11346002)(6246003)(186003)(66066001)(229853002)(81166006)(25786009)(305945005)(97736004)(2906002)(54906003)(6916009)(476003)(26005)(486006)(1076003)(8936002)(81156014)(316002)(71200400001)(71190400001)(7736002)(76176011)(86362001)(4326008)(6486002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6332;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FeG0MANlnm5R3XkXny48VlmoBawpsOjKgc+3Oq1vq9trVFrP4ow4S8gIReuy6dXDpThbujx1ggGL3D+jXj8NXVmQOONwpOb/GqpnyIYm0vYtDL0mdQO+rs+zko0oswH7afzgj43ju45sK/8n+PQ0y0XkJ9CW/nGAeeidtnG8H0RX/ntUlxZjKHf685Q+jW7I6jm1KzkTqYFyWhRC668xvWJRZUxGMOS6//Khsoh0ssOl6HlWxot5ciBgjxUjglKzt4vqINC3wD5a1o/NtRQOnZsIv4lJCeHaAs55djEdf9404szB/XpuYWjH6PD/5wp7dsErx0ahgL9ZdYSUoXQ89prYUrdb9W8Pjd4ypqUVpXfEbidfHFbMjJdol4u2kD7phMJV931cCkZ+wZqO5SIz0MTpbiagdRgLvJ+l3a6af+Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8737F017EE55144EAED77EFC1B14F6BD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afb9f51-9268-4ed9-d0ff-08d6961ec095
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 04:00:14.3722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:32:38AM +0800, kbuild test robot wrote:
> Hi Jason,
>=20
> FYI, the error/warning still remains.

Nothing has changed, it is still a microblaze problem.

Jason
