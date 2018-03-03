Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119969-2-13554792576040302232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119969; b=D5OnzFek9SzDHT/t9sV7/F+njdt7DYe4p97iP+Ik4zNbpJj
    A2J8Nj+7MoEuKr7bXJMoAoRzaRYpl8SUl+8VQqQ1D4J9fdITkHEWzN3c5/NSBKH+
    aPkngfm/37EQkiHmDeQtyzMsaPxmJnoGosnhRhP0uuAtdZteCElGOc0uTPeJAOHC
    kRS4FjAHfWELGOaVKwsdDLibW5qPFcxR6BJ982QbU6SMpbeq38vP9AyssLGMlDj1
    /BYpNCLIprfr1kH1rXzyz72c3sUEqfZkiJUbEBhupTF5vORn+QaWfnz2Kk3Sz4FW
    8C9fltOaEDekq5TEa4M4U/WviHmopbj4LGIkaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119969; bh=i2+mut
    XLXwSGarWA03/Y7on14+ZwNyAPeQLBfRxS34Y=; b=hZFLAAYay+qgKwS816bxi+
    RiP2K0fhYprxzTGH5OG9u6fh7at8L/7tLTAm3oeZvgQ+swWHfV6eAuXQ9+SDqfPK
    KIahV3NrYhI5iMIhFVvUKHx3jkvRtIjOA2AinqkfMyrETNbvg2b89xcXd2Bizm90
    Heat9skAPgTrROzac97ixgEOSQZo9TSkbDOrnJEx0EiSkFoB1FmfHPBtF1FOKBFi
    JxA/EpbnvFjABymyzqmWZGlmOzwEAAwgv9BPhECejrNew0zwBVjHAJPvz1QIytyl
    bCtExE3M3Y6jNaUkRqyhdsbM3wrNI3CaPgWB/mdGRcNKKKwRNcP2xCI/5d5kqogg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EhfviiNl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EhfviiNl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeCCXcU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:32:20 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934493AbeCCWgK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Hamad Kadmany <qca_hkadmany@qca.qualcomm.com>,
        Maya Erez <qca_merez@qca.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 167/219] wil6210: fix protection against
 connections during reset
Thread-Topic: [PATCH AUTOSEL for 4.9 167/219] wil6210: fix protection against
 connections during reset
Thread-Index: AQHTsz8blGAeGyH1pUiR41mMODPiEA==
Date: Sat, 3 Mar 2018 22:29:34 +0000
Message-ID: <20180303222716.26640-167-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:p8lSsn3PIhO+ucDUnsq4xZJH8pUSbgwbBIcBJOBk1s89AkHZrxdDP/6EW07x65yOb+6OsFAe0PuiDmoLVj8JMF3waDjhMnn4Lu+YbVk+AuFtUBuItaVzS6cXEx/USgdqYwoLzpO4UgcczAbxFnYA5rRrPlezsrbB2f+RwBNtN1AusDUn/m1Lel6drf55qQlcznHlQVsPj2/aVA5oqi1pEgzLjfkiv+6wOU88+hp+9GGQS3WTqzDG2hGa7Jgh1nhH
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68f39bd1-e56a-4583-ee6e-08d58157249f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034DEF0D88A13123795360BFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: H/t2dL9KnZJa88hlnghmpM3zSHtsIzYCWdibTSxa9V++eu5ewWTDXD88Ss2FRCGSTvsqW53vRvJxN6mECfttISr0U1xAhQaYZ3Ya+EGx5LtWsFhrz7F+DCdkv1Vavwgl/qsSAycRXbL0bAmnNUA0IFdUh8MrvZiYMCQVRFj/MtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f39bd1-e56a-4583-ee6e-08d58157249f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:34.2913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
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
