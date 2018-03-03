Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1211789-1520117854-2-15609734844431291610
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
    t=1520117854; b=C1P1GhENyFzITmtcdsWeyBMX1YciD9IBMyHtzg//XzgAMmI
    tES6gKLESLT5Yxo+P9W2NZlnL9IrKz4dWBLVYM2TrJYIzdskN8BI9BRqsItHiXww
    lU91DP8KVOuemHGaTl45qABTpofSfBwZK9/Lc2q71bh9KaNbZjrM4IPDJgEgJ797
    vJ+GQ/Wi3JyJxSQTaMKUlgh0Nq7zRSbRozldaA1CJ+ir4bB2fyUQSmmHIpBKLfMY
    SJPwiVOVFV1IKTqzqKeqlWvaXnqezniIHUhfXVjW/HU8v+uR/Ouj+iOmgh1XHoSp
    wSYN4jSieZdwvtyi7g57RnnZpXgpeoNzRCx5B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117854; bh=4Cd6ZC
    7F86f74gd05XdpPlEnVKFyWUpCKRS6bW1aQC8=; b=nXoqtHmJsEZJKslOw6qJIg
    pR8TDPYjy6xFl7QIwdx5vcxGGRUyw5B877Sh1OdvEArEnTnqZrDG3CxrcZq34HAs
    AcWP0j4b79i05jDvT7aMmnqUNgIrZ1G5a7rYu+Zld47LWL4xIztGOfGPfq8Vpd3e
    V3e9lGNRu3i/wQiTjQYMMk4ERF/T7umLeWaBnpOQGmWCq6aIuQYD+SRJ1dHzSxEQ
    dLJi3y2mcbnxtxuCnHbvmZ77maiQvz9CAKN7QaPXvN7ZJ+iaYXXEIh7X6h0Y/LaX
    L9iGO3tGGRgQuvkzBCu49yK1MrJNhXVOdd2zO0UhUUoPy+58Fp6JtFPfiiS0zGOA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UanrChXw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UanrChXw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935344AbeCCWk5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:57 -0500
Received: from mail-cys01nam02on0110.outbound.protection.outlook.com ([104.47.37.110]:31968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935328AbeCCWkz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adiel Aloni <adiel.aloni@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 110/115] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Topic: [PATCH AUTOSEL for 4.4 110/115] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Index: AQHTsz9vUbvbEUv1cU+cB1dqb4wo9w==
Date: Sat, 3 Mar 2018 22:31:55 +0000
Message-ID: <20180303223010.27106-110-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB344;6:Me43IXlnBvGH3w+hk6XKzdC9ibNewmaXG1BqbRr506OghKCKTHS9TD7KAB+fgb4WVCtTrJV4eDhBmdbGaK2orpZiwzBbD5KjmI9Jwqrc3GIQoRET7tchvPxWrAn+OhssIdwyXGE4Xg1iczmvzPOZZ/6Z/3GvZqfzRGGI8jd/0XDSTEY/8g0DqOoYQC+VqiCpZkw0YJFtwXKl+GppdmXgJKFftSUhT5vP5o09VKrcR4cp1aZZ0kyATvQ/L00BgMkPv4LU9bRhFjcE0y2wbWuymUghNtPp1vYgbdQxUkAItZA4jVfeOaJeYvXD0ZZnw5dO1RujLtNIKbST/BZjtJGtXKwRGWcCwqA8Vwf23d4xRGLhQLQiNjVsLFXz2AlTVGaB;5:1hZXotP+qCLDqabTfd4LSwKQKrNXwx6aEyG3U5mOKKRXX/yIXQwSEmOoaB6XpGXwMU9tIAjZYdPJDFVFz7REMpKtEDCG9+xfIDrfOaPaB8eR3hW60g52TwPKawSrPZQuaRpDF1QqFqb67wYY8bV4IK8/8QrFI82Ng5+BMy3ccBw=;24:LosWjlrdPyv4eSzwxih2lovv7sCYE1LPIsaOAETN3VjRcGN6oVjxLHTlksvsVpVi1fmXlXgh4kFWIFIqhV8en/kpnPkj8EPVjIL2ujw7M5w=;7:wB0gM5fi62bM8swbELVqvzvaEgHQSrMOU3lbF8Lte3XRXnNvP3RgDtPqeRhxE2M4Ttj6uMOn2dZszjRf5pOOoNHiiZDB8u97cWfROLvyvwrh+A1KrZsf3juU26tzzl/W5kwJCNGmtPwAfuga5w3drnjbVk9tICyo9TlNl0wYKbCj5yLt+B3byEHrP76JM3lesL69vMip0qLXo2mzuFAazzV3PLd/VAze6zJLlKH+tQF/8pabRCEQUsXwQNtChkse
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee78a1be-428a-41ae-2f92-08d58157d144
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB344;
x-ms-traffictypediagnostic: MWHSPR01MB344:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB344E6FE8709559B3AC6FAA9FBC40@MWHSPR01MB344.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHSPR01MB344;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB344;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(39380400002)(189003)(199004)(59450400001)(8676002)(5660300001)(5250100002)(2501003)(6506007)(7736002)(36756003)(25786009)(3846002)(6116002)(97736004)(305945005)(2900100001)(76176011)(6436002)(10090500001)(26005)(8936002)(186003)(81166006)(102836004)(81156014)(106356001)(86362001)(10290500003)(3660700001)(2906002)(99286004)(14454004)(86612001)(105586002)(478600001)(4326008)(6486002)(53936002)(107886003)(68736007)(316002)(54906003)(110136005)(6512007)(72206003)(3280700002)(22452003)(2950100002)(1076002)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB344;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: O3EvylYSQZvou4Fn0+4i8vIs1UY+XcgXEm7lPwWSThYs6fJc5zhWZ0qeCxKqo++vwc0/mLx7NzWcZ4rJk7eyFhw0Z96UQuNIc4MEhm9EQOlN62KsJWc4HSn0gnuKhGh2IQ972fMcYbPlmWaGRBTv3eNP6ox5IXZdjkXhGnGZ8jA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee78a1be-428a-41ae-2f92-08d58157d144
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:55.4020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB344
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
index f877fbc7d7af..8a9164da6c50 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -699,16 +699,21 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
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
