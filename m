Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D802DC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877A020850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZeJPTTq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877A020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLDBxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:53:02 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:64652
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbeLDBw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbTeUBFpiUKTXSMXipxiAzHGCyxc7VLSh3MIWL5UgoM=;
 b=ZeJPTTq5BagpwFBJy0NrPKrkZfMXnnAJ1ZvCb549xpQLNrLrzDL7pJNWkcwOik44ji+o22G2Gm1vUdbc1HyLMXF5AU19BkPF2HXGGOQa+UDj/4qt7gGoVAtvB79xpYyGubkOW8xir4jexzz3v0gz9NsfzHftkdGnVMR3PIhosSI=
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com (20.177.119.202) by
 AM6PR05MB4822.eurprd05.prod.outlook.com (20.177.34.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Tue, 4 Dec 2018 01:52:54 +0000
Received: from AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::6136:d1d6:67c2:3920]) by AM6PR05MB5553.eurprd05.prod.outlook.com
 ([fe80::6136:d1d6:67c2:3920%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 01:52:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHUi2r6IQWSBn9b6USjr6/zZkt17qVt0UaA
Date:   Tue, 4 Dec 2018 01:52:54 +0000
Message-ID: <20181204015247.GR12288@mellanox.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
In-Reply-To: <20181204114731.48b18bfc@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To AM6PR05MB5553.eurprd05.prod.outlook.com (2603:10a6:20b:30::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB4822;6:VKl/FlcLk1rx+mjNJTo7u1dstctrRD75uC9J3A/Wu8pF4uOTRcPGH4Q6XMNr/RT7MkNzSwI2ndWq1bTacXXjCutpyBgrjQVPwIvDhsQ3L1ujJ3seFOzjN3lVgVgxzvWkg+Il7UEyKWZ1+pQoDPC1//Y8OyNwhu5shMslse4YtJ7PzIyBZvXBjhjxzAAhtDADsPpgwf3auR59ym2PfnXvlKu7OEFtNuNlW4ZVK9jcT2wD4dogR5samxfPIXRrTVmX3io2lvkDv+rIJpoJ8700sHtGFIweyNSU/b1P4KrmMp00sdclZkcjxyhjaMzcPji9bCrGH4A+OUZa6wLVh3sI6UrEXJyPttiMGCJaA3/wlxHYBKQiLZf8Ae5+nhKskU4Yyeuvl6YngspfPHbixpNx6Coc0B74V6GvZfZNpusF/smuzoTw0UAjgUYYCOik4nmK2uSTaB4jO0HL0gnUtpcmQA==;5:WTjbvo+JtaCp1otkGQcVQo8ku5S5DQ2Kqd1rCTs0U9FqlkI0uHvn0tVbbur3Hxr917z+XYsaS2Jfst04p+5lde8XTaJImeEJDks0drx3UaxW/4ve+Mx5PBk7c/uWvsyrxWhNlVdVUJRAwbgK1Bd6BiWKcW9dTPVLHohyrRo9B1s=;7:6ugJ0Fg7KPYEywfm9zEx2GGhTYb/IRpDtynibEFNvDe0xuFwnRs2S0q4V25lzJE3JCx5COyMXT/GEHnvSwnJ/XXnzt089IXFmUjJAbe3cU6VCkKHWKzlbP2OFRM0l4R5FVg7/yHusHU0ZimNzpuAQQ==
x-ms-office365-filtering-correlation-id: 749116fd-2524-4909-969f-08d6598b3428
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4822;
x-ms-traffictypediagnostic: AM6PR05MB4822:
x-microsoft-antispam-prvs: <AM6PR05MB4822B7B725886712E00FF308CFAF0@AM6PR05MB4822.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR05MB4822;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4822;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(53754006)(189003)(199004)(36756003)(52116002)(105586002)(71190400001)(476003)(25786009)(6512007)(4326008)(1076002)(81156014)(81166006)(71200400001)(8676002)(478600001)(106356001)(54906003)(99286004)(53936002)(14454004)(107886003)(6246003)(305945005)(7736002)(229853002)(97736004)(6116002)(186003)(26005)(3846002)(6486002)(5660300001)(256004)(14444005)(86362001)(8936002)(6436002)(66066001)(6916009)(2906002)(316002)(6506007)(386003)(68736007)(2616005)(102836004)(486006)(11346002)(446003)(33656002)(76176011)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4822;H:AM6PR05MB5553.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DthjvluTb30rKxAlST3YPqNz745KOAiOuDq3Urx8TRENjcY6XWBmO209F0nm5g38mtscFG0hebAIdP1csIM1qRFHq+M+0U6WP5UOxmclnFcnTpIzzWVWSKRi59tILx25U9kE5/ci0I6Qa0AUsM2p1NtCatAUa2fFkamyt3Qo13UZFlv7WKM6iasl9TonNpQiLvw/cm5A2JkxSyuqyFMpf/tZN3/i3m+k+/LOpq2D86cWEuMVpAZoJVV2aJbG+j1rpQeRV3x80kqWeNUdR0Ujs0LsHrFHMyAnuwLHpop48l7FjS+xUVpxE3BJ9BxXVG65tF5UYgF8CDPKvV50TjxuBpfbBFQ4ytinoXxVqP0LcfQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C9D767E85910C4FAE523A23D712CC7D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749116fd-2524-4909-969f-08d6598b3428
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 01:52:54.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:47:31AM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> After merging the rdma tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> ERROR: "mlx5_get_send_wqe" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefi=
ned!
>=20
> Caused by commit
>=20
>   34f4c9554d8b ("IB/mlx5: Use fragmented QP's buffer for in-kernel users"=
)
>=20
> mlx5_get_send_wqe() is still used in drivers/infiniband/hw/mlx5/cq.c
> and declared in drivers/infiniband/hw/mlx5/mlx5_ib.h ...
>=20
> I have used the version of the rdma tree from next-20181203 for today.

Huh. So apparently every compiler that tested this patch (0-day, mine,
the submitters) optimized this call away because is_atomic_response()
always returns 0: meaning mlx5_get_atomic_laddr is never callable and
can be deleted entirely, including the call to mlx5_get_send_wqe.

Not sure what compiler setup will hit this, but it is clearly wrong
code..

Guy/Leon, please send a fixup.. Maybe just delete all this
handle_atomics stuff?

Thanks,
Jason
