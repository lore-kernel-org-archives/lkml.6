Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521496830-2-16238889809490844106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521496829; b=CEnwFFWhcLpNkiZ08QTf8yOuXUBc5OiH9wyfvNzX42f5Pbr
    icv+NiqKi7lQJu6NvDZOeYc/bDFrlZOkJDuS69T4cU4paFBr7r5Zqp8Vr0+VfBgT
    n5/ODSJY145MF0QJn9FDXORVHb8zbdUnPBFjIwz5P5qFFJrVOrewOTqVQbyppR5t
    6Xi8NntleDjsdoYhoXf2i6rkqM0RXLLsOuVYC59gVgkZP4ZBqtDIti8hl0NkoBke
    Xnw3ne9qwiOF7ETv/ALT8NSvufFaG8hdUUMID6EUrQWwWCt77eoOG+RKWnSvHh2z
    CirOhSmNVk4ef71+wdKW0YvVWDYAuSAZyN1ZkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496829; bh=DWljMh
    9S0H3NTT7UhQPV4fKA4jN7atPjFwaDox0JmXE=; b=XA8GxZIaV4EK6Hr6kFqVZW
    MUhXRuRMFurwjKommjz+/ZWkLT0qWXCxDnVQt2k86uOUn4KV6lw8XgK97LoYbfOQ
    reK24BY6/udmKWu+HIqYJRMIHhdukyyu558WnhySsObS2xJRQECPWGranuAQ7stj
    Yfq6aQ/i9rH66eGUmopN7ig1tXN7xXcgnWJecYUp6aG3eCF3jHmYtXIlTGV5tS3T
    DyDzM+TmdYa0ywW8eBRftOlX7wjF2rzgQFI3mNhDqUUVFLqkkxqgvITNhKb/ovoA
    GuCJwDDQbQRlxP6aJWFyjnR0MYgNXrCbflQvOvCK/zMAQ1QnJPXI4aYeD7xvQrvQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S1XRig2R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvjeenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S1XRig2R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvjeenucevlhhushhtvghrufhiiigvpeejke;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeCSV74 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:59:56 -0400
Received: from mail-dm3nam03on0127.outbound.protection.outlook.com ([104.47.41.127]:29856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934452AbeCSP4A (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 56/97] rt2x00: do not pause queue
 unconditionally on error path
Thread-Topic: [PATCH AUTOSEL for 4.14 56/97] rt2x00: do not pause queue
 unconditionally on error path
Thread-Index: AQHTv5q8Pvbo9mHX6UifuY07ffqWuw==
Date: Mon, 19 Mar 2018 15:55:43 +0000
Message-ID: <20180319155411.12348-56-alexander.levin@microsoft.com>
References: <20180319155411.12348-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155411.12348-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:hia9O4YhwONVV4ltsfHMA14eobl8jCT0s1occOx4qJuNosJD1qIDTi1S0E5CcG+0DN4s7n4Mm5npI1k9WH/Tlic1kPaCzvI98BVnYS4qUOMqPxF/IpnW5c7l/x3QsmQrB7LwSpYT+gF2VMNHEC2zbCjAbN4usEj2CxdysdR5fOSef/m6kXmKpEg1CXPmH3FhaPnRI70agAlciv1DO2lX5NZVP+vkJZKvzauEONBarwemABTQWWgoByxpIhNNhOvh;20:5Qp9ttkJ+nAOdxixppo7gvlbZZCM3njGiHlpQbje+8C8/XepeaWEru02rKqqfuoiy0E6XOlJ40mA2ufKZvuiKFpUK9dUHzAH+zYLYpma2eSlJsNt3eab1/j2ZK2nOPTucbxNSRBRYctMdoTwphLbinoKGkOwlNCNBZGFzvZrQrs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17ebce22-a19e-403b-73ce-08d58db1e768
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807ACB900465DA3B0FC0F99FBD40@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39380400002)(39860400002)(199004)(189003)(26005)(10290500003)(305945005)(6666003)(68736007)(186003)(102836004)(4326008)(25786009)(66066001)(6506007)(8676002)(59450400001)(2900100001)(5660300001)(7736002)(2950100002)(81166006)(10090500001)(81156014)(97736004)(2501003)(5250100002)(3280700002)(316002)(76176011)(478600001)(8936002)(99286004)(53936002)(575784001)(36756003)(86612001)(72206003)(107886003)(110136005)(54906003)(6512007)(14454004)(6436002)(22452003)(3660700001)(3846002)(6486002)(6116002)(106356001)(1076002)(105586002)(2906002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fu2pTC1B0XDN4O/MasRTvKBeUWPtD9O0IS4BNEV4hMh1fL2XSjn/Z5+wtjHPMkOlOEYB5s4J5i/p+M++ag420eUQpt4d/WR3Ouy0a9T/xLynn5SWd0DQSBg/vTJABz3qJEAYtXhgQI8NS9kQcPGyOw0E2zCXNI5sgDMVdGudpDMefcxSvYfjCZk6gmqGgEUbTPOkJk24UrRhM5fvIkFxmPFoa9wuF+YRGfz9juRQXxwxNyUWeEOe8eerH5I9UWdALeJqc4CaP65vo3IUM944We2fI2sGZf+gn5VnEMUn/mP9en0isi7QdTAkn7+uLIhjqCZZqCDL+vhD7K3cYLXW2g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ebce22-a19e-403b-73ce-08d58db1e768
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:55:43.6100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stanislaw Gruszka <sgruszka@redhat.com>

[ Upstream commit 6dd80efd75ce7c2dbd9f117cf585ee2b33a42ee1 ]

Pausing queue without checking threshold is racy with txdone path.
Moreover we do not need pause queue on any error, but only if queue
is full - in case when we send RTS frame ( other cases of almost full
queue are already handled in rt2x00queue_write_tx_frame() ).

Patch fixes of theoretically possible problem of pausing empty
queue.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Tested-by: Enrico Mioso <mrkiko.rs@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2x00mac.c
index ecc96312a370..6fe0c6abe0d6 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -142,15 +142,25 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
 	if (!rt2x00dev->ops->hw->set_rts_threshold &&
 	    (tx_info->control.rates[0].flags & (IEEE80211_TX_RC_USE_RTS_CTS |
 						IEEE80211_TX_RC_USE_CTS_PROTECT))) {
-		if (rt2x00queue_available(queue) <=3D 1)
-			goto exit_fail;
+		if (rt2x00queue_available(queue) <=3D 1) {
+			/*
+			 * Recheck for full queue under lock to avoid race
+			 * conditions with rt2x00lib_txdone().
+			 */
+			spin_lock(&queue->tx_lock);
+			if (rt2x00queue_threshold(queue))
+				rt2x00queue_pause_queue(queue);
+			spin_unlock(&queue->tx_lock);
+
+			goto exit_free_skb;
+		}
=20
 		if (rt2x00mac_tx_rts_cts(rt2x00dev, queue, skb))
-			goto exit_fail;
+			goto exit_free_skb;
 	}
=20
 	if (unlikely(rt2x00queue_write_tx_frame(queue, skb, control->sta, false))=
)
-		goto exit_fail;
+		goto exit_free_skb;
=20
 	/*
 	 * Pausing queue has to be serialized with rt2x00lib_txdone(). Note
@@ -164,10 +174,6 @@ void rt2x00mac_tx(struct ieee80211_hw *hw,
=20
 	return;
=20
- exit_fail:
-	spin_lock(&queue->tx_lock);
-	rt2x00queue_pause_queue(queue);
-	spin_unlock(&queue->tx_lock);
  exit_free_skb:
 	ieee80211_free_txskb(hw, skb);
 }
--=20
2.14.1
