Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520120019-2-11152880552254765839
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
    t=1520120018; b=pRVnRMySJTJHrHERwL4S9YIlEm8pCngzB1Pf4Rxm1egGMHu
    MGyL72ILGeXBkgofgr6OBsYDSMQ+q1OYrs/ueQ0QHWB2r+XDK2pvpOvPjTs6jk11
    cfaYZN+jwdBWLkvLeUA9pQw4SfMddaeLtiIZPmie0dOCPAlVgpSjF8o1jKRsN+hl
    iFTzHpPysI3++1rzzKGwpss4kBwo88J3byiarS/CZqND0ijO8g8vP+XCIeoPqmgF
    H1FSUOCDUAQcn/H3dvVjfGd0OgeTAK84cOsSMM0trxNdSPNonQyNqpg4J/aQ4sIU
    7Fnesmt9fKd9WnoLPDH2JZXHIwF1jn9SZ5VRabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120018; bh=LbpBfM
    5MIxQrpyBGlsfMH3zr7ZtNAp3XCGaNIunqcmQ=; b=Cdj1bAn7c3sO+eyq4WFGgF
    wbEjLxR1JOimQyxkTgQbf6bTn8G0AvFCZ416mwjxmo+fd5fKs7u3zs5gXeCAwEh4
    PgUuZ8iHtfwig+qkm3VvVAfo0geSqYF0uTZ7/JwfDyu54KAsUpiog1FYLsjO9G4H
    4X7NBkcxgmDlOmcyRtUKydb4nOXq9iht1Lng5O6vxFBTYmLa8DexZOmiLUZpGFDB
    5SjakFJzFQsVcrg3HOFl0ul8kqvuGuCHdFKl3fyv3trvBlbqDfJStDmfNufAcycx
    Nt0D6REc++EZClw9ThpDf6y2FpBPSoiZA2UbHweudnh38rTBuF+K/a026bkaABrQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knn+nAB5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=knn+nAB5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934198AbeCCWgH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:36:07 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934493AbeCCWgD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:03 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 165/219] mac80211_hwsim: use per-interface
 power level
Thread-Topic: [PATCH AUTOSEL for 4.9 165/219] mac80211_hwsim: use
 per-interface power level
Thread-Index: AQHTsz8a7gifVAcWkk+gvjgvzYOZXg==
Date: Sat, 3 Mar 2018 22:29:33 +0000
Message-ID: <20180303222716.26640-165-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:fXxgCUALJMiqWMgHXS9OBr6wRdEjUCfkL03GnlCzf+w/XzT9+0lQSl17mJqbyRQh1FaeAwSeQU89MFxhpHbmFQgIoBQfzK0aNFEtvv7lF2ZNULhaPxiJ3vE8dYbR5GgwqccKdNJFXmojOf8KglcneG612VdwzWBepgPNgFC7PzSvAZtXELkVHaxA4SBN5rO6FmMxlfI3T6GUcYGx8Nu+8D02gXTpXM5StDz81jk+KaCGs1L7sJnwa6OTTHXeUTyZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 706e9412-bfd9-4978-b7d7-08d581571c98
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB103450A8E146F3FF60B56679FBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fvf1HB+7LQ7mCub0JyyM80ZEmXNSFEDQ0kAcBkV41a3CUWVseefTGY03lsdUDjXv9W0jbHAfhuXvfaAXL3gUSnY8VqlDLS8aFrj10ZJeswjsiSggpPKQKw4XgyDfIryviS9hqp2zwvVdRnEMzaGNGK5mRY4aCvmRNNH1Tgko4FE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706e9412-bfd9-4978-b7d7-08d581571c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:33.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 1d5e9f80ab021e3e1f9436627a4ad07a143ccb2c ]

When channel contexts are used, there's no global power level
(the power_level is always 0). Use the per-interface TX power
in mac80211_hwsim to have a proper setting for both cases.

This fixes the bgscan_simple and bgscan_learn test cases when
the number of channels advertised by hwsim is >1 by default.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 4b462dc21c41..990c857992f6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -552,8 +552,6 @@ struct mac80211_hwsim_data {
 	/* wmediumd portid responsible for netgroup of this radio */
 	u32 wmediumd;
=20
-	int power_level;
-
 	/* difference between this hw's clock and the real clock, in usecs */
 	s64 tsf_offset;
 	s64 bcn_delta;
@@ -1208,7 +1206,9 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee=
80211_hw *hw,
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
 		rx_status.flag |=3D RX_FLAG_SHORT_GI;
 	/* TODO: simulate real signal strength (and optional packet loss) */
-	rx_status.signal =3D data->power_level - 50;
+	rx_status.signal =3D -50;
+	if (info->control.vif)
+		rx_status.signal +=3D info->control.vif->bss_conf.txpower;
=20
 	if (data->ps !=3D PS_DISABLED)
 		hdr->frame_control |=3D cpu_to_le16(IEEE80211_FCTL_PM);
@@ -1607,7 +1607,6 @@ static int mac80211_hwsim_config(struct ieee80211_hw =
*hw, u32 changed)
=20
 	WARN_ON(data->channel && data->use_chanctx);
=20
-	data->power_level =3D conf->power_level;
 	if (!data->started || !data->beacon_int)
 		tasklet_hrtimer_cancel(&data->beacon_timer);
 	else if (!hrtimer_is_queued(&data->beacon_timer.timer)) {
@@ -2212,7 +2211,6 @@ static const char mac80211_hwsim_gstrings_stats[][ETH=
_GSTRING_LEN] =3D {
 	"d_tx_failed",
 	"d_ps_mode",
 	"d_group",
-	"d_tx_power",
 };
=20
 #define MAC80211_HWSIM_SSTATS_LEN ARRAY_SIZE(mac80211_hwsim_gstrings_stats=
)
@@ -2249,7 +2247,6 @@ static void mac80211_hwsim_get_et_stats(struct ieee80=
211_hw *hw,
 	data[i++] =3D ar->tx_failed;
 	data[i++] =3D ar->ps;
 	data[i++] =3D ar->group;
-	data[i++] =3D ar->power_level;
=20
 	WARN_ON(i !=3D MAC80211_HWSIM_SSTATS_LEN);
 }
--=20
2.14.1
