Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503662083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="V+0kv/v/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBUXHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:07:25 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:40576
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfBUXHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1tub9ybzqIXdomxLvf3aGG+2HedLNOS2BLWB45b98Q=;
 b=V+0kv/v/XWU29dx6QYlUTwW14IcNASNySSMr82k552EW2FmiVkQRb5LncVM3Wv9p0hOHtzmGR+nVvBG1b7FANDpgulk1emVQBAFkwOJt5NWIOQoZjVxwgC5PGWQ9q7CTJK53SeO+tD3BRf+J4fdPXwqGKq66JG2Toise0/1GPwY=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6553.eurprd05.prod.outlook.com (20.179.44.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 23:07:21 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 23:07:21 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Thread-Topic: [GIT PULL] Please pull RDMA subsystem changes
Thread-Index: AQHUyjoy336OIMLA2kecjmaHi6VO2Q==
Date:   Thu, 21 Feb 2019 23:07:20 +0000
Message-ID: <20190221230714.GA10656@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23)
 To DBBPR05MB6570.eurprd05.prod.outlook.com (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d760034-78e3-404f-1b37-08d69851550f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(49563074)(7193020);SRVR:DBBPR05MB6553;
x-ms-traffictypediagnostic: DBBPR05MB6553:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6553;23:Nu3S5oE+ZRSmBCTmO7XpJEFTMhGeRCILwWEt+Xvl3?=
 =?us-ascii?Q?cxCIrjAtu3uwSyTFMKN6OUZpLkPFLKsfKup7g/uHX1tsPl2qeeLFk4hOqeJs?=
 =?us-ascii?Q?lvVKQuZrAK6RyXyHOxnVLwQjxCDf/qj69ru2pqp7MH+tK8Z2aVmuVsHdiuy8?=
 =?us-ascii?Q?Gen1FwMQToNsp0DeIgmZFg7PA/0H061o995O21BMQ2yze0QJIo9W8S6deqFi?=
 =?us-ascii?Q?HFyXUUfK2ImyBWUshF/+bn/WPrl930iLV5z/Vz88FoxF2DD1v5DshW4ucMIs?=
 =?us-ascii?Q?yfN0v8eyHKEB/NM/JW5pXjJqSj14iTxRtWs+q3QgC5Z7pRNu1LM1uDxeZEog?=
 =?us-ascii?Q?oAaW9nqJzg139fQf33buSrs5DKnyf7FWN4elyzzMVbs5RoYrKNHNksC7tNrn?=
 =?us-ascii?Q?W5a7LIZPCwnwXDd/QJDbOpgZYl/Nq/Rfbp7m+ItIG3x6l5zzuV2QzFUKo0D/?=
 =?us-ascii?Q?aGlxidmcr/Hr6ELpaL7oQ2Xq9G+ItHTzaTc5jBCvWJasS7ji/n9nkwyRwX9F?=
 =?us-ascii?Q?jlGnVzeLEmr9P9q0NoqcVREcMJ5RMihaVGZF6A12Q4vfPX4V6d2XfL9PlOPW?=
 =?us-ascii?Q?2mYYtETqwRH0zqkaoEqbQV+Y9b8gtCYmSVmniIeXJN0+mS3hsKlI2Cr20m9/?=
 =?us-ascii?Q?K5fzl0VMg5CZkoiEenLEt3Jy5Z+07/T67/r11k1lPDqsJC1QX9piwYpnk9yL?=
 =?us-ascii?Q?y2Dy2bXnIEg9ZlGmCCl5P2xXox1/hF/PrGVmqPQnXL5R6WDc8xC5YaGeRaOA?=
 =?us-ascii?Q?gAyGtVVnkq3O7750EVSC47zGm/KANYiWqGxdV87bwKEaJTGKa5WhBntLnkbE?=
 =?us-ascii?Q?ygRjUJxPXbmb/KDDnZTGccM1K/u7AnojNsKZZW79KBogF4BVJ2jK5YcYj5lJ?=
 =?us-ascii?Q?v47DndZ6xg21NNugfhDbW76h3GwDbQ7wuZo7Y8AKElLS4QMm7gn9VUxCTQpH?=
 =?us-ascii?Q?Y7BNGnL342PnFxuBiQFWsHw4An84v7tAwobPWO6/bKdVBNBuArrerSGmCfbX?=
 =?us-ascii?Q?/m+Ty/Pqsy20nq41ssSFsvUDNE77UsPMzr4qzE02XqzwHVxEpKWOVRv+vhsW?=
 =?us-ascii?Q?cXTzma8L0slz4YA63C5diKf93AF6a9M+AYOZ6iVMKyL0t57gdhN67OcdvzcA?=
 =?us-ascii?Q?mi103IhXp+pMEKPcIGP7ITxtP7VM+Cr2hLSk6TWeHB5sQU8CKbyI50Y828Zv?=
 =?us-ascii?Q?r4c3jJ5zaSLr28leZZP/DUTFoldyGq0o2As?=
x-microsoft-antispam-prvs: <DBBPR05MB6553331AD00F718C8DA3D5D0CF7E0@DBBPR05MB6553.eurprd05.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(6486002)(33656002)(3846002)(478600001)(2906002)(105586002)(25786009)(8676002)(110136005)(316002)(6436002)(5660300002)(68736007)(8936002)(6116002)(486006)(102836004)(14454004)(81156014)(6506007)(7736002)(54906003)(81166006)(1076003)(36756003)(106356001)(305945005)(99936001)(66066001)(476003)(6512007)(86362001)(33896004)(386003)(71200400001)(9686003)(26005)(99286004)(52116002)(186003)(4326008)(97736004)(14444005)(71190400001)(256004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6553;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3+p57Zcnu0BcIJs6C1l+vQwmD0edbwgrK1REmUfcQd7jGyRzFV5Bgmw6zpv1cJ8jQruxGAaj7hrW8DK+ljE5moxBeuN1y1cs99UCmOtMKh1iemOYQaFWNcGt49bBzdWkUqC4HJq9Jb4PyBHl5kkGk7F5uUw6vgqHzJ8A1v7i33s/yTEjIVW0EqWRtktCfs1iVIy1w3zBWO4ZSLzTdspdjc8iFXKaBLrjm1YGRIHo3HFll9j3l91iYHxkCapiuigwWCh4m4YS9NOs1+4Fgg4cnTernZLs85Vcdgd1cQeP3/wlTom2ueu1S0aMz4QeGqxWryk4Sena4GbX/18bjcwECwbfrr+RtOfj58oo0xmumxB/mZQlPGP3O6Jy69Bm2DNWM0uqXXL1bax0cOYQLQqAV71mjwbjFWntyoad9q+yIdk=
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d760034-78e3-404f-1b37-08d69851550f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 23:07:20.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Small set of three regression fixing patches, things are looking
pretty good here. Thanks

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to f09ef134a7ca3f0d2ce485a757f5b79809ebb803:

  iw_cxgb4: cq/qp mask depends on bar2 pages in a host page (2019-02-15 09:39:39 -0700)

----------------------------------------------------------------
Third 5.0 rc pull request

Three smallish patches fixing regressions in v5.0:

- Fix cxgb4 to work again with non-4k page sizes

- NULL pointer oops in SRP during sg_reset

----------------------------------------------------------------
Bart Van Assche (1):
      RDMA/srp: Rework SCSI device reset handling

Raju Rangoju (2):
      cxgb4: Export sge_host_page_size to ulds
      iw_cxgb4: cq/qp mask depends on bar2 pages in a host page

 drivers/infiniband/hw/cxgb4/device.c           | 15 +++++++++++++--
 drivers/infiniband/ulp/srp/ib_srp.c            | 10 ----------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.c |  1 +
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_uld.h |  1 +
 4 files changed, 15 insertions(+), 12 deletions(-)

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAlxvLx8ACgkQOG33FX4g
mxoAfQ//fkI0f1urZsjloSiXrxiuQ2wRd6uHEywTtwVwWuad34WsvAvodQllnS+h
AesDPOa4L1+RlSWQ+vZ1Mc+JmNNqZBADg7uFguf0nyeuO/Fbyhgi+C4rXrV/pSUT
lhlgznAX9psj2KrV465D8uOrAj3LIfcARoqKeQuMMgnX13ld7paBAySQc4dlvc1L
e2VGVDYz6j7XgY91+iCu1cddhlyUleGyP0Q4x0TVRWAWmviMMKgXFhM0Xl5R7z3q
Y4NukzCAXC2lMDwT84NJdBg3pxqQk73V2QB2kKaTjVD4k4wqWD7zja+IeU5exygN
zYMJqIa4/M85lJASuNCZ3pL8Y7eHiYnG0Ng8IVr28YhDL8mY/c96OJRmINP9H4kX
4QVNa47tow2tNz6CSwcqQLJbgS4tQrEb1NZuxJsP6ACL1sLa0Q8S/ocTW6R6exJe
fXEM4/P2S3lrx5l0r9hwo5LWlSWxzde7sNtSt78KLFAJAQYLfEJdeBmHfo7VniU6
QFKDGLQXZ+FCTvqE9rTUnR1f+EniWPQddaaBeLNPO3IENaR4TEI08QZzJFhAlaEZ
LX04Q4noRWBmhkulRgT45ytdcFWC1OlIJ4UVFJlbCajO7Imc4kD6wleMr8uGdrUi
/YUuidQlgfKe4aCEDqmQUnRXiERE0oXr0H64Pdp/AtPDPV6e+MY=
=/Qn6
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
