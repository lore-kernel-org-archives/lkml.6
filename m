Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119456-2-10392564054949950978
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
    t=1520119456; b=G8w1AiYQi0/Wn2X4bOG1Qs9/TakZHMOtoqljCquSXcIqxQA
    EgbIGXnor0qZsl1nZ0DY0DVpCb2m6/w53N/z6Ore1NZnw2vaItXGz63SjWK/lt1Y
    90DcxNiEifb7NZK5G/FsIlsjGO8yhZ3bBOsSvJqgq6tlnqsCzhqvKKBi19a0+pek
    8TWLUQC61z2KUGFKwxVjhvYM+ZUhX+TSJcpBQxz86ZIzwuoNGBQhBXLu7dLiW6dV
    Xg4k1pa6PSZx3UvWejIqyAZ/ZjaOajUJDfjdnodXcmB+IHqgVRfchhiZTUVHgrUT
    1QJDUMor0PoIWhnivMqdKdo8Xm3AKt2sX/mmAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119456; bh=z3CVky
    VwEOal8OJM4QpaPLJRPCr5d2BFjbjowtORqDs=; b=qPBLd7a6ZgTG6vFaWO1CH7
    1XVFLjAPl86DFHvH1xZn91loIyPyqJOOVOd4JvjYTXn9elWk3k70PO/kONX43eS9
    CByMxsvUKlLbt5xlA7AwXFQGWRSZAZWdfBZ5yavaZPVioa0y1BjST/ik2vJqtjrn
    iat+BhzOJN3NRF8blC04xsuDW2xT6pOn4sp6ObfaKGBdT7TTSABNyPOnzfUj3fjT
    dAXf+s/hEpczx7sfWUFueFjzpzxMycsIcUS+sl8X8KLFOcfvjEFGE43LxVSyQZqN
    vu/q8H14AA1g9kvc7zhtnoRjoiJy7Z0lncZi0/YeuxSviJvZcuhJQFFXWfE8VGXw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3EixQdD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V3EixQdD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeCCXX6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:23:58 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934400AbeCCWhu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adiel Aloni <adiel.aloni@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 213/219] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Topic: [PATCH AUTOSEL for 4.9 213/219] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Index: AQHTsz8qW9j+0hpKz0magKX6mw8tLg==
Date: Sat, 3 Mar 2018 22:30:00 +0000
Message-ID: <20180303222716.26640-213-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:4bfAwTzzlfNr+XXsrPu3jCgyvcO8NjK/z2EsVVe2ta2/G7P/r8FIymip0voJ2x7zoYNl3+LCD+OL6xF/zqNtAhrG5Z0GqVQqGUeHUhOz1F2mgL/gNnvU8A8n24wcs0i5tKFXXN2NiV7CsBg38r/CUmEy1Q1vw9Ac/JeXbIkjm4DeL6Y06XSz6dbk9nk23xlPFzIiOih5sxHh1HVCJSNyuZfwGHq8XKrUDQxmmWE6/y2ous0qlL1Tp7h97NGvWrI5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c9461dc-db31-493b-4ac5-08d5815763f2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB110011D13DDA1CC1D2E8AC0DFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: aBV2b7M/KDJcymqF7fpmghitWl2Qcj/EFJWvMdgK6eodgNplMhu3ByXtv+B+iGTqOaiT25GeRM3iq0XmSlPZv5lsEvhLrKititPWRSapRhClXZjg44aZKhiCUYbQFQcImtS5TTA5BWuGpqUicXjEx6P4W0WMvKTLDTKc3jgjT1g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9461dc-db31-493b-4ac5-08d5815763f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:00.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Adiel Aloni <adiel.aloni@intel.com>

[ Upstream commit e16ea4bb516bc21ea2202f2107718b29218bea59 ]

Enforce using PS_MANUAL_POLL in ps hwsim debugfs to trigger a poll,
only if PS_ENABLED was set before.
This is required due to commit c9491367b759 ("mac80211: always update the
PM state of a peer on MGMT / DATA frames") that enforces the ap to
check only mgmt/data frames ps bit, and then update station's power save
accordingly.
When sending only ps-poll (control frame) the ap will not be aware that
the station entered power save.
Setting ps enable before triggering ps_poll, will send NDP with PM bit
enabled first.

Signed-off-by: Adiel Aloni <adiel.aloni@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 990c857992f6..d12c121806bf 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -728,16 +728,21 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
 	    val !=3D PS_MANUAL_POLL)
 		return -EINVAL;
=20
-	old_ps =3D data->ps;
-	data->ps =3D val;
-
-	local_bh_disable();
 	if (val =3D=3D PS_MANUAL_POLL) {
+		if (data->ps !=3D PS_ENABLED)
+			return -EINVAL;
+		local_bh_disable();
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_ps_poll, data);
-		data->ps_poll_pending =3D true;
-	} else if (old_ps =3D=3D PS_DISABLED && val !=3D PS_DISABLED) {
+		local_bh_enable();
+		return 0;
+	}
+	old_ps =3D data->ps;
+	data->ps =3D val;
+
+	local_bh_disable();
+	if (old_ps =3D=3D PS_DISABLED && val !=3D PS_DISABLED) {
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_nullfunc_ps, data);
--=20
2.14.1
