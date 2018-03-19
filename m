Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521475477-2-8672585629852865989
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
    t=1521475476; b=UC1ifaQkcurye47eI4HlOJXKZKAtiwbif5LhxeWy7HTXluP
    G2Ptr4ExKfERBk978OP8RGZVdlsLgk6jeTjD59SX6dY1NAwsMiqAOkPF9mlUkWxl
    LdNF2J7/gTUIq11B0LTXryDs+BHR9K07KFmMXIcMsdEHrGcVwfLJ/UYr7uFqz42O
    j8LdQVt4yd7fQAZhNJkPwDiCq4xClepVXG9SSMPTgBD5XNHu8sTByCVgFBExPb0B
    SNjNwV3KBL4KtOba9NNek1VvU6v6fT06+Igv3wc8mp9MDzdUqM9lwawzlE9rp2VT
    bfXQlCklWEXmVKiNtDbDrgQHD4DcfAwAsrd0aMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475476; bh=Q/N4G6
    +B5gXeYAlhIo+s9FTVbQhSsiMiFmzirvQWGK4=; b=wV4Vv5jYYaaHGGUMngeyNt
    OK3h5cSyID0VL9/Fd3PTdYV7T8MS98CAMzoh12B4+e1Ds5WxLJIu2RZh52K0STi3
    Ue9t+YH6CBluwePGvZ6RDUP1BOlqLDbkKXka4y81kyz4Dp4TcejNSo1fdoaTByDl
    guYoD7bOLZV6YuzrvkztS6hX3w7OH2m11Ww+OV8ZiZt7AUBeI8HfEHvMOcZ1ioBL
    f4oW490Vgp8Lh0xgApDQORSg4VC+0CdRncwgm3Lc4/yGU882HevkbvsumhlPUzr2
    iRPQtOyqpzHlf0G5pVIaLa2rHveQorHTWQvRSPRg8KiGC1JmItUoGNK1gd9axL5w
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UaDnVmde x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduledvnecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UaDnVmde x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepleduledvnecuvehluhhsthgvrhfuihiivgepjedu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935087AbeCSQEc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:04:32 -0400
Received: from mail-bl2nam02on0100.outbound.protection.outlook.com ([104.47.38.100]:26624
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965656AbeCSQEW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 210/281] e1000e: fix race condition around
 skb_tstamp_tx()
Thread-Topic: [PATCH AUTOSEL for 4.9 210/281] e1000e: fix race condition
 around skb_tstamp_tx()
Thread-Index: AQHTv5uelZpKcbwjcEujnehsLuN/dg==
Date: Mon, 19 Mar 2018 16:02:02 +0000
Message-ID: <20180319155742.13731-210-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:pWA/lSomrLdRCW7s8Wpkd+cSFb+2xh0tyGWgHsan79xGcZQmKeMhGx5Zs+8Ldl1kWRs11ibq2HLFxkMBFoKosqvZZKvzU0cHT5gwoQNcIptyZfIldSsFFZx31UvwMTt12+KRIjes31tfSYVHo0b9rzwK9Fqy5VYlDAg2S26HYe8TXZGpEU3gH+GWYlvFplrdivLJjJUDQ3O8I8o/uVNwey7cEtlbgRkmvFYLefdTdnzTu/ir4wP+Ir/ogBCpqt0z;20:+6i9/DwoFcQ3PdAUNwScmjTPRhzSz7eD8rd05lGyH204hHApQofjUAI8WKy38K5g1TQ8XcVU6cM0sYau66P8vmsBoG2jejDpN8Pm092uDXWlD8yLPWSGORJhIH1Yrh8+jn5X+8o7d+Fs9S3aJg6ew7Ol50I6U9Qu/qBaoY6eeJM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c594b2c-8265-45a7-55ab-08d58db3094b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727D9E4CD9FB087205ED4A8FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(59450400001)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: FcXbouBZ912/QM12tPiVYhP2nh74+9dhbpdknPen2Xi9SbXdUN4Ihfs/tf05yYSDwf4sXB9I2nwU3VchmipSOpP8BDDonIrReCIY84VHoTIkV6Yoi5ctRQYJtaAzt85SLZcMzqZj/aRf21MUefMUU62i2A8KoNKGZa0JegO/hHQZOuDPZKIIW8sACUDN+rxYiMexej2nRo5yVA0xqgP9Ypk0DM/wi3CvPHOQ6aTt5cfz8e4Bj7BeTU8nHEErqbrl0L0Kx+wMTZzvxbksgTxxB9DQsqT4bHJeni2JSaQpTf9fW/IsWFalrlKj484TAuNRHxGwoEatdbHL7+t89SkS1A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c594b2c-8265-45a7-55ab-08d58db3094b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:02.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 5012863b7347866764c4a4e58b62fb05346b0d06 ]

The e1000e driver and related hardware has a limitation on Tx PTP
packets which requires we limit to timestamping a single packet at once.
We do this by verifying that we never request a new Tx timestamp while
we still have a tx_hwtstamp_skb pointer.

Unfortunately the driver suffers from a race condition around this. The
tx_hwtstamp_skb pointer is not set to NULL until after skb_tstamp_tx()
is called. This function notifies the stack and applications of a new
timestamp. Even a well behaved application that only sends a new request
when the first one is finished might be woken up and possibly send
a packet before we can free the timestamp in the driver again. The
result is that we needlessly ignore some Tx timestamp requests in this
corner case.

Fix this by assigning the tx_hwtstamp_skb pointer prior to calling
skb_tstamp_tx() and use a temporary pointer to hold the timestamped skb
until that function finishes. This ensures that the application is not
woken up until the driver is ready to begin timestamping a new packet.

This ensures that well behaved applications do not accidentally race
with condition to skip Tx timestamps. Obviously an application which
sends multiple Tx timestamp requests at once will still only timestamp
one packet at a time. Unfortunately there is nothing we can do about
this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index 0feddf3393f9..6ebe7e8147e7 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1182,6 +1182,7 @@ static void e1000e_tx_hwtstamp_work(struct work_struc=
t *work)
 	struct e1000_hw *hw =3D &adapter->hw;
=20
 	if (er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_VALID) {
+		struct sk_buff *skb =3D adapter->tx_hwtstamp_skb;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u64 txstmp;
=20
@@ -1190,9 +1191,14 @@ static void e1000e_tx_hwtstamp_work(struct work_stru=
ct *work)
=20
 		e1000e_systim_to_hwtstamp(adapter, &shhwtstamps, txstmp);
=20
-		skb_tstamp_tx(adapter->tx_hwtstamp_skb, &shhwtstamps);
-		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
+		/* Clear the global tx_hwtstamp_skb pointer and force writes
+		 * prior to notifying the stack of a Tx timestamp.
+		 */
 		adapter->tx_hwtstamp_skb =3D NULL;
+		wmb(); /* force write prior to skb_tstamp_tx */
+
+		skb_tstamp_tx(skb, &shhwtstamps);
+		dev_kfree_skb_any(skb);
 	} else if (time_after(jiffies, adapter->tx_hwtstamp_start
 			      + adapter->tx_timeout_factor * HZ)) {
 		dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
--=20
2.14.1
