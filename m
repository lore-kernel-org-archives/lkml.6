Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237960-2-16255253111874156251
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
    1523237959; b=pqP30q3YPebRFk4NQxhdTXm4IJTzb1gGqg+uoFj2pn8Z16tJ//
    wI2E6YMjnG0+eVq4qeRYgkFQ8o+fWz3rYloaS073E1D3SF76ucwa9Jacv94Q4kYE
    /UC2WkW9h54Zm5l4Swy+HAtdDy21wOi76FuWpmldfVWus8ZRAUf1l9E6SoF9HSnu
    dYdzvOdN6zx3pPeb0MYAQGfxRd+nE3E/CoL+wsHLN0m5yZvUuKhu9/f9h//wfv7c
    l9yQfp+kLsVAVSE656HvzeEw493VEiawyU/0ECR5UEjZCk75Q13C/HyYVg+0O0mx
    WiitkZtXaa/+OU955Be8g+H8qEZMtCPCLlmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237959; bh=6igGT/ECIi
    eUhw7WHQ2iyEVzFKrblwI4ZNjrZdmjrfs=; b=IgUJvcXEKgWpOynJBUqNRNrXEc
    Ihv4tCzebeaMA2+FG0KNbcYJnQQI3gQlu/ZnuU08oIayhCgIS2zinrVy/JmJhDOa
    5fuACRRuddMmCTuE5Dvd2FXS8ntVNYcCj6JSgu9Yq+eXbicnW8AS5AwOgDhbOYNW
    eUD6JtOEJsFZ66otDQSwNg1fumIp6qAgX5ptZLfIareqR5zsp3jCaHacgtJ4mlKA
    X0wW0wPZfCKFGgOKp/UlFrVPnFmolACwKNlLHiR0XD5XTezZDu1C56JL3gDgvNNx
    9pRuZkfd4hHJVo8Iy4jcj2N1JUoBr0+BUZ7XBKrEpV1DgYyX3pAen67orLaA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSZDtD0T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lSZDtD0T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPaMI5ildk3M1zcOeyYzsf4gpokXy6VYgXavkOTNNFeAmF/nGGSqZZCuxYRqH1rLG1KUiAzEzSvGqx5H6CveQdsoSahMaqG8y+ZCN82QdmTyB2NeBljY
    UQasr514D7s1eXDe9iApgvGDjk85gJwsIYSyAWGFwqKAF2QCDG7cX5nFQiszYyNEG5WzjRjPa09DdNbJEI0AFUax194OO1YJKyvdw7xkL2r41QcOoF6l8CWH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=donMdxIkcKOA4bL1sPcA:9 a=wPNLvfGTeEIA:10 a=4LA4qAFo6bo561LpWNDU:22
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757311AbeDIBi0 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:38:26 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:10752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755715AbeDIAfC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:02 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 012/162] bnx2x: Allow vfs to disable txvlan
 offload
Thread-Topic: [PATCH AUTOSEL for 4.4 012/162] bnx2x: Allow vfs to disable
 txvlan offload
Thread-Index: AQHTz5mYfKl0T5aSOUG3RYckWMnLsg==
Date: Mon, 9 Apr 2018 00:27:51 +0000
Message-ID: <20180409002738.163941-12-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:9YapHSPCI/0OXJK/ya3CKZBqx4O3HxSevcMsgDOXEJMAhGVKDoMd/zFT8f2Yts1mnpKrKegtOYzoM4KbEgqApvcnDnmG7LsIYORya7JocBVnM4/JY3v9KOPp/SIU7v25LQioU8TaJiWIBqDAHlhqPy8YKdV+HCBA56M75DbRRpza6MFl6U+TD9vQXe5GK8GDhMGLO0s7nnW1/7vwOGsjt7+iR8Qh4DtVwGhq+h7UC4d6L/zyZMQQ2AMAGXMbwsRb;20:kBoMJ9PVGk/uWG2xSUCTTTg/5/CYv/RNeicd/O/NJhdGaK6ogYsGYkhKSKZJKKS4BRLbqM6vfV+Wy7wuXJid6c7/8D1Q3UnPEut8rWeV8MkBJdkv0zWijugqBSukY8LCoiQ5JvAak53PKer0Zhd1K7JfW/t8jgPPWXmVd6fJ+7A=
X-MS-Office365-Filtering-Correlation-Id: a68a61a7-d350-4f8f-b11d-08d59db1b88e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101311000087382C84F83102FBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(478600001)(10290500003)(6436002)(5250100002)(2501003)(14454004)(305945005)(4326008)(66066001)(99286004)(10090500001)(6506007)(36756003)(102836004)(54906003)(486006)(107886003)(76176011)(59450400001)(2900100001)(22452003)(316002)(110136005)(86362001)(3660700001)(2906002)(81166006)(186003)(86612001)(81156014)(2616005)(8936002)(3280700002)(11346002)(53936002)(7736002)(476003)(446003)(72206003)(68736007)(6116002)(5660300001)(106356001)(6666003)(6486002)(8676002)(1076002)(105586002)(26005)(6512007)(3846002)(97736004)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: jq3wTTYTCq5aunLsbvEwPSBe5pW2xJslmZ1RcYHTZQUovQNK0MZps/kYX5Tl9rCcFcd1cdDWiTiXgvUjEV7KIDhTUsBF7PDZ4w566lfIKntkL+p2ocd2P3HVSB62TK2tKwCpQYiCA4Y/Hr7lG1ajVVqpX5PKVBk8KZC/C6+8wKA+DA4iQiSuEDCgzQ0667uQbTw9UltoYqnZKTaBXkbS+FR2b5Vgv5XvEWV46nb00yaIaOMUDp9uIqy6p2VixNvStUkFt3ZPXaBh5lTEsb7qHOD1QbBHIaxhp2treEJ6X6yblhSoXqN2rNjWz0pJXJvCO6OMs72hNZnbXuEmUj3n8JRzK5B9mFvJoWcW0KaNaIa+dxRq8ecQsOm5jGRyL1OaA/XSOseEZxSnFCyYnsN0nCl5kV3T1+MT/Zje7MrsKL8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68a61a7-d350-4f8f-b11d-08d59db1b88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:51.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

[ Upstream commit 92f85f05caa51d844af6ea14ffbc7a786446a644 ]

VF clients are configured as enforced, meaning firmware is validating
the correctness of their ethertype/vid during transmission.
Once txvlan is disabled, VF would start getting SKBs for transmission
here vlan is on the payload - but it'll pass the packet's ethertype
instead of the vid, leading to firmware declaring it as malicious.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index d1103d612d8b..949a82458a29 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3943,15 +3943,26 @@ netdev_tx_t bnx2x_start_xmit(struct sk_buff *skb, s=
truct net_device *dev)
 		/* when transmitting in a vf, start bd must hold the ethertype
 		 * for fw to enforce it
 		 */
+		u16 vlan_tci =3D 0;
 #ifndef BNX2X_STOP_ON_ERROR
-		if (IS_VF(bp))
+		if (IS_VF(bp)) {
 #endif
-			tx_start_bd->vlan_or_ethertype =3D
-				cpu_to_le16(ntohs(eth->h_proto));
+			/* Still need to consider inband vlan for enforced */
+			if (__vlan_get_tag(skb, &vlan_tci)) {
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(ntohs(eth->h_proto));
+			} else {
+				tx_start_bd->bd_flags.as_bitfield |=3D
+					(X_ETH_INBAND_VLAN <<
+					 ETH_TX_BD_FLAGS_VLAN_MODE_SHIFT);
+				tx_start_bd->vlan_or_ethertype =3D
+					cpu_to_le16(vlan_tci);
+			}
 #ifndef BNX2X_STOP_ON_ERROR
-		else
+		} else {
 			/* used by FW for packet accounting */
 			tx_start_bd->vlan_or_ethertype =3D cpu_to_le16(pkt_prod);
+		}
 #endif
 	}
=20
--=20
2.15.1
