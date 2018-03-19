Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482339-2-18111097063725479716
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
    t=1521482338; b=JkYNMwR3Ax3UKqGbbk+WBH5fh3g5BXMkfJQ4CCTMvRt22X9
    HhJLrZMk7zaeQjJEGJLF+/d/z6TpAd0OP6nZsXSXxT+PiPR2s1NPcJ5IdBWVEcOJ
    Oc30isKWRjtiG1R3EqvyHkPs21zeWxnX962T4Xn76GEzoKXD80T9COep20/lIjy2
    L5B9BPic1VcV7+Xx6QoM61+nXwywjw3GmRZjKU/lHbrMmWJpvoibnqMk+uFfJOw7
    bEe7K77uvLsyAaCxXbYEJgJ70BsU3g/gAMhqYCfLilrpyWYHb9esZTWJtF2rpEjO
    Sgxzj8jUrYWwh7wXdFLc36SwFWsDWxaWOWDZWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482338; bh=JC91ks
    235mJzwltMgGKThmpXSURWZ3HLhIrf31Ps9Ds=; b=oVa/gpwfWzWdlJ69nFCn9y
    5eiWIfLn2RI6NrqVRBJFpXCmMYO0Lg0B78Ss1+AWLliUitSG0nOHCl0U2myoNns1
    TMis8phcVs9FnA8O2tdRu3dTtqn1getqakFWb9DOs2tE53vM1rh+SgmUaAV8EqVR
    GubZhmgcfep+fQdgYg30o1ct6/ALHMc8haPjRldliR17YhJ1fWg7tobLvMvBBpC9
    CATPkISmSu057GfchBgqdxSHFS5lxo8uJ3sjCw96N29RxlL63bhYVsbVUK2yWBdK
    6a3DLzMFaSLEmrIN2K2MXtIfglCxSeAVx5fD5NGwx8JsMWcoJJ36+91gaCDwGIZA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eLeWC+eK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludehkeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eLeWC+eK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeludehkeenucevlhhushhtvghrufhiiigvpeefie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030346AbeCSR6o (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:58:44 -0400
Received: from mail-by2nam01on0131.outbound.protection.outlook.com ([104.47.34.131]:9760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935089AbeCSQEg (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 211/281] igb: fix race condition with
 PTP_TX_IN_PROGRESS bits
Thread-Topic: [PATCH AUTOSEL for 4.9 211/281] igb: fix race condition with
 PTP_TX_IN_PROGRESS bits
Thread-Index: AQHTv5ufRDFnldMA9ECPIFlC+Zoa2w==
Date: Mon, 19 Mar 2018 16:02:03 +0000
Message-ID: <20180319155742.13731-211-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1077;7:BD09EvvZ+RAt7WVAxc82E57OoayeA3clF/wD3+EqDc2xksdQPWtuXjYQHSiZlRdTEz8Ls+j5tTHOaxUhTGdvA2ewKyfOHo0zMSoHPJw163laUEA+47lCZAxVxrrt8Lp5A9rQbDcc98IJFxWebyk2ymdPwi/LDCdbwREHS1Z2VGNJoDYq+4TXdRhSZGD/OJBt3paSQGFsXBB8szAMFb+m/9FoXJ61ugkS7W7gTHcKPKPnbJWZvruxANsRY0lYY9b/;20:08/QGH4Zldhqz6pjXyDFIYNDxrJBuReMp7SM9Lxz2SXA92O+bpWlkAeOlRcjx+48KT7V+obCgK1NXK0EG4MdrFpSqbXKXEOzCQt7ujwPm5Ksbq74C2Msr8tjAJNvrYL3bJ3ZrGhGeKInrnhGP7M47fqIqEOQGvYdjnFtgrIQKTQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b9db23e-ca29-4b1d-b169-08d58db31b75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1077;
x-ms-traffictypediagnostic: DM5PR2101MB1077:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10776F414BA7F15023CB9EBEFBD40@DM5PR2101MB1077.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(278428928389397)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1077;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1077;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(199004)(189003)(110136005)(36756003)(3280700002)(66066001)(3660700001)(4326008)(6666003)(2950100002)(25786009)(86612001)(105586002)(10090500001)(68736007)(22452003)(99286004)(106356001)(5660300001)(7736002)(305945005)(76176011)(54906003)(5250100002)(97736004)(316002)(2501003)(3846002)(6116002)(1076002)(2906002)(14454004)(2900100001)(6512007)(8936002)(186003)(478600001)(10290500003)(53936002)(575784001)(8676002)(107886003)(6436002)(81166006)(86362001)(6506007)(59450400001)(102836004)(26005)(72206003)(6486002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1077;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AqQXrSLEzZF1x7nrm2U27/5JtIZMld0ZB9dFm0oMdWu1yTJMHCO8ZgYPWQGlJaBLFfV5Daua7L+OKSqw5/eg5IjFwS1DgYmSk/Ld9MloQ/Ut6wSZqErWNabvst6JPc4BDah4vs0QQvsgtzLthz2Z8pie3TPN/zkTENt1+HerOEfkwNH+MPziwn69QCgsdGmz4pluPnDN0878ZMKnLll4xvh5eVXSGpDXdMKa+fCpU4//F3Om2YwR18VOmAjnb3EKlYhzv/n8BqeLrO/n9fT9ALVbuev89KYI4uDMOzqMHa3yJ1/TvV8V3Pvd4292mDBo1er04TrrziwPqdzrdt7RxQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9db23e-ca29-4b1d-b169-08d58db31b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:03.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1077
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 4ccdc013b0ae04755a8f7905e0525955d52a77d0 ]

Hardware related to the igb driver has a limitation of only handling one
Tx timestamp at a time. Thus, the driver uses a state bit lock to
enforce that only one timestamp request is honored at a time.

Unfortunately this suffers from a simple race condition. The bit lock is
not cleared until after skb_tstamp_tx() is called notifying the stack of
a new Tx timestamp. Even a well behaved application which sends only one
timestamp request at once and waits for a response might wake up and
send a new packet before the bit lock is cleared. This results in
needlessly dropping some Tx timestamp requests.

We can fix this by unlocking the state bit as soon as we read the
Timestamp register, as this is the first point at which it is safe to
unlock.

To avoid issues with the skb pointer, we'll use a copy of the pointer
and set the global variable in the driver structure to NULL first. This
ensures that the next timestamp request does not modify our local copy
of the skb pointer.

This ensures that well behaved applications do not accidentally race
with the unlock bit. Obviously an application which sends multiple Tx
timestamp requests at once will still only timestamp one packet at
a time. Unfortunately there is nothing we can do about this.

Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/etherne=
t/intel/igb/igb_ptp.c
index a7895c4cbcc3..9eb9b68f8935 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -721,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
  **/
 static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 {
+	struct sk_buff *skb =3D adapter->ptp_tx_skb;
 	struct e1000_hw *hw =3D &adapter->hw;
 	struct skb_shared_hwtstamps shhwtstamps;
 	u64 regval;
@@ -748,10 +749,17 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *a=
dapter)
 	shhwtstamps.hwtstamp =3D
 		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
=20
-	skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
-	dev_kfree_skb_any(adapter->ptp_tx_skb);
+	/* Clear the lock early before calling skb_tstamp_tx so that
+	 * applications are not woken up before the lock bit is clear. We use
+	 * a copy of the skb pointer to ensure other threads can't change it
+	 * while we're notifying the stack.
+	 */
 	adapter->ptp_tx_skb =3D NULL;
 	clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+
+	/* Notify the stack and free the skb after we've unlocked */
+	skb_tstamp_tx(skb, &shhwtstamps);
+	dev_kfree_skb_any(skb);
 }
=20
 /**
--=20
2.14.1
