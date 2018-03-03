Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122628-2-11133975553771816736
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
    t=1520122628; b=ptTizbD/k2Ac143rSk1B4x89eUjoD96HRdcDqAV6qXu1RN7
    d6KMWswBhi64ga7XNX2whO0zoTqDm8jIzxZRVN/oFHk+DJWCJ7y8fQfrWMJ2fTPu
    bOrQl56VbFrOP7qFH9SdaNBBG7tWj2U/411C1kPApSr7pBVs+FSGJ0QDAxmmALeh
    RLt5o2IoNtQOQdyd285achSVuyvNE1GsYzFYO15vb2W4yDiI+IEPN2GbJEJQGNQR
    4yjsFPJTxCKfjFYaYEiNgMft+uYWeov5cIErfrHZUN4BPxBdIm4keA+DLPLnOtq5
    +lH9tWHrm/wvuhiH65lpCi3jDW9d9AnUdRgv8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122628; bh=zY5bxP
    tnL5Zqh+REcZjNulDDmpcksXUODlJFfKRDTB0=; b=YZBfr69U3B/vYAaf+vQuVi
    hgpC/7b4XXgCdDwYvkGSjWwJZIfJ4WLeRvAnHbxX3BlhjVb6NAnevhfaUqinxK+z
    ubqyLbxMMdNVGtu4K8zbTIvUccqnMmurRK4StlC/1vGqbR+jhgv0ParKPQiYXOag
    Pqe/p7TI+3Ypy0MZCFEIFVzied1TGxoV+Dm/PbWXPTEERuQt5Krxp1/QyjY3Au1A
    E+f0KMGsKuppxOS0UlBECKVISAoSIDGRvLT8A44Yt25941Hzg3E9EdbMkUHqK7v5
    q9EJIJa/AvWZ1nVaPI/89H3gu6LOq2nKi4aAjsOkdWE4aG/V55c7cO+po9yMCC/Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mc6s5ySn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Mc6s5ySn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeCCWaI (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:30:08 -0500
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932498AbeCCWaG (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Limin Zhu <liminzhu@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 53/84] mwifiex: cfg80211: do not change
 virtual interface during scan processing
Thread-Topic: [PATCH AUTOSEL for 4.14 53/84] mwifiex: cfg80211: do not change
 virtual interface during scan processing
Thread-Index: AQHTsz6tKul/jzjUmkiZ1s51tUZ5IA==
Date: Sat, 3 Mar 2018 22:26:30 +0000
Message-ID: <20180303222518.26271-53-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:HY1Lw4jwcQbxlVaT+zIMatBYrZbnjvVADXftsmunndEO35JpNjOG/SJ+q4cgOMfTi5pTKO2VGhWIqv07+fiIZuUw8sBHhMJKF53QYgtHF1uWOgiuzvzliDSXhYKR1aiA8d9DKbaM5yxCYQUMXfh+BaR4ecMVDU6CbkKzLd4wrEz+aTZAjQz72ARjPzaAwXN51LviSTgaqjXx52t1zPnUfkcAg6HKdteU83QmjVoYJjYu806OUPGhbyadtVx772HD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 706df789-49c0-4eb1-9a5f-08d581564f56
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106543E9147D0F6066F79F4CFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(6666003)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(575784001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: nhJIdnVlGXw9pdsEFoFEfluHbS4OEE++Nv7YjwgSKkDlj9YyNiVPOGWDZkl2yGGu3SCdge4MbGyPBoXTVTr0YTxdxJsGlJtAWdluvDDnP6IrHdO9O9IkgFUGpgn8605m8RBKxUp3KfN1dlPEhcRJ69EeuWJ7mK21BBxmVUtIGEI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706df789-49c0-4eb1-9a5f-08d581564f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:30.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Limin Zhu <liminzhu@marvell.com>

[ Upstream commit c61cfe49f0f0f0d1f8b56d0b045838d597e8c3a3 ]

(1) Change virtual interface operation in cfg80211 process reset and
reinitilize private data structure.
(2) Scan result event processed in main process will dereference private
data structure concurrently, ocassionly crash the kernel.

The cornel case could be trigger by below steps:
(1) wpa_cli mlan0 scan
(2) ./hostapd mlan0.conf

Cfg80211 asynchronous scan procedure is not all the time operated
under rtnl lock, here we add the protect to serialize the cfg80211
scan and change_virtual interface operation.

Signed-off-by: Limin Zhu <liminzhu@marvell.com>
Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/=
wireless/marvell/mwifiex/cfg80211.c
index 32c5074da84c..68aa0c7a8139 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1116,6 +1116,12 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *w=
iphy,
 	struct mwifiex_private *priv =3D mwifiex_netdev_get_priv(dev);
 	enum nl80211_iftype curr_iftype =3D dev->ieee80211_ptr->iftype;
=20
+	if (priv->scan_request) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "change virtual interface: scan in process\n");
+		return -EBUSY;
+	}
+
 	switch (curr_iftype) {
 	case NL80211_IFTYPE_ADHOC:
 		switch (type) {
--=20
2.14.1
