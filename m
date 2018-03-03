Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116066-3-9573565732564704328
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
    t=1520116066; b=j4bC+wZ28XiQ69KzLq3lI154LXDDO7n63ZRab1OI6Jm4f6U
    smpj6lu7nHeDshHW1VpJoq7+WzDZOhHQQXHaaj5J7atoIHse7JQ9rX50G18SC6+m
    GoWzPDUgO8ghkckNy73ZbRr2djDBfgwzvYG5Ea1YZqRB8zxwkCyXxnTaJJWnjufH
    eLm0SS5vi9ulJN1La93h0999vz6cfxH97oYcU9mTbG4lvQdgf1rNHFm9PyuGg1Fp
    tDUwPV2OQYdsLxMkBq3+3DbEXIH1+3YFQgrMYnrOAJO6lqHgRQYxTw6WWh+ZVOQk
    iSPeOFqVf/lGJZL/Bm0mg/kxIsKMxxY8o8VEi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116066; bh=dWyOU4
    gu1WrTCMHKJGiOqf1s1sPGx1SHPISvsg2Hk0A=; b=LSLtPwaS1T22l/nvEyAi88
    fWiuKh6kHztwUEJSzOz928CNQSfJG+cEw9hKc49uEBJbFG3nTBOQDEMITfWEmlYo
    svpUitkKDUm5jK80LaINU3mTz5hedInP+7aB5NfQ7Wwzo9zvNq4QbeoYi6zWcHSU
    5lrZWx39wfgvaSfQ45W+YIJQVXgGexdyuQ7zcx2RPGhNckjvKVObe5/aCaCdMwJA
    N642PMo0ztaAOpkGLvmP2RBjxGCunCGeOicizCpRf4/Z3YLWuw3tnWePiNEEnK4t
    IKcnVJ510TPckCa9gcqwjOXCn2DxUCbfsCLy16COaQnATxL8s8iC/r46qE2x7Gsg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LN0ydI0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LN0ydI0C x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932856AbeCCW1G (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:06 -0500
Received: from mail-by2nam01on0137.outbound.protection.outlook.com ([104.47.34.137]:52173
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932846AbeCCW1C (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Limin Zhu <liminzhu@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 069/102] mwifiex: cfg80211: do not change
 virtual interface during scan processing
Thread-Topic: [PATCH AUTOSEL for 4.15 069/102] mwifiex: cfg80211: do not
 change virtual interface during scan processing
Thread-Index: AQHTsz5x5V4bGbhb6ESB8CQ2yJwP3Q==
Date: Sat, 3 Mar 2018 22:24:49 +0000
Message-ID: <20180303222318.26006-69-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:A2ranPhghI0TmHZdsAC3IeEJZByt8I/8tUfAQaoc4TkMg0QB+19cvAF5TnAbkbonRWPuqWDP7MdkdcTerT/s5inyls6n1BPk+TrIWxgSMFkIeXiad0i4nvy1sBX/kO5RoYAPeWoSZ3+QEhdJ4vOnUgu9vMa5Zivup2fQ94GUYwcaIR/ymLY4afODg/gisjXyp8pBC7W53u9HOXRftAJgebZqogTHhl84YG4YQW+XA55cs+v+Zo+zoCYkxUbE4H8F
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5556ef2-251e-4541-faf8-08d58155e07d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB067CABFC74A00391C639A1FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(575784001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Qr81lTyYGfQZaAtKHxLHIRA23zbNsgnBLAIVQ/fNaxq9OZD6c/urVE5YQ5vK8E79icxCV4KWIGcej97S53yhldWDu2CRbTld67GR2JMdvIa2a0ERNX7r3JkiuSz9W6CZiSDoXT2PLP/DXFHiYXLr1evkcncWmg4OZsKK5bmaCik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5556ef2-251e-4541-faf8-08d58155e07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:49.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 6e0d9a9c5cfb..f32401197f7c 100644
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
