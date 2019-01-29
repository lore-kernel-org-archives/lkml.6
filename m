Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51311C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E932177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XmAXoRnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfA2G5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:57:55 -0500
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:54880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfA2G5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 01:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1ly/XyXbRR1V6GpDzsMp0ihwXxe9lk5dqoP78bwlXY=;
 b=XmAXoRnDNA0yG0LB9h1s88gMbjdLHQwMvbTc37hjrD0/KL3TJaP0aNjRspf2mUCC8uEqxt30aa+5GYodWCFMCrS11NfaxQeAJfN1yMHpRFPoTdd+OLu+UFdRMCfKbNPoLZEigMfIOMl2JyNrCO+MZNEuOWYATpiApDqXlDX6VsM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB4573.eurprd04.prod.outlook.com (20.177.55.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 06:57:51 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::a1c2:cc79:80f3:3bcb%5]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 06:57:51 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: RE: linux-next: build warning after merge of the spi tree
Thread-Topic: linux-next: build warning after merge of the spi tree
Thread-Index: AQHUt3a62Ee70mxZo0K+W97/inGmg6XFz85Q
Date:   Tue, 29 Jan 2019 06:57:51 +0000
Message-ID: <VI1PR04MB57262F1ADEEC151C11E0F48499970@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <20190129130237.677e5ac8@canb.auug.org.au>
In-Reply-To: <20190129130237.677e5ac8@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [92.120.0.7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4573;6:tk95TelleNSn619VjU3L0uegPek+DRjrYnbmMlNJkKgGHY2plb9M6YCZWSXKDoZ6WSOYWXgZxIx/pLwy+XBX5xNq0nw6icKesKAUCQK1e69dluvMGqYUYZ2n99lLzUQRrjYZFBePH4sfR0OP8OMs6yfckqGQoKneRnJa0f7k8sEGesbcdj3NnxjpzYzuNwuHf+wgiqf+URg9LF2aVFwpGK4jmlXDHi2g9QmodlI0tuAgvBhBfyxr79mcRYE0tX0iJb70S1vz5/4xusl4335nOA3DGz8Gm3LrM66VqgeoNhkwrPlKMt7agv+KuDvII9N5PenR9f58fk0ROuGKCeJ0y36f8KbOfQwuBrCPSm7idXAbrenjqDVrCdHLX8lEA0n/Mf9GxHz2Hzmlq88K7BqeG80ZbcZMnGHrR0C4uWvkkZDHiVGqHYMM2/FfPzQPpQ1rXCDnkMWI5DxBSgSjpmaMrg==;5:pA5dn7TB7djZsVfYKkHz7MPPVNZ4Y5nqpUWZdxYp3Q57/HVn2ohLRixVEk3pMZinSzbdnbqMZyGip2zUI+m5WF+VEdY5N7AtTmMU/pWMn62qCsU9iAhIvAdRJoD7tN6K2hOjIqwA+Xr2L3fXSubPoLamVPEnCrMkTSa8M/3FDERC9bQdsKDQ1gxhB2oZWSFc7aDAeNcz6oX5RgM8+ti6rw==;7:JvwbC10Ma/j8+RFmxHgUIsNX2Ro/8FwKdQW3Ubeij5EYWtUF6U27UlJ7Aj+L5KsGKkswWI5Dn0JT5BPK2Lva2dTXp9qZKqpCd4pEHytr2mj9lfF5wxyyZqXZIUBxotOymQpv9Qo+7vaeb9dYhyWcDQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8b7bdfd-6a00-46ef-8544-08d685b7160b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4573;
x-ms-traffictypediagnostic: VI1PR04MB4573:
x-microsoft-antispam-prvs: <VI1PR04MB45734A569D683766A653882199970@VI1PR04MB4573.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(13464003)(53754006)(74316002)(99286004)(305945005)(14454004)(66066001)(316002)(7736002)(3846002)(71190400001)(110136005)(54906003)(2906002)(26005)(33656002)(7696005)(76176011)(102836004)(71200400001)(6246003)(53936002)(53546011)(6506007)(105586002)(97736004)(106356001)(186003)(68736007)(11346002)(229853002)(8676002)(4744005)(55016002)(476003)(14444005)(486006)(4326008)(6436002)(478600001)(256004)(9686003)(86362001)(25786009)(8936002)(446003)(81156014)(6116002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4573;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uzl1jejUcrvgTuwAHLjL8/AnhzfwexOKmk1z++oVOYswpXZbnPvj1TvN8ndUpj8Y8nyausGKElQK4F1XqhDiHfrEG5GifL1gk8NMLqwUZqCHfxtc+XCi8dHC5rH2jTqyQ9mWWjgSIJA8pg9duRV3g2GB0m41NNGX4TWxjDNNosJs+gDVY9SCB7OlwtXs+OU5y1OEiWahpo2+0B6vpEzufBlnsTfaRU6pybyCDS/Pvvu7SSU+8+6CLcl9yVaeGtwGwT0Gn3SISIJaujw40Q9BQPFFtsS/8l4hI+QErUByeyvmd6oGSzlXXUHWypRkgL0zftZ5AnGkpROOQlC7ZyV8zpPjrePd/rNDY6VaADtBn9OgI3WUlcCM7CDqw+YQ+pv9NcLqR6/GrFTTmzLG6Oc90xvJA8rKQjz+ioIGt7k66T8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b7bdfd-6a00-46ef-8544-08d685b7160b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 06:57:51.3566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4573
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Stephen Rothwell [mailto:sfr@canb.auug.org.au]
> Sent: Tuesday, January 29, 2019 7:33 AM
> To: Mark Brown <broonie@kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel Ma=
iling
> List <linux-kernel@vger.kernel.org>; Yogesh Narayan Gaur
> <yogeshnarayan.gaur@nxp.com>; Frieder Schrempf
> <frieder.schrempf@kontron.de>; Boris Brezillon <bbrezillon@kernel.org>;
> Ashish Kumar <ashish.kumar@nxp.com>
> Subject: linux-next: build warning after merge of the spi tree
>=20
> Hi all,
>=20
> After merging the spi tree, today's linux-next build (KCONFIG_NAME) produ=
ced
> this warning:
>=20
> WARNING: modpost: missing MODULE_LICENSE() in drivers/spi/spi-nxp-fspi.o
> see include/linux/module.h for more information
>=20
Can someone help in pointing out that why above warning message is coming f=
or mentioned commit.
Below MODULE_LICENSE string is present in the above mentioned file, drivers=
/spi/spi-nxp-fspi.c.
    MODULE_LICENSE("GPL v2");

--
Regards,
Yogesh Gaur
> Introduced by commit
>=20
>   a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
>=20
> --
> Cheers,
> Stephen Rothwell
