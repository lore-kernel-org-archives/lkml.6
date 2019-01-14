Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609F4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261632070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mAk8e4ar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfANR0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:26:17 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:22070
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfANR0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN7Naei5elJO3w8Y/ky1akyiE1fMqJDKCr6W/PoBNw0=;
 b=mAk8e4aroVTKygOeZhrQelJw/zA2jXwNYuOsqDYo5WU3/8jQdoRNV48hOAck5lHo1uKbEpmXJpJDOKy+k1ABouO+dH0u2og1Px2+665uGEyFK5CDyCtla2ivqmCIUmOYKNov6p4KORx4+G6sGcRDd1rW6PenATTC0oN5iox/IW4=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3404.eurprd05.prod.outlook.com (10.170.244.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 17:26:10 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:26:10 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Joe Perches <joe@perches.com>, Gal Pressman <galpress@amazon.com>,
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
Thread-Index: AQHUqT7yMz195OkzB0O1DFW0sNTtuKWtbXAAgAGchIA=
Date:   Mon, 14 Jan 2019 17:26:10 +0000
Message-ID: <20190114172603.GF22875@mellanox.com>
References: <20190110234805.GN6890@ziepe.ca>
 <20190113164936.GW6310@bombadil.infradead.org>
In-Reply-To: <20190113164936.GW6310@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR2201CA0005.namprd22.prod.outlook.com
 (2603:10b6:301:28::18) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3404;6:YcCZp7R6K6ZPu9TMX5CmNA1Gc7CUs9CwDLUg5Lz5UOgjRpRgk2jfgEAhk5dqw1fdeU9BaQwz9EH8RmC7509Xnl1xAx0XLZizFEAo1rw6GWR6GxFVwMnofieumSGPLf00sX09fQdnIxWYnk3BkpLn/wc8u/yRA1Ek2bcubJM34kNELkL3kFbt1F1RyFCdkZUHQ75YR4fKT3ZuzhIuZLOp8w72EYh3E7CaDYoYB45mCWcmZ876q4qSg2YizF2WxaFSSg8IbQMlE7IxgmtD/ARQqTuBTpbynfvfOYV2SEsXza8pHjF8+1ACDhFQ8LpkkbX+awRIdYLpHG1yBxN78Td/qNfK6nueUW0arg5YCP6vCKOSnKfrpuZ0Ni1uODbXIaRX4w6eL6x+8glAk6AU8xuhv+erZ/RTxL5f8YWGoYqMavsw1qOPXrpnH5KLfly33xsT/OWa4TAyLqWynYQFTcw+bA==;5:mHhFZVQYG9BlN/G8gy4hLF9SNzYHTWeTd9yR4sRZKQSbLNh39tW6izlL+3lQaDb9lLrhZ/ZI0Onfu9o3zHWjXLgkbv8dsnMdMNdd9YKH7UNdS1Yb9O0XdSdp2x0jqZGs+A+LvoPjWK8HeqGD7q11m83eLvdQK46/9CVAUZe9QGlo/r7aeRedhGeytFkFRumaQzU39zVTOuPOJUkCoxwvcg==;7:vyHRyqtjeIeSE1NfrpDPsbBBzyFtDUQZFMkL+uMKvBo1Ti/ySauNTdSx9+e/12zUt9ZjxY3YK4rpXOj6cd4IOc9dThVSN62/Rf/iMD0RteJ1elMOipHKbJ1trWtiOJEEBn93eWrqY/wr2u3BYoIXzw==
x-ms-office365-filtering-correlation-id: fc89a19a-f2cd-4fe5-456f-08d67a455fd3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3404;
x-ms-traffictypediagnostic: HE1PR05MB3404:
x-microsoft-antispam-prvs: <HE1PR05MB3404F239164E608B6FE61F12CF800@HE1PR05MB3404.eurprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(376002)(346002)(189003)(199004)(7736002)(106356001)(2906002)(97736004)(6916009)(7416002)(6436002)(54906003)(316002)(102836004)(386003)(6506007)(305945005)(86362001)(76176011)(26005)(5660300001)(105586002)(8936002)(99286004)(66066001)(14454004)(256004)(14444005)(478600001)(36756003)(81156014)(81166006)(8676002)(486006)(71190400001)(6486002)(71200400001)(11346002)(1076003)(446003)(476003)(33656002)(52116002)(25786009)(6246003)(68736007)(186003)(3846002)(6116002)(229853002)(4326008)(53936002)(6512007)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3404;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D6zAmNd4+QzM0fl6G/0mFoaBh2QRRNjnKYPLk/f97sBt2ghpOPW1LOygAg6cnAFsx4nv9rBR7AmYejfu3+c1eW2K58ZfwyfHlGNcS7nqUlV3SngntYdlQa9XV+MZ6WLIXgRrp3JaQyCM8owf7T+RpqFE1G9Jzaut0TDbs6jIiLOgRot0lv04r7bSNb/SqqJrNUUQQzcKp2U/1J0iCdtsScuErV31yRKeXV0IJ7Hy0tVuJIJFE/ZhbUDQzW2qHKVqSKy4+tbdBAqp+PHqy6pN90g/1xqqBMStlUAa0SGjVQqf08OQ8bfmFa8/JUZt9J3iqOpVZ7ySQplIwdzUwM27aZV11CwutUDDmxUJAsDyIjnuKWxHWVDURNF0LIwzCr0wRopF71OPdofj2rrKdwzcbOD5C30Rxmh6RcYn+0hLjKE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B58898B74CCDD49A5E17C8658896DD4@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc89a19a-f2cd-4fe5-456f-08d67a455fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:26:09.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 08:49:36AM -0800, Matthew Wilcox wrote:
> On Thu, Jan 10, 2019 at 11:48:13PM +0000, Jason Gunthorpe wrote:
> > +The Linux kernel bool type is an alias for the C99 _Bool type. bool va=
lues can
> > +only evaluate to 0 or 1, and implicit or explicit conversion to bool
> > +automatically converts the value to true or false. When using bool typ=
es the
> > +!! construction is not needed, which eliminates a class of bugs.
> > +
> > +When working with bool values the true and false definitions should be=
 used
> > +instead of 0 and 1.
> > +
> > +bool function return types and stack variables are always fine to use =
whenever
> > +appropriate. Use of bool is encouraged to improve readability and is o=
ften a
> > +better option than 'int' for storing boolean values.
>=20
> It's awkward to start a sentence with a lower case letter.  How about
> rephrasing this paragraph and the following one as:
>=20
>   Using bool as the return type of a function or as a variable is always
>   fine when appropriate.  It often improves readability and is a better o=
ption
>   than int for storing boolean values.  Using bool in data structures is
>   more debatable; its size and alignment can vary between architectures.

This is more concise, but I think if the coding style is not going to
give a concrete advise then it should at least provide some general
information so the reader can try and make an informed choice.

That is why I had it expand on some of the rationals a little bit,
along with a concrete direction to not use bool in the cases Linus
specifically called out.

> > +Do not use bool if cache line layout or size of the value matters, its=
 size
> > +and alignment varies based on the compiled architecture. Structures th=
at are
> > +optimized for alignment and size should not use bool.
> > +
> > +If a structure has many true/false values, consider consolidating them=
 into a
> > +bitfield with 1 bit members, or using an appropriate fixed width type,=
 such as
> > +u8.

JAson
