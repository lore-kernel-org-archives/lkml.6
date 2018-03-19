Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480833-2-687638920341393853
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
    t=1521480832; b=Ux/MQU9KQyVVeMpcgvKZFq/9Np2YM7+JGWYCqJI+Zy97PEH
    nmVFiM4B3d82gYFmPJFzb0Hc52BH5YmbC8bsAyhaegoxYz4CZWXzlB+mOZXWRNZ7
    at0P4aVydnIfK6OEYN4KZtlbtmXK2KUzjjnUs4aYebk8UmND0a7ThSNSoMLaJMbG
    zK5oq9Wn4mBsrTyBgJWZ6HcPdvGOuqbrGiVzsXD4XnWwlXVx5AqB0SuCKDhBtTdW
    l34zn1bP+aXKu1J0w7Ul3ZB8WRGAeMefJ90NXcOsdDL3NykkOybwLijWOjyd8Lr/
    IuOLnRuFono7thkmaxS+lvv0nfWkOLAr+fq/w+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480832; bh=5RcC42
    xmh1WJJYrlQDaJLa8/l3dDkZkCxZ0bouaQaJ8=; b=AovJhfcQJKfUSAnn2NdVha
    07AdIkc2htNvYUnbpw6BH30XjWdnnpxthF9Jot33+L+FnbzL5hIu2PWXB+tHm4E+
    PMnxYrdLwEDywNJK+kyZ1Jzm2Jp3P7j/YDJQuOGdsSeJ9TdEpSB/7ok5kCYiof8J
    yHdy/dOGhHy1iMLcmJSy5T6q9ee0b5KwdFPl/8H1KZUx47bEWMIhwuXdqs/0PI+v
    an3sCVBYI8M/6F1P7xMLKMmZ5Bxrtz5fCmKaYUlY2SCgzau7VtI0YaZJnNh62nai
    OyR6omb3Izq6x2oRNcg/R8I10tqTv+U2k3sOh/jPo3LfVCsxzXy7GDVh2sFSKZiQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lpv8jYUn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeejieenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Lpv8jYUn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgeejieenucevlhhushhtvghrufhiiigvpedvge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966103AbeCSRdk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:33:40 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:20505
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965952AbeCSQGw (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Talat Batheesh <talatb@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 018/167] net/mlx4_en: Avoid adding steering
 rules with invalid ring
Thread-Topic: [PATCH AUTOSEL for 4.4 018/167] net/mlx4_en: Avoid adding
 steering rules with invalid ring
Thread-Index: AQHTv5wi0XNbCV/oMEWJDD9eSMqJqA==
Date: Mon, 19 Mar 2018 16:05:44 +0000
Message-ID: <20180319160513.16384-18-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1093;7:+wbXAfqC9UYiGLAPOSgCmRGF+U1XbEm5r59D+vsaOb5LdUEFNLLR3t4+3V384HGv/CLuwUSPT3vaTljCNZS0xE4etrg3uKMaBdCad9sK6uPDRm18ikqw6CoZ4bHKk8skUAzS+mEsi3Mpju7JhSURIKLYPQqs8l31t04JmVUR/g2p7s8rd/H2D2jdzkDFEKZsU9+IShKoLVTy0fEDM1C+XNmUgBRyseO7gJPuUD5Q01gt0vzhLWjAbTGB/ZGbcJrp;20:1J84JYLpWAXw/FKUN50LaArP0JYIrJx+TUADYVDsqS1pg1rB5RvFiFFojRrMw32PAl5dejZ9+iwJlaqvP8oN3L6MNymKB1rlChY1mKQPXl8NuFvlotHFGXSZ3rcziDznjzhDRHzRvsdczv/FPU+xN8hj4lnJ0y8PMiS0l6RX6nQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8af49d36-479d-4dc6-ac21-08d58db36bd1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1093;
x-ms-traffictypediagnostic: DM5PR2101MB1093:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB109308A230C6B185758B732AFBD40@DM5PR2101MB1093.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1093;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1093;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(10290500003)(68736007)(478600001)(110136005)(72206003)(36756003)(99286004)(97736004)(10090500001)(305945005)(7736002)(6666003)(76176011)(107886003)(2950100002)(6436002)(86612001)(6486002)(4326008)(54906003)(186003)(3660700001)(25786009)(26005)(2906002)(53936002)(5250100002)(2501003)(81166006)(81156014)(2900100001)(86362001)(5660300001)(8936002)(1076002)(8676002)(3846002)(5890100001)(3280700002)(6116002)(66066001)(316002)(6506007)(14454004)(106356001)(6512007)(22452003)(105586002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1093;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: KJNftOR2D+uuziyncrYGzk+KEP98HMj31iWrEWRz+t3iTMO2nuezyfThBI3dwoamN/XbXDbZHh23DAfo7ZAZQ/58FVJX7JB/Pwsxv4v4VzbAX/QQJOzTvsnCLO/QAj2r4A3t2x1fBZNw85XbQF2LgI4V39h3nBUgAkRyLSPhU+ODbK7Ij80y3tLifYKrb1C5aryFHuRmpN+OrjAaLPParZXmPBdEZuZA1vRQ+XHQSQRqNX3nV27TFAO0E5P3exAxXTDWZ5SunTUs3In8edd1sKg00oyKDK4BRj7cOVpg+xhNStYQTjdK7bPBZ35g2fDXwElD2XKmMHBMqQFWjOLVig==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af49d36-479d-4dc6-ac21-08d58db36bd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:44.3260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1093
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
index ddb5541882f5..d9bb185f7320 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -1513,6 +1513,11 @@ static int mlx4_en_flow_replace(struct net_device *d=
ev,
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
