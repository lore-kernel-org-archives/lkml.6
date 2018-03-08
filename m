Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520487656-2-10037964140751292988
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
    t=1520487655; b=QtB5sNYgTjZm/N38F0d/6FT7jrx8O71uyF/2OK+xiOcB3dE
    XPSQ5m9OW5z55axEA/YaKS2PgWxR+P/1k2AUMe5XUIBLhimSRLivqtyOpn5vDpVl
    VSj5ftCJj8NuqApxG30VIQD+W1mehmixdbbpC9AdxWb7FYQlHd4T8+aWNzSt9g+V
    A+JBQK8HRx6UbLfUtQELRGs1YVEfOZk87QBikcDxzjSCh6C8H/0hY4JYR/h2Ed7M
    CtXfn5CMHjA9/aaStB7BUiy6oxpKOw6ewGxZBWBsam9t0363e7cnaxPVGdD54M72
    NATro3F91hRL7QAe9F6C+cKorzVBK9WE6xB90RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487655; bh=MlhY5e
    ftgC1SsDZQCOjyDZh4kv8K2QEKvVYLGcoIy5w=; b=cvqmw1Hr6QpLcaCrFnSsBl
    ItuTroWxRxHWigoPj9oWqzTXfVIZPWenJzjgSmmIVn8hvJWVy3LVQ+4ErAZSUOAx
    drxueQykrkxGaCb6dkbdKvRLN87XmENe1IGx2JRjRHr28iex6Hz07hMtonaIJ4TR
    oDjSum0wwhKNQrcNzkEVZJJyXYiRvMDpTI7Pv2k/r2gxQ5dmZIbqBXKNsumS8iW4
    jfnKTg7FddV50DRrR9WTmjGF9B2+GuwgRSH3pwLg0739MzPWSTwA+KHYeLpoto1h
    Eetfrsf6Jt/PUU2P7zvPS0IW8l95dqMEIjvIJKsuP/VLZcWfVzHzM+Av1sJb9dnA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JLveij7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JLveij7x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966352AbeCHFkS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:40:18 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:58876
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966229AbeCHFFY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:05:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 025/101] ath: Fix updating radar flags for
 coutry code India
Thread-Topic: [PATCH AUTOSEL for 4.4 025/101] ath: Fix updating radar flags
 for coutry code India
Thread-Index: AQHTtpqHG+peq4zE/E+jGdNMvQEM+Q==
Date: Thu, 8 Mar 2018 05:01:34 +0000
Message-ID: <20180308050023.8548-25-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:MgGQOOrfhS0IWx+0S02vX0aqpbr5lXO9ihKe7xh4ElLPfG8a3ioRzSnxJLp4s5mK/7pw4v0oEVvUG9/5Qn9JTq2AY0kpx1oOLhJHIl5TglTLbUrpiC1SaaLkbcI9+nAzi633QqhHDx9qDQZYegn8XAIuv3GWVj7CI/Cz7HaxdEHDi/UJPpJTt+Ij8Ynawy9rswOlEL5tWXeFgyYYwpGaioOLXo7xPUImC89+Lak+L30dzm32Z3EcDJaT99pq8vjs;20:cc+OGemcDe9re9aqVzB1GtA+vL/AWwRqqlfFhF2y2MgSIAZTCiaqw/l22ceJA0AzsuJjHet/63/vHBczKcEo6NJTLdg0Cn2S9SbD/RA5fZvfPSFhN6JeTByUVab7Y39R6Rf7KKVPMfjZZx34AQyblbTT0Mttbi7JSgwTyNGCUNU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 493c251c-5036-493a-e22c-08d584b22dde
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727119235E9A4A895A15189FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(575784001)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 0UNPi+iv+sW3q0/22FlYasHkhgnSV/BtzNCsSjj0umfzRPRqFVTwpbOL+gsNPc8TYLMDb1LEO01G55fyUIOswBDuBG1g8FmQI427LfaXf5hG1owC5qkifrRZ/yb9D5hS6AXngpj+Bs60KUOqW5TmEbrxm+mBlDVZXxl0VUrDSclOuRjKN3jiztxFiCY6m61V/14p2+ixyAiaV538qvsOYJZur0/ZBmjR+s88i+G5wwGS93rua/zivvHcfXque/zL5f263bQgqClAhhNUCUduAlVK22iHceuEqLIGnPEXHiy8892VSzNdi+Nh8K4IyPg16erNXo5Z3RUXfcYvFA0EDA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493c251c-5036-493a-e22c-08d584b22dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:34.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
