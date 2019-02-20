Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FB82089F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netmodule.onmicrosoft.com header.i=@netmodule.onmicrosoft.com header.b="VkqTiaVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfBTSQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:16:07 -0500
Received: from mail-eopbgr140102.outbound.protection.outlook.com ([40.107.14.102]:44873
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfBTSQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector1-netmodule-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLLKF7LOkPEC1uoIm3UMLA0iZpRnY+JM96eHXdcxTj0=;
 b=VkqTiaVgbf29XHDNNKDHnLwRRmTh1zm4fFQ1kvWM0hGG7smCV0McO7qJ8XiBoS/5kPH6ES5oYUZw8+B3BHaFMjp0SNZks3oVZDeWJMdz6Cqzwzuy64RVj/ruU9qn2N1kvmy2xM5avaxsq9r6t25JD4rkcNa0v8RsNRq0eYjkii8=
Received: from AM6PR06MB5894.eurprd06.prod.outlook.com (20.178.93.141) by
 AM6PR06MB4168.eurprd06.prod.outlook.com (20.177.37.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 18:15:04 +0000
Received: from AM6PR06MB5894.eurprd06.prod.outlook.com
 ([fe80::a8b4:f455:315f:e54]) by AM6PR06MB5894.eurprd06.prod.outlook.com
 ([fe80::a8b4:f455:315f:e54%3]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 18:15:04 +0000
From:   Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Marcel Reichmuth <Marcel.Reichmuth@netmodule.com>
Subject: [PATCH] net: dsa: add missing phy address offset
Thread-Topic: [PATCH] net: dsa: add missing phy address offset
Thread-Index: AQHUyUgzULgH1qu5306pO+2T82cCJw==
Date:   Wed, 20 Feb 2019 18:15:04 +0000
Message-ID: <20190220181426.2970-1-marcel.reichmuth@netmodule.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.130.140.44]
x-clientproxiedby: VI1PR02CA0047.eurprd02.prod.outlook.com
 (2603:10a6:802:14::18) To AM6PR06MB5894.eurprd06.prod.outlook.com
 (2603:10a6:20b:97::13)
x-mailer: git-send-email 2.11.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d76e21a9-e3b2-4e9c-2cf5-08d6975f55e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:AM6PR06MB4168;
x-ms-traffictypediagnostic: AM6PR06MB4168:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR06MB4168;23:AEbIsp1Knxi1intUIdd4Ukf05X8hiB/UBP2Kehe?=
 =?iso-8859-1?Q?mxAVBOsTeUsMFlwNjJbp+GMVJGlinQ3dhDC4VgguMAU0g4juZGHjyl0Z0C?=
 =?iso-8859-1?Q?IC9EM9bHMNToANM2ziQCiD9UDjv8TkrG0HiIwNK0YRCnL0Ei6htqA6+SPo?=
 =?iso-8859-1?Q?Fr5E4Aoh9HstoHJ7ixSEClSOGpUJBMYF8olqf4Kr5Wb2v79z+p3mZVz0Bl?=
 =?iso-8859-1?Q?FXrgIZn3E7VGmEiICOUEcaJxwh1jG7LExSog9sTBkTt8nmUazzJmiQNbxf?=
 =?iso-8859-1?Q?0I8vaa75s9/Kl5zvEEB0igomfF3Au/T967mDI75lFTxKrc0/bNJRcq3J4Q?=
 =?iso-8859-1?Q?pOhLl96mfU+SMkCwYmSYKBPGdyzb4o6m3OL7ibtRTCtljFJDV0RCDeYSHF?=
 =?iso-8859-1?Q?SGEi9ai1/WKqv0zbU4D/kxTiVFbfAmQg9hAFwwR1lwmZ60jMYORwXbwAsQ?=
 =?iso-8859-1?Q?8Hd3wGcWfApsZVeSGmisRMXomU8i9y4BJKtauE0i0+HY2d32qSDbMnok5m?=
 =?iso-8859-1?Q?VFqsdOFmkgQkpq2VUlyKiJJa5j3XB6Nmp5V3gOFLPu8S6W20hzXwu0suh3?=
 =?iso-8859-1?Q?qD1rnzIaZaod5+pulWbtV251QvrGhI8L50oUs4Ruh0COlQ49fB8xkDpTMB?=
 =?iso-8859-1?Q?hPr9KfYt5w7N8JB5Cq154Z3I0AAnMst7kfUe1ifxy/04U7R38lEw5f+1fx?=
 =?iso-8859-1?Q?BH/9SKsqJBXkxwPiXmHtxVuLU6NJitkvEy8Bs3Y+kD3mj9yZcNaq5w2NYe?=
 =?iso-8859-1?Q?Kw4ocyDgCtS5xjotMvH/CPBrw/E4NF9GcQSvQ2WGh3807LdgqppoJD7b+g?=
 =?iso-8859-1?Q?o4mifzBFItvGhIfpMlrSwvpen2q3pScaBdwH+b/eK+8ppLuHEfhZCSLGUQ?=
 =?iso-8859-1?Q?Xp1K5B3P6wH9ncAGExKeASks42Mf8ZKVNb9xiEOGP4tgWwCnl8znQzoRHK?=
 =?iso-8859-1?Q?HS1NT19ovAmsUuODcC6N6iHNrR30mgBEkflVeUMZcqAoMbcIX0ZlMEoufi?=
 =?iso-8859-1?Q?xiRrYjmfmhf1SXPh/CfOcrc91v5s31RhCmP2De8BoYQi+GBAv5ZjzR459Z?=
 =?iso-8859-1?Q?xzgYO8SxMg9Xvscgi9DyXy+k+tlwMMb5q1yGDvRCriAW6t8anEdmFT0jyE?=
 =?iso-8859-1?Q?EkyIT1bH9eSItAW41wYHuw6hYMss1QKibXiJUOpGHyUE8ydJLdPidH4iie?=
 =?iso-8859-1?Q?I4eilc4h6k0WNPfK8kkvNqCasr+NChrSJibuRscfZA9KMPmhZbFZ5AHsnn?=
 =?iso-8859-1?Q?d/PTGQ5IhTPXbceK6JZu7E74mlnEejnkTqabKmk9QJUDF5svD4qNEFBDBa?=
 =?iso-8859-1?Q?nbD2fc0oXkonZ8HaEYz8ECF?=
x-microsoft-antispam-prvs: <AM6PR06MB4168C9E39D309E00E618399B9B7D0@AM6PR06MB4168.eurprd06.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(105586002)(97736004)(14454004)(305945005)(6116002)(3846002)(106356001)(508600001)(66066001)(99286004)(72206003)(54906003)(7736002)(81166006)(8676002)(110136005)(25786009)(81156014)(8936002)(4326008)(2906002)(2501003)(316002)(36756003)(107886003)(26005)(186003)(386003)(6346003)(44832011)(1076003)(6486002)(476003)(71200400001)(86362001)(2616005)(5660300002)(52116002)(6512007)(71190400001)(486006)(6436002)(14444005)(68736007)(50226002)(256004)(102836004)(6506007)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR06MB4168;H:AM6PR06MB5894.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netmodule.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marcel.Reichmuth@netmodule.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AvUmmaTjG5xGMcXwKXultHFtNhlceoMi1oywDk550O84hSweyAY3rHLm2kZN2WI9XP46oossm7R2jC4rSms9o03aEmgFqi7rJiK0o2yNpBXRT9h2ARc9IlmOq99/6A1TT2I1wrJhZPGbE0i6T4tCHfA7ja9U9je8OilDLZEAr3LW9QR7McP5NzYVwmFRWe2+ivq7n7eYdcJX5YodEbHA2WN8de7AOLUJBI+X/GGxb9Kt0fOmic5s7rEkLyAy/ucGmXqnnDss2Mn7FPSBbYPA5neQoLz75RM8CbVu951eTCgtmUvvra8B08B1L7cOdlqBeXnFP/bzCqfTP23L+0ZE+NWQO0QLxiwO/SEEI+bccIl7YcCqDdtklaRkr8RDxxHAiGpvZYIrolfSADNvHBKlRFM+XUr9mmcBmYceJ0iklhE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76e21a9-e3b2-4e9c-2cf5-08d6975f55e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 18:15:03.4523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB4168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When phys do not start at address 0 like on the mv88e6341 the wrong
phy address is used and therefore the slave ports can not be
initialized. This patch adds the proper offset to the phy address.

Signed-off-by: Marcel Reichmuth <marcel.reichmuth@netmodule.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 3 +++
 include/net/dsa.h                | 1 +
 net/dsa/slave.c                  | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/c=
hip.c
index 12fd7ce3f1ff..0ca649f784d2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2198,12 +2198,15 @@ static int mv88e6xxx_setup_upstream_port(struct mv8=
8e6xxx_chip *chip, int port)
 static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 {
 	struct dsa_switch *ds =3D chip->ds;
+	struct dsa_port *dp =3D &ds->ports[port];
 	int err;
 	u16 reg;
=20
 	chip->ports[port].chip =3D chip;
 	chip->ports[port].port =3D port;
=20
+	dp->phy_base_addr =3D chip->info->phy_base_addr;
+
 	/* MAC Forcing register: don't force link, speed, duplex or flow control
 	 * state to any particular values on physical ports, but force the CPU
 	 * port and all DSA ports to their maximum bandwidth and full duplex.
diff --git a/include/net/dsa.h b/include/net/dsa.h
index b3eefe8e18fd..f9c9dc1f6d21 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -196,6 +196,7 @@ struct dsa_port {
=20
 	struct dsa_switch	*ds;
 	unsigned int		index;
+	unsigned int		phy_base_addr;
 	const char		*name;
 	const struct dsa_port	*cpu_dp;
 	struct device_node	*dn;
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index a1c9fe155057..4f67dff34a3b 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1221,7 +1221,8 @@ static int dsa_slave_phy_setup(struct net_device *sla=
ve_dev)
 		/* We could not connect to a designated PHY or SFP, so use the
 		 * switch internal MDIO bus instead
 		 */
-		ret =3D dsa_slave_phy_connect(slave_dev, dp->index);
+		ret =3D dsa_slave_phy_connect(slave_dev, dp->phy_base_addr +
+			dp->index);
 		if (ret) {
 			netdev_err(slave_dev,
 				   "failed to connect to port %d: %d\n",
--=20
2.11.0

