Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4C82084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="f1PW1w4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfBYJtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:49:47 -0500
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:16672
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbfBYJtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC0FC1DHkFygybBFFoLGJXKoznqoL5SXk5r1GEBjanQ=;
 b=f1PW1w4Ud2RbEEUDTGk2LmtB+ASF/6ROd0Bie4gkFGUC1E56zYNj5ALVZSKYx059xktERIVG5TQvKA/V7O+s5UZtMvOe46SlbQI5b2OSPm9fXlfMzo8Rwf1Y02Dg734QsxJsm36cdpim7iNWQG7zYfgC+BHqR11GWOOPxBKsPDw=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6551.eurprd05.prod.outlook.com (20.179.18.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 09:49:43 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 09:49:43 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Topic: [PATCH net-next 7/8] net: switchdev: Replace port attr set SDO
 with a notification
Thread-Index: AQHUywrdkdsT/LOBwUG+oBo6MXUQTqXtL/eAgAH7MoCAAR2bAA==
Date:   Mon, 25 Feb 2019 09:49:42 +0000
Message-ID: <20190225094940.GA15128@splinter>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
 <20190222235927.10295-8-f.fainelli@gmail.com>
 <20190223103207.GA13070@splinter>
 <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
In-Reply-To: <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0602CA0024.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::34) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e369216a-6264-455e-39e0-08d69b06911a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6551;
x-ms-traffictypediagnostic: AM6PR05MB6551:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR05MB6551;23:aVcNKHPQBvPamLjUDhYKos12NG7sSmUlXSxDrvj?=
 =?iso-8859-1?Q?JM/Asd6PYwCS8Y2woSoPu/avPQ1i9h5dNnR9kqfLJ155iViT9S347u7RfP?=
 =?iso-8859-1?Q?/3xjtscDFiKpS3Izlm6QJrqOf8hOELcwnDQb9YIBdLZJA1rawIDVxDn73A?=
 =?iso-8859-1?Q?Cxw3JanUaZKCmgLhwj2baHg0m4ONITTPCSUaJxdwcdAfz3agViX2l6lQL4?=
 =?iso-8859-1?Q?b0924mn7zF+afMAlLqeJ/SQXKfBxqpcCYZpPXgnaXx0S+3ILlxpeG5lkdJ?=
 =?iso-8859-1?Q?pK+NkeYtPHyZp5TzsLeHmv0y0QELcL9rkGAkTZ44ILRUZ/1tnOhM3HQkhZ?=
 =?iso-8859-1?Q?SoC5Tj+rjOKJzU537VeI5TNB+tWsZ1YPhJpwippkhEoh9bqGAxt4L6Ej2D?=
 =?iso-8859-1?Q?kjcAjTecFJ8WGAA1xnjbeuIJgHDJnTn2EyblCtvKZiyFztQHYEa4sSV6Z+?=
 =?iso-8859-1?Q?BWaWz7b0j9/oYjO0eqNsiPyHyrpt+vwq87kjqECaG2bE2beywn9/zWp+eP?=
 =?iso-8859-1?Q?YXrtKVXylY/ccMA1FEOuTl12JwOG4doJd+6XAEkN02NDg7LRzPN+1w5Kim?=
 =?iso-8859-1?Q?nyu9j1TmKJPHNYrlMU9OAZ19I06uXJHgLJXMTjOODIxrBwcKOQHm9BkUwc?=
 =?iso-8859-1?Q?nCuub82rUJ6svAfde1w7Ha6mAXFVzelBAZlINYzczm2M5FT4TIR/cb3otF?=
 =?iso-8859-1?Q?+5ZnCsoeGLFmqlzk/Zl2JkeV3L6/kJM6E/TJzHuQ8IVtocgYl+SRpjuEI9?=
 =?iso-8859-1?Q?5IJ8Mn3oF39rtpzSASM06vuSqv4D533Syb8PK1vjNF8okc54BjMFoi0L87?=
 =?iso-8859-1?Q?yvDQMXojcZj0UuKibjezK2lxBzO6s8fbfwalih1tAKwoi4iBtEdNi7TLCu?=
 =?iso-8859-1?Q?Ul89WyXajrNjaNzlMe+OUKLF+Or5Eyqalw5jZWWH+XM21pW1oevVKQQQ3G?=
 =?iso-8859-1?Q?JBQHPPDlw9QnsjcYt9RkIMlu9LD3JNSML5Nl/pWasoMmwVCeqx86BAld+W?=
 =?iso-8859-1?Q?vjpCv+TA5uSSbvgxzre1BTra1Rhh6cuPotP2J1BtI2Lj+1woM34EykDe2l?=
 =?iso-8859-1?Q?LPm34dj/AQaOg2rVIxHwcm75NC32HCbfLOL9RndZ349Lq0RgkNOZ3910Ps?=
 =?iso-8859-1?Q?YTDGT8VgO9qSsqUMOvHlQKvzgW+mSvpVJfFPeewnmcTdt5TPQf4rM1aeoT?=
 =?iso-8859-1?Q?GCbhRwTstUydPoESaPvnK5JMBjFI8naV6ddBUxtfhiknI51WjFo2tXMcgs?=
 =?iso-8859-1?Q?qNdfCivkmsD+PhJfbimU077GPrvFKzw9S9KtD3OonlC748xfQnM4AiOfCJ?=
 =?iso-8859-1?Q?b+JVuRtSIclN7+tBVmqxFUqxKUYC5jaVYhysKsvZkTULFy+I7mhmUlSHPY?=
 =?iso-8859-1?Q?5y3qhEVs=3D?=
x-microsoft-antispam-prvs: <AM6PR05MB6551DFF31DBDC78B66F6E7CABF7A0@AM6PR05MB6551.eurprd05.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(376002)(366004)(396003)(39860400002)(346002)(189003)(199004)(99286004)(5660300002)(81166006)(81156014)(102836004)(11346002)(386003)(6506007)(54906003)(2906002)(446003)(476003)(8676002)(256004)(6916009)(97736004)(33656002)(33716001)(105586002)(4326008)(53936002)(14454004)(76176011)(6246003)(106356001)(8936002)(305945005)(52116002)(93886005)(316002)(26005)(71200400001)(71190400001)(186003)(25786009)(1076003)(66574012)(229853002)(68736007)(6486002)(7736002)(66066001)(6512007)(3846002)(9686003)(478600001)(6116002)(6436002)(486006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6551;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xr/AHA9xj5rOeS9QAdlFxQ/rFLnY7499w6ZPxJWnYAqgzTpNeABFCwO5/wOgUtONdKM+1VrFsvRrau9Khz6mQhD5NqQ0xYEtA/PJNRupXWDlsPPGpZrAGWjfkwpM1eKCA97U7O/tXMznfS4ZtXuZM7yhaMMNZlYlW3NOdVv8NIbLkDFrvS5JTEkLPcbkNMnlXl+CVMD9LhtBdeiHk3KYb6VKsfZ64P1oT1mJzaFsg2pWfSkhEt9bNBBU9LrY9Ebr1NQ5jtBTAENH4THWVN6EMzeChWmvTx5e4uhv5Pi4F6xDlA5SY2qa+zehMphy3ib2C4gHR3Eog2H4eIrCjRNs90nRIYyyI+33ka8lIPf08KVVJD37USxiN/da4xlwEx5/346pS9Hsyz9IZ0tDXKc5TE8qkowQcr/EpYCOPbMV9LI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6DF005F2CFAE0A438F5A632B515DC704@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e369216a-6264-455e-39e0-08d69b06911a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 09:49:42.4026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 08:47:27AM -0800, Florian Fainelli wrote:
> Le 2/23/19 =E0 2:32 AM, Ido Schimmel a =E9crit=A0:
> > On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
> >> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
> >> +	if (attr & SWITCHDEV_F_DEFER)
> >> +		rc =3D call_switchdev_blocking_notifiers(nt, dev,
> >> +						       &attr_info.info, NULL);
> >> +	else
> >> +		rc =3D call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> >=20
> > I don't believe this is needed. You're calling this function from
> > switchdev_port_attr_set_now() which is always called from process
> > context. switchdev_port_attr_set() takes care of that. Similar to
> > switchdev_port_obj_add().
>=20
> Except for net/bridge/br_switchdev.c when we check the bridge port's
> flags support with PRE_BRIDGE_FLAGS. In that case we are executing from
> the caller (atomic) context and we can't defer otherwise that trumps the
> whole idea of being able to do a quick check and return that to the
> caller that we cannot support specific flags. How would you recommend
> approaching that?

In this case you can invoke call_switchdev_notifiers() directly from
br_switchdev_set_port_flag(). Eventually switchdev_port_attr_set() will
be gone and bridge code will invoke the notifiers directly.
