Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE91C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABAB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WHIH13y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfANRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:20:55 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:59872
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbfANRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XcuNSCDF56wQ6uFJEwLiijDZB4Zk52vqZUhFrSKmHE=;
 b=WHIH13y6CYHPRUNCkcKgEItQmaQ4YWhqHkIICxEyUtR4sK8dFEKBK2FOWY7XCM/NY5kcM+vRhU1KqG2jn0IaAR9HhkyHmy/2iqgg6TnP0ptTgY51yRu+5oEb48M6A+rGRjY5vLvWJhGxWr1MBhuEWlvQz6tL/M/kelOJ+sRrGh8=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3387.eurprd05.prod.outlook.com (10.170.246.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 17:20:50 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:20:50 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Joe Perches <joe@perches.com>,
        Gal Pressman <galpress@amazon.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "xavier.huwei@huawei.com" <xavier.huwei@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] coding-style: Clarify the expectations around bool
Thread-Topic: [PATCH v4] coding-style: Clarify the expectations around bool
Thread-Index: AQHUqT7yMz195OkzB0O1DFW0sNTtuKWqU/gAgAS0gAA=
Date:   Mon, 14 Jan 2019 17:20:49 +0000
Message-ID: <20190114172044.GE22875@mellanox.com>
References: <20190110234805.GN6890@ziepe.ca>
 <20190111172940.zufmrhvukqo5hkat@gmail.com>
In-Reply-To: <20190111172940.zufmrhvukqo5hkat@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0025.namprd11.prod.outlook.com
 (2603:10b6:300:115::11) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3387;6:REOL4wVuaX+GUY5bHtX9TV2lGhO5LBowaDe7gE8fIocEsdRSdiYmM3IYCuPSXp25qVDHLQVZ12yQdEBdFd/EZVPHH8sLoXzjKYss1in0iZAQohYKF54/O76B7TpmeDMv10YtQT5QBLV+6UCZCux57LJcww3PE5YdVyL2kVM912lO2ydVoHbL+NFnE1Dn6jDY0upJaIyCbQtIa2eJqdQIhEt0AIqOTJ0UacS9axSsa4G2ByDFMTOmbF6icIYee97xdtZQkNjgNhVS/fV3g2fjSjSrDbrDmH8dAGLYqgRIyIRxQ2vhPEkYYy9cCsy9c9HjY09LHTaVtoEF2zlo7fca0Wbnmrd3pAOA4cc2CCGA84u2QZbCIxgTvTKSqOtK77V3EO/lKL7w+I7Fvxhb3PZYogOmJnW568KjEHOP6UPauXVMQvS2wrudaRKAgP7Rule2KlkJsyQ52Wpr7coCPPpHgw==;5:obu8W8lM87BEMfKUHtllIAaDTNeYwg/0yF+z2hYNO8MAPetVQ//oFLzrk7ferv9hxZAxqZheO+OnuCdwBZd2Cp35H4VBN4Gcpd8v0GG0OrQHU/vSXRarmdhqFlap1bkbCfmCMiCewQLTE5TkDhDTkrF3VB+Phiesw08lZVj7CxyoxqhD32KkAi/4ttm3IkrFuu+orVK7pp0VMjYIwbjWww==;7:G/2/NmGy4pQBEQNWCaVRHK0UDqBJqZgDUrXIM/PqL3IWfxj4ZVdS3IHi16VwJeybNC0KZAbn4n3pAKWVNSubKv/KpRBK0uqpaUlq2y2MObPAyidc+abzfI0bCzPjei6oH6H1om/SLq70hKDkJ0VDeg==
x-ms-office365-filtering-correlation-id: e452320e-8d92-436b-9068-08d67a44a0ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3387;
x-ms-traffictypediagnostic: HE1PR05MB3387:
x-microsoft-antispam-prvs: <HE1PR05MB33877B3F755F2BA6B0F4BC93CF800@HE1PR05MB3387.eurprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(2616005)(476003)(11346002)(478600001)(446003)(2501003)(486006)(39060400002)(97736004)(33656002)(53936002)(2906002)(6512007)(7736002)(305945005)(14454004)(66066001)(6246003)(36756003)(25786009)(8676002)(81156014)(81166006)(256004)(14444005)(71200400001)(71190400001)(229853002)(76176011)(52116002)(6486002)(6436002)(105586002)(106356001)(5660300001)(99286004)(7416002)(386003)(102836004)(316002)(68736007)(6506007)(110136005)(1076003)(6116002)(26005)(2201001)(186003)(86362001)(3846002)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3387;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z2ZYaowOHWQWkrt5vYwS5KOVvmowcBJvD6FVN0D1w9GK5jd9PT8869GP+8AY9GlYz654Pz+Y0JI3ZEInbAkkm6fjkxLt6ZJ2OYZ3dBtjtAZA+jZrOutjdHH/AJtDKXtfQAG+vP2rsPsDBKQ9XMg0sINIWXlGRoEf3P52uV5oQaP3PHHVw3z+O5XkQO9t6BxYMHA3miPiOIt4rsz7sRWrxk+ckxnDOQHF+K/sFg80xEm63uDU+pxRs8na3s8RzSSCylM4LvRG8ZjnwUKXybh3RdngLlHjTSzgRqvKhHsq59D2NcYThpLaZ4/JUq99OfOkQydSupPR+rBAbCmrSRpTU/YrmR2SUG/nVsdYfDuvbAGL+4XuwANs2AFymZ3+KOhUT7G2Wez0FKcOFzeLVv7I7Qo8jX076Te51adAwAcVq08=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <420A43F343C15F47AEEDD50D202BF142@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e452320e-8d92-436b-9068-08d67a44a0ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:20:49.3468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 07:29:40AM -1000, Joey Pabalinas wrote:
> On Thu, Jan 10, 2019 at 11:48:13PM +0000, Jason Gunthorpe wrote:
> > There has been some confusion since checkpatch started warning about bo=
ol
> > use in structures, and people have been avoiding using it.
> >=20
> > Many people feel there is still a legitimate place for bool in structur=
es,
> > so provide some guidance on bool usage derived from the entire thread t=
hat
> > spawned the checkpatch warning.
>=20
> Hey Jason,
>=20
> I very much agree that the bool expectations could be much clearer, and t=
his
> patch is a nice step in that direction! Just a couple small nitpicks:
>=20
> > +Do not use bool if cache line layout or size of the value matters, its=
 size
> > +and alignment varies based on the compiled architecture. Structures th=
at are
> > +optimized for alignment and size should not use bool.
>=20
> +Do not use bool if cache line layout or size of the value matters, as it=
s size
>                                                                     ^
>                                                                     |
> Adding an "as" makes the sentence flow a bit cleaner: --------------
>=20
> > +into a single bitwise 'flags' argument and 'flags' can often a more re=
adable
> > +alternative if the call-sites have naked true/false constants.
>=20
> +into a single bitwise 'flags' argument and 'flags' can often be a more r=
eadable
>                                                               ^
>                                                               |
> Missing a "be" here: -----------------------------------------
>=20
> Ack from me after those two corrections.
>=20
> Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>

done, thanks

Jason
