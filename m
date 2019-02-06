Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5E5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D68E20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Nkc9/A76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBFTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:10:13 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:11440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfBFTKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtehfmoOGxk3oXEMPjG37A+9LNQdGQWyqzyj4MGy2S0=;
 b=Nkc9/A76ziwpLt7s2yQMcgtmX42SscdMWQditxqXXn/r+yOUbBR0Dl1D0j1JWt/Ks79Z7oTiN94VmaSdMxIrzk406mJCYpXixwfIr/RjAqW0ypBBZ+vn5OzaWhqzmHNk1j1FYaU0EjqmCnYDAB0IO65InFfnfcngr+KW1+q0d8c=
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com (20.177.196.214) by
 AM6PR05MB5016.eurprd05.prod.outlook.com (20.177.36.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 19:10:09 +0000
Received: from AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866]) by AM6PR05MB5240.eurprd05.prod.outlook.com
 ([fe80::3542:889c:3a85:3866%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 19:10:09 +0000
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
Subject: Re: [PATCH net-next v4 12/12] net: Get rid of
 SWITCHDEV_ATTR_ID_PORT_PARENT_ID
Thread-Topic: [PATCH net-next v4 12/12] net: Get rid of
 SWITCHDEV_ATTR_ID_PORT_PARENT_ID
Thread-Index: AQHUvkPi09dOgIZerkCuyNwFkJlrXKXTIpaA
Date:   Wed, 6 Feb 2019 19:10:09 +0000
Message-ID: <20190206191001.GB14340@splinter>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
 <20190206174546.23597-13-f.fainelli@gmail.com>
In-Reply-To: <20190206174546.23597-13-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0201CA0004.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::14) To AM6PR05MB5240.eurprd05.prod.outlook.com
 (2603:10a6:20b:64::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.229.58]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR05MB5016;6:sPD0y4eaLDB4mnySN/MG9clP7+sjPEezDD/8BD/v5wRc1043CmFzZxNdxGquf/qdJFXJz3FXOp7X15aNKV+VshDzKjxl3LixmV3u9nm7+mQIwGkaWoVQOyWmRZT2h+jSJGa8KihHy77TAVlElLVnv6K6xPH0x/J78EK7s7AgZh1qio3NizpX2MMlzY/jpm4g55W/OtgaqqQ5/RtxVov/ey1RgRTSTwde1cONlnCwqJbhek3dR3aP/qedfUGA9LxobfWeThtCMvAPtesennHig8U1Q9CMsdqcDFzpBTslA9cVJvwcy3IJPb3EiNWikXVuv+IQ98F4TIR7+y+xRtHIS8aCux0+xqGTv3wgDvk0IzVnIyxRUs7OHZSW80WgDiuISxBtUMK3hx7Q6NzCqaxEaSV2RoBrEPY90XMJNKHZ0l8Aq3nJ09pXxn6+c99LRk6lfDtiPV6mI60mRPRDZ/dvug==;5:+nO5rAJ0Rq13c7ooUhC4FwqCqzrKspfqxSYBXMx7KJ+h9jJqOpt72cAnV2PakQupLVYeqIMFOu5M9VH4F1PclnfgN/TSMk7DVimvcMOosv/HVOH5UYDJRrvqXdc5aQQNdSj3lU8wUJ7pAUiLLayX3kOLSOzbuOfi0APzJsnoGySW+2BWv7u+W0oYkJfLkNzCjLIUIe+TJTJ9DbcNuCBoCA==;7:l1FHJ8pIU+FWEBLRd3WiTLwqMW7ri2jAzy4vyZoQspeoRT+KQVJiteSIPOsupGYs/uARHFnjPfD0EW1HxOzslkQCWiHEJkJxPNlqYKpDaDPoxnRFo4S5lOmL8yWU9Y+O02/i9i6oBwY2bq7cMbs1yA==
x-ms-office365-filtering-correlation-id: 624ffe20-932d-4a29-efc0-08d68c66b61e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5016;
x-ms-traffictypediagnostic: AM6PR05MB5016:
x-microsoft-antispam-prvs: <AM6PR05MB5016B298E2E312915398C253BF6F0@AM6PR05MB5016.eurprd05.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(305945005)(256004)(54906003)(26005)(71190400001)(71200400001)(33716001)(316002)(6246003)(102836004)(229853002)(6116002)(3846002)(2906002)(186003)(6486002)(99286004)(97736004)(76176011)(25786009)(11346002)(14454004)(8936002)(33896004)(68736007)(386003)(446003)(4326008)(6916009)(1076003)(476003)(8676002)(6436002)(478600001)(7736002)(66066001)(6512007)(9686003)(486006)(86362001)(105586002)(81166006)(106356001)(33656002)(4744005)(81156014)(52116002)(6506007)(53936002)(26583001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5016;H:AM6PR05MB5240.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jtA+S2drH7LBia+uOytnrQl8wmQ+AIETvZdE2wZ2ErcKWK7wm4pwW22hXRj1rj1rnXxrFuWlrlAzVGAOL6GsdiIFlh8RQkWub0a4yrFP0g9vd4oNMSVBgE9vIDqqQxlQBCYC/y5mMNNZqt/atvOX8DM0AoYk4p2GTllxwNuUOekayxpiQXzbKTgY0M1Eq64M4eX63x0RYSy2S6oxzcCFR2qpGwPdFrEE0L4UV2MFSS/sVIIBM+1bJh+DntNgP42p8bzz8Y2B0aYnoPb2E9drvdDJ+oG7FCWpUuCqXueKBttx9+66Vd4bysG8Kzugmzx1vxk5b3kKuHlwDXE4sCPLxo9VFroJFLCoH36ex69WePc4X3WuPzwFQRRYw49H5TF/GPX9U8AOaPl0gtG2sp01WyKglSZk2EfB0R12IWI9Itw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45077B349C70DE4D981148D775C01A65@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624ffe20-932d-4a29-efc0-08d68c66b61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 19:10:08.7225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:45:46AM -0800, Florian Fainelli wrote:
> Now that we have a dedicated NDO for getting a port's parent ID, get rid
> of SWITCHDEV_ATTR_ID_PORT_PARENT_ID and convert all callers to use the
> NDO exclusively. This is a preliminary change to getting rid of
> switchdev_ops eventually.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
