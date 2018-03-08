Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520485221-2-16129240598800507998
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
    t=1520485221; b=P+rxseZu2/6/6KZwgkoigATaZTuK2qfurvmsACkKz7cu7UC
    j+eYUzqAMAvjQRb+Xm9dmT1iQA3DzjEOhfAqYF7JcL4rDr7KOmqQHWZNvjh6YDT/
    kf7sAfQoAVQRz52gGvvV4L679CheJ3QOeVShZS/u+BzikEY8g3niiOuPD03qub1d
    Ksoo8xxRfPFJSamZRSTqM49173diJ7KJtFgse/yRmNw19umtIuV9Y8UPkrPDCCQZ
    GlmfZCza0BLXW2p00p6QacWf3bJ7LN4f1HPkBk5OCCDrKx3mSOBsTPaCX/zCoOME
    1cGqQACIQngWn3CY16Mw9+MUDuFphOlGYIDTjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485221; bh=LbpBfM
    5MIxQrpyBGlsfMH3zr7ZtNAp3XCGaNIunqcmQ=; b=rh7qhpySKFAF3R3oSaRMw3
    GFsm+SY2H54VCDCptZym5Zf/LNjeKPdVeCZt+TzsocvFwebDjSREJ4XnLwLHtjRT
    Msz5GVAfTLTogZPFAxzBKKkH5quGajxCWerYdfSvQwSDHfUiLm5S5IZGd++JqncV
    S12PTPYWlSmpJY6dwqMpPJ9M6eDaurdU6LFTOguMODyGgm7umB3kFsYwYsHx7mOu
    FNiZw4hXay7NwRyylHKmudIQaC/RFwVBA9sRlM1HDvh0W6tK58vISXfocBkTQiUf
    bUe7I6KHhmMJ6kQp91a99KemZv0zHGRoFNnWsacD6wtDH3WKBUNmHUPoAkFf0Zbw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FqcabBJg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FqcabBJg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeCHFAS (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:00:18 -0500
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:8240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeCHFAI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:08 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 019/190] mac80211_hwsim: use per-interface
 power level
Thread-Topic: [PATCH AUTOSEL for 4.9 019/190] mac80211_hwsim: use
 per-interface power level
Thread-Index: AQHTtpoqziXqc05Ee0+0rcNSHpj3CQ==
Date: Thu, 8 Mar 2018 04:58:58 +0000
Message-ID: <20180308045810.8041-19-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:xyukByXC3UgAb/vzLGcJTtV8uxCBtoEvDCLhEuDf4cO77pWCQWZynqhIvTPG0PzUadhZkHYU2QLKF5CPodojJB7BPp7eLuiSCm/ijSj3IaU83RC3MAg6lsOsLr3Gu6DDXLgC9e74T3/U/sFwR4cVrEsgK6z28f5GXJuAJwORsSlstg8wUwVqsn52koRTgLV2ZNT84Fg9QG+aY0CCbbFdy7Uic+s9vGMlMp8vHU0OHogVfokvxYGz3M5iopmGFy1w;20:S3/nItk6CLc78BpCah/nWqoxlutGhy5YGuGzoy9WvQWpc0t4QhZcBHDtD3XxpQTC6YPGczvxF74fDfDhySGXY+nYl8wG/qbd+rpjgbgyMs77MEqzlS69JThDh3wbeqbLyFA8mOROGMX8K6IkXpHM+j7pnwtm5yDaFDozbGqJFH0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaeb77ec-e4f4-4953-32a6-08d584b171fa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098358821DFFE99171EEAF51FBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: WuYpLkDWkFnM+kfy7swSjQAUrTpZYVQ1wEjeKEc+O/lL12WctlrZMhUaQP1fd5ZTUIq1FifhSTPSYoJsr1JWQRALJUGRb/VgHWzQiVwzsy+UhTecidrCXV6PC2yGxJ4MIAN81/RbXBcb8o3YAnGCSqwNblxCpCtx+Py51j95iDQoD+JyEnc6a5efQXU6Q2DtBqWYTnGrJzbdXn2+2SIsZt28bYNvIdOtteHuVugR+4YIP27W+m7DM/tNYEeOGP+X78ZSdU1e/h9GmuDzCPlvd+3o1kWTMsGzHxYephbstulYtbjLTNKYSLJkJ5UU4JE10ZFGW2cM0Zyf7QJQOOEhvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaeb77ec-e4f4-4953-32a6-08d584b171fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:58.4118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
