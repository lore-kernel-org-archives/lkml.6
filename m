Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF72083A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rerZ9aF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF72083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeJQSSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:18:42 -0400
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:28112
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbeJQSSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHZQc8Us42FLfIoiKEiGrv1pHBL2bkwPjdM6iK0Zr5M=;
 b=rerZ9aF/yu5N/0acin40d6sVkrGtFCHUzThNE8ZX1THIAYN8qfxx1IqbsltaVUPHjwiK9ghgM3BJMEyZNkijnguIb3lF3/XoYf7nAjxWr1SUlfiKXb1VqhDCtUSRBbh7lfEIrNSiKLnzwvxD2xo0es2gsiJht2OH0OjI0xh29jI=
Received: from AM0PR05MB4450.eurprd05.prod.outlook.com (52.134.92.23) by
 AM0PR05MB4900.eurprd05.prod.outlook.com (20.177.41.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 17 Oct 2018 10:23:32 +0000
Received: from AM0PR05MB4450.eurprd05.prod.outlook.com
 ([fe80::2c5b:1cf3:984a:3e84]) by AM0PR05MB4450.eurprd05.prod.outlook.com
 ([fe80::2c5b:1cf3:984a:3e84%5]) with mapi id 15.20.1207.029; Wed, 17 Oct 2018
 10:23:32 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3] IB/rxe: Remove unnecessary enum values
Thread-Topic: [PATCH v3] IB/rxe: Remove unnecessary enum values
Thread-Index: AQHUZgN03YUcVBdrh0mg+yHADHhXTg==
Date:   Wed, 17 Oct 2018 10:23:32 +0000
Message-ID: <20181017102331.GA30105@mellanox.com>
References: <20180927050156.20023-1-natechancellor@gmail.com>
 <20180927051222.23084-1-natechancellor@gmail.com>
In-Reply-To: <20180927051222.23084-1-natechancellor@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0006.eurprd06.prod.outlook.com
 (2603:10a6:206:2::19) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB4900;6:aNQcDprx78NCqDOMp9stSfWmdN5dX+I76s4wPnt6CDn3ELf/PwrRrLiI/ZMrH6MMaA9kWB/fFe6SfwKmUS4kvDArB6AwEHYN481M0fO7I8hyGz1+euTPV/F6W6ifUsFCpsjZPq01UZx9MiLTVANBsxmil42oOcUGv4TZcNr1ZUT/jwe4J1M0cExQ1+ao3bSqCMGWPxdwcHowSxn39V/WSd2XhR7U+gqMUYQfCebquTyvSU+cVvel04xbRCMqPsdccg13i5pg7PMNmiSwO/BtdMo/UZ94CrN3u+BFpXJ5ATweChIjOXQCS6858U+HpIvP7GLTNycvgM9mUg80h0nm9ry5J7u1+4gIfnFzNa6QCMgB+06r5gQYMfTGzGdqo41rQ5Y/1KjPkPoFMJ8CZEdJ3IXGQj2ftI4fZ++opw5OTzNilWOioYBdJTtiNUoQs+iZEl+rRVbkreOBPOqnCmkjXA==;5:OEeH4S48J9n0li2S3FWAcPVYeC2GIBDxEcDRp+7ffzd+1mDhUE2txGZQ7tjRCVZt4uiLpCakX+btkLwytxsmoNmF2rPDSvAgPLmQfr5uANkgTiYmk/DqE9+LUxdX0WM6okxIKpmREP4y2CuSXGOa3mVhIW4MrNgwNI3Mg3Nh3Jk=;7:gJjM78PKUngAgAfIy6O6Hbry+5Hs28koErD0AGTguQtu4Y+zm6tC4zDXLnsZuY0II/fiq5WDIbLg8e5lMiG1LZogznb9PQemBHQ9cFmW985rJNXbASUuatBXfp6gHodcbPOUJvZvTQG7BYyiEQC1wGWeZLbIPMVnth5EdzjQiD0ImpmKhAp3xm4slmycWHsDkA+N6wMb+/hgySbuR/4vadu7NakBwMGRC7liL5DKFuUJVQe+wpTWVaZG0R+elT9y
x-ms-office365-filtering-correlation-id: 31478fa6-afef-4024-b340-08d6341a96ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4900;
x-ms-traffictypediagnostic: AM0PR05MB4900:
x-microsoft-antispam-prvs: <AM0PR05MB4900001E0B8F4025D6FB28F3CFFF0@AM0PR05MB4900.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211936372134217)(153496737603132)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR05MB4900;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4900;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(6512007)(2616005)(1411001)(25786009)(81166006)(8936002)(256004)(229853002)(26005)(102836004)(8676002)(33656002)(53936002)(14454004)(6436002)(386003)(6486002)(186003)(14444005)(6506007)(39060400002)(4326008)(36756003)(81156014)(7736002)(476003)(6916009)(6246003)(76176011)(305945005)(2906002)(2900100001)(97736004)(52116002)(446003)(99286004)(54906003)(105586002)(486006)(106356001)(5250100002)(66066001)(71190400001)(86362001)(6116002)(68736007)(11346002)(3846002)(1076002)(478600001)(71200400001)(5660300001)(316002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4900;H:AM0PR05MB4450.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VrMr9+uWOVeSFD4OKgNFJqqfk/if4P649Ti+mGwq0sxPYKMw1TexWNxB+jm65q3wQ3PLZCJFrpKk8KJ/5uOlDDewpikyOpDCeeo+d8fZXVA8Eg7ho7kfaf/9PRX9S0GyGMSX9ZVhdT6rGhrZ2X+oFJEvAerZJDsAOc/uLzBom6ohLdmqkm86b7NVCQj+V+LbqiZksZ7aM3z70qy5fxaL3K5RnAXF19WwtoC8wwixadr0Fggn5vVjWwSG/13nq/qpDOApIApdi3QuZBCdoy0s4gY8QmrXQ90Ot4XBRaicaV0Z+06oxWG3+fD0NMeJdJJOXafxChxPxqWCbIaDJIeGdS2nDw6MR/jBg/CAd2baQ5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C4E4211A0EDCB4BB626B705499B4E40@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31478fa6-afef-4024-b340-08d6341a96ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 10:23:32.7699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:12:23PM -0700, Nathan Chancellor wrote:
> Clang warns when an emumerated type is implicitly converted to another.
>=20
> drivers/infiniband/sw/rxe/rxe.c:106:27: warning: implicit conversion
> from enumeration type 'enum rxe_device_param' to different enumeration
> type 'enum ib_atomic_cap' [-Wenum-conversion]
>         rxe->attr.atomic_cap                    =3D RXE_ATOMIC_CAP;
>                                                 ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:131:22: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_port_state' [-Wenum-conversion]
>         port->attr.state                =3D RXE_PORT_STATE;
>                                         ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:132:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.max_mtu              =3D RXE_PORT_MAX_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:133:27: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.active_mtu           =3D RXE_PORT_ACTIVE_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:151:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>                                 ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
>                                 ~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~
> 5 warnings generated.
>=20
> Use the appropriate values from the expected enumerated type so no
> conversion needs to happen then remove the unneeded definitions.
>=20
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

Applied to for-next

Thanks,
Jason
