Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498034-2-16025151706707487233
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521498034; b=mENKFdb17TS1Dev291kl4bG63JNbVM48/02y2NJvtjBUZ/o
    /SX25nkKprkFKS7yJJZx4VMhOXEk/WoI84tzxZNeL37zMT7t6ICX3TXmF8vBpF6/
    VCRkmB79Z8QcD0jeNxlPsVTLSgMIFa5iTd8kk+bWTeNxU9hJnT7R4+0C4mGgQ15V
    XKK+CAa9b0eyZ8Y4MofbrpNNvJ7ONP5S5vG4jjtkYGXQmMvqj/HgpL+ryrluucZw
    xRAcUAsFqpO66VjmTg4rkwkKk2Ac5oGH0VFZWMMfWH7rwTB4wBoRx7H/CNB5lydj
    grHXeZVULwf6XkPGBG8ICWh517g4GwJk6o5LxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498034; bh=GCX0g9
    omGqMdl3E3DC8aAFMlbEV7b5vNfrY4PjyxHHM=; b=p7bpgwDgmiZ+h+1H+WidnU
    DixRufcD1i4ML/nww592JZw6Vf4iTSa+VekUL4p2RuKJfKogRw99i65G1wTlwVsx
    pOF+DSjpwTgDQzilbAPd1van80lj6nsJiYOzilviX9jxrHcJ/988B9SjykGOe1nd
    IkBC8f/xazilUykLZBwBZPuoCKIAEGdLMxmzKSTvUaofxVTY9v3zzzEG4Jlv8POA
    qUxL+ICyurMCDWXEw/uig8YgoDQKZOczSZ7JTiV45EGVvYPczotPcMWgMsbY/rdz
    d5diOOq/vuuDu3jHymMf7rKd4I60aDyd2BN0PCZbsfpB4TVEkHnablEaEQnqUPAg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRDibYXM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleeikeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BRDibYXM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejleeikeenucevlhhushhtvghrufhiiigvpeduhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933847AbeCSWU3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:20:29 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:60759
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933937AbeCSPtT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Feras Daoud <ferasda@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 090/124] net/mlx5e: IPoIB, Use correct
 timestamp in child receive flow
Thread-Topic: [PATCH AUTOSEL for 4.15 090/124] net/mlx5e: IPoIB, Use correct
 timestamp in child receive flow
Thread-Index: AQHTv5nAelRmdTUWzU+Y/+hVMa2srQ==
Date: Mon, 19 Mar 2018 15:48:39 +0000
Message-ID: <20180319154645.11350-90-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0981;7:+5TtkrWMtP7nmF/O8wBl+p39m0qjTrFqAIYsQshFA6POryrseaFo7Dovl8LU9L92Q82S7UDr9duYnNbig1VuXEVBPFO+U2WzukGBlxoX/lCllflIpsBNgOqJGQR035SuDZu3/LwVynWnxtPBMQxQnMbuElHVWUJbV4/pH6idowlYlwat04INe3jI6ufY3e6qWS8NzmHhvRrL+gDxmgqgGyOS5xJz7zou/1q/ZHeCT9Cq3H4shH+xFaoS0EXLJIGN;20:4/tNtc8HmWuSslAEfO3Ybvzdes5tdkpH+bKuNtegtJWtBiKgJ5Cd4Xn99s98Uu9ujmokhtVvRkLm781UZp2DTsveoZmRlHZuQpMN8gh/cEhXV0YjTG+EN6tVNhDs6raBut+aaSJQy7uTfJri6msWonooKqx4tUu546iJKzm7UPc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ea79f42-6ac9-4098-7123-08d58db0f257
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0981;
x-ms-traffictypediagnostic: DM5PR2101MB0981:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0981279143E9DE7AA96E7580FBD40@DM5PR2101MB0981.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0981;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0981;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(39380400002)(189003)(199004)(66066001)(6486002)(26005)(110136005)(5660300001)(54906003)(3280700002)(6512007)(68736007)(102836004)(6436002)(107886003)(10290500003)(53936002)(186003)(59450400001)(72206003)(14454004)(36756003)(6666003)(2950100002)(316002)(6506007)(22452003)(478600001)(10090500001)(106356001)(105586002)(99286004)(7736002)(3660700001)(86362001)(76176011)(305945005)(86612001)(2501003)(97736004)(5250100002)(4326008)(3846002)(6116002)(1076002)(8936002)(25786009)(81156014)(81166006)(8676002)(2900100001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0981;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: t7PX9g/SR2efI9eBv6NC/PsIKUC7eLmzGiEcmK4qoLWkhSdkCLfbUehWrOwGg7snhwpxMmD6DnT0i8VpdeaRjo8CK7FHwsSscY2JjoPsNxSujHVsaWSwes6oHOnWaaFdzKYFZY3LUIHYL+IDHbzuVJbqVwghNwSPZ7g8rE+UzcSpilblsOLy+KOFbxlWE5IaVcKAdLOKFpaomCZxcYZZyNQnn3ujUhVgZh9dOGYgOme/3Fqb4B8PEFHaHM76EVRzyje9L+5z/NGD/n6woKvbKS8usMZDJrwA6jN2zzRJDuTNtdmBaqYeIDviYG9iXZIr7JRn0WenUCt5/QOK1VTQNQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea79f42-6ac9-4098-7123-08d58db0f257
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:39.7995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Feras Daoud <ferasda@mellanox.com>

[ Upstream commit 36e564b76f1862914ad32c35bab433e07da2ebf8 ]

The current implementation takes the child timestamp object from
the parent since the rq in mlx5i_complete_rx_cqe belongs to the parent.
This change fixes the issue by taking the correct timestamp.

Fixes: 7e7f4780c340 ("net/mlx5e: IPoIB, Use hash-table to map between QPN t=
o child netdev")
Signed-off-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/=
ethernet/mellanox/mlx5/core/en_rx.c
index 36611b64a91c..f7d9aab2b3b6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1196,7 +1196,9 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e=
_rq *rq,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
 {
+	struct hwtstamp_config *tstamp;
 	struct net_device *netdev;
+	struct mlx5e_priv *priv;
 	char *pseudo_header;
 	u32 qpn;
 	u8 *dgid;
@@ -1215,6 +1217,9 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e=
_rq *rq,
 		return;
 	}
=20
+	priv =3D mlx5i_epriv(netdev);
+	tstamp =3D &priv->tstamp;
+
 	g =3D (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
 	dgid =3D skb->data + MLX5_IB_GRH_DGID_OFFSET;
 	if ((!g) || dgid[0] !=3D 0xff)
@@ -1235,7 +1240,7 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e=
_rq *rq,
 	skb->ip_summed =3D CHECKSUM_COMPLETE;
 	skb->csum =3D csum_unfold((__force __sum16)cqe->check_sum);
=20
-	if (unlikely(mlx5e_rx_hw_stamp(rq->tstamp)))
+	if (unlikely(mlx5e_rx_hw_stamp(tstamp)))
 		skb_hwtstamps(skb)->hwtstamp =3D
 				mlx5_timecounter_cyc2time(rq->clock, get_cqe_ts(cqe));
=20
--=20
2.14.1
