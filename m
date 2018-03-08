Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490605-2-7716530131935007528
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
    t=1520490605; b=L/xoQEhSjfv5HwauaX+Mthj2CeRvnq9iFKqM/e0oHKaDRZw
    fCRdXLdLCAGITP+KKCQQ/Gazg+Jrvr6Xg82AGSXiowj26127hs9ZWiBSadVFCBq4
    1QRGxSrY9mYm8LobC0zsSbojq4EQSV0XuXXaJyS8rD8X/GsfocMo8/s6MuZ2M+sb
    eh20NoSDbaxhlQP0HFVcN0F7baGbTZ/jB0Ox2w7JXBulYqq7SozLt+8rXV7OBVGP
    xkkQs5D7rRhTu+wilTAoyFoXgn/W1F/kN9UEX1SzVQevTCS0J0taqGdni7kjCY4i
    frwRXmS0JDU4s96wzGwdYSd4Sc3DajEjW67mFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490605; bh=i2+mut
    XLXwSGarWA03/Y7on14+ZwNyAPeQLBfRxS34Y=; b=q0w62ExW9QqbCiGDMUMlZS
    PSploSjepBQmsO+J+OvXp+7gt9wI0OC3lOYWdwgkQJHoSlaUZKB1ObrFO4hbTjBr
    u+E4KnqYCIAHgBu2BPqVtdxZFbGdslDL5pBimEp0LDzNerfNaKGh0ehJCahWQQ/M
    D4PFnxGL/50Bf/1vODCTuKmPk2BqcnC1//zPrWoF95aYpedhWszniS2jbdfdBEoG
    8/ztvikwza4gH57WarZaYc3XyDHoRzFbj5jrO1U3HkikVeJ2hoiklANG4Bb0hLSF
    6D6bVy2kjtIoyywRwJ8aSttnV7MsN0qGOY7fZKq2/6ocl0Um8S5HkspDeGihirMw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SU6hN7hi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SU6hN7hi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeCHGaB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:30:01 -0500
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:8240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751292AbeCHFAM (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:12 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 021/190] wil6210: fix protection against
 connections during reset
Thread-Topic: [PATCH AUTOSEL for 4.9 021/190] wil6210: fix protection against
 connections during reset
Thread-Index: AQHTtporLy5jfYYvC0+OMw3beTunLw==
Date: Thu, 8 Mar 2018 04:58:59 +0000
Message-ID: <20180308045810.8041-21-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:DzU9pozcT510uctq2gH1b3uDdsvz0nj3CiOc5H90N7pCS/lz3bmmn+F3bYPe56n2tcnb+w77tMpnzurepDnclG2/1aT3yUItsRb5TEStrj7BGFTFsRGVUCECN5rG6VS2E1RCDIL9myB0BrF5ui49ErhwGvilx/nrT6IsuvGxY+mg6JatCEArssEDaO6atPnDVo7JDv5PRE5MR+FGp6dDcpUOl7WKiABQ3sddAoq9CgRGpf0PiyQFM5SxMg8uDWcJ;20:YsxgOOrv5m1c2Jb4IadfMNbOJ/1tMpskOHbYB50xXMli+3Z4KSGzfXUD8QM/b8ZHn5UZrbL+On2qp9wuuKAEhlZ46F5mrLTohc8Zm8GJhKzN5FZCLbh1JQDA9wcnW4DEmxQEgQN6h1WxnMuSyyEulSAa1ezqH58SUngImnJdFbw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3593df7d-f08b-4b3b-632f-08d584b17284
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983B6D5DAE40A91316F7B0EFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: BHu33mf5KP2WpQFIK5f3Zywybd3l7Zh2WsGcvXYCBuWjzUGZe7GD2qNmmi2QU0Ho00AM3RxMIz7d6iz2skbENaE5e/0voCg53fpaI2lR2XDCGkYad8gqs6tPozU4Xprb7nepkH75jSdUNZuZZ1W9VRuHxNPn9crFRdemDYtQ9Npvx1UCNfE2KVXVAhi1Hj2ELRig/O3Y0gkRmWXeqy6DwThOmI/RHOmsAqAIp71RBDhPM0A9R+w4Czmcarrhn/8ve/lXej4JiU/YBWkgmg2ZR1PenLwGDundaw6UsLRdUcRMc2m3x01dahc0mn4ome1qaPEi2J3xEvDRd+h0zzM1iA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3593df7d-f08b-4b3b-632f-08d584b17284
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:59.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>

[ Upstream commit b819447dfc4bd120c9d6cd8521252d544fce8fe7 ]

Existing code that ignores connection events during
reset flow will never take effect since it locks the
same mutex taken by the reset flow.

In addition, in case of unsolicited disconnect events ignore
those as well since device is about to get reset.

Signed-off-by: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>
Signed-off-by: Maya Erez <qca_merez@qca.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/=
ath/wil6210/wmi.c
index fae4f1285d08..94a356bbb6b9 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -501,16 +501,16 @@ static void wmi_evt_connect(struct wil6210_priv *wil,=
 int id, void *d, int len)
 		assoc_resp_ielen =3D 0;
 	}
=20
-	mutex_lock(&wil->mutex);
 	if (test_bit(wil_status_resetting, wil->status) ||
 	    !test_bit(wil_status_fwready, wil->status)) {
 		wil_err(wil, "status_resetting, cancel connect event, CID %d\n",
 			evt->cid);
-		mutex_unlock(&wil->mutex);
 		/* no need for cleanup, wil_reset will do that */
 		return;
 	}
=20
+	mutex_lock(&wil->mutex);
+
 	if ((wdev->iftype =3D=3D NL80211_IFTYPE_STATION) ||
 	    (wdev->iftype =3D=3D NL80211_IFTYPE_P2P_CLIENT)) {
 		if (!test_bit(wil_status_fwconnecting, wil->status)) {
@@ -608,6 +608,13 @@ static void wmi_evt_disconnect(struct wil6210_priv *wi=
l, int id,
=20
 	wil->sinfo_gen++;
=20
+	if (test_bit(wil_status_resetting, wil->status) ||
+	    !test_bit(wil_status_fwready, wil->status)) {
+		wil_err(wil, "status_resetting, cancel disconnect event\n");
+		/* no need for cleanup, wil_reset will do that */
+		return;
+	}
+
 	mutex_lock(&wil->mutex);
 	wil6210_disconnect(wil, evt->bssid, reason_code, true);
 	mutex_unlock(&wil->mutex);
--=20
2.14.1
