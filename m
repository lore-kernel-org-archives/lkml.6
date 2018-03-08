Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520489060-2-28149357469085808
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
    t=1520489059; b=CJbrPEOI+woQ3Il8ha2ZiC+oG+n7sD2DUnIw0tFak/TekQZ
    UO4//0QoXHxr5QifJS7NIdGiBmaU4nGQp53eqfEdUcznbpSwjpywdcxo+6QS9e3k
    u3Pe8LG69zfdfLiKbTW8BXj5v8nmjwp17vlvtw74EA2AcTFAuSvd0UJGT3MfwIkJ
    5L9pv+eQ1qVQdRCqERnMFUmRPC7VtZWOsfg79PXNGwbLZvbs8YsDb3c0wlTS13hw
    TEkbsEIpruB/pwom8Y6Mv9xBpO4LDAmJBgXvQYJQSgxmx4+ywUBCG21ChpzSy+3E
    333LgoRuGUrjKTcuj8OggB08evKCTbLvmLC/tJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520489059; bh=8gwLeU
    a15Yxe/7Hx2ulDHw5FRIQ8PCvg0WnedqLEU/0=; b=IIu68dhbjRJ9PW63dE3JMa
    VHhUBYr/EMzrWGcujnQsLNJviHub+t7kCo2amIY5Kj8eZCTvQzQon8NzVkC+LLl4
    2OxB/5MsQf24c0FY/HFYgHYBv2xjVP9/O26XvrGNfm8YuqZGEiYYT+odTZjMcE6I
    +z5BcSYEKqRiUyN40rgkTGvyaw/wEMGaPGAasWoC+wLiz2Ao36Yv1EiYPM8UIjAd
    Ho7AKjqK0jvunVOpdQa+CjrgqqKp4u/XMEos/YGxW+Aiv0M2Ssp71M4lhuZY2GhW
    0N5c1rCI78NusGQQKLnGOqReFXj/P70lq9ET9M3xA+UVWeDo9uubntGHecckX1bw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TZ/Cp2Eo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TZ/Cp2Eo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935470AbeCHGEA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:04:00 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965822AbeCHFCY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Michal Kazior <michal.kazior@tieto.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 108/190] mac80211: Fix possible sband related
 NULL pointer de-reference
Thread-Topic: [PATCH AUTOSEL for 4.9 108/190] mac80211: Fix possible sband
 related NULL pointer de-reference
Thread-Index: AQHTtppDpNvIto9Wi0eBXVucVa6/aA==
Date: Thu, 8 Mar 2018 04:59:39 +0000
Message-ID: <20180308045810.8041-108-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:GoRQmOFqxMGOivaxXlYXnaNyAsSy0lJIIZxPG8KspNUZ0plivDCF0BZs6OfvzmRS5I4j4tuZa85if63Cqkrn1+eNL/de5gtPXyHFEOgNz9NfvxRiNmTOldc1B7kSfSjPNdF287Dy8Cbwi14pA7io+k/mXpMQyUC8fz3Jq8pVTYJylwz7u2z5+yi3d4otbYtGG1A+XJblnrLe9YRT//4gcOEIEXzVdV/QD+3J4+rNNZ97EN7J4I0faNVCd99m+9Qx;20:yp0T0Fc2Jg7QbmV8EYCvQxbzOSl05UMu7Yb8TtxNshyJXwGMNmDe1zGh4AJS5w6TNjPGl/Yb2lch565c+EMhs0/yu2VZGZXrcQ76VS4KGDsZ7ARHei54wthvSUd5aOd8RQtSq69cWRP4sjThqLZi8rhBEeqJQEiWL25iyXSlXlg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3735a688-538a-4e74-105c-08d584b1c24e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997408CE306F0806B60E125FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(21532816269658)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(966005)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(6306002)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(53946003)(68736007)(7736002)(6436002)(22906009)(217873001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JfvS2O7wsF0ixokBbPIS9n6T8QEc7jXphD5rPiYAuuvB3y7HWZjfHYIYDdXICdo8dJ4pRzdnZXdiJUJ0nnTwpZSuNYjOMN86oCI6WjXHyCdMx0xk4cGL4byK5ODXEkf+RXyu6/gFrNDUSLRlpetmbUmJuIP408Q7ptFrq8fF7eKxXw/4663o8U2M5ZQsRds2aKgJK2dI30RB2rxjejqrDAtq+Sx0+4Dx18xz7BAGzQF4prOmkQJ0WWzsORAXZ5hw6cmBofkgbwtEj/ILyBfIFWVwr8eKw4L1IXCcFyScN5b/Rzj0ldd4GqBPIiuLYJerLeBFpdiJDcLHk8e1nqIv6w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3735a688-538a-4e74-105c-08d584b1c24e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:39.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit 21a8e9dd52b64f0170bad208293ef8c30c3c1403 ]

Existing API 'ieee80211_get_sdata_band' returns default 2 GHz band even
if the channel context configuration is NULL. This crashes for chipsets
which support 5 Ghz alone when it tries to access members of 'sband'.
Channel context configuration can be NULL in multivif case and when
channel switch is in progress (or) when it fails. Fix this by replacing
the API 'ieee80211_get_sdata_band' with  'ieee80211_get_sband' which
returns a NULL pointer for sband when the channel configuration is NULL.

An example scenario is as below:

In multivif mode (AP + STA) with drivers like ath10k, when we do a
channel switch in the AP vif (which has a number of clients connected)
and a STA vif which is connected to some other AP, when the channel
switch in AP vif fails, while the STA vifs tries to connect to the
other AP, there is a window where the channel context is NULL/invalid
and this results in a crash  while the clients connected to the AP vif
tries to reconnect and this race is very similar to the one investigated
by Michal in https://patchwork.kernel.org/patch/3788161/ and this does
happens with hardware that supports 5Ghz alone after long hours of
testing with continuous channel switch on the AP vif

ieee80211 phy0: channel context reservation cannot be finalized because
some interfaces aren't switching
wlan0: failed to finalize CSA, disconnecting
wlan0-1: deauthenticating from 8c:fd:f0:01:54:9c by local choice
	(Reason: 3=3DDEAUTH_LEAVING)

	WARNING: CPU: 1 PID: 19032 at net/mac80211/ieee80211_i.h:1013 sta_info_all=
oc+0x374/0x3fc [mac80211]
	[<bf77272c>] (sta_info_alloc [mac80211])
	[<bf78776c>] (ieee80211_add_station [mac80211]))
	[<bf73cc50>] (nl80211_new_station [cfg80211])

	Unable to handle kernel NULL pointer dereference at virtual
	address 00000014
	pgd =3D d5f4c000
	Internal error: Oops: 17 [#1] PREEMPT SMP ARM
	PC is at sta_info_alloc+0x380/0x3fc [mac80211]
	LR is at sta_info_alloc+0x37c/0x3fc [mac80211]
	[<bf772738>] (sta_info_alloc [mac80211])
	[<bf78776c>] (ieee80211_add_station [mac80211])
	[<bf73cc50>] (nl80211_new_station [cfg80211]))

Cc: Michal Kazior <michal.kazior@tieto.com>
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/mac80211/cfg.c         | 30 +++++++++++++++++-------------
 net/mac80211/ibss.c        |  6 +++++-
 net/mac80211/ieee80211_i.h | 36 +++++++++++++++++++++---------------
 net/mac80211/mesh.c        | 29 ++++++++++++++++++++---------
 net/mac80211/mesh_plink.c  | 37 ++++++++++++++++++++++++++-----------
 net/mac80211/mlme.c        | 14 ++++++++++++--
 net/mac80211/rate.c        |  4 +++-
 net/mac80211/sta_info.c    | 13 +++++++++----
 net/mac80211/tdls.c        | 29 +++++++++++++++++++----------
 net/mac80211/tx.c          |  5 ++++-
 net/mac80211/util.c        |  6 +++---
 11 files changed, 139 insertions(+), 70 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index dee60428c78c..efa2a2fcae72 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -620,10 +620,11 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 		int shift =3D ieee80211_vif_get_shift(&sta->sdata->vif);
 		u16 brate;
=20
-		sband =3D sta->local->hw.wiphy->bands[
-				ieee80211_get_sdata_band(sta->sdata)];
-		brate =3D sband->bitrates[rate->idx].bitrate;
-		rinfo->legacy =3D DIV_ROUND_UP(brate, 1 << shift);
+		sband =3D ieee80211_get_sband(sta->sdata);
+		if (sband) {
+			brate =3D sband->bitrates[rate->idx].bitrate;
+			rinfo->legacy =3D DIV_ROUND_UP(brate, 1 << shift);
+		}
 	}
 	if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
 		rinfo->bw =3D RATE_INFO_BW_40;
@@ -1218,10 +1219,11 @@ static int sta_apply_parameters(struct ieee80211_lo=
cal *local,
 	int ret =3D 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata =3D sta->sdata;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
 	u32 mask, set;
=20
-	sband =3D local->hw.wiphy->bands[band];
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
=20
 	mask =3D params->sta_flags_mask;
 	set =3D params->sta_flags_set;
@@ -1354,7 +1356,7 @@ static int sta_apply_parameters(struct ieee80211_loca=
l *local,
 		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
-					 &sta->sta.supp_rates[band]);
+					 &sta->sta.supp_rates[sband->band]);
 	}
=20
 	if (params->ht_capa)
@@ -1370,8 +1372,8 @@ static int sta_apply_parameters(struct ieee80211_loca=
l *local,
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
 		 */
-		__ieee80211_vht_handle_opmode(sdata, sta,
-					      params->opmode_notif, band);
+		__ieee80211_vht_handle_opmode(sdata, sta, params->opmode_notif,
+					      sband->band);
 	}
=20
 	if (params->support_p2p_ps >=3D 0)
@@ -2017,13 +2019,15 @@ static int ieee80211_change_bss(struct wiphy *wiphy=
,
 				struct bss_parameters *params)
 {
 	struct ieee80211_sub_if_data *sdata =3D IEEE80211_DEV_TO_SUB_IF(dev);
-	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
 	u32 changed =3D 0;
=20
 	if (!sdata_dereference(sdata->u.ap.beacon, sdata))
 		return -ENOENT;
=20
-	band =3D ieee80211_get_sdata_band(sdata);
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
=20
 	if (params->use_cts_prot >=3D 0) {
 		sdata->vif.bss_conf.use_cts_prot =3D params->use_cts_prot;
@@ -2036,7 +2040,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	}
=20
 	if (!sdata->vif.bss_conf.use_short_slot &&
-	    band =3D=3D NL80211_BAND_5GHZ) {
+	    sband->band =3D=3D NL80211_BAND_5GHZ) {
 		sdata->vif.bss_conf.use_short_slot =3D true;
 		changed |=3D BSS_CHANGED_ERP_SLOT;
 	}
@@ -2049,7 +2053,7 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
=20
 	if (params->basic_rates) {
 		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 wiphy->bands[band],
+					 wiphy->bands[sband->band],
 					 params->basic_rates,
 					 params->basic_rates_len,
 					 &sdata->vif.bss_conf.basic_rates);
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 62d13eabe17f..d31818e7d10c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -994,7 +994,7 @@ static void ieee80211_update_sta_info(struct ieee80211_=
sub_if_data *sdata,
 	enum nl80211_band band =3D rx_status->band;
 	enum nl80211_bss_scan_width scan_width;
 	struct ieee80211_local *local =3D sdata->local;
-	struct ieee80211_supported_band *sband =3D local->hw.wiphy->bands[band];
+	struct ieee80211_supported_band *sband;
 	bool rates_updated =3D false;
 	u32 supp_rates =3D 0;
=20
@@ -1004,6 +1004,10 @@ static void ieee80211_update_sta_info(struct ieee802=
11_sub_if_data *sdata,
 	if (!ether_addr_equal(mgmt->bssid, sdata->u.ibss.bssid))
 		return;
=20
+	sband =3D local->hw.wiphy->bands[band];
+	if (WARN_ON(!sband))
+		return;
+
 	rcu_read_lock();
 	sta =3D sta_info_get(sdata, mgmt->sa);
=20
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 03dbc6bd8598..7fd544d970d9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -991,21 +991,6 @@ sdata_assert_lock(struct ieee80211_sub_if_data *sdata)
 	lockdep_assert_held(&sdata->wdev.mtx);
 }
=20
-static inline enum nl80211_band
-ieee80211_get_sdata_band(struct ieee80211_sub_if_data *sdata)
-{
-	enum nl80211_band band =3D NL80211_BAND_2GHZ;
-	struct ieee80211_chanctx_conf *chanctx_conf;
-
-	rcu_read_lock();
-	chanctx_conf =3D rcu_dereference(sdata->vif.chanctx_conf);
-	if (!WARN_ON(!chanctx_conf))
-		band =3D chanctx_conf->def.chan->band;
-	rcu_read_unlock();
-
-	return band;
-}
-
 static inline int
 ieee80211_chandef_get_shift(struct cfg80211_chan_def *chandef)
 {
@@ -1410,6 +1395,27 @@ IEEE80211_WDEV_TO_SUB_IF(struct wireless_dev *wdev)
 	return container_of(wdev, struct ieee80211_sub_if_data, wdev);
 }
=20
+static inline struct ieee80211_supported_band *
+ieee80211_get_sband(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local =3D sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	enum nl80211_band band;
+
+	rcu_read_lock();
+	chanctx_conf =3D rcu_dereference(sdata->vif.chanctx_conf);
+
+	if (WARN_ON(!chanctx_conf)) {
+		rcu_read_unlock();
+		return NULL;
+	}
+
+	band =3D chanctx_conf->def.chan->band;
+	rcu_read_unlock();
+
+	return local->hw.wiphy->bands[band];
+}
+
 /* this struct represents 802.11n's RA/TID combination */
 struct ieee80211_ra_tid {
 	u8 ra[ETH_ALEN];
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index b4b3fe078868..b2a27263d6ff 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -63,6 +63,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sda=
ta,
 	struct ieee80211_if_mesh *ifmsh =3D &sdata->u.mesh;
 	u32 basic_rates =3D 0;
 	struct cfg80211_chan_def sta_chan_def;
+	struct ieee80211_supported_band *sband;
=20
 	/*
 	 * As support for each feature is added, check for matching
@@ -83,7 +84,11 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sd=
ata,
 	     (ifmsh->mesh_auth_id =3D=3D ie->mesh_config->meshconf_auth)))
 		return false;
=20
-	ieee80211_sta_get_rates(sdata, ie, ieee80211_get_sdata_band(sdata),
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return false;
+
+	ieee80211_sta_get_rates(sdata, ie, sband->band,
 				&basic_rates);
=20
 	if (sdata->vif.bss_conf.basic_rates !=3D basic_rates)
@@ -399,12 +404,13 @@ static int mesh_add_ds_params_ie(struct ieee80211_sub=
_if_data *sdata,
 int mesh_add_ht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		       struct sk_buff *skb)
 {
-	struct ieee80211_local *local =3D sdata->local;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
 	struct ieee80211_supported_band *sband;
 	u8 *pos;
=20
-	sband =3D local->hw.wiphy->bands[band];
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
 	if (!sband->ht_cap.ht_supported ||
 	    sdata->vif.bss_conf.chandef.width =3D=3D NL80211_CHAN_WIDTH_20_NOHT |=
|
 	    sdata->vif.bss_conf.chandef.width =3D=3D NL80211_CHAN_WIDTH_5 ||
@@ -462,12 +468,13 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data =
*sdata,
 int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 			struct sk_buff *skb)
 {
-	struct ieee80211_local *local =3D sdata->local;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
 	struct ieee80211_supported_band *sband;
 	u8 *pos;
=20
-	sband =3D local->hw.wiphy->bands[band];
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return -EINVAL;
+
 	if (!sband->vht_cap.vht_supported ||
 	    sdata->vif.bss_conf.chandef.width =3D=3D NL80211_CHAN_WIDTH_20_NOHT |=
|
 	    sdata->vif.bss_conf.chandef.width =3D=3D NL80211_CHAN_WIDTH_5 ||
@@ -916,12 +923,16 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub=
_if_data *sdata,
 	struct cfg80211_csa_settings params;
 	struct ieee80211_csa_ie csa_ie;
 	struct ieee80211_if_mesh *ifmsh =3D &sdata->u.mesh;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
+	struct ieee80211_supported_band *sband;
 	int err;
 	u32 sta_flags;
=20
 	sdata_assert_lock(sdata);
=20
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return false;
+
 	sta_flags =3D IEEE80211_STA_DISABLE_VHT;
 	switch (sdata->vif.bss_conf.chandef.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
@@ -935,7 +946,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_i=
f_data *sdata,
=20
 	memset(&params, 0, sizeof(params));
 	memset(&csa_ie, 0, sizeof(csa_ie));
-	err =3D ieee80211_parse_ch_switch_ie(sdata, elems, band,
+	err =3D ieee80211_parse_ch_switch_ie(sdata, elems, sband->band,
 					   sta_flags, sdata->vif.addr,
 					   &csa_ie);
 	if (err < 0)
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index fcba70e57073..2d3c4695e75b 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -93,19 +93,23 @@ static inline void mesh_plink_fsm_restart(struct sta_in=
fo *sta)
 static u32 mesh_set_short_slot_time(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local =3D sdata->local;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
-	struct ieee80211_supported_band *sband =3D local->hw.wiphy->bands[band];
+	struct ieee80211_supported_band *sband;
 	struct sta_info *sta;
 	u32 erp_rates =3D 0, changed =3D 0;
 	int i;
 	bool short_slot =3D false;
=20
-	if (band =3D=3D NL80211_BAND_5GHZ) {
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return changed;
+
+	if (sband->band =3D=3D NL80211_BAND_5GHZ) {
 		/* (IEEE 802.11-2012 19.4.5) */
 		short_slot =3D true;
 		goto out;
-	} else if (band !=3D NL80211_BAND_2GHZ)
+	} else if (sband->band !=3D NL80211_BAND_2GHZ) {
 		goto out;
+	}
=20
 	for (i =3D 0; i < sband->n_bitrates; i++)
 		if (sband->bitrates[i].flags & IEEE80211_RATE_ERP_G)
@@ -121,7 +125,7 @@ static u32 mesh_set_short_slot_time(struct ieee80211_su=
b_if_data *sdata)
 			continue;
=20
 		short_slot =3D false;
-		if (erp_rates & sta->sta.supp_rates[band])
+		if (erp_rates & sta->sta.supp_rates[sband->band])
 			short_slot =3D true;
 		 else
 			break;
@@ -247,7 +251,15 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if=
_data *sdata,
 	mgmt->u.action.u.self_prot.action_code =3D action;
=20
 	if (action !=3D WLAN_SP_MESH_PEERING_CLOSE) {
-		enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
+		struct ieee80211_supported_band *sband;
+		enum nl80211_band band;
+
+		sband =3D ieee80211_get_sband(sdata);
+		if (!sband) {
+			err =3D -EINVAL;
+			goto free;
+		}
+		band =3D sband->band;
=20
 		/* capability info */
 		pos =3D skb_put(skb, 2);
@@ -393,13 +405,16 @@ static void mesh_sta_info_init(struct ieee80211_sub_i=
f_data *sdata,
 			       struct ieee802_11_elems *elems, bool insert)
 {
 	struct ieee80211_local *local =3D sdata->local;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
 	struct ieee80211_supported_band *sband;
 	u32 rates, basic_rates =3D 0, changed =3D 0;
 	enum ieee80211_sta_rx_bandwidth bw =3D sta->sta.bandwidth;
=20
-	sband =3D local->hw.wiphy->bands[band];
-	rates =3D ieee80211_sta_get_rates(sdata, elems, band, &basic_rates);
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return;
+
+	rates =3D ieee80211_sta_get_rates(sdata, elems, sband->band,
+					&basic_rates);
=20
 	spin_lock_bh(&sta->mesh->plink_lock);
 	sta->rx_stats.last_rx =3D jiffies;
@@ -410,9 +425,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_=
data *sdata,
 		goto out;
 	sta->mesh->processed_beacon =3D true;
=20
-	if (sta->sta.supp_rates[band] !=3D rates)
+	if (sta->sta.supp_rates[sband->band] !=3D rates)
 		changed |=3D IEEE80211_RC_SUPP_RATES_CHANGED;
-	sta->sta.supp_rates[band] =3D rates;
+	sta->sta.supp_rates[sband->band] =3D rates;
=20
 	if (ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 					      elems->ht_cap_elem, sta))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1118c61f835d..fdab4f1390d2 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1851,11 +1851,16 @@ static u32 ieee80211_handle_bss_capability(struct i=
eee80211_sub_if_data *sdata,
 					   u16 capab, bool erp_valid, u8 erp)
 {
 	struct ieee80211_bss_conf *bss_conf =3D &sdata->vif.bss_conf;
+	struct ieee80211_supported_band *sband;
 	u32 changed =3D 0;
 	bool use_protection;
 	bool use_short_preamble;
 	bool use_short_slot;
=20
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return changed;
+
 	if (erp_valid) {
 		use_protection =3D (erp & WLAN_ERP_USE_PROTECTION) !=3D 0;
 		use_short_preamble =3D (erp & WLAN_ERP_BARKER_PREAMBLE) =3D=3D 0;
@@ -1865,7 +1870,7 @@ static u32 ieee80211_handle_bss_capability(struct iee=
e80211_sub_if_data *sdata,
 	}
=20
 	use_short_slot =3D !!(capab & WLAN_CAPABILITY_SHORT_SLOT_TIME);
-	if (ieee80211_get_sdata_band(sdata) =3D=3D NL80211_BAND_5GHZ)
+	if (sband->band =3D=3D NL80211_BAND_5GHZ)
 		use_short_slot =3D true;
=20
 	if (use_protection !=3D bss_conf->use_cts_prot) {
@@ -2994,7 +2999,12 @@ static bool ieee80211_assoc_success(struct ieee80211=
_sub_if_data *sdata,
 		goto out;
 	}
=20
-	sband =3D local->hw.wiphy->bands[ieee80211_get_sdata_band(sdata)];
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband) {
+		mutex_unlock(&sdata->local->sta_mtx);
+		ret =3D false;
+		goto out;
+	}
=20
 	/* Set up internal HT/VHT capabilities */
 	if (elems.ht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 206698bc93f4..dbceb42c2a8e 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -875,7 +875,9 @@ int rate_control_set_rates(struct ieee80211_hw *hw,
 	struct ieee80211_sta_rates *old;
 	struct ieee80211_supported_band *sband;
=20
-	sband =3D hw->wiphy->bands[ieee80211_get_sdata_band(sta->sdata)];
+	sband =3D ieee80211_get_sband(sta->sdata);
+	if (!sband)
+		return -EINVAL;
 	rate_control_apply_mask_ratetbl(sta, sband, rates);
 	/*
 	 * mac80211 guarantees that this function will not be called
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 348700b424ea..1ecf3d07d1f5 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -395,10 +395,15 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_=
if_data *sdata,
 	sta->sta.smps_mode =3D IEEE80211_SMPS_OFF;
 	if (sdata->vif.type =3D=3D NL80211_IFTYPE_AP ||
 	    sdata->vif.type =3D=3D NL80211_IFTYPE_AP_VLAN) {
-		struct ieee80211_supported_band *sband =3D
-			hw->wiphy->bands[ieee80211_get_sdata_band(sdata)];
-		u8 smps =3D (sband->ht_cap.cap & IEEE80211_HT_CAP_SM_PS) >>
-				IEEE80211_HT_CAP_SM_PS_SHIFT;
+		struct ieee80211_supported_band *sband;
+		u8 smps;
+
+		sband =3D ieee80211_get_sband(sdata);
+		if (!sband)
+			goto free_txq;
+
+		smps =3D (sband->ht_cap.cap & IEEE80211_HT_CAP_SM_PS) >>
+			IEEE80211_HT_CAP_SM_PS_SHIFT;
 		/*
 		 * Assume that hostapd advertises our caps in the beacon and
 		 * this is the known_smps_mode for a station that just assciated
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index afca7d103684..f20dcf1b1830 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -47,8 +47,7 @@ static void ieee80211_tdls_add_ext_capab(struct ieee80211=
_sub_if_data *sdata,
 			   NL80211_FEATURE_TDLS_CHANNEL_SWITCH;
 	bool wider_band =3D ieee80211_hw_check(&local->hw, TDLS_WIDER_BW) &&
 			  !ifmgd->tdls_wider_bw_prohibited;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
-	struct ieee80211_supported_band *sband =3D local->hw.wiphy->bands[band];
+	struct ieee80211_supported_band *sband =3D ieee80211_get_sband(sdata);
 	bool vht =3D sband && sband->vht_cap.vht_supported;
 	u8 *pos =3D (void *)skb_put(skb, 10);
=20
@@ -180,11 +179,14 @@ static void ieee80211_tdls_add_bss_coex_ie(struct sk_=
buff *skb)
 static u16 ieee80211_get_tdls_sta_capab(struct ieee80211_sub_if_data *sdat=
a,
 					u16 status_code)
 {
+	struct ieee80211_supported_band *sband;
+
 	/* The capability will be 0 when sending a failure code */
 	if (status_code !=3D 0)
 		return 0;
=20
-	if (ieee80211_get_sdata_band(sdata) =3D=3D NL80211_BAND_2GHZ) {
+	sband =3D ieee80211_get_sband(sdata);
+	if (sband && sband->band =3D=3D NL80211_BAND_2GHZ) {
 		return WLAN_CAPABILITY_SHORT_SLOT_TIME |
 		       WLAN_CAPABILITY_SHORT_PREAMBLE;
 	}
@@ -358,17 +360,20 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_s=
ub_if_data *sdata,
 				   u8 action_code, bool initiator,
 				   const u8 *extra_ies, size_t extra_ies_len)
 {
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
-	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_supported_band *sband;
+	struct ieee80211_local *local =3D sdata->local;
 	struct ieee80211_sta_ht_cap ht_cap;
 	struct ieee80211_sta_vht_cap vht_cap;
 	struct sta_info *sta =3D NULL;
 	size_t offset =3D 0, noffset;
 	u8 *pos;
=20
-	ieee80211_add_srates_ie(sdata, skb, false, band);
-	ieee80211_add_ext_srates_ie(sdata, skb, false, band);
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return;
+
+	ieee80211_add_srates_ie(sdata, skb, false, sband->band);
+	ieee80211_add_ext_srates_ie(sdata, skb, false, sband->band);
 	ieee80211_tdls_add_supp_channels(sdata, skb);
=20
 	/* add any custom IEs that go before Extended Capabilities */
@@ -439,7 +444,6 @@ ieee80211_tdls_add_setup_start_ies(struct ieee80211_sub=
_if_data *sdata,
 	 * the same on all bands. The specification limits the setup to a
 	 * single HT-cap, so use the current band for now.
 	 */
-	sband =3D local->hw.wiphy->bands[band];
 	memcpy(&ht_cap, &sband->ht_cap, sizeof(ht_cap));
=20
 	if ((action_code =3D=3D WLAN_TDLS_SETUP_REQUEST ||
@@ -545,9 +549,13 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_=
if_data *sdata,
 	struct ieee80211_if_managed *ifmgd =3D &sdata->u.mgd;
 	size_t offset =3D 0, noffset;
 	struct sta_info *sta, *ap_sta;
-	enum nl80211_band band =3D ieee80211_get_sdata_band(sdata);
+	struct ieee80211_supported_band *sband;
 	u8 *pos;
=20
+	sband =3D ieee80211_get_sband(sdata);
+	if (!sband)
+		return;
+
 	mutex_lock(&local->sta_mtx);
=20
 	sta =3D sta_info_get(sdata, peer);
@@ -612,7 +620,8 @@ ieee80211_tdls_add_setup_cfm_ies(struct ieee80211_sub_i=
f_data *sdata,
 	ieee80211_tdls_add_link_ie(sdata, skb, peer, initiator);
=20
 	/* only include VHT-operation if not on the 2.4GHz band */
-	if (band !=3D NL80211_BAND_2GHZ && sta->sta.vht_cap.vht_supported) {
+	if (sband->band !=3D NL80211_BAND_2GHZ &&
+	    sta->sta.vht_cap.vht_supported) {
 		/*
 		 * if both peers support WIDER_BW, we can expand the chandef to
 		 * a wider compatible one, up to 80MHz
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1ffd1e145c13..84582998f65f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4182,7 +4182,10 @@ struct sk_buff *ieee80211_beacon_get_tim(struct ieee=
80211_hw *hw,
 		return bcn;
=20
 	shift =3D ieee80211_vif_get_shift(vif);
-	sband =3D hw->wiphy->bands[ieee80211_get_sdata_band(vif_to_sdata(vif))];
+	sband =3D ieee80211_get_sband(vif_to_sdata(vif));
+	if (!sband)
+		return bcn;
+
 	ieee80211_tx_monitor(hw_to_local(hw), copy, sband, 1, shift, false);
=20
 	return bcn;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 545c79a42a77..a2756096b94a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1590,14 +1590,14 @@ u32 ieee80211_sta_get_rates(struct ieee80211_sub_if=
_data *sdata,
 	size_t num_rates;
 	u32 supp_rates, rate_flags;
 	int i, j, shift;
+
 	sband =3D sdata->local->hw.wiphy->bands[band];
+	if (WARN_ON(!sband))
+		return 1;
=20
 	rate_flags =3D ieee80211_chandef_rate_flags(&sdata->vif.bss_conf.chandef)=
;
 	shift =3D ieee80211_vif_get_shift(&sdata->vif);
=20
-	if (WARN_ON(!sband))
-		return 1;
-
 	num_rates =3D sband->n_bitrates;
 	supp_rates =3D 0;
 	for (i =3D 0; i < elems->supp_rates_len +
--=20
2.14.1
