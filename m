Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D9C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A24217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="nyxoR4Mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfBFHvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:51:43 -0500
Received: from mail-eopbgr140085.outbound.protection.outlook.com ([40.107.14.85]:7591
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfBFHvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fjFmgiQHzS9dhgyCSYr//s52C+P0gZ6d6/CRuh1hcQ=;
 b=nyxoR4Mc/8uHGRZWiB2P9uevVRmTddY9bcmKRRKY3xE0YVOVU9s9nM86EtTpEzW+6zU2MBWoucnBzoRCJk8ZOrYK7vTtEOEMSCESdIrcRfDNzapiaGXNOTSn9JGXuRoSGCTgCYHPzxUrt7xgFhMuPrv3OOlCbqPHW7LxCDfIATo=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB6278.eurprd05.prod.outlook.com (20.179.4.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 07:51:38 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 07:51:38 +0000
From:   Ido Schimmel <idosch@mellanox.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 00/12] net: Introduce ndo_get_port_parent_id()
Thread-Topic: [PATCH net-next v3 00/12] net: Introduce
 ndo_get_port_parent_id()
Thread-Index: AQHUva5OxuMdQIeiKEeI1MwbcsUxgqXSZjUA
Date:   Wed, 6 Feb 2019 07:51:38 +0000
Message-ID: <20190206075136.GA2283@splinter>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0014.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::24) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB6278;6:gOvsXRkRwufBG5efl+gZPNYxoA06FK4VD9YexxrqQNpaj3z4zTd6OOLJqrvUGtVtwzpV/V7TYHbgGCiOVQuNCUYmAnf8jiEekNH7mQUspX1V+YmgGok+YiIZ2PaR8GMjceI+YAPgz0qJT7GuFRkmZxv/2yzEtd5FhZ4jNmLDzfbckauYvKvWkp/RRbDMODa4beOfvHrS0/C++i9Ya4tP4wytHYe8MvjHIuRSm3l3MC1S9xdyN4ve+tquSwSB0efBawRaHB72h0RoWfBpMpHJy6hJrJFHFzv8XMHZkUF2ajUvwAY3U0n+p+0luBBPOO+G2wOHS6FXOzZ28ZiZ7Pix1c6rBsQ/pGids9rnzPbNQfvqA6gWrP4WZLCgNX+BmNYkez5xsksISiCi0CD0AIAN+ktZT5ek1ypgm538kPNS0EKkIpi0sa92lZDyhokdJbtrI7JTkd17eSFDe8tCiv15XA==;5:9LHudXbKVtj7d2o+HcB4wvv/3klXi6XS9LJwo5y85EtkRS/PCdVaAzglnlnXalbSnv1UN6jRFLL30eY3W3GCs39khEF1qu1Z9cgWZMR1Kfb7QHGaRYVrQcUrvVARZ6Vg+aCoy8xzCo2azdx9RQVn7MV+45nznK1IHj2vjduLc7ktFc+phZIFyBb9IsXwz/zzloBy6bptixb2o0vlRZGUqA==;7:jGiZYeagk99tuJS+h4QdP3amZLrCKwu8ZMmpZ/kO1bg/eNI//FdG7qu+sNaVhHmEjBnjhnp5bUFasJM4XtB0uFpZBB+7wdHG16stcMPL4hZb1c2818zIiyW/oF12Pr2LNfhWeLis6AT/ZU2p7pn2zw==
x-ms-office365-filtering-correlation-id: f077152c-6183-45c9-3f98-08d68c07eca8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB6278;
x-ms-traffictypediagnostic: AM6PR05MB6278:
x-microsoft-antispam-prvs: <AM6PR05MB6278B8781EE93C4694DB12A3BF6F0@AM6PR05MB6278.eurprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(396003)(136003)(366004)(39860400002)(53754006)(199004)(189003)(6246003)(3846002)(6116002)(446003)(11346002)(4744005)(486006)(386003)(476003)(86362001)(66066001)(71200400001)(71190400001)(6512007)(9686003)(186003)(33716001)(26005)(76176011)(68736007)(6506007)(33896004)(102836004)(33656002)(52116002)(14454004)(1076003)(53936002)(105586002)(54906003)(229853002)(316002)(6486002)(8676002)(256004)(2906002)(6916009)(81156014)(81166006)(7736002)(106356001)(305945005)(6436002)(8936002)(99286004)(25786009)(478600001)(4326008)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6278;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lgaJod9JFKQHLHiGJHVY6EzuH1R9wcIk7ey0zC2Shcob5rVQ2ezaw+UnrbVx9KO0i0Q9G7iGI+nGYJ333ILnbDRQnlXxkFlSAEkbHKABo4OgigzhsnPEYdt2vIpnSXew8dLrP/pJ6ogjxImerIUdwnNZYfyY0NBKUmSqmxHDhQyuR2sBEcCSEbt15rZWHwNTsSztctMFko+wz8JgW9/Cc3IaFvswQj01vHTqQzprieITIICpT5XryKIV598lNWdpKEO80vuVsk/xmHYqrpDHeSTWiMf31jaukFXQN8DSGutOsIBYgFHaAsmfUB4exXcvnF9XTouiQ4iv0bFKbI/tQSrawazK8KcmuriYw9515ja+O+gLCVnfLjjBXVSXYqRmfPhWMF7rXXZhYC1yf1uUzuOHSgbMVya62OqlTFNz1fc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <388E482218ED4E428D59B4AC8420E216@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f077152c-6183-45c9-3f98-08d68c07eca8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 07:51:38.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 03:53:14PM -0800, Florian Fainelli wrote:
> Hi all,
>=20
> Based on discussion with Ido and feedback from Jakub there are clearly
> two classes of users that implement SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
>=20
> - PF/VF drivers which typically only implement return the port's parent
>   ID, yet have to implement switchdev_port_attr_get() just for that
>=20
> - Ethernet switch drivers: mlxsw, ocelot, DSA, etc. which implement more
>   attributes which we want to be able to eventually veto in the context
>   of the caller, thus making them candidates for using a blocking notifie=
r
>   chain

Florian, patches look good to me. I'm going to build a kernel with these
patches and run some tests. Will report later today.

Thanks
