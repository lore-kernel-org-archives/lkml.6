Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121778-2-5461288583589528561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121777; b=U7ByDapkSppH8GTKxhxy74Jq3pynxGquI1A7ooFb3ZlTlyY
    AynDjgBHaiWJyyEYMVFmB6wpTejkTdNqH/jEG0ZjF0K1d5ePBZzklDCtnXDtc46M
    FVZF2jF7ZBC4pqXR6DFC3pYkvqM8pKSUg3jyY31lGE++9mZ3bi0m7eQv4ts56ZC5
    sWH9BFcaNAq3qCDJ2aHOu1yS8uvf07Hj1gzsEWKf5+xA30r8qxEqK5RxdgYJkpNz
    apMNtsjp5uVldl8s57igC8Ikt9Ydr0mgEdMzIXDwBvvSrIXm5Q4NYjiYatcf/F7J
    i0Itcmw86ObKXsv2ye25C3T+65yIXpdgiGlr7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121777; bh=H6jUFF
    MwfP2JjPbkEmdCT+TFu2NFyT3BceOwZLFMNeY=; b=dZCcYVr/eWc6Vgm8UQb9OW
    cT50IxKn/ProPKIVAwbqucqj4K5ioZI/B7l/c1gcta7EV2iZny7qNmKc+M1THwF1
    jiPXaaQFgrMOvhczPVXzUbvbYMGWgpCoPsAfqBMyKFt/gkeLyHu/R8D5cnv87lSq
    DqB88RW5npHZA3kiR8zUwG0hE+vxlwk1jHSMV0Rh1djVmMkGTslFpFprBBi1zwLH
    LFI9yQBFQGgKWzGQAWvBs5MxUOByuvtfS2QrLhOKAuewuHD5cj4JQwNkuoGGDHEB
    3Xs6+tb43HgoH3hAEgjyWxsqJ9/++0WRvENu3EE+fdK2z/Sze6q1TplZtv3/gldg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o88B/ovt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=o88B/ovt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932861AbeCDACk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:02:40 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932872AbeCCWb6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Iyappan Subramanian <isubramanian@apm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 033/219] drivers: net: xgene: Fix Rx checksum
 validation logic
Thread-Topic: [PATCH AUTOSEL for 4.9 033/219] drivers: net: xgene: Fix Rx
 checksum validation logic
Thread-Index: AQHTsz7raS0p6u5lhkiDa6v4/JTU3Q==
Date: Sat, 3 Mar 2018 22:28:14 +0000
Message-ID: <20180303222716.26640-33-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;6:hgag4b1tlFTD8ZH+8oGF1plHzzZd652NSc4EJ1olsWyAu4DMHYbmXr9v8zxtGWUWQo2dTPYX4LM/6lQbF3zEGFbBTeRLTPet/HNeQ8Yf5etqHX71PHTsNDi7D1ZsdB0v1UbL1AN/qibM9nIUAlYdJQPgxsO6qLLHxVzf0ngXz9Al72bK/FpGgLtiPHrQ+X3ggObN2e38Tn7MvGCjgZIeWwx7ZXII95uBQ9+0TmmmBAFtliWfsYnUUW+OipTQ+DwewYyKdit2HOLea+yyLSlwaWsybozx9axLdTaUdB4UsyDXSWlCsoie4HlmyKITx7aqATGLZtMGhFG7avsIv4i1eDtzn93yjD4OVSylZ8Ykjr7/YCpkMgzrYqQFde+VlG8d;5:an0ItP3Jd9MFUC9lxvrppXX9YY3z3HC3PV4HnbGkpxONdPFDx/5r4CRD1d1rf1WH/HT7eVw18ANwUxdbOPIPpFCNWHaPJgcdndDyirklsX7x2T1Llvu5pTnmvGQ8xCkQM4/Jx+k4kOUweIoK65mM6c12WpnRFYZMuaoWjmgatSs=;24:KBXBpycI0JPptB52NHbulaExq2MQJaxADwnMpJbGsulCMrPKy13IK5nqqUld4H0nvzxnT/kFVHZr1SV4xKGNpYXC+H/yaCgS5oZOm9Waaj8=;7:+871A3sm072i02KJHJvCYrXRIplVJn5QABDW5CTPQPRfw8ysSWzjI/FUihwnvPpeFntvB4BQ1NPnB4jGWDgg6GYrkoc0Q87l57osliV/08gt51eev88OJ0KjoPU230jsUizsVGCerPsFi8GsoAmBYYyoeE1KzlEoeovIfXl/D3HJokRsNDBjgc/MGkbZxfJtm+ffL7bTGyxAqsD7RtDWb9grEA0NlRspRCA46FCXyuzFhBvaGHXhxfMdTAm6uohX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef6fb89a-a2d5-4288-ebcd-08d5815692a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1083CC1577C25E2C7C57E2CBFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: oJWOg4kNHLZJXa2uSA58d2tEL5Ofp/ET1YwZyxt+Ibudn3gJwTfTCET8F7wnlgiVfW8CGX96DMORkNSNkbx9KS6giA3xSmq2VZdjKKJAYySabo2HwFZnyQ+UFq/P3GLkjRFKDhzTmAZ0nCUxtanWsFi64fjR2v/6ES02iSBF4UU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6fb89a-a2d5-4288-ebcd-08d5815692a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:14.7912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Iyappan Subramanian <isubramanian@apm.com>

[ Upstream commit 0a0400c3094b5d5cedd479ddbf1329de74c09c4b ]

This patch fixes Rx checksum validation logic and
adds NETIF_F_RXCSUM flag.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 27 +++++++++++++++-----=
----
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net=
/ethernet/apm/xgene/xgene_enet_main.c
index de1546a63a7f..651f308cdc60 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -505,14 +505,24 @@ static netdev_tx_t xgene_enet_start_xmit(struct sk_bu=
ff *skb,
 	return NETDEV_TX_OK;
 }
=20
-static void xgene_enet_skip_csum(struct sk_buff *skb)
+static void xgene_enet_rx_csum(struct sk_buff *skb)
 {
+	struct net_device *ndev =3D skb->dev;
 	struct iphdr *iph =3D ip_hdr(skb);
=20
-	if (!ip_is_fragment(iph) ||
-	    (iph->protocol !=3D IPPROTO_TCP && iph->protocol !=3D IPPROTO_UDP)) {
-		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
-	}
+	if (!(ndev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (skb->protocol !=3D htons(ETH_P_IP))
+		return;
+
+	if (ip_is_fragment(iph))
+		return;
+
+	if (iph->protocol !=3D IPPROTO_TCP && iph->protocol !=3D IPPROTO_UDP)
+		return;
+
+	skb->ip_summed =3D CHECKSUM_UNNECESSARY;
 }
=20
 static int xgene_enet_rx_frame(struct xgene_enet_desc_ring *rx_ring,
@@ -555,10 +565,7 @@ static int xgene_enet_rx_frame(struct xgene_enet_desc_=
ring *rx_ring,
=20
 	skb_checksum_none_assert(skb);
 	skb->protocol =3D eth_type_trans(skb, ndev);
-	if (likely((ndev->features & NETIF_F_IP_CSUM) &&
-		   skb->protocol =3D=3D htons(ETH_P_IP))) {
-		xgene_enet_skip_csum(skb);
-	}
+	xgene_enet_rx_csum(skb);
=20
 	rx_ring->rx_packets++;
 	rx_ring->rx_bytes +=3D datalen;
@@ -1725,7 +1732,7 @@ static int xgene_enet_probe(struct platform_device *p=
dev)
 	xgene_enet_setup_ops(pdata);
=20
 	if (pdata->phy_mode =3D=3D PHY_INTERFACE_MODE_XGMII) {
-		ndev->features |=3D NETIF_F_TSO;
+		ndev->features |=3D NETIF_F_TSO | NETIF_F_RXCSUM;
 		spin_lock_init(&pdata->mss_lock);
 	}
 	ndev->hw_features =3D ndev->features;
--=20
2.14.1
