Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ADA20C0E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UpSu0Jwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ADA20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbeHGQN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:13:58 -0400
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:31533
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727429AbeHGQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pecy+jeI7zmAiDkGR3C6CCQL2JNKtl8cxfAQW8FlRA=;
 b=UpSu0JwmpIWmh7/cQ6cwE0IIr2D0Jkl4LxKPVPDqiWbfkKcVnaGM6R1FR/f5rHQ43t+0rKaCzz+7wbBlL3CslT+RJuln3Gnkd8/5OWjnjCtmUfQtAtFD9kFz1bfzAdjrKbjO+Vzv7mC5Muei/N8YSDUJXUtG6yL4xebt57iTRyQ=
Received: from AM3PR04MB338.eurprd04.prod.outlook.com (10.242.110.15) by
 AM3PR04MB1169.eurprd04.prod.outlook.com (10.163.6.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 13:59:26 +0000
Received: from AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::54ea:85dd:e8ee:d864]) by AM3PR04MB338.eurprd04.prod.outlook.com
 ([fe80::54ea:85dd:e8ee:d864%7]) with mapi id 15.20.1017.019; Tue, 7 Aug 2018
 13:59:26 +0000
From:   Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [PATCH net-next] [RFC] dpaa2-eth: Move DPAA2 Ethernet driver from
 staging to drivers/net
Thread-Topic: [PATCH net-next] [RFC] dpaa2-eth: Move DPAA2 Ethernet driver
 from staging to drivers/net
Thread-Index: AQHUK0TQAhBfBUb5JkG7x+SRGzuJ9KSuO3GAgAYatRA=
Date:   Tue, 7 Aug 2018 13:59:26 +0000
Message-ID: <AM3PR04MB3387FF9574B9C0509F54DA294270@AM3PR04MB338.eurprd04.prod.outlook.com>
References: <20180803161221.6322-1-ruxandra.radulescu@nxp.com>
 <20180803164239.GG15029@lunn.ch>
In-Reply-To: <20180803164239.GG15029@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1169;6:YO93rLpGzvzeUgN2Ye2C0o/oepJ1K+GlCy4BbUny9J/FZPxVlngSBHgEr5MT3naop9Pk7FbupO7IZ1aRWUrp5if0e7CFA3sWvPrqsDttLSZHfo2/KLb9aEJQg3Kj1S61itQoyXEMFvZheNxLHTcYT6FVI5VqjCoEj64P9pfdrSfff/x7EIos4RNHoo1p1Vj9q1ypT6UG/lTU3ooyyV5n73aoBVkyTnr773YEjjhDTZKPqEplbEUCk1JyKvz3R26qz/b1EJwfRKjjwCE5TOaguN5yyKPxgBFipYB46DtHjSUcUrVAMnn3VtcCYK0a5kAeGtfwqXRfsvWjWqa9Tj4TZ4gQKlne1WnwBV2fYoSkJ4G9CTQrh8z2T2GvEmLOLGJJlnGgp4Syqsk3OzrYduimahO88lmvFodZM/JGMx5LHFagvXbgccp1w3IfrHKmOaibIPAmdvhanS9MHxpcOOymjg==;5:Ustr2HEZEXlrTjtFhMwoMHKM6GzzMSGGEyVpjWAPPySVtqw53/dWB7JtORie1L1WekS6XaxowmeKz2Dk7cEmG13fgxXCYXyfOfr8kaqxYBAnyQy13CLOO4TlXzvJK2ASP3x5fErosmd7O2Y9n9WZrQxt6mTozO6XbLneA5TMYhU=;7:ZYoWSK5Mq4Jmv/yJ7KPNMC9PphzgdMlxLu1x9Z7pOhwhvDmcVJ616eWKJZynTViaaEBS7gGX5t4bWLNx0k5yuHFV5DpV81sHTs9XhAxe0TXRJbnPCD51XdeiTP/WqJiPHvQRgxrL9Ysy1ngEKSrlJOCRq0u/H/sPu9eQoRvPPLctbExogzumk7MfgtuBijkhCRUZENugOhjH6uE3hQAI5wPN6QIDvXpFgf65SjEnbF82DR5a2cYyYxVEyEeKWDiJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3f98859b-018a-45d6-719a-08d5fc6dfcf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1169;
x-ms-traffictypediagnostic: AM3PR04MB1169:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
x-microsoft-antispam-prvs: <AM3PR04MB1169153A51C657345C058FD194270@AM3PR04MB1169.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(275809806118684);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1169;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1169;
x-forefront-prvs: 0757EEBDCA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(366004)(13464003)(189003)(199004)(81166006)(7736002)(99286004)(305945005)(106356001)(105586002)(2900100001)(7696005)(76176011)(6436002)(2906002)(74316002)(81156014)(229853002)(54906003)(8676002)(5250100002)(476003)(486006)(86362001)(5660300001)(11346002)(66066001)(8936002)(316002)(55016002)(4326008)(6246003)(26005)(9686003)(53546011)(446003)(33656002)(6916009)(6506007)(3846002)(6116002)(102836004)(478600001)(97736004)(25786009)(68736007)(53936002)(256004)(186003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1169;H:AM3PR04MB338.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mh2nJ9OovGVSxSt4JPFwZjAya2jVfe8E4AkEvBjiJwNoDHzSSXfE+dlUzIDuI04ehzBghkVBnqVHEhs8kSIVLJVm1ZdqLRR+T9YS826WFU3tWtwqsuws2f3jDozMC6G0C+YAbmAG4yR/UxHWwe6HYaNxhDZYkzgt5/+cdha8D3u8aaeImHkX43d2sSkWDXc32QRgxicUI4CA/bmS9l/3bo9Ho6i5rEZXtwz8jvevyN1irRSE3NYdRpdeNrJHEK4jhhbaJVn7dQHKHgz3mYaOjo2C2kKc1BqH8jjuQlnvxkEbKwpMCTjtxNWs+RqLsNdf0CqBdKAiia52NDxbzHApVCwuyzUbaW9YMivH49Ih/V0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f98859b-018a-45d6-719a-08d5fc6dfcf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2018 13:59:26.6370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Friday, August 3, 2018 7:43 PM
> To: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net;
> gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; Ioana Ciornei <ioana.ciornei@nxp.com>; Laurentiu
> Tudor <laurentiu.tudor@nxp.com>; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Horia Geanta <horia.geanta@nxp.com>
> Subject: Re: [PATCH net-next] [RFC] dpaa2-eth: Move DPAA2 Ethernet driver
> from staging to drivers/net
>=20
> > +static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
> > +{
> > +	struct device *dev;
> > +	struct net_device *net_dev =3D NULL;
> > +	struct dpaa2_eth_priv *priv =3D NULL;
> > +	int err =3D 0;
> > +
> > +	dev =3D &dpni_dev->dev;
> > +
> > +	/* Net device */
> > +	net_dev =3D alloc_etherdev_mq(sizeof(*priv),
> DPAA2_ETH_MAX_TX_QUEUES);
> > +	if (!net_dev) {
> > +		dev_err(dev, "alloc_etherdev_mq() failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	SET_NETDEV_DEV(net_dev, dev);
> > +	dev_set_drvdata(dev, net_dev);
> > +
> > +	priv =3D netdev_priv(net_dev);
> > +	priv->net_dev =3D net_dev;
> > +
> > +	priv->iommu_domain =3D iommu_get_domain_for_dev(dev);
> > +
> > +	/* Obtain a MC portal */
> > +	err =3D fsl_mc_portal_allocate(dpni_dev,
> FSL_MC_IO_ATOMIC_CONTEXT_PORTAL,
> > +				     &priv->mc_io);
> > +	if (err) {
> > +		if (err =3D=3D -ENXIO)
> > +			err =3D -EPROBE_DEFER;
> > +		else
> > +			dev_err(dev, "MC portal allocation failed\n");
> > +		goto err_portal_alloc;
> > +	}
> > +
> > +	/* MC objects initialization and configuration */
> > +	err =3D setup_dpni(dpni_dev);
> > +	if (err)
> > +		goto err_dpni_setup;
> > +
> > +	err =3D setup_dpio(priv);
> > +	if (err)
> > +		goto err_dpio_setup;
> > +
> > +	setup_fqs(priv);
> > +
> > +	err =3D setup_dpbp(priv);
> > +	if (err)
> > +		goto err_dpbp_setup;
> > +
> > +	err =3D bind_dpni(priv);
> > +	if (err)
> > +		goto err_bind;
> > +
> > +	/* Add a NAPI context for each channel */
> > +	add_ch_napi(priv);
> > +
> > +	/* Percpu statistics */
> > +	priv->percpu_stats =3D alloc_percpu(*priv->percpu_stats);
> > +	if (!priv->percpu_stats) {
> > +		dev_err(dev, "alloc_percpu(percpu_stats) failed\n");
> > +		err =3D -ENOMEM;
> > +		goto err_alloc_percpu_stats;
> > +	}
> > +	priv->percpu_extras =3D alloc_percpu(*priv->percpu_extras);
> > +	if (!priv->percpu_extras) {
> > +		dev_err(dev, "alloc_percpu(percpu_extras) failed\n");
> > +		err =3D -ENOMEM;
> > +		goto err_alloc_percpu_extras;
> > +	}
> > +
> > +	err =3D netdev_init(net_dev);
> > +	if (err)
> > +		goto err_netdev_init;
>=20
> At the end of netdev_init() you call netdev_register(). From that
> point on, you device is live. Its .ndo's can be called....
>=20
> > +
> > +	/* Configure checksum offload based on current interface flags */
> > +	err =3D set_rx_csum(priv, !!(net_dev->features & NETIF_F_RXCSUM));
> > +	if (err)
> > +		goto err_csum;
> > +
> > +	err =3D set_tx_csum(priv, !!(net_dev->features &
> > +				   (NETIF_F_IP_CSUM |
> NETIF_F_IPV6_CSUM)));
> > +	if (err)
> > +		goto err_csum;
> > +
> > +	err =3D alloc_rings(priv);
> > +	if (err)
> > +		goto err_alloc_rings;
>=20
> How well does the device work if it has not allocated the rings yet,
> when it is asked to do something?
>=20
> > +
> > +	net_dev->ethtool_ops =3D &dpaa2_ethtool_ops;
> > +
> > +	err =3D setup_irqs(dpni_dev);
>=20
> How well do it work without interrupts being set up?
>=20
> > +	if (err) {
> > +		netdev_warn(net_dev, "Failed to set link interrupt, fall back
> to polling\n");
> > +		priv->poll_thread =3D kthread_run(poll_link_state, priv,
> > +						"%s_poll_link", net_dev-
> >name);
> > +		if (IS_ERR(priv->poll_thread)) {
> > +			netdev_err(net_dev, "Error starting polling
> thread\n");
> > +			goto err_poll_thread;
> > +		}
> > +		priv->do_link_poll =3D true;
> > +	}
>=20
> Probably the correct place to register the netdev is here.

Good point, I'll fix it in v2.

Thanks a lot,
Ioana
