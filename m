Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEBDC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D9F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="jflki1wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfANR2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:28:42 -0500
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:65056
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfANR2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+10xgcP3bB3YXfZwVzop4pIXVF8P35unhxy/Ad7dAj8=;
 b=jflki1wdTmQT+DPxYGghlx7PYNVc/KEDinqL1P+zwtXVJQ6iUVgWdyuktF1ey3mim8SL2ZRDbzDC57cTYzCl56xRSHfTi53iTZUGSMxm9ENaoqQ+dWEPUD0QjMXKO95eEOEs+O0oP7rDMmlH0WXWaHJcNQFceW/P/XkEj35iUZ8=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB4634.eurprd05.prod.outlook.com (20.176.163.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Mon, 14 Jan 2019 17:28:34 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 17:28:34 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
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
Thread-Index: AQHUqT7yMz195OkzB0O1DFW0sNTtuKWtYAuAgAGqlYA=
Date:   Mon, 14 Jan 2019 17:28:34 +0000
Message-ID: <20190114172827.GG22875@mellanox.com>
References: <20190110234805.GN6890@ziepe.ca>
 <d09397d56df116e0d2b8e1a56ace0a37@vaga.pv.it>
In-Reply-To: <d09397d56df116e0d2b8e1a56ace0a37@vaga.pv.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:300:93::31) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB4634;6:RL/gwLjDvoUFyqw4m/Pnm59ak5qvpi5tOmjdXma+N65taQEXgCSkuaxlU6rxnKu+wyNz/kc8LZyrdNYIS4I1b4ckc5N0FRm4diyDR4Soa3Wx2y0bsDSSsk2+t2pW+E6NghyEE9WYYkcSfKmXOZ9heAY8a2AVrxLwKXn/N+1Hftsz8986biruYoSPPbGxz3IABlEEOz34yZH5eRqpzgKQVuqyrJXCHwMOvpE12Ip49Vqmb7ox3WqDeFNNbyBwe6oJVuPvVziD6suQWkd8KSCMQi1hio3C1NLzTmXN1duu4jDFWgDUZGB7xE/IAGq+CN3ph7f9NKgukxfaB+zqGdiLdDIC2gBaQO1w+fQhz+SyDjkSXn2L1GcMp2hTvB3NTdrWAOb+tpxzpm5I1JJ2CC5+B3ixGvfvwEfM8JIVELQeb6H+C9NCrK4FY1qwPP5DLNZ7P8VWYe+WSdlZ/T0XMgxyMw==;5:P06IGtAgivHSpEiLDu7Tm5B2paj4QZEzUINGeeBQ/bIbcAJcQvBML9mTETbxvruikMpC7LJu2vHd65GYpxqce3FtU14qZLtzPKO22SWEtZh6+eKX7lDQtQ9TACrW5WTL1zzi8cdHRHUROxkk2V/ADrFNXHDSLZ4C0KhZrC16hZOHwrfm6qWBqsUJSWbVCBQ1ZYB30BUy+h1Z3Xw6BzFcaA==;7:fY4M73h+lEQDjFGeynwTiEe83MYB61hOahKrignf2hSrKkj24T1Cf/x/aAhaSZ5dTb/Z6S2CqWGYj42ERyzKPzpLblhxC0w/v4olK5HHM8bxMeGauFrfn4Dj2pswah9LbHqGJAoN4hMaQZQWP9t1hw==
x-ms-office365-filtering-correlation-id: da97e2b9-b7da-4a82-5e89-08d67a45b5fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4634;
x-ms-traffictypediagnostic: HE1PR05MB4634:
x-microsoft-antispam-prvs: <HE1PR05MB4634BC1D7826375C75EB4513CF800@HE1PR05MB4634.eurprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(7416002)(36756003)(99286004)(26005)(476003)(2616005)(486006)(11346002)(446003)(7736002)(256004)(14444005)(186003)(2906002)(53936002)(102836004)(6916009)(25786009)(5660300001)(33656002)(86362001)(305945005)(105586002)(97736004)(106356001)(6506007)(6246003)(386003)(66066001)(316002)(68736007)(8936002)(81156014)(229853002)(76176011)(71190400001)(71200400001)(81166006)(14454004)(6486002)(4326008)(6512007)(8676002)(52116002)(6116002)(6436002)(3846002)(1076003)(478600001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4634;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nqbfZBOZHid4YS1q6cElPzBjPyGycMQYOyQqGLyv2Re1cQgH6jWyi7rIBc4CQDNAC1KaUux437tnOBhJgXXdZKOw/Q2OnYop7AdIr4DKxWtzjq8Rftwtt0C6eQx6okCCptgHMxllsGNge/q9z/dM4m5FYCfcCXPuuRkKpTMZiR+YHRILH9P/oKF6eUVBP93JmSO5Z8FhRAcNKQAXukqE1Pg/n029E38xZ0asHZhare7rijgLcTVByVZFjz4dXF10OzbmVJYS0/8Ex3ELc1F9479rPYuGshRcKAaaef2mYlNiszSGmqhGZCjBwJjL5FAr2h+mUPDGlA7LZKsARP+jj3e93sbOMjGABydnLURFgRK+OSYormRNkN15hevOa7/VQ4Bv9ziVshSYt8eiNXpENYx+TE2vzH0Jm1j0NFkFtI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ACD50DC412CF9A41B0647F6ED9BBD7BE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da97e2b9-b7da-4a82-5e89-08d67a45b5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 17:28:34.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4634
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 05:01:39PM +0100, Federico Vaga wrote:

> > -17) Don't re-invent the kernel macros
> > +17) Using bool
> > +--------------
> > +
> > +The Linux kernel bool type is an alias for the C99 _Bool type. bool
> > values can
> > +only evaluate to 0 or 1, and implicit or explicit conversion to bool
> > +automatically converts the value to true or false. When using bool
> > types the
> > +!! construction is not needed, which eliminates a class of bugs.
> > +
> > +When working with bool values the true and false definitions should be
> > used
> > +instead of 0 and 1.
>=20
> A very minor thing. I would suggest to keep consistent, in the
> statement, the mapping between definitions ("true and false [...]")
> and their correspondent integer values ("[...] instead of 1 and 0").
>=20
> In few words, I propose to change "0 and 1" into "1 and 0".

Hm, sure, seems harmless

> > +Similarly for function arguments, many true/false values can be
> > consolidated
> > +into a single bitwise 'flags' argument and 'flags' can often a more
> > readable
> > +alternative if the call-sites have naked true/false constants.
>=20
> Of course, English is not my primary language, but it looks to me
> that here a "be" is missing: "[...] and 'flags' can often a more
> readable alternative [...]".

yes, sthanks
=20
> > +Otherwise limited use of bool in structures and arguments can improve
> > +readability.
>=20
> I'm going to update the Italian translations for this. Do you want
> me to contribute directly to this patch? Otherwise I will send a
> dedicated patch later when this one get accepted.
=20
I think you should send it as an update I guess? I don't really know
the process for translations

Jason
