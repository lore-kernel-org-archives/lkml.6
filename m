Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3763980-1521493513-2-3790595849663815878
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
    t=1521493513; b=jURqgGlf5R/wxbOee9sSq25zWfPWx1Zw47vdXNb4iCxStSS
    2RwKWNWC+5KjS/iZ5EgLJaFjnHuHIN+1ejUHA3fXq4sVkHsYgq5PyrS9v2jpI8R/
    HqHoK0hcxl2UIF199DpTQiIO1dvJ11TaquWur49DYYqFvPBHKMbVl0XlUqDKwCHG
    4+y5Xxxuaf8xzu7C2BtdlKUPflD8TI+Wsl/iatuJw3UjDv14awmjlWpF/55ScLw4
    VZcBMOGtCeBUKSDqAWWBpbruPAAbPx17ZDRPldXTTtCjBSPS6/qQCWOY3iLIZs66
    BBn69i8eAwFHi58eO8UV6FO6nWi1DuCyUlbi5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493513; bh=/rRBzt
    3KV4Rf2y/l1gkKOFswALBsaHOjp4uxb/qYPWc=; b=PMAaG39eYR1HEhLMDVZeT4
    AhzwikHk0C1F+mfjB9vz48+TkHjbiD9XGRgh466CiL4Q2cfD+q8nC1pEuibm1aUb
    26aslgOlxavvehaekbJzKIipkQ0n36iv2v/k3lI6dyjRD6pZHKPoqZYBSHs5254g
    RfECTCH+JOKb0uQ/8SUfAua6/b+q8UQS0fb26TD1tbAI7uimjiKHEd4gEY6qQ7U9
    SkoaKNPxWlWhRsHQSk3D7o0sh0xHTu2BJGpwVQaxb7hyfgsWV8g24dmdoUffVKeL
    m8BFnILfFClJYfo2VQEqS5cefIBofy9UvCGKdFDYOfsj/8YsSJU3Db6fFpRtrPzA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmsRz/lJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvkeenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=OmsRz/lJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekfedvkeenucevlhhushhtvghrufhiiigvpeejge;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965425AbeCSQCP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:15 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:22550
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965412AbeCSQCL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stanislaw Gruszka <sgruszka@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 149/281] rt2x00: do not pause queue
 unconditionally on error path
Thread-Topic: [PATCH AUTOSEL for 4.9 149/281] rt2x00: do not pause queue
 unconditionally on error path
Thread-Index: AQHTv5tzjYcZno7mNEe0jMTBB86bNA==
Date: Mon, 19 Mar 2018 16:00:49 +0000
Message-ID: <20180319155742.13731-149-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0933;7:F7xAnFShtWmEUROk/JLsT3cvo6hVS9qFriQGqyd90Ngl/1Dh0Ga6ydeX3aTr3RjMXeUjVGEtemU9P3IB3x5oQC8RaXNOjttAivglB3CRv2B+ihuhQx3/bENv0xdMok+xXkDfvDiN9T0ASBBiaY/G2ChMyfxpNj+qwE9pz9xG40NYnf10TJv9VAuTQRIdEPa2aphg72AKiP4itCsH41GDkj0fXIX6FRiOFqtlt7X6eYgHAp54qDnadOJwWbC/CoAn;20:Rm+bXQFpngoE5QDt0nQ74T+KrU8JpFNTXJLUgCLkNWzkmSB74LDo6LEsOViMsNViRMShroZhGIrlDwRdmn/6zfkb9fschm2rw1S8GzK217Kbz70HE4F6LvywL3fYq+E5vSpSKK3g2/xzkCgL8atMno6QFhS0+04QGa/fwVzQWSk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09fa1f9d-dfdb-4e68-a003-08d58db2c031
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0933;
x-ms-traffictypediagnostic: DM5PR2101MB0933:
x-microsoft-antispam-prvs: <DM5PR2101MB0933AFE2E982A8B16A658587FBD40@DM5PR2101MB0933.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501300)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0933;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0933;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(366004)(346002)(376002)(199004)(189003)(2501003)(72206003)(1076002)(66066001)(10290500003)(99286004)(10090500001)(7736002)(14454004)(6116002)(5660300001)(2906002)(97736004)(6666003)(6346003)(102836004)(22452003)(86612001)(3660700001)(186003)(2900100001)(25786009)(478600001)(5250100002)(26005)(6486002)(6436002)(81156014)(81166006)(36756003)(4326008)(86362001)(76176011)(6512007)(8936002)(106356001)(3846002)(53936002)(105586002)(3280700002)(305945005)(68736007)(110136005)(2950100002)(54906003)(8676002)(107886003)(316002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0933;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 3H5A4Toxsj/wp2e7w4MSAocBFA7L2nKAAGK10opL17+CePQWEhx/Pje85+cMBWIBrWYQfIWsHcwzrtApngBTn6iLBuheBixzIl6L8SgQMSzDXq3zXaiL+jS9OyLj/nvmxcO/kTwAsbFsy5BX6/F284VdB3LDk26eMjRNIQo1QAWcxeo5hwmYstYuQi8hJfW06zJOv1K+acBfeibooMzRzZWQbnMuwU/9OaC3L4S0OJsnhHDI4oQRN+DlYuH5OSxRbAbaIRo+fInDv4mPJ1emhmpeB3XF4WwGVo1L0B6xPpvwPZ3J3bLOcZmeMGsYnzs4UF93fc+tYVEM1DViY2AJ7A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fa1f9d-dfdb-4e68-a003-08d58db2c031
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:49.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0933
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
index 13da95a24cf7..987c7c4f43cd 100644
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
