Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891247-1521498365-2-4462919289190927828
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
    t=1521498365; b=ZfPgqazcEn6ZbkJ9VYd4WMFh5DGyxy3pP+P/qP5KqmFZ5O3
    D4JNF13lqFz+YikzgPWxjQzdZ9AvbAz858GdWXv3MofHjeBoMWqfIh/wpsn5i8Wo
    fnu/UNdHbb99i1GosQqdh0k4YpFQSp3shYUCXMTAd8IbLni7jPyh7IV4E3QsAa7w
    aja6sbvqxEhlfU/wcoKPDR5cQBOY1wrEvgD+04kgeuxvLpojYkGwMJSNy2JL+vA5
    FNL/gClPCJ39yPA9m3oKwLvcfUnlpI0N4sB0fkt10kRbNyjuO5OlV1QJ1oZLicKc
    0ZzrVsZok6NFaG8O/1i6IC39A7qVFDAciB/g/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521498365; bh=DWljMh
    9S0H3NTT7UhQPV4fKA4jN7atPjFwaDox0JmXE=; b=SjWhri3ZbmzT6XPKgrDwEZ
    ucohnJVtctxbIvS9tGA36TYSSLDnhwXJ7nQlYeIwxQicHOyh9G3eGmC5Jrgf4HoX
    8QWZoea/e5FQ2oCzMcTdx3znJDKDblZpKotGa9lio6ZT9edUUs9IjgdZtV4qtC0F
    9gmKvJBDIZSse92hqwUjOmQLuoPQOuq1K6X1nkP0G/PNKqiTPWhfMBuQO4cWT9L3
    F2I2hR6LsRHzVqqDcAxA8iBuEcoh/kRuKyTkV9KhUvtkESX8pNxU7zgVVqtpDzNE
    wRu1R0/HmToDXTD6l1XSH6EvfOsw+/HizVxSC4zc9wD8E3psJ+pF7c1PYM5zWgcw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QBxiKRrp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeefvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QBxiKRrp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduieduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfeefvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933900AbeCSW0C (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 18:26:02 -0400
Received: from mail-cys01nam02on0096.outbound.protection.outlook.com ([104.47.37.96]:43108
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933869AbeCSPtC (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:49:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 072/124] rt2x00: do not pause queue
 unconditionally on error path
Thread-Topic: [PATCH AUTOSEL for 4.15 072/124] rt2x00: do not pause queue
 unconditionally on error path
Thread-Index: AQHTv5mzD/GQV40i0EaA0J6C7Asv7g==
Date: Mon, 19 Mar 2018 15:48:19 +0000
Message-ID: <20180319154645.11350-72-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:OThPjr/CmbFGYwUt/UWz8M/jM07ZtW4MoRQbKwRRtmBw7v07CtT1k8JcZ4FprsUF1dMsb4IQSUkKbDIysCn6HHuoHLRXXgp+bIK/ncdnzJM1iXz40BUVZI2aqViDI+OT6CHFVxTA8Y6JXj+yxKP62L9abDBjKDjr2H2uKgG/WrwQPVKq0vbTiEZtIo4sH1VvtPe2P5yMu+V7owzliiV0MfDxgQiCZ+gBv1md2O1d0dBGdFNyo8+AUDvisz77umLY;20:o2bIf0XlGaAjWC1K6pb9jsDu1KWVVdMNRrVzJDBbp8ev5j4fzsEWkW9EFJiKCC19uJktFpBJ+w0x6v8iskSaAeU+keO87SIOfKPhA4bhfo8m/6EF4vFlD7NB7Uf2iV6q5oDI3I23FFvJouZ0hHL82eHsuz28PS6K3wjnTc366h4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84f21c85-1758-44b2-876e-08d58db0ec0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E05B2D078B9C18A227A8FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(396003)(39380400002)(346002)(199004)(189003)(6512007)(5250100002)(106356001)(99286004)(102836004)(2501003)(6116002)(59450400001)(1076002)(3846002)(186003)(10090500001)(76176011)(6486002)(25786009)(316002)(26005)(22452003)(68736007)(6436002)(2900100001)(54906003)(2950100002)(6666003)(72206003)(81156014)(3660700001)(4326008)(7736002)(110136005)(305945005)(478600001)(3280700002)(6506007)(97736004)(81166006)(8676002)(10290500003)(575784001)(66066001)(2906002)(86362001)(105586002)(8936002)(53936002)(36756003)(14454004)(86612001)(5660300001)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8oyVC0UapNqr2OqBFj4HqXuRJJhMvBfHtq2rUeuvRk8CiKB6z4Ci/SYYlyyT4XmkrliAshI6Kx5CTnifTAt9SDlLYaCbMcnS8Z6gaGOfwdtmkpMWnruQiU+63Q6KEQWt8c7AtFP7TDpZIxAoh2bJgDHKpwMbFQMw68eFaLEsxyhLM/+fJtPpDi9oZm7HcZkQA2g69+oh4ckzjqaTB3A5bEzUgJn+6bJ/Wr3ax5WfuGs1eO22HhHn3s00wGGc4+kock6E2RUEeWgamK95Sg6z2PHLEjaShF3s3MUh9EvCOYjz+zLOo7aeMmc6yN9QxttlRsOKyMj+g7kK3wx767MFvg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f21c85-1758-44b2-876e-08d58db0ec0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:48:19.0971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
