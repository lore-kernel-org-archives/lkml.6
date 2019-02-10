Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027B8C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78720811
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZIbmoA6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfBJPnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:43:24 -0500
Received: from mail-eopbgr130081.outbound.protection.outlook.com ([40.107.13.81]:65113
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbfBJPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PktgmW/25H7gITaw2osmVE+hXF9TEp3aHZOcofZkA/0=;
 b=ZIbmoA6fi/gRHUIREDAhD0wHGTU1o/qzywaEe+n3qiMCK2XK6U2rXHGORMQ7v7yZ+HlDFt3TdwYYj0eN5KopWoZFgkX86oI/mp7tBErhJcf84b4asqVb8n1DTu/eoBf2be/cwHSarSVbqcIRun9m34wYOj3cOTx2UyN57KlXNCo=
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com (10.172.216.13) by
 AM4PR0501MB2723.eurprd05.prod.outlook.com (10.172.215.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Sun, 10 Feb 2019 15:43:16 +0000
Received: from AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::15bf:a58d:3097:bd00]) by AM4PR0501MB2769.eurprd05.prod.outlook.com
 ([fe80::15bf:a58d:3097:bd00%4]) with mapi id 15.20.1601.023; Sun, 10 Feb 2019
 15:43:16 +0000
From:   Ran Rozenstein <ranro@mellanox.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ubraun@linux.ibm.com" <ubraun@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: RE: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
Thread-Topic: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
Thread-Index: AQHUuw0UstR6Cw2r7kCu3tfALWKWF6XZLqiA
Date:   Sun, 10 Feb 2019 15:43:16 +0000
Message-ID: <AM4PR0501MB2769C4BE6CF1C5B051068D0BC56B0@AM4PR0501MB2769.eurprd05.prod.outlook.com>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-10-deepa.kernel@gmail.com>
In-Reply-To: <20190202153454.7121-10-deepa.kernel@gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ranro@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0501MB2723;6:APhytEhwtQB8KUH2PklVFQbX52CjpiV8MPaQdIsvEKubFG26tjCs99+uSfb2ZeyJglmdsrKkGYmtl73cGI76DejTpDN2zGiumtLe/xHSTe7LJ8/EwFLMTnA71JdrkRiPYx9mwL5uQSc2m3oE1ylfHn/4OO8+QE6I86sFRu0ce5BqNL2YFBJgBZhWSY2zyFv5/da6ViFKDsWMzXc+HEIPaCz1Yc7TWp4AZN150IB8g+cPTNs+EXNqqSshL969RTtnUNYARVRUmhrf7A7T7QTUCcnF8Ngb3wrerhVhJVfrtgns/1nU/Kav2UdBMSw5kMxAzK/KZr044nwQ8ZcYYoHJrnhOWm41ijr9bWeXk6qWdS7eKKEwY2ghr7gb7uNL3uOKILvkE2RXWlxwP1oy/4k0q/1qGiRCRbZ3h06BIII9k0kgL6acm6VQdQk0ISUnicp4wncpwEadl2ZNgYa+4h4QIQ==;5:waltn7Hjg6uB7ntJVQPXX488NnciKUdT8jjrdPnN2jFHDnZKO5Ok8Bu7DH76NH7LVr0EeKbz8CWmwuhEX7TiKjHQ90ZxhEySykjuoPTzExOT3myLHJDGvUnR+C+WH8NaBsPqn+hv7FNkl250qQDvfKKNidYYOEgXmFOrsk+1y1mt8QkGHdvifiF9geuHRaIx67Y7AydXwI/tXoUu3PDqHg==;7:BKi2EHnFiuwJ1UjU+iPLlxqCV9ZgvIdR4QpREBjkP65YhtF188RdUhm7g/wv7sDnfb893JAkoabExsmb51PbZNFqZ420APa+MNomNJB75SQCOvpI8Ag0Ct9WZuz1D1vluphq21OW9yO3NzK2QmghgQ==
x-ms-office365-filtering-correlation-id: 2173d389-8eae-4f2e-01f5-08d68f6e794e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2723;
x-ms-traffictypediagnostic: AM4PR0501MB2723:
x-microsoft-antispam-prvs: <AM4PR0501MB27236C4BE91864FD6554EEDBC56B0@AM4PR0501MB2723.eurprd05.prod.outlook.com>
x-forefront-prvs: 09443CAA7E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(2501003)(33656002)(68736007)(229853002)(76176011)(7696005)(6436002)(11346002)(53936002)(446003)(6246003)(25786009)(99286004)(476003)(4326008)(486006)(97736004)(71190400001)(71200400001)(105586002)(26005)(102836004)(106356001)(14454004)(3846002)(6116002)(110136005)(54906003)(478600001)(316002)(74316002)(186003)(66066001)(81166006)(81156014)(7736002)(6506007)(2201001)(256004)(305945005)(9686003)(7416002)(8936002)(55016002)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2723;H:AM4PR0501MB2769.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ONqfc8+cfPe9sjHmzY6hOwezk+Zpc45APK0BO2SHLeg+ydcDdbZcrH2QolekL1VlTpbnQtQJ1YpURGSeK5W8ywSfpHm48MEeIaHtT6vq+tar72lgm6xrSey3mxsq+RJEt9z8Fget+aYx5ordLM0NhfOts8cCxBX30jOb9oZknO1CjwwtomLZoXSVCxnyanqAhI0QGwKPWfVNpAQWYb5xuHmM2MD57/8tagZkEuiazlVWpk2pb/n3T6uFjhR16KPLZYnuDcmb8YzO08P4abzUCu/8OkpdE7IbK9Khzj5ikqlOuh48RkYwWQ5oi0w6awp3entVNKhJg7eZEzPFcp+V14UUxvmMYqKD4+UmB7Y52NhKT9oDJYyztdlKBTJ0x7E9dINB5lE76a6bgwQuKAZdC4nci4JLlxJbwWSGO6We3CE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2173d389-8eae-4f2e-01f5-08d68f6e794e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2019 15:43:16.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
>=20
> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD for all
> architectures.
>=20
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Acked-by: Willem de Bruijn <willemb@google.com>


Hi,

I have app that include:=20
	#include <linux/errqueue.h>

It now fail with this error:
	In file included from timestamping.c:6:0:
	/usr/include/linux/errqueue.h:46:27: error: array type has incomplete elem=
ent type 'struct __kernel_timespec'
	  struct __kernel_timespec ts[3];
                			           ^~
I tried to do the trivial fix, to include time.h:
In include/uapi/linux/errqueue.h
	#include <linux/time.h>
	#include <linux/types.h>

But it just add some other noises:
                In file included from /usr/include/linux/errqueue.h:5:0,
                                 from timestamping.c:6:
                /usr/include/linux/time.h:10:8: error: redefinition of ?str=
uct timespec?
                 struct timespec {
                        ^~~~~~~~
                In file included from /usr/include/sys/select.h:39:0,
                                 from /usr/include/sys/types.h:197,
                                 from /usr/include/stdlib.h:279,
                                 from timestamping.c:2:
                /usr/include/bits/types/struct_timespec.h:8:8: note: origin=
ally defined here
                 struct timespec
                        ^~~~~~~~
                In file included from /usr/include/linux/errqueue.h:5:0,
                                 from timestamping.c:6:
                /usr/include/linux/time.h:16:8: error: redefinition of ?str=
uct timeval?
                 struct timeval {
                        ^~~~~~~
                In file included from /usr/include/sys/select.h:37:0,
                                 from /usr/include/sys/types.h:197,
                                 from /usr/include/stdlib.h:279,
                                 from timestamping.c:2:
                /usr/include/bits/types/struct_timeval.h:8:8: note: origina=
lly defined here
                 struct timeval
                        ^~~~~~~


Can you please advise how to solve it?

Thanks,
Ran


> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.=
h
> index c0151200f7d1..d955b9e32288 100644
> --- a/include/uapi/linux/errqueue.h
> +++ b/include/uapi/linux/errqueue.h
> @@ -41,6 +41,10 @@ struct scm_timestamping {
>  	struct timespec ts[3];
>  };
>=20
> +struct scm_timestamping64 {
> +	struct __kernel_timespec ts[3];
> +};
> +
>  /* The type of scm_timestamping, passed in sock_extended_err ee_info.
>   * This defines the type of ts[0]. For SCM_TSTAMP_SND only, if ts[0]
>   * is zero, then this is a hardware timestamp and recorded in ts[2].
