Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119657-2-10119345282724536734
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
    t=1520119656; b=ue8UtivfaW9MvjHsu/hkHcWOwgp7567QTWXm+PnjOjBGhBG
    xWPZBzFQ/RhlPSqqZUB7dvYhrdkITXCW0DnIKxEKwjbydoBRRdvP5Qh/Z6HJ9CRr
    gffVeIgUwlW3MeDzM9pQSwNCXLGmP4+KnScul4+emVdCfYg4BzpnLyy1nPDODGU5
    pZYD7cw921G2whv62W6M8CJGPVuf21EvTiwGhgt1sJZwDYIaKmjlSel8WNbYMBzA
    F9//OiFuaJHT/GSWd+xW0kjO6xARv43MeL/lgcnKSOovPWZA0s3bt/nOsN1x8yUs
    pZH2jAbkx1Y1NjSXQX5bZJoCXAGYHC2Zaf4u6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119656; bh=6bOVuc
    z9Dk29gbfX9p9hkwmP0Cd7um/7q7t2+A0WdlM=; b=evx9R0U5Ps1wSSN2jBv8M3
    RZsFWf9m43KS2qwxV5y2cV2sERMMUg51YfmAPJX3VsqaOJXjxWLhRr0Yb0nWZIM2
    Rncu/Otu+uDRFM+m98vOWwVMcm1tFTD2flr6HiQOFo05wWNRDW6InYvcIKsIf3Ft
    q5Jxn7/OuAbvG0b/PdH99dfWoEWT19MVvxeLy7zZ0m8RTygRLRiZvxjT9RAT6CdF
    ROxNkgQm3Q+kI3nuW0dCL772ETBc4fIinf817gBpqfZ4wMIpdM8txOvLd1APqB0u
    wkbX2tjy9cARIENhw01Iy75cpzM5sPuarb+9DGq2Oo2onENwk5rZURgob0/btw9Q
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KqoCon9K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KqoCon9K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934662AbeCCWhF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:37:05 -0500
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:4477
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934054AbeCCWhC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Limin Zhu <liminzhu@marvell.com>, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 199/219] mwifiex: cfg80211: do not change
 virtual interface during scan processing
Thread-Topic: [PATCH AUTOSEL for 4.9 199/219] mwifiex: cfg80211: do not change
 virtual interface during scan processing
Thread-Index: AQHTsz8lDRme8KMEk0C2hpqGlDJHTw==
Date: Sat, 3 Mar 2018 22:29:52 +0000
Message-ID: <20180303222716.26640-199-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:5ubWZQ4XYN2EAskMI4BqFyDV2HJMNKwzu0zaFtHvgfUA45gld3yZFDwN3d49+KKPfDMJGjvscZOtp4cf2goU1JToFgTnNGCl0nEA5E5TzgJBjtx13BuP0dTkqN+Xn0cfAWKASnOXx2JWiIU3NCO80UEaWWsY2c9BtNwp+bxLr7jNJhpz08Ovf4mdxtiSHWLbSj37nfNCqBTnGF39Fs1G/9AnxZo5yLg7GNNf1dRtSTXAp8jcxCBUGc9qkgD15EpM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71c76476-6e51-44e3-4f2c-08d5815742c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-microsoft-antispam-prvs: <MW2PR2101MB096920F74A96DEEB6D2E1FE9FBC40@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(366004)(396003)(39860400002)(189003)(199004)(105586002)(5250100002)(53936002)(107886003)(36756003)(6436002)(4326008)(2501003)(6486002)(1076002)(2906002)(6512007)(2900100001)(54906003)(110136005)(305945005)(106356001)(7736002)(316002)(3280700002)(478600001)(14454004)(59450400001)(10290500003)(68736007)(2950100002)(72206003)(3660700001)(66066001)(3846002)(6116002)(102836004)(6506007)(5660300001)(10090500001)(25786009)(186003)(26005)(99286004)(22452003)(81166006)(76176011)(575784001)(86362001)(81156014)(97736004)(86612001)(8676002)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JJuEz18OFV5UQrCFfOZCOJD1Jrr1Ea4LZOIFwsFJ6BFY84g6oUMbKeJMezQt5Z7LHUlt7RTI3YoFqolVT8UfKMu0e0+upoWRJiXUs+rR9DL2CVPxm2PUrsyaZLJIqzdAll5J+ANMJEgum1D7NfIOAPKitD6iOrjc8Zv8llKoZtc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c76476-6e51-44e3-4f2c-08d5815742c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:52.4633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
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
index 8677a53ef725..48d51be11f9b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1109,6 +1109,12 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *w=
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
