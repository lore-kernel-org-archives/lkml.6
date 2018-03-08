Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491766-2-17804962051627634238
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
    t=1520491765; b=CG2pcyDspxmDxRUdJmDHe4ALaCVvC7vw25f5Ex9CPmTMxKE
    41EHRDZ1NV2x3BoDCxd0Yeo44Xm+N3D3oTtonfKafCyvfFTV5MK0PBkrillpPftR
    AIj1IhcEbYp750Qqu3z7BetzEB2iZKJd6GvSjRKk4gEKksJk5TV22C1dY9X8RSr0
    SOGrYPRhrWWsjOS9Jkc6pUCg1sW7YkiDMuWkHYO7DlVbrSd6KuH1XddRL2A1BQ8x
    3cePdynXSy9M+ojfRugpsNALUnjD3gIPs/oFETHJ4peV2HWJcPXzgwg7cK97zHe4
    nvHxeEEAJN7Oc3AgpzBCbNBnZs/bc8y8Y++iPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491765; bh=WYxw6k
    KMZ4b9lLbAWH80njtJYyKJXUYXB8CfINQI5qY=; b=HvzkNFMcsEVOc9pQl0ic7q
    X2BT+B0/FiwoROtkLB2m/kOHTo54vPuWKDp9ZCjjZfaHOJdhi6vCI9FzKGoqUAQ4
    gmA3v/mGA2Y/MUAVj2L5Cj+bhHiMR7XLIw/8YeHqO0p7UECAP7r4/1TY47m8AiWp
    jyMxGsAdnEbGmMRLIefZR3WfVf45ZaYGmzq/pvMFjMmfD3xzVKFr8CQRld61nbc7
    lfmkFZcgc6uAk1+hgt0n2hM1Y6ou5BExeSXIxThv9zkPtynMkNj3fjYcUYVCVL1v
    EnXj3I5xOHWnB+N66RydB7MHYf17K4nMdtvj+s30fHRqiWsEbjFfysd8rTTSWhAA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xawc3S6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xawc3S6m x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965295AbeCHGtX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:49:23 -0500
Received: from mail-by2nam03on0101.outbound.protection.outlook.com ([104.47.42.101]:17968
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965073AbeCHE6P (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Balaji Pothunoori <bpothuno@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 17/67] ath10k: handling qos at STA side based
 on AP WMM enable/disable
Thread-Topic: [PATCH AUTOSEL for 4.14 17/67] ath10k: handling qos at STA side
 based on AP WMM enable/disable
Thread-Index: AQHTtpn71+H4OyCZqkKgcG5jLad7Sg==
Date: Thu, 8 Mar 2018 04:57:38 +0000
Message-ID: <20180308045641.7814-17-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0808;20:9Kpik1vAFuoiHeDL3BDCNc9/LlCbcKiq9LuMOehMsjjBcF+iVeOwflxDgv9Sp87+Y7EfudsRkVcTTDKEMV4Pp/zoDITWfpmPQ6xoSeljTtdw1t+q6z53F5YmuzLNiIbkm8u/9HmMrj6IbuiB3smFsH0iBOife038aAc29ANGaXY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be5641a9-c420-4a4b-a784-08d584b131d8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0808;
x-ms-traffictypediagnostic: DM5PR2101MB0808:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08085C56C0278DE7320496F6FBDF0@DM5PR2101MB0808.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0808;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0808;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(22452003)(99286004)(76176011)(2906002)(105586002)(3846002)(86612001)(478600001)(72206003)(14454004)(2900100001)(8676002)(102836004)(68736007)(5660300001)(316002)(6116002)(54906003)(26005)(6506007)(59450400001)(1076002)(86362001)(36756003)(186003)(10090500001)(110136005)(106356001)(4326008)(6512007)(6486002)(7736002)(5250100002)(3280700002)(3660700001)(2501003)(6666003)(81166006)(2950100002)(305945005)(53936002)(107886003)(8936002)(6436002)(81156014)(66066001)(25786009)(10290500003)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0808;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: B9mbFyZuyPirMK/S4TalpT/RNwxPzBsZfgGYk8HMBeF6NJL21Lg/MniFx2qJyhS84JUcGLavoKcYsIOZwsYCO3V1qbJXHBIfUMhRBArainU+uSM36G6UWfPKIltH0vU1vv0XMXbReBeCwNtdItVOppoIApFYZ0tOoeDBdBbM+aEgSelChYlPlxPLtdiBRoDXja4VsbnuBpxaDbqVP8NHOSUToCzBbOxb0XZJ1bo23TtQfzUGh4zP+/DMlQ+u4XS5t4kajjusu51I55zCFPIs5RLXQmfeymcoNONJn4FoCiJdn/DKTm3j77BXSAK9GEKYZZ6XalikrUA+zQ3EaJ4umg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5641a9-c420-4a4b-a784-08d584b131d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:38.9780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0808
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Balaji Pothunoori <bpothuno@qti.qualcomm.com>

[ Upstream commit 07ffb4497360ae8789f05555fec8171ee952304d ]

Data packets are not sent by STA in case of STA joined to
non QOS AP (WMM disabled AP). This is happening because of STA
is sending data packets to firmware from host with qos enabled
along with non qos queue value(TID =3D 16).
Due to qos enabled, firmware is discarding the packet.

This patch fixes this issue by updating the qos based on station
WME capability field if WMM is disabled in AP.

This patch is required by 10.4 family chipsets like
QCA4019/QCA9888/QCA9884/QCA99X0.
Firmware Versoin : 10.4-3.5.1-00018.

For 10.2.4 family chipsets QCA988X/QCA9887 and QCA6174 this patch
has no effect.

Signed-off-by: Balaji Pothunoori <bpothuno@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index 5683f1a5330e..ab2da84dfe02 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2553,7 +2553,7 @@ static void ath10k_peer_assoc_h_qos(struct ath10k *ar=
,
 		}
 		break;
 	case WMI_VDEV_TYPE_STA:
-		if (vif->bss_conf.qos)
+		if (sta->wme)
 			arg->peer_flags |=3D arvif->ar->wmi.peer_flags->qos;
 		break;
 	case WMI_VDEV_TYPE_IBSS:
--=20
2.14.1
