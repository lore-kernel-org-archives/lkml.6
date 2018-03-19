Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521478155-2-8969022961262421587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521478154; b=chb0IZID/x3222zDC80jvOuU6kwImaRC699bUPqwW6v+IYG
    wEZ8jf2HOzS1Dy6cmG937leyw3LMS2vo5NDhqhdju94LQuC1wlgbegz28VY6zWpm
    mBUGcPQUDRK+9VT/AaD8QkeOrmuVRD6N/Wb7MEbXS0n+c22aWIaqLYuItPuS6R56
    uZ8gmNruXkuILhoK6HqvPCCX7zVZuaLhk04HYpmIvdkYcMDre6ReeOjHGWBTTewk
    Pvh3C6H3gjriOEQXAOGZQUvhwZMeiYjXPHRKHrpmyZoJ0J9PoYQqgKvfdLukqvzG
    y2Vmw+AeuiQLaYU5VqNruMtxY4uk9MtTMKz90EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521478154; bh=K07EE9
    San1m8A1GIH4qYt4GfNSG5oF64dVVsFMLCrmM=; b=Nat2bUyOZu21zsIavjTOdR
    pmgamhYedtqQpoWhmCRf3FGBh1y/itTw3Y3JJgiJFV4THyFREbSbSvsARGFXnXCd
    pVKZgG+AyF7zllCSprJoeo0t0maMlczVK1+Ajs6eui3rlK3IGYrCiQ4lLdolxHS0
    6LRzZFgdCh3WiKML04HLrvC2MiWBxU/udgMepJC4KqRHqTdxpCUctdKCm6o9T2Iq
    PJDxXiVc4x+brEwiPT/Us5hIc3VaLlsT+zCErUH7qo/xhRcyeDNqdXPWkhaOeQFD
    PSx1xAalqKwM4ZdtezIgE5jIDMI++tFDYm2ib0Pi5F5hsLzVNKQAUocuk0haSW8g
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bGpw1Zh/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtheelnecuvehluhhsthgvrhfuihiivgepleel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bGpw1Zh/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtheelnecuvehluhhsthgvrhfuihiivgepleel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933771AbeCSQL5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:11:57 -0400
Received: from mail-sn1nam01on0121.outbound.protection.outlook.com ([104.47.32.121]:24704
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935177AbeCSQLv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:11:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stefan Wahren <stefan.wahren@i2se.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 013/102] net: qca_spi: Fix alignment issues
 in rx path
Thread-Topic: [PATCH AUTOSEL for 3.18 013/102] net: qca_spi: Fix alignment
 issues in rx path
Thread-Index: AQHTv5z3Fp9hY6xwJEiJRswW4v6ZOA==
Date: Mon, 19 Mar 2018 16:11:41 +0000
Message-ID: <20180319161117.17833-13-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:f90IA95+9mcJzgMA3b74TTWa28Z6RHOYZdYwRPEW6frxc5YJAGAYlPUAPq//wrVb1byCBQRf1t/CfeekcBeT4wEMVFkbV2S+bi5IVTEby2Ht2j8D78ySvgjdBht5Rhxk4k/LWgkx0pBMQ3D0k7IQvTtp6MULuZXjdUJK3JGGWyrk7k91FyWvSfSl044JRSLtGIJqSG90rPGFm7p5PQkh/VUo3KABhe+nkb/X6/6yV5aGd2WfYx4nghxZnASQ9+z9;20:0/+fwveo/aB6CrelmrQFgDSMvtZxRKSNao33CA2vJVn8Z2N9+WlziA3/Jp6W4w3GdndebaaoIkf+srhpB+0PKAKCh1k6QuUo25bWDlAD043PE/keNflZEnswyQsJJRfWdj30l6M5GdD8BfbdjyR0vZj08g88JqZbw58/vPtc6Io=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18415bf1-59f2-42fd-f814-08d58db41a15
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098411AD81C67722D5C0F713FBD40@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(54906003)(14454004)(68736007)(10090500001)(5660300001)(6506007)(186003)(26005)(99286004)(7736002)(305945005)(76176011)(316002)(22452003)(53936002)(102836004)(110136005)(2906002)(107886003)(86362001)(10290500003)(3280700002)(478600001)(3660700001)(72206003)(86612001)(6512007)(3846002)(66066001)(36756003)(97736004)(6116002)(6486002)(25786009)(2950100002)(1076002)(4326008)(5250100002)(105586002)(2900100001)(2501003)(81166006)(8936002)(81156014)(6436002)(8676002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: itpwcNyeXrZvd7jhXCEZdvPSDibRtIRvtcc2AV40lhjGVrahy2db5jLKDGEn9ZQ/gQJV84smVA6XQESvKQkMSVSYk21KC6CP9uaUJOxCjzs19XQoWiP2wwMKic9Qe28e3wf0+W24MvfywFhceBI0fzw4LfpAPSr9LdoIkwWrgc+QsYbSaQ0eLBEMcVP5T6+5VAeqiaW7FH/YsPQstt2ox90pCDSVlCqea3UECtlwRC9jnlFnAcTEBGUAkUCjNU/bQRlraQ6p4DlaVZbl57bKqHksBYf7wiOYcu2cKq/efJhVVJTln0tJw6Ne2R9f6a7tqm6iev6k48DU4+rqr+1Hgg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18415bf1-59f2-42fd-f814-08d58db41a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:41.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 8d66c30b12ed3cb533696dea8b9a9eadd5da426a ]

The qca_spi driver causes alignment issues on ARM devices.
So fix this by using netdev_alloc_skb_ip_align().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for QCA70=
00")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet=
/qualcomm/qca_spi.c
index f55be6ddf3a7..487d6ab771e9 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -297,8 +297,9 @@ qcaspi_receive(struct qcaspi *qca)
=20
 	/* Allocate rx SKB if we don't have one available. */
 	if (!qca->rx_skb) {
-		qca->rx_skb =3D netdev_alloc_skb(net_dev,
-					       net_dev->mtu + VLAN_ETH_HLEN);
+		qca->rx_skb =3D netdev_alloc_skb_ip_align(net_dev,
+							net_dev->mtu +
+							VLAN_ETH_HLEN);
 		if (!qca->rx_skb) {
 			netdev_dbg(net_dev, "out of RX resources\n");
 			qca->stats.out_of_mem++;
@@ -378,7 +379,7 @@ qcaspi_receive(struct qcaspi *qca)
 					qca->rx_skb, qca->rx_skb->dev);
 				qca->rx_skb->ip_summed =3D CHECKSUM_UNNECESSARY;
 				netif_rx_ni(qca->rx_skb);
-				qca->rx_skb =3D netdev_alloc_skb(net_dev,
+				qca->rx_skb =3D netdev_alloc_skb_ip_align(net_dev,
 					net_dev->mtu + VLAN_ETH_HLEN);
 				if (!qca->rx_skb) {
 					netdev_dbg(net_dev, "out of RX resources\n");
@@ -760,7 +761,8 @@ qcaspi_netdev_init(struct net_device *dev)
 	if (!qca->rx_buffer)
 		return -ENOBUFS;
=20
-	qca->rx_skb =3D netdev_alloc_skb(dev, qca->net_dev->mtu + VLAN_ETH_HLEN);
+	qca->rx_skb =3D netdev_alloc_skb_ip_align(dev, qca->net_dev->mtu +
+						VLAN_ETH_HLEN);
 	if (!qca->rx_skb) {
 		kfree(qca->rx_buffer);
 		netdev_info(qca->net_dev, "Failed to allocate RX sk_buff.\n");
--=20
2.14.1
