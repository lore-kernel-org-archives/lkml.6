Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9225C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED120684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eCqxG9+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfBWIp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:45:29 -0500
Received: from mail-eopbgr50040.outbound.protection.outlook.com ([40.107.5.40]:47008
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbfBWIp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKUUFDM1eh0npOI8T41v8TGeA3Bao48r0bd5buRZ3ZQ=;
 b=eCqxG9+3FS5pSBi4uGuozJ+oT3JqJkvXJ8UGmzkMm2B/ohqMxm30nhmIw5hnUzN6Ae4aDxl8DE+9S5taVK/cpM4ZAbco+iqHusLsLJwCDaWSW2itHIQP/6pXxoBKRiSUvvXMdb1UH8xvmovU10JXYMwKRFwTfWW4ogEWETy8DfQ=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB2766.eurprd04.prod.outlook.com (10.172.255.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Sat, 23 Feb 2019 08:45:24 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%5]) with mapi id 15.20.1643.019; Sat, 23 Feb 2019
 08:45:24 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:DPAA2 ETHERNET SWITCH DRIVER" 
        <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: RE: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice
 check
Thread-Topic: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice
 check
Thread-Index: AQHUyvpLtz/9Xsbtsku40mZJ5Ia3d6XtEOgg
Date:   Sat, 23 Feb 2019 08:45:24 +0000
Message-ID: <VI1PR0402MB28009A8333F247A753F44F94E0780@VI1PR0402MB2800.eurprd04.prod.outlook.com>
References: <20190222220214.25401-1-f.fainelli@gmail.com>
In-Reply-To: <20190222220214.25401-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.127.41.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf50d65c-1e93-41b3-fbdb-08d6996b40d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2766;
x-ms-traffictypediagnostic: VI1PR0402MB2766:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR0402MB2766;23:kP9OkRoCtHOY5f+6FyIsgH2/1Lli/yMR+OwL2Tc?=
 =?us-ascii?Q?dwQE/gOQLkNIY3AUTPu4bOujJRWRxLtElNk9BUWauUM9JxoV5CVvxaHLaAvp?=
 =?us-ascii?Q?hGZHNVleidadZc7GrkJV9Fyv93sgwcBlSBrXmdupdiA+mvhug2MnsjBuao5q?=
 =?us-ascii?Q?kIBYNey0nXQELT2SA4//zKIhv65eQSsVWri0KBmKZgYUrk9AxHIeTZZtGcCP?=
 =?us-ascii?Q?0iEx4aOx87fE0INX6zZlotXNKQ7iO8GW6xZFR2uaI5wXiVSVyntyj/+IMTZ7?=
 =?us-ascii?Q?GV9MMIVTrSGLmNVk/L8rMctE2ofrZSy0iitFjIhf3adGQyKHiGO5SsZ3Frk6?=
 =?us-ascii?Q?UR1L6VHMEE//vGn7GRSJAIMo/p4aUfHip5HKiQlrnPmoCJIi2K+TpaB36yV1?=
 =?us-ascii?Q?AShclgPrX3Qnz/NaKN9aFH72Xm4koZ5odkml6BZKF1bg95wwRrFlbRjMWXgc?=
 =?us-ascii?Q?2jcQDSDD1jFS8+5pB5EAvsSbFvU4qSgCXzzxieKAvHfmqbjZUBf85IsZJlDK?=
 =?us-ascii?Q?2lsVQfvNwJ4YUCGbFlwGiFlICwOx68ZoGknTVk3fNwGGsl3zjhBSNivzQ/PX?=
 =?us-ascii?Q?W8kCkodtkVksOqHaTl6t3TOmrLZwbXnDUiROaEf4+QtdjZzsXsIWLIZL84iT?=
 =?us-ascii?Q?wdpshCnokqefio7+if+7QwGrwi+9HizTuDnzpvQpaMSHaoB3WBxBQEp3GVFw?=
 =?us-ascii?Q?SgieM8LsxtjZMLLuuNlwTUhdedSq368CPGjjwRg5KblfTXwQGfNIL1mT9n6G?=
 =?us-ascii?Q?ty4eiGNCZTCDeREB0Co30O402u3Bt2IaG/z/sn70Z9749ohJUKj7J6d+rq37?=
 =?us-ascii?Q?fALEywkSech3M/iDdbC7Z+vc+BiTl4/qaL6VCUkeJ5iKNPRUozOqNG4cE8UJ?=
 =?us-ascii?Q?OgfF+xR5UbRRxFZQvhJREYkrP9uaF5weljm1fp8ROsjFrXJr0agVV6Af62sd?=
 =?us-ascii?Q?gQPXFBNGvNZPxwAFeGzV4UsC7Ob8V8S1SYNqOhXAMc5/m7lNc27vDdi4PPDF?=
 =?us-ascii?Q?gtaotPsyELNwZ+0Y57IvCw/ug3SVGo2l8KmVSu/dNwU7ejsK9UI85ogMVqM4?=
 =?us-ascii?Q?DTtGSNdBkEcM7/S6M+Q0j91IDd+LhAkl5Jj++b+CpK27HGQYYN/K/3uteJwz?=
 =?us-ascii?Q?TQhrlnlB5dkWnHf6IoGSLHw9ud9i1EN+NDdohL7cDZycrJUbz86d3puUeZE7?=
 =?us-ascii?Q?2sh7AAmzOmxehdEbm9EfJ3D3MsmdrlKgfoDWtxcC8aLpN/ft99YCaBzxP8ar?=
 =?us-ascii?Q?Is55jLT0kvbYPo2f8Qz3D+q8R4xpLdUBdE7IeScjU0Svl9N+jGqKLXVeI3VT?=
 =?us-ascii?Q?oSA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2766DC4C38B48D4963CED1B7E0780@VI1PR0402MB2766.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(66066001)(6436002)(6306002)(9686003)(33656002)(55016002)(229853002)(97736004)(3846002)(6116002)(14454004)(966005)(478600001)(25786009)(4326008)(53936002)(106356001)(105586002)(6506007)(102836004)(2906002)(26005)(446003)(99286004)(476003)(76176011)(7696005)(11346002)(486006)(44832011)(256004)(186003)(71200400001)(71190400001)(74316002)(2501003)(316002)(54906003)(110136005)(8936002)(5660300002)(86362001)(81166006)(81156014)(7736002)(6246003)(8676002)(52536013)(305945005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2766;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bmTMWA5aFlSqyomoY6cWl8uZ+NB59F6Za34HGpRamid1J6CjMWEVmnK6910IcqT7wRfHERF30LPmMZD1yQr3O2E6yjmU60evBsaVgM/6iQRfSDqM3exDX0MRD3svGWgdjg1SA82ODu/9FyDUlF+00legCCU5xhsxAgeQRuArKp5NQbsfH3CORqCSp2Jgc4ZX2EBkglBVBIW0u+So6EZ5toz+3huxHb56RgkjtH4bgYCA+ZCtvcKdXdPI9D3jdFjc0t5eK9qfCjxX1OLRQh0OAGXuEH9dQcLJ3j8fSCjhWmYP3WdoFdyON4NdZ5CGxpMF4jvjftZH0vtQSsLBzBMe3KjV+Ps/y1jdoPAekkP2fLWDl+7jA536Ilteb6klH8T5HTxxTkxoV6HXDp+Edm3sJUvBWwG/C8p8VrdW55pRxyY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf50d65c-1e93-41b3-fbdb-08d6996b40d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 08:45:24.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH net] staging: fsl-dpaa2: ethsw: Add missing netdevice che=
ck
>=20
> port_switchdev_event() does not check that the target network device is
> actually backed by the ethsw driver, this could be problematic in a stack=
ed
> environment case.
>=20

Just FYI, I sent a patch set containing a similar patch verifying if the ne=
tdev is backed by the ethsw:
https://lkml.org/lkml/2019/2/6/216

I sent the entire patch set against the staging tree.

Ioana C

> Fixes: 44baaa43d7cc ("staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ether=
net
> Switch driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fs=
l-
> dpaa2/ethsw/ethsw.c
> index daabaceeea52..2edd82f5229a 100644
> --- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> +++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
> @@ -1047,6 +1047,9 @@ static int port_switchdev_event(struct notifier_blo=
ck
> *unused,
>  	struct ethsw_switchdev_event_work *switchdev_work;
>  	struct switchdev_notifier_fdb_info *fdb_info =3D ptr;
>=20
> +	if (!ethsw_port_dev_check(dev))
> +		return NOTIFY_DONE;
> +
>  	switchdev_work =3D kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
>  	if (!switchdev_work)
>  		return NOTIFY_BAD;
> --
> 2.17.1

