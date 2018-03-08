Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486292-2-13910022332311283774
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
    t=1520486291; b=SAqTqkQJCUjHCbaqZDll2EPKNFAfakjfN+8s1ym+b1eIDrC
    m87i8rK+HezEPtTOIyGpRc2l+xcY+tm40dx3AcAN0rK8qHcT4SRwMMNroVJJMKf8
    v8Nw4ax2PJhZEsJQaYs3jRo37ZUJ6HsJwkKTL2rwb3m3Wt9KIESdle/Wq6jgT9Nt
    RJHPRXAI/w4D3Ow2Mo27ta261IEvz7M3z+w/dX9N+JGAnlDlxpDrz8t/WiT2tJYU
    RorFQ3rne2GytnG4a2bhOlfZXR8OrykMJuu8OgvaP034E8CA6RqX1rCd++pS7Spr
    nBBPzb2m6fzbyYmZsAmqHToEI0JMXfqb/xI+GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486291; bh=MlhY5e
    ftgC1SsDZQCOjyDZh4kv8K2QEKvVYLGcoIy5w=; b=o+Tbn/Kyi1Ab/P+YnLIw0o
    rUdZKQnlKphXWR/5djXkE6v2xvVDPnzK0kVqHVY8wAVs2YMWJfJ/GG8f95JVoOGw
    XFkmYvjV/eBtNpofviEqinfjTOh4MgvS7MGVJOisO++XJxBsY+K8R9pcvodCFAGx
    7DwtAQ9quJcrKfG1IdXBdqz4YSkOhMzTPxIEzKvV3Xv+HcGoqfUHpi7+3IHAUoB2
    iK2nNHr3VDMQgS0hKXQOYAO2LdBjiy+4mlXtDpK7W6WsWdljMf4Ze5+K7TjAElop
    MLXJdJkTVx0F3FSDX8DJsZ/pbN1grjAcHT1QMV1oZOAZY09VuerqqZdeOQ11av1w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IDuuhXEP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IDuuhXEP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966464AbeCHFRm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:17:42 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:62624
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966452AbeCHFIm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 18/53] ath: Fix updating radar flags for
 coutry code India
Thread-Topic: [PATCH AUTOSEL for 3.18 18/53] ath: Fix updating radar flags for
 coutry code India
Thread-Index: AQHTtprDebSBJkf6M0SzNNIFUwQbhw==
Date: Thu, 8 Mar 2018 05:03:14 +0000
Message-ID: <20180308050230.8876-18-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:ikkSXB9z6PLfci1TwcD1S0QQQcUn4QBTdW4Q8UGRpjSRkjsKeiVx2h6tEgLjiCB3MBKUwFxuOWoVnVHLzYIupEgf435LraOxSzBrjTeCI44JOL83ASJ4pDKGDAIVexslrd+THm5P9nIvANA8TWytKKTpcWJ/ePYu4P7nKj+WLgufPwfE6ty33pSYp4ggoBOg6/zRfNG7QVL8tB2dgHgApfQJ3rKdBEwJNVtuQXCzIjFqCcxM9zOTwyJJZq0uPySr;20:MSB7sBLxkMWJdJeLI3G6xc73uTA+lqWVhg/OfE9Cz05vkkX+C1+TGY+kISICcdG6wkFtG+bHVv3UogxQHtpblzsEL3FC6IKb0nVo3kyxEfn/Hz94+ybvmydMt1zKYok08ewzcoBoR6WNKkZ6taz+8nFC9kwDG2HyTSw7bqiZwUk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f823063d-2527-4028-de31-08d584b2a7a4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871514440CFD301BB1E8C7DFBDF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(7736002)(14454004)(3660700001)(68736007)(305945005)(2900100001)(10090500001)(66066001)(97736004)(81166006)(105586002)(10290500003)(8676002)(72206003)(8936002)(102836004)(59450400001)(86612001)(53936002)(6512007)(6506007)(110136005)(107886003)(478600001)(54906003)(106356001)(81156014)(25786009)(4326008)(26005)(316002)(186003)(5250100002)(2501003)(575784001)(2906002)(86362001)(6666003)(3280700002)(22452003)(36756003)(2950100002)(1076002)(6486002)(76176011)(5660300001)(99286004)(6436002)(3846002)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dOJ52+tNnnUzKGk9V2fjd/g4dYDYfUoo61XYm9qr7MDqMwL2HhM4f6VgxEBniekvV0xC/sW29Q6GD397IHlzmaRtUSKf7PtOHtt9mn7spbZKlAPKSkC/vchBNjnDpXVpguEKzSpwMeKK4wFobh9evRQmUlTJOOqD9ggTq9o9gOXeOXES18zOX+kvbISjq5RKda6ASiqMijvEMigo8ur0fIn0kP4cL7LX62u/omBLgmFGpXQWGz0SCeWcElnidP0Rz2p3/4Lej48Kmescn3gcGndx8hqs1IW5Ms28HNEuimi9x96wgU/xJJ/NWHIMFdt0VlPxr3oGSKrWc5gMHeatow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f823063d-2527-4028-de31-08d584b2a7a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:14.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit c0c345d4cacc6a1f39d4856f37dcf6e34f51a5e4 ]

As per latest regulatory update for India, channel 52, 56, 60, 64
is no longer restricted to DFS. Enabling DFS/no infra flags in driver
results in applying all DFS related restrictions (like doing CAC etc
before this channel moves to 'available state') for these channels
even though the country code is programmed as 'India' in he hardware,
fix this by relaxing the frequency range while applying RADAR flags
only if the country code is programmed to India. If the frequency range
needs to modified based on different country code, ath_is_radar_freq
can be extended/modified dynamically.

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/regd.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/reg=
d.c
index 06ea6cc9e30a..62077bda8dde 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -254,8 +254,12 @@ bool ath_is_49ghz_allowed(u16 regdomain)
 EXPORT_SYMBOL(ath_is_49ghz_allowed);
=20
 /* Frequency is one where radar detection is required */
-static bool ath_is_radar_freq(u16 center_freq)
+static bool ath_is_radar_freq(u16 center_freq,
+			      struct ath_regulatory *reg)
+
 {
+	if (reg->country_code =3D=3D CTRY_INDIA)
+		return (center_freq >=3D 5500 && center_freq <=3D 5700);
 	return (center_freq >=3D 5260 && center_freq <=3D 5700);
 }
=20
@@ -306,7 +310,7 @@ __ath_reg_apply_beaconing_flags(struct wiphy *wiphy,
 				enum nl80211_reg_initiator initiator,
 				struct ieee80211_channel *ch)
 {
-	if (ath_is_radar_freq(ch->center_freq) ||
+	if (ath_is_radar_freq(ch->center_freq, reg) ||
 	    (ch->flags & IEEE80211_CHAN_RADAR))
 		return;
=20
@@ -395,8 +399,9 @@ ath_reg_apply_ir_flags(struct wiphy *wiphy,
 	}
 }
=20
-/* Always apply Radar/DFS rules on freq range 5260 MHz - 5700 MHz */
-static void ath_reg_apply_radar_flags(struct wiphy *wiphy)
+/* Always apply Radar/DFS rules on freq range 5500 MHz - 5700 MHz */
+static void ath_reg_apply_radar_flags(struct wiphy *wiphy,
+				      struct ath_regulatory *reg)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_channel *ch;
@@ -409,7 +414,7 @@ static void ath_reg_apply_radar_flags(struct wiphy *wip=
hy)
=20
 	for (i =3D 0; i < sband->n_channels; i++) {
 		ch =3D &sband->channels[i];
-		if (!ath_is_radar_freq(ch->center_freq))
+		if (!ath_is_radar_freq(ch->center_freq, reg))
 			continue;
 		/* We always enable radar detection/DFS on this
 		 * frequency range. Additionally we also apply on
@@ -505,7 +510,7 @@ void ath_reg_notifier_apply(struct wiphy *wiphy,
 	struct ath_common *common =3D container_of(reg, struct ath_common,
 						 regulatory);
 	/* We always apply this */
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
=20
 	/*
 	 * This would happen when we have sent a custom regulatory request
@@ -653,7 +658,7 @@ ath_regd_init_wiphy(struct ath_regulatory *reg,
 	}
=20
 	wiphy_apply_custom_regulatory(wiphy, regd);
-	ath_reg_apply_radar_flags(wiphy);
+	ath_reg_apply_radar_flags(wiphy, reg);
 	ath_reg_apply_world_flags(wiphy, NL80211_REGDOM_SET_BY_DRIVER, reg);
 	return 0;
 }
--=20
2.14.1
