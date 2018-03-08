Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490202-2-3555920984501184980
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
    t=1520490201; b=Kv1KDMh8QOKRoKaQbBRNRGRrSSlgYWTf0AorBCRXd5PTMDv
    v+fQ/oBVA8dMdJdlcKnmjvJUkjed1wqEZLHvY/VGhddoyoyScX0fRay4aBJeRHzU
    t22WDGAKRM1ubiww0hdnxlEgbl94nSLu29kZKsriVAZiNN4NTBk4IK8jvfbUGjnw
    Hz19r1DWO6Qer27DI4K4qNB9DGdafWHNnECcSQcV2w6p7G1xXPZ/RuJScNJm6JVF
    MzMSjyZDRAg/DrSacyn/gAkTcpW4xTuWYhfcBclGuNzzqPQLJEMWrFBis1l4qSJn
    RVeBeIql5u9dlH/UQ75HBSqcz/D1oC4uqS55NTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490201; bh=7a1V2M
    o/2y1SYAJYCU2Mg6/RicEG7wWrk1QpLEetOzk=; b=M+NkiSUkjw8v4LM7xrjdVM
    E/C38IO9IZpg116BS1GVTy/FksLj5ZB2sz/18j96fc+JnwKigXIp2JR42+pMwxu4
    jz8PklZfDPjX3/U6THQ5b6MBxCkNYT00vkFaBjPrg3/dMKoB1bn2AK1dGTSjVxA9
    j7lB9pkUoRToNcg6QgrPPBcgfYNo5JE/DX7sAJATt4B1wWJTrulYLvFkRYJl9B6m
    UH8NiUMoBI/oonDCuoiVnEbZj5CkYDwn4L0w/BrkBgAVTk7FfD/KId78UIDUW3XF
    5QgVchKpjnzEZgXphUxUBO8Un/8eo4IPu66Yt9vsXnv8AYKboWsoAvKLkxN/I8gQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vr78Mbmo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vr78Mbmo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965837AbeCHGWb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:22:31 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:45505
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935393AbeCHFAp (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 045/190] ath: Fix updating radar flags for
 coutry code India
Thread-Topic: [PATCH AUTOSEL for 4.9 045/190] ath: Fix updating radar flags
 for coutry code India
Thread-Index: AQHTtpoyYXepjHHBQUGPTG7hSA/t4w==
Date: Thu, 8 Mar 2018 04:59:11 +0000
Message-ID: <20180308045810.8041-45-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:hH3i6flxj7GyVtKTI7Sya0rPo1rSnMOL4nuD/M/oU65Lkxy4/hYjntfI2qzMW8VQ3i7cxLmd76E8JcUMvTIUt70VBq3CMCoOtTP6ejk7Mla/VOP4avR+m+qKR+l3CM/L7Mj8tb50m0Pc2vhn8m1TBl63iiXLvDh7KIZv6kLwjKlev+uztekRFhTd9//JdxayLQuBd/yBAcqFzSDoLsVDHv/jyrTXGZeWNJcxKxmLpUiZjMrEyR9lKSQitU/AQFW3;20:ddxm8vCwn8SKI0PM442WpbHZ4ZNhmT9E2+pNAR49FHdo5XQcU1JPLVlfXlYsvBQKId+QCy2xBYQPd5qxETr5M2VlZpK9mHoD5lX8cnDGgGT0lqEXpVyplYDjbjyMgFeC/ymNNcye55wvfqdG3+blxwZBbAgFc1a+PL9+sE2Pu88=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7783db78-8461-4c2e-16ca-08d584b18b5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11099265D4E4A9A8B05FD81FFBDF0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(199004)(189003)(3660700001)(5250100002)(102836004)(6436002)(2501003)(81166006)(8936002)(6486002)(81156014)(53936002)(6512007)(8676002)(6506007)(5660300001)(86612001)(76176011)(10290500003)(86362001)(575784001)(4326008)(59450400001)(105586002)(25786009)(10090500001)(26005)(2900100001)(316002)(106356001)(97736004)(54906003)(305945005)(7736002)(186003)(36756003)(22452003)(110136005)(14454004)(72206003)(6116002)(3846002)(68736007)(3280700002)(66066001)(2906002)(2950100002)(478600001)(6666003)(99286004)(1076002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: esBRhF1aEAQLNlZR3HOzzjd6auXDZj9ziuyBIwe/LBErfEmscsa/0B+eMlElmPuWOHyOKwQBaywSSJzagTylB66x+QBgwmIua9S6HA1NbKZRTyB2vT4LAUNjCOL0SIbBlFGFC92ZpdXt697Wp4Tdrefdj/qo1sEP4Nm03XaRk5K4tb9ZazVdDqv5fU8EUlaXd+BF7oYRZ/a41qViFh6am8KRZPgcvY5dZ3fWfMXT0ktYieVsg3/FjCKL8NKLXBogs4hbzFOkaw6sdPvLUkGwV/A+wh1u5Sxxbh5qGltKl7fMaGDOjly5LF14xkI1JhUNkJyDqDsPHRyzYJQaWS64rA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7783db78-8461-4c2e-16ca-08d584b18b5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:11.5631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
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
index f8506037736f..404fc306cb2a 100644
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
