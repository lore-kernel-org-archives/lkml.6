Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520119151-2-5198989100059987293
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
    t=1520119150; b=WQCL9mxHxeb27qZjBX5erkEhnMmec3+t3ohad4c8Rejjhpy
    k52jOtjZnSVV+aRvUOkMQzso2xAiwnao1HXaKCQrym92RVYa556PSRwyO3S+VRph
    0fsHQKrQGszCgI5fGHt6/iicG0/e45IE0oi1KkQmigiNGHBmqI60FmtOOfakFsRt
    hxpVn+28M+hManMAg52mAnGfeHGE731OEq+Jp8uVwETFlu/10aDVKT5fRjBbrWrf
    7tVMn3tu4Lqzbjn0BGxDEjNU0LNy73oF/gQ+Y7LRIhIsZFOiOgNkOpz6myFRmQW3
    sXFNnX7XA0eDazHZXndMCeTNDCFRopcPc4Pf3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119150; bh=MCFnSr
    w8iZ//rN+Fsqp2qkjGqd5JZaGl8A0tDktCjMY=; b=AMDPxe/VrzqZE6JKNLxD4S
    PZRXGrQ4+TFyuniCzswF7xZ0VOTuXxCOH8lCTEd1Zo5oqX+OMBrSp8AqinG5NGEy
    ViPP1TEvtIRfNn4BElpusi2hRotAuE3K/ZoA+4Bjld1xxBf1dlVDKrvpmL2CvPhv
    qi1z5cYEhyAPpl3Dd7tIgzKGhyFm1EHRTwOjST5lrNHZyi88NntGd2SUPdb9zUyj
    YeqpRF8AjDdnBU6gsQbqmBgmZw/xkylcLXGJvMf4iu+tqaxqYnGjYKA7yLQQU2jK
    Aq7j9WJlTR/kN/JTwMQBMhm+LW1ncGZIh/ey43JW6YbkozcWUNFnnEE6ALx6OocA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kFty0hOd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kFty0hOd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751063AbeCCXSt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:18:49 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:41081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934750AbeCCWiH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 017/115] ath10k: disallow DFS simulation if
 DFS channel is not enabled
Thread-Topic: [PATCH AUTOSEL for 4.4 017/115] ath10k: disallow DFS simulation
 if DFS channel is not enabled
Thread-Index: AQHTsz9MsbeA5/Pm/0qqe1WnT0bAtQ==
Date: Sat, 3 Mar 2018 22:30:57 +0000
Message-ID: <20180303223010.27106-17-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;7:9Co5d8YCbCQGre6LgFXwjTDdm/xeyknw7Xic8kLEQk3EV+vvBup6+O57Wz/azNolcnjHNGZHdWFX8FYfUgoajKSz573wNZPR3xccyqr7QaUEoOvCg/PVmOlKZWfcTrUhg8/jxgiT2gN7vy9u1zHk1WTDK7vkwV542Ra91rCv0jfCIzea7jeVkkqOjrv3Qj4SYgUjPspCusLk3dM0EzXLt2H6PT6e4f2baWfmj2UOH/6BNUb9Og8WJK2CDxsS3doy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0143a220-68d5-46d6-07d1-08d581576dc8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067413B75F788057038CCECFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(51234002)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(575784001)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MvzV1LWzH7z+aAsWb54thpX//sYo9NWg8NWCDlYg3hx9hqybgfKOC5vNY7qpAWYr1Mfrmh3bGfPa72NZdUhHDneOiiDzKnZSQaFy/ZEC2Pj4UIJDqwiS9Vhr8+qGCgX9Kcc4sP3+5+NVYB1Tv1n0ZOTzJZci0ph5vErmFdMuoME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0143a220-68d5-46d6-07d1-08d581576dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:57.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit ca07baab0b1e627ae1d4a55d190fb1c9d32a3445 ]

If DFS is not enabled in hostapd (ieee80211h=3D0) DFS channels shall
not be available for use even though the hardware may have the capability
to support DFS. With this configuration (DFS disabled in hostapd) trying to
bring up ath10k device in DFS channel for AP mode fails and trying to
simulate DFS in ath10k debugfs results in a warning in cfg80211 complaining
invalid channel and this should be avoided in the driver itself rather than
false propogating RADAR detection to mac80211/cfg80211. Fix this by
checking for the first vif 'is_started' state(should work for client mode
as well) as all the vifs shall be configured for the same channel

sys/kernel/debug/ieee80211/phy1/ath10k# echo 1 > dfs_simulate_radar

WARNING: at net/wireless/chan.c:265 cfg80211_radar_event+0x24/0x60
Workqueue: phy0 ieee80211_dfs_radar_detected_work [mac80211]
[<c022f2d4>] (warn_slowpath_null) from
[<bf72dab8>] (cfg80211_radar_event+0x24/0x60 [cfg80211])
[<bf72dab8>] (cfg80211_radar_event [cfg80211]) from
[<bf7813e0>] (ieee80211_dfs_radar_detected_work+0x94/0xa0 [mac80211])
[<bf7813e0>] (ieee80211_dfs_radar_detected_work [mac80211]) from
[<c0242320>] (process_one_work+0x20c/0x32c)

WARNING: at net/wireless/nl80211.c:2488 nl80211_get_mpath+0x13c/0x4cc
 Workqueue: phy0 ieee80211_dfs_radar_detected_work [mac80211]
[<c022f2d4>] (warn_slowpath_null) from
[<bf72dab8>] (cfg80211_radar_event+0x24/0x60 [cfg80211])
[<bf72dab8>] (cfg80211_radar_event [cfg80211]) from
[<bf7813e0>] (ieee80211_dfs_radar_detected_work+0x94/0xa0 [mac80211])
[<bf7813e0>] (ieee80211_dfs_radar_detected_work [mac80211]) from
[<c0242320>] (process_one_work+0x20c/0x32c)

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/debug.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless=
/ath/ath10k/debug.c
index 1a88a24ffeac..30c357567054 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1892,6 +1892,15 @@ static ssize_t ath10k_write_simulate_radar(struct fi=
le *file,
 					   size_t count, loff_t *ppos)
 {
 	struct ath10k *ar =3D file->private_data;
+	struct ath10k_vif *arvif;
+
+	/* Just check for for the first vif alone, as all the vifs will be
+	 * sharing the same channel and if the channel is disabled, all the
+	 * vifs will share the same 'is_started' state.
+	 */
+	arvif =3D list_first_entry(&ar->arvifs, typeof(*arvif), list);
+	if (!arvif->is_started)
+		return -EINVAL;
=20
 	ieee80211_radar_detected(ar->hw);
=20
--=20
2.14.1
