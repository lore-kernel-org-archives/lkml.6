Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED4C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95E520870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="dx1t0S/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeLKUoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:44:00 -0500
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:8416
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726134AbeLKUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTmwfAbundIj+QREDkmHKPBUItLQlVHlx4o7Q4NAJEQ=;
 b=dx1t0S/qRZcHShu2vTh8IM431IBT6wA8jgGu8pRjMwIC0Uiz5BXd1NO9F481V0+t8allZs7ZCVibaAY26S3CxCzbjKp776rfXb3qY7Lppz7LxjAYA+OOoY6M9ZGX3ntxpRAJehxdzp7co7OvstfRHqdjmZOgcaYs+9chQiZBUYE=
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com (20.177.119.202) by
 AM6PR05MB5863.eurprd05.prod.outlook.com (20.179.0.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Tue, 11 Dec 2018 20:43:56 +0000
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::b596:88f5:d8c9:fdb5]) by AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::b596:88f5:d8c9:fdb5%2]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 20:43:56 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -next] IB/mlx5: remove duplicated include from mlx5_ib.h
Thread-Topic: [PATCH -next] IB/mlx5: remove duplicated include from mlx5_ib.h
Thread-Index: AQHUkZI7mT5nGRqnnk6xM0IhAFvxfg==
Date:   Tue, 11 Dec 2018 20:43:55 +0000
Message-ID: <20181211204352.GA7497@mellanox.com>
References: <20181210072759.26128-1-yuehaibing@huawei.com>
In-Reply-To: <20181210072759.26128-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0343.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::19) To AM6PR05MB5553.eurprd05.prod.outlook.com
 (2603:10a6:20b:30::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.111.136]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5863;6:EH8dKZ1wmchoadRzCz15v9fkSThNhgKxdQdXU5l/3HmTyZHYCQ+X3QOO9fOis5fZ198A70j+qOXZ5xENH3gNDEA/HyZIPMSIx/z9mGS3HWIOpVX9L4RejSoXuEtKgoOYEB0rXXh9kDPzYfqsOwlWA5LQsiMlYznIv8J9Fl+YXcvcSmuv3DpuaG+8jvUOmNt6Cqw7e4toFGI+UlvPBYv2j+ZB4dGUwNKN6YpQZ4gdZ69yW15ncdtlQBp0thrc3iApRWYjgFSymbUlvbBuABJmaXX44I8exFNd2bzFyUlG4OUTwBeXv9lYGX1juq7cdB4m2jNQo0FdhH/5nmUmHsfJfvMWfruELtizuv6UwVq+9G+Io8va1uXPWE6FiOSbOtB4LRQCzNcBJzvzCWPL1707HI+MmrwXNOxkZPc9izonKHOqNwR/LoFYtZJ2TCHl8Gd4MhyIpqEaVUTzAtg+qmZZxg==;5:JiaymIMXyzEZwOXd0dPBkTif0lDq7bvsAaIFnosgYFTLL6XiNNtvmxIu73LjlI78uy60yZm9LyzAU/mMhQ130fzX9+kMlsSZ6rbodAgcj1JxFUJjFSDaHKT0aNlViLOtQUK4cXPUzE7j1O0DsP4b0kJ2WuMUin/KLc9BDpMzt/E=;7:DbcZrTddn3GqSsk4wyMiQfK9u2R9W32uIY/A7IaOkUz3I92h6ebMD0qDM+QyFwNrl724+7x7tx3C1jWDNvABy0fyzQxsSUY4Wgy3Zluh6NUOWBT3ZYvCdEkFtwCqBz1W4ZMvBQp4bOOBpwDhaoBB/g==
x-ms-office365-filtering-correlation-id: 5b82c9d6-573a-4ca3-d806-08d65fa95e35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5863;
x-ms-traffictypediagnostic: AM6PR05MB5863:
x-microsoft-antispam-prvs: <AM6PR05MB5863705FB21F32BD5853F79FCFA60@AM6PR05MB5863.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR05MB5863;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB5863;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(476003)(14454004)(2616005)(1076002)(486006)(8936002)(305945005)(66066001)(6436002)(229853002)(68736007)(99286004)(97736004)(4326008)(105586002)(81166006)(6116002)(81156014)(11346002)(8676002)(5660300001)(446003)(6916009)(558084003)(86362001)(25786009)(2906002)(3846002)(6486002)(256004)(14444005)(36756003)(54906003)(478600001)(71200400001)(71190400001)(33656002)(316002)(186003)(52116002)(6512007)(6246003)(76176011)(106356001)(7736002)(26005)(102836004)(53936002)(386003)(6506007)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5863;H:AM6PR05MB5553.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gSq9s8AA+w/xJD+1fjbnKuijzljZj6IAn6bIG71T+3VCkW3xDIFNpucqPUhFguT2/t88/9+o6IbqRMU3mk3l/4MnRQejx+Kd/NlQ6al4zAUrxCZiMZ+O1TiMPViPjL3HuE5r5vrOwif2A6Tvt99wxM2YU8XXOojvu8hl16+MHX3cgx+g/mMB9hMAC4xrQSp0SttzqM7fM0pLkZ6xRcJcKui8eyGZN9WzdJRGyHxM+ZFZOAkl76Pjhjrue1IzGlXYFSVS2WNiw0lHsx/ONdh0gX0kdwlksvNiO5IKTipex/QemThmrQhq3/amKV8ACk0+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F76130A78C8274498E3749FC687F9B92@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b82c9d6-573a-4ca3-d806-08d65fa95e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 20:43:55.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5863
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 03:27:59PM +0800, YueHaibing wrote:
> Remove duplicated include.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next

Thanks,
Jason
