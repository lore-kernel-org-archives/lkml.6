Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237562-2-1081432196715573641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237561; b=dfYb1Di1KOdaJVzMTgeVFSw5eKVaraHNMlwod/TGWQprLw+wKH
    4Na8k9yCOZjdm0jFY0hFpTyQXOXTsSbA0fQ8yhplEcltqFM7BRumGKJV71oeOXEE
    aOzJA36OCqO7dKgBts1q04DAD2n2+yFrrb507tJU77dHh/XUzxqksb9TUJlqwLPp
    P8FrZMe751SJ58VeIFFZ04/556TabdOxUIaIf58N/hP4TwGNRgguxyf3K7p4QlpX
    BjLCZCDBfMsRwJeRWEy0JSgBpR+O8Tnp2gq8WPcnpjuLiCQiD9NDZieTrzmuA5OS
    vQpGcgUl8NVGLK1low++2JcyAST/lwTpMCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237561; bh=Fx8Jfbvf3q
    fWYkUms15kn6L2DJ3pMVPaxe0lkTYa8aE=; b=MSQQgPs6f8l+x621iXfa875phS
    g4x0q2yeUvl7uoJqVXGcjBn7ORMMHPKCqSJ//40D7/JmbTSwy9jaz2qJDtZZOlU+
    yxFwxvsgRUrnOQlJE70f5LmsxbB7TRfQVW3N0SZhKj3zf+Wt9O/vodvj6tPG8CYU
    Oal/gQDzgaQusj4kBlcMsUspfhFVruGULLU0En6dCIF7zFlmPuTgATP/ols46aCW
    Mss2dKK4LwLimSux8Ww0aOiRvj8FuZGqa6uiv0KFEkzWOOsxE4XpZPz27Kf6zSgv
    JZUxLovYzh7BMrTB8uwlpTV0Sb7pQclWhLbDRQghmJAi2G1DOJXXoHZcD+EQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QRoi+amQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=QRoi+amQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEykn5HqJ0nPkUBJJzMb5Lv4IhvtKDiMi5/Zq5rd+6gSj8IbY5CClCLONw+0JbIpX10oqjnOsjfcixiOnrpMK8Eop441vESzPAfr/OIHhFEZ+6wA0VOI
    2UTfIrqq05EhCTtqImvriHF8aDugILS9ce6R4gtwkPeNI9rpdtS7EdmRgMXYrw+RCWKNBjeiYoeO2FtTNNrIzM4TTegvhTPV/UA6V/5vpxiXgsNU/JD4OthW
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=dq2cNPrMAAAA:8 a=yMhMjlubAAAA:8
    a=zz7Vc1meF-ew3THYyscA:9 a=wPNLvfGTeEIA:10 a=UrzWRhJOTTn3oDX10iyi:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756596AbeDIAfs (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:48 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:45331
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756582AbeDIAfq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 034/162] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Topic: [PATCH AUTOSEL for 4.4 034/162] ixgbe: avoid permanent lock of
 *_PTP_TX_IN_PROGRESS
Thread-Index: AQHTz5mhyzL2H2nA/UCmccL49b+Rng==
Date: Mon, 9 Apr 2018 00:28:07 +0000
Message-ID: <20180409002738.163941-34-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:+SXo55iIwJs+GQ3qq6NtlVJ1tj8vyicvQsROpDtqd1yUVga61BAE/LmonenDbouK99XxwnDUqH/DWi6zGJL3+2istcusGkmBr0pNC4vEKAwTczl6iJzROmgM3EjCZef0pYngRdP0YseU64rjRKd6CAgzjCJTs4Wc/wmV6uEJ813ORaURrP6VPwAiqR5KXKhGu15y+cn2s2ee6KvdDgFy4I9GvlqQocni36o6Q/FTr8oXbCi48uuw5FZyJJHIHOkE;20:gfTpjdgF4dLJ+04owQqSzBd68IO8Nws5wVGLQfHFkHgGIOxg20kaGOdWQuzlzW8Pn+1QXvkYP5sGPYeo5p1hjPK7Micq/7MjzQ0Qj3NOYM/xoVzLM/j1a8tGsUV8E3JN0mtBveEQZtqDQb0GszXIu3Zbik70Xi8WngHBWsy9Irs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5fd4beb-b1e5-4a4f-fd16-08d59db1d483
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725F4DDAB94717717CFDA80FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: YhUuWkcxa2bNGMGGfK0bGUvJNVD5ATJjTn57jvMPKkEquifsWLCMqBDunbShVaSnDVR1ZGaIzs50EzQrGBKXiYCc6lyFaAXQaOeexaA5jDZtsBruGW3w5W5b/+sRMiPstENzFU27YD5OpFQu3wTdGHXXzcxmOK/OZkHI21YgdSkPsRQbCY6RvtFg6i1T4696l4pBGOov2XhjNhuisen+3ByYtZF5X6VY9r8qxOQ6k6Fjyo05tIipoUlnrRpq5bh78n0ovtKWW4ORBuXAupO6523qJ+FPfoaQtVFpoafBClDgde2Ss4OGP22UNs8jVS3j09qWxpNC56UAWQ52/WxSTYUrDiutpyKSq9NY60BPnI7D45PLOMCXrpkUW1nTHdL8NTnF6/wwSr8veEeyMCFwTS78Ql4GTThDCi7i1064BUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fd4beb-b1e5-4a4f-fd16-08d59db1d483
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:07.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit 5fef124d9c75942dc5c2445a3faa8ad37cbf4c82 ]

The ixgbe driver uses a state bit lock to avoid handling more than one Tx
timestamp request at once. This is required because hardware is limited
to a single set of registers for Tx timestamps.

The state bit lock is not properly cleaned up during
ixgbe_xmit_frame_ring() if the transmit fails such as due to DMA or TSO
failure. In some hardware this results in blocking timestamps until the
service task times out. In other hardware this results in a permanent
lock of the timestamp bit because we never receive an interrupt
indicating the timestamp occurred, since indeed the packet was never
transmitted.

Fix this by checking for DMA and TSO errors in ixgbe_xmit_frame_ring() and
properly cleaning up after ourselves when these occur.

Reported-by: Reported-by: David Mirabito <davidm@metamako.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index a5b443171b8b..3283e8e1f409 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7180,9 +7180,9 @@ static inline int ixgbe_maybe_stop_tx(struct ixgbe_ri=
ng *tx_ring, u16 size)
 #define IXGBE_TXD_CMD (IXGBE_TXD_CMD_EOP | \
 		       IXGBE_TXD_CMD_RS)
=20
-static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
-			 struct ixgbe_tx_buffer *first,
-			 const u8 hdr_len)
+static int ixgbe_tx_map(struct ixgbe_ring *tx_ring,
+			struct ixgbe_tx_buffer *first,
+			const u8 hdr_len)
 {
 	struct sk_buff *skb =3D first->skb;
 	struct ixgbe_tx_buffer *tx_buffer;
@@ -7309,7 +7309,7 @@ static void ixgbe_tx_map(struct ixgbe_ring *tx_ring,
 		mmiowb();
 	}
=20
-	return;
+	return 0;
 dma_error:
 	dev_err(tx_ring->dev, "TX DMA map failed\n");
=20
@@ -7325,6 +7325,8 @@ dma_error:
 	}
=20
 	tx_ring->next_to_use =3D i;
+
+	return -1;
 }
=20
 static void ixgbe_atr(struct ixgbe_ring *ring,
@@ -7611,13 +7613,21 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *s=
kb,
 #ifdef IXGBE_FCOE
 xmit_fcoe:
 #endif /* IXGBE_FCOE */
-	ixgbe_tx_map(tx_ring, first, hdr_len);
+	if (ixgbe_tx_map(tx_ring, first, hdr_len))
+		goto cleanup_tx_timestamp;
=20
 	return NETDEV_TX_OK;
=20
 out_drop:
 	dev_kfree_skb_any(first->skb);
 	first->skb =3D NULL;
+cleanup_tx_timestamp:
+	if (unlikely(tx_flags & IXGBE_TX_FLAGS_TSTAMP)) {
+		dev_kfree_skb_any(adapter->ptp_tx_skb);
+		adapter->ptp_tx_skb =3D NULL;
+		cancel_work_sync(&adapter->ptp_tx_work);
+		clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
+	}
=20
 	return NETDEV_TX_OK;
 }
--=20
2.15.1
