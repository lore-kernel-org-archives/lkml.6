Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478306-2-9715409721297655876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521478305; b=IY3X9RWfkngXC6+0n5R9jAmZoFcLZnoRZCBVEvO1MR83p6t
    qov4xczjLpSkrpZhgvPRXhad36IAyIgvXhx67WhYfguuUUfF2lY++6x1KxH91mD8
    87HuskbuoMtCR7dEiMc/89JXQ8eb1rHOxEYTWsZ0vMb0CcjsYrgfQHvYhnAuCOnT
    LDS74+3YkWIRmnJIHrvRUEDnUvgFzecRO9tvKEnzia3RjsOttxvkBZPr2VMfWQwq
    BoFbWCO8Ltli3c3JRHk1WOc06YkCBGHzIrtr2g2Z0U9n2MTbTmUEifTZdG8yWufo
    SQ+/uKxe3bVD++rXgleUF55HnbEltOrK4pXjI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478305; bh=RheGOc
    sXOGBv14HTYyrYRbtGJmqqygKM4nqbSFtz1kk=; b=pKCK77TF1SNCE/b+XELqPU
    FaLCDGOYzarN64eIV3pouUNw7ptUx7GAB7YkypgqC1kc4wUMIbTVYKbOOX5Vuv6j
    t3Vg7XiKWXF8dppu0lK+8fiPSFxT2gnyY5VtPJlLutBlMyrsEEee2V+eEyZnSs0J
    9lsvezekOnyG0T263sQ0P+JRetdQ1kp7/VHSl+ueYkPfjrit0xj+dzGxFhxJxxeG
    QWenZRt/vsowRNstpWobWkKR6wm+f68gt6PwUV/iyquE8bqA4Ii2ZUg/sKswaFIT
    XPYnbmyUQlvN792txX1y8+ARsE3rPfTKhjQMkUBErV/c/eqJppQ4pJ3IJWoIazog
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EtI/Jx7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieehnecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EtI/Jx7q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegieehnecuvehluhhsthgvrhfuihiivgepudek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967262AbeCSQvM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:51:12 -0400
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:24704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935144AbeCSQLt (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 011/102] net/mlx4_en: Avoid adding steering
 rules with invalid ring
Thread-Topic: [PATCH AUTOSEL for 3.18 011/102] net/mlx4_en: Avoid adding
 steering rules with invalid ring
Thread-Index: AQHTv5z2ZasFsq6Z0EqjlcdzEOro/g==
Date: Mon, 19 Mar 2018 16:11:39 +0000
Message-ID: <20180319161117.17833-11-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:+GxIMbdPFg45lhAMpa3Xpo7L92oJ4P0MG5EKF+vE2vJO+bh/El8ShtHHarbymp6r5cwJWAlEOLkS7xJivJyJAi+OsHdSzhaG0L3kz2uNtf0RULSrM8fTivu+G5O1LX1icdBGB4TvLNZEGmxI5lD6YHZa7BRXCT/dMB0nb7S1vDL+nKrmOKGsduJ0W/ED6eJE5KoBiMFIp4Ucfc7A4Q3jqDNEK5RWOnfff+IkJYO0SkobTM6s5051rjODTYjFiBi2;20:JgP4Mvm76XPLmrR+SnYIZtdX+jt4CSRhpmUE9/HvjQFI5w+n3kA/4pGQkGye+1KyLfnKhtqNrCFXdL/1P/7exnDdI0NhWNlb3VeGLS2c8BFePrx6uyX+bNoiDrigxUJBltpbMX3IKU/axgDMn1vRGVB4lYHkd6Ule/pt/a5bTzE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d094bb5f-ec1b-442b-57dd-08d58db418c6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984F1C643D5D83CC932DEC1FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(5890100001)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: idb0YkQsbO0QLshNSga2Fa9W82b7f5KgM110IvcjSLOrP3DdwItBnNVovZ7ELwl1Pxg6PlVVAgrW0lqbZgFmpndWLvBUj0M5WLSA9p3KuLoZ4BO/mV5LRp4hnqqdYwsRChm3eyVQFed8ok3synfwtsVm2Qf58qoTCjJyPXZG6iRWaL5MTWrl4NeANeKobbtB+c2vsRDjeEzWf2ycO8USAAKG+7K/Rl+S2TYhKNk8U6IcsQFbhTQkLTw8CcmLVrcgrkeRoU7me6gcHQDNhUYgEcmZihaurqKrVC98iSjna0avdpCf0a31KFtAeI1uwbvMqZcLP0SBVCl7UvEUvNFUaw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d094bb5f-ec1b-442b-57dd-08d58db418c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:39.0693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Talat Batheesh <talatb@mellanox.com>

[ Upstream commit 89c557687a32c294e9d25670a96e9287c09f2d5f ]

Inserting steering rules with illegal ring is an invalid operation,
block it.

Fixes: 820672812f82 ('net/mlx4_en: Manage flow steering rules with ethtool'=
)
Signed-off-by: Talat Batheesh <talatb@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/=
ethernet/mellanox/mlx4/en_ethtool.c
index ae83da9cd18a..17b3950e04a7 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -946,6 +946,11 @@ static int mlx4_en_flow_replace(struct net_device *dev=
,
 		qpn =3D priv->drop_qp.qpn;
 	else if (cmd->fs.ring_cookie & EN_ETHTOOL_QP_ATTACH) {
 		qpn =3D cmd->fs.ring_cookie & (EN_ETHTOOL_QP_ATTACH - 1);
+		if (qpn < priv->rss_map.base_qpn ||
+		    qpn >=3D priv->rss_map.base_qpn + priv->rx_ring_num) {
+			en_warn(priv, "rxnfc: QP (0x%x) doesn't exist\n", qpn);
+			return -EINVAL;
+		}
 	} else {
 		if (cmd->fs.ring_cookie >=3D priv->rx_ring_num) {
 			en_warn(priv, "rxnfc: RX ring (%llu) doesn't exist\n",
--=20
2.14.1
