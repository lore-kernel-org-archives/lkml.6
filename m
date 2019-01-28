Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52098C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F202171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="BlL+bhF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfA1So3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:44:29 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:31488
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726667AbfA1So2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOoW34ZUW/HkZcyNY+XifJOjMMIhWScdWSUcO4yblJQ=;
 b=BlL+bhF15M9F1+/C1Qx4qYxpeS1dg/w7mtWVhRkX5n9Tg8kvfTTc5c7Cv+l6jnjOYGS0XsHh6gGS4GA8vaW/aGvPMqa3dBaSUuVGZY64deT/6iEs/Zw0JiPJ2em9UHY8GYP9IUz7tPZgeJUE16lENXki+nxCO4aVFlbiX7aDHa0=
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com (20.179.42.80) by
 DBBPR05MB6505.eurprd05.prod.outlook.com (20.179.43.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Mon, 28 Jan 2019 18:44:24 +0000
Received: from DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::60b3:74a3:818c:7a0d]) by DBBPR05MB6426.eurprd05.prod.outlook.com
 ([fe80::60b3:74a3:818c:7a0d%3]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 18:44:24 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jiri Kosina <trivial@kernel.org>
Subject: Re: [PATCH trivial] kernel.h: Make container_of_safe type safe
Thread-Topic: [PATCH trivial] kernel.h: Make container_of_safe type safe
Thread-Index: AQHUtCcVBuKr2t5aL0ypcH5AlR+idqXEtmAAgABUQ4A=
Date:   Mon, 28 Jan 2019 18:44:24 +0000
Message-ID: <20190128184417.GM25120@mellanox.com>
References: <20190124205451.GA19634@ziepe.ca>
 <20190128134242.GA10951@infradead.org>
In-Reply-To: <20190128134242.GA10951@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To DBBPR05MB6426.eurprd05.prod.outlook.com
 (2603:10a6:10:c9::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DBBPR05MB6505;6:0Srr9sUHHOMrfEzhvszfUpLBgmQyD42b53rarlGAw/nbwE///Owlxp3P/VcIe2Tlwn7ZFpreyTUek5QhhS8ilVjW7Y8fubt+IroIgb4JWk9TaKFXKzNxqQ4teX7qUc8Yg7defePNMnD/JG1HWYq5cw+OuJImXUAHSDWvynK1zQVfjDXEehlqHfM1inzpjllEbeNIQgT7myAjs5lm28YLFm85xnfnKBUqc1bCfHQ5rfqrD8o+jPbc9RFAWLLYxpiQW0ZRBwy25q9Lp7Rm3amqElpK6f7k9uyJ6OkcBQs1QBvIndhM5GraWG7nlGY9WEnnncET7jX7uLEoXkneelExTiKA67TMxVgJWT1H62q+DgqK53xgR1Exp3O09co4T6WmrBkpP6RAGBwdHRnrfNAjCet4l3VlFpPbkmvGiCi0G2L0bxjcJZOQioua8sthVH7dB1vJu2GaYGcblQQM7PYYpg==;5:s2tisDmANF6WQ0nu5RsEhvMqptozsVbwW9wL+H3vuIBk28OJfTRG87zBGwEC5bNYCCBr1SleLkppr/Gpea4TuYdz8bt/cfm+UZKnnL391Gv4Goye7aohkw/loYPH8/3t/oujMX2u0mi6tzz1Af/FQ+dhP/OE1/mZVZALZ49zCTMc87YIMKoKzrTUdTyIYfcoLIkH3ARuiIPrjKheJORsNQ==;7:0XHLNj6CjxTNI0adG5vCXIFp2XvknQ2k1VZ6/5lvT9+AFe+n5E73Ve6zF2JEShnZxgZXV3xmBd3+/Pf7pWPi71/45yy4OIpfb4oANqwv7e+68xVVm9gGDhibHUEsEuXG53LWVDLt51RgqoQqzeQY7A==
x-ms-office365-filtering-correlation-id: fbba659a-c0ca-4c4d-0e11-08d685509fe2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6505;
x-ms-traffictypediagnostic: DBBPR05MB6505:
x-microsoft-antispam-prvs: <DBBPR05MB6505CACBD4F0F1B271383093CF960@DBBPR05MB6505.eurprd05.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(136003)(396003)(199004)(189003)(446003)(2906002)(316002)(2616005)(186003)(6246003)(66066001)(966005)(11346002)(71200400001)(71190400001)(476003)(4744005)(25786009)(97736004)(486006)(26005)(6916009)(478600001)(102836004)(4326008)(36756003)(99286004)(14454004)(8676002)(106356001)(229853002)(6512007)(33656002)(6306002)(305945005)(6436002)(68736007)(86362001)(54906003)(7736002)(81166006)(6486002)(81156014)(76176011)(8936002)(6506007)(6116002)(3846002)(52116002)(105586002)(1076003)(53936002)(256004)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6505;H:DBBPR05MB6426.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kt1cy7ELSWr8Vt1XcibTyzL7aIBUActYcKKVo7zkagZ8S5G9LecYfJCaTuOoZAMhNa5F2cSkriYPXmkJqiezv7ASQ0pER2LUMU3CEtYcLrR28MkN4Z3jNTmeEGOgT5V2J7jGP6TMtwhnGQm9M/RIpTQ/q/t01cCIvOeSj7z4B/HBChJp6mpLQ3q9tdp4IOkefu7lUbG28tF+ZiEPRGrneRPSMwp3rXpz96pqHCEl1c3dFyP7pvafmEzUE0zGGiNZvpvzUbDmZhSlkxDtgJHgTG7eJToRCBra0xlGPl4ZDcrR3DkftQNp9Sdf0WiEvVuEgm0xG0LrYI4Bhc7r4HERKF0aVnIIoXYMczYN7PMQksK7E9XQgCSoPHp48kppPen3CN/bJarwSahbDtqkHo63Ga9jvHPqN7pQkt7IuREEgUI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32F43EE85B48E244B4AB0C28D899E477@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbba659a-c0ca-4c4d-0e11-08d685509fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 18:44:24.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:42:42AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 24, 2019 at 08:55:05PM +0000, Jason Gunthorpe wrote:
> > The final ternary expression is given void * and type * as arguments, s=
o
> > the resulting type of the macro ends up being void *.
> >=20
> > container_of returns a type which maches the argument, this provides ty=
pe
> > safety and allows the expression to be immediately used as the target
> > type.
> >=20
> > Explicitly cast ERR_CAST() to get the correct type.
>=20
> I think we should just kill off container_of_safe - it has no user
> in the tree, is grossly misnamed and not really all that useful to start
> with.

I see it open coded from time to time, here someone sent a patch
open-coding it yesterday (with the same bug even):

https://patchwork.kernel.org/patch/10783535/

I noticed it didn't work right because I had a use for it..

Jason
