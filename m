Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521476657-2-15932223779205861866
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
    t=1521476657; b=nrIryOprwbIBgL/FsCrp586tOmYNVJmu6GgSuRsJF7T9EDj
    o20+E/bwjF+GFTv2YQBFB2GNrEGpJpJe5GBvGtbEmmzz6W8SlTQlaw4eJtswLSRZ
    5v5Ug/X0d9DfyzpZT7YCWXJU4j9jvcklnPFhyxs1hn9Qxzc/qiG3+WZDNfPpdkaA
    FNmSIeyFTKgQNVR7qGpC/QuyJ5R01QmGQScHPLixr/9Imn/EmMaqz1pmRgnPE9PU
    osVtHW1/Y4iyPamXEpmphcFn8aCW/VWwmaRcs94D/bVX5ER1Hvl8fn/0APeQ4o75
    +wjrZd5AwdiS+0IVuEBKWkwK3a1wibDJ1A7GwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521476657; bh=IK/hkt
    xIoHKOXcOvDwbp5HDScGVf04oyNysMpJn32+U=; b=mHLviL96OWqrj6z3HhK3xZ
    LUS57GRpxRlzBeVQRWv6HgdP2j5AlSNFAkLgQn1n4EQfHOWF/wSGsJ4ytRqy3tz0
    X0fwuogFPHRneabWvjWS0ELdqADmk11Km4eAMHja9zgPjilTLHwZ6R0cxmDUThQc
    RtmWBq1DLmD99V/3AkHybRMp4pvVNwIuaAMTHIH5Vxnf+nlzr3j3AD7edVapijPT
    IO/MWJYJJVhgkqnPSTGt5K0XeEY/FSy/3nFsFhiThAYZpEWDK9QPavXovuLUKR2e
    zhkh8WOZrmh1aUP47c0dA8G0sEIOrM2ILYB9w2YvLz86IRIdpn4oZBibs602d3Wg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B9aBNq8t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledvgeejnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=B9aBNq8t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekjeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepledvgeejnecuvehluhhsthgvrhfuihiivgepuddt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeCSQXz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:23:55 -0400
Received: from mail-cys01nam02on0101.outbound.protection.outlook.com ([104.47.37.101]:53605
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966910AbeCSQOJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:14:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 073/102] e1000e: fix race condition around
 skb_tstamp_tx()
Thread-Topic: [PATCH AUTOSEL for 3.18 073/102] e1000e: fix race condition
 around skb_tstamp_tx()
Thread-Index: AQHTv50nMpC+aeyMWU6FUfKsgT3OzQ==
Date: Mon, 19 Mar 2018 16:13:01 +0000
Message-ID: <20180319161117.17833-73-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:q4RLJVF1XkiyMrjkxR5s6Tv1582zfLYOkCxL80wWoddX8o8YPuR/Sx98bMzd2KXpAgLHm4GU+e9msiGLVxp1MFYiDOUjGW6F9G14X+QRIpoSwPYcwFO3WWT+HKd5b+QOzFKEoxCwI5+uQglG2Zj/lyapPXWDUnuIejScHlNRoZhQpYbxT4TQCX+psY+XsHi1ESH2Oet5DBfLEZIQUlcc7UcFTW5bTnXEzkdfXjQa73l4wsN+Lms8PoESqzd64hzf;20:7RvC29jwTxW1BDJUN1xE8KgH18xTlubmkrxlU5fZY2e2pmxz5f1IhGWYyJKDj6C1O5bWE4dLgCjOHjnYkdC/GgQLdvH/21op0JrU2zuLCKKTTtPeagpmaSp11UT2Hxrv4EM4Iqk/pLINbI45oSpjugnoiTHVSEyGzOR8eJNJHvw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d818f77f-f518-489a-c306-08d58db46dd0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063252FF0D929646D70F6ABFBD40@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(39860400002)(376002)(39380400002)(366004)(199004)(189003)(3846002)(6116002)(8936002)(1076002)(8676002)(3280700002)(2501003)(575784001)(5250100002)(81156014)(53936002)(81166006)(2906002)(5660300001)(86362001)(2900100001)(105586002)(22452003)(102836004)(6512007)(316002)(59450400001)(6506007)(66066001)(106356001)(14454004)(97736004)(99286004)(36756003)(2950100002)(107886003)(76176011)(10090500001)(7736002)(305945005)(10290500003)(72206003)(68736007)(478600001)(110136005)(3660700001)(25786009)(86612001)(26005)(6436002)(6486002)(186003)(4326008)(54906003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: aP5KOyR1hTuUZIXnUW9FIOOPt0s8fnl72Khr6NzTBT4bQJmyah0xAEHsDSaMV9Pqi5XNWuUUrtnundIoi8x8h8ntsNtdhbhbAXs8eb6Symegy1OPWSgh1Mn3qjKOLxQbeuKqXHd5pqgYVqF9NFt+qJdnjiP/rrinAvu+vUyRLl+S1RHD5KqoqlR38/YNlUCWgs6nT8GYoec6ILHFouorJwlWWAsuZFts2pOTe0OxyqGQXRPx+05LXYUqfhGklcYH0J46n7+7Ygtw7QHlG8fRw2eahl/TagL4MOnamFDwxjFS8GsPFg3SYgFCR4lczf4wDcjJyzh/AyQNroEqpSYxTQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d818f77f-f518-489a-c306-08d58db46dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:13:01.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
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
index 081dad4e0178..15099a58fcee 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1181,6 +1181,7 @@ static void e1000e_tx_hwtstamp_work(struct work_struc=
t *work)
 	struct e1000_hw *hw =3D &adapter->hw;
=20
 	if (er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_VALID) {
+		struct sk_buff *skb =3D adapter->tx_hwtstamp_skb;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u64 txstmp;
=20
@@ -1189,9 +1190,14 @@ static void e1000e_tx_hwtstamp_work(struct work_stru=
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
