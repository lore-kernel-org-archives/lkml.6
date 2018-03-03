Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123534-2-912130179155705852
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
    t=1520123534; b=T6w3pj5NFIagPEOI9XxjZiwE1vkewNhHKV5wP/5pdBZyBZG
    s7TjFIKL2qWBQzy2PgmQqlbLPmAlEA9oRJ/fsmQ0ANSoBHrg2z4BSF65FmdvHl0b
    mfh8LYDbMZpwaSiA/3GwQWAKrnf1zIQVShUCMwH7hud178CuEeWnD1GL3fiA8ngk
    rdCa0TgHQNzcUOIR+rYgJKaHVfLuVWF5L/Kind9MKSTzjJn1tXuCdv5gS/tbnRiy
    M84i1QSj1IeklNd98mpo4EBGUa1K+1Fry16Vhy7H3bTV3gdYgaVQnmjU4dra/umr
    QX8nOctpAYJSJSyrXrhOpzpTg2NIuhzMLrhbG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123534; bh=i5DfQ1
    BjV/LOIjqTaD32IPyrNqIg7uu9biuSG5m3kXs=; b=dkkjl8NMWH/eMF48OooE+S
    rDsJMAToYAV4LyDXhGjZNnRAMwFsYvX6kxAS1IXWqOCf5Vslyk2zUZQ71rMetZzN
    lP8icaUJP4Qk67IuEhuY5+XLuogux0Pcz1q/pZEuNMstjKQgQBiz8cH/n8RDs2rN
    gjGFse/7MyHPa7XLB2uNOGuoEQV8PXX49awTdwCprTuQNlt/G+ObgpVy0HAjHYSW
    bTY4dw08bVR/AHZ+pSTDfnvGrvVUzCfIJc1JWtDSFRDhahc/rqUjFkr6NB+5T9Cd
    OC4GdvhPRg9Z1rJPNsZY/5A5AqQOd5fAZIp9ixSPG/WjsfwxZEEj1SPupL16co3w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TY/a5aAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TY/a5aAl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeCCW1x (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:27:53 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933006AbeCCW1v (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Adiel Aloni <adiel.aloni@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 091/102] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Topic: [PATCH AUTOSEL for 4.15 091/102] mac80211_hwsim: enforce
 PS_MANUAL_POLL to be set after PS_ENABLED
Thread-Index: AQHTsz55O2eRtICRGEKCjdBV1GNMvg==
Date: Sat, 3 Mar 2018 22:25:02 +0000
Message-ID: <20180303222318.26006-91-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:AFTViZlFcRgJx//I3pOVFUbREO2bghVJXVslTlt69l95EuzGC5Ex9a+UqQ9QUV4N/GCmu2sJsq1E2SETbdFLMDicTAB0zPcvWeseKDkLir1s1n1ZNC8vP4RgnSCUpIO9IDOzKIHTpR79whf5142QTu2mR0iEOZ3ZPlZGcB4tw178g8/j+V7yuMSd7NuLBNrrqGfaAZmecJ6pWZ3s9kbeyuu16rPup5DrcbZunXU3nV97F/c+O/L8fBB5mOXic6v9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64f7d6f7-5e13-414f-f53c-08d58155ff40
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB0673006A8BEFA18A14FE68FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(59450400001)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 4sjbJ32bOkcYxym/R8oseY9lQOsHLjanoYtoqrFwXQtTgTTC3gCJm1klwih4FwTCYtkkI2KtXqbnFZNRP4F/t2LxS7lMz4+VOIWIH4amZ1SJPBWb/676+kbMkXfJN4KUewaCIrBG04Xn4fRR4Uz5S5kDkhcUYY3sVH6Bl8NlO6U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f7d6f7-5e13-414f-f53c-08d58155ff40
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:02.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index f6d4a50f1bdb..e54255597fac 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -729,16 +729,21 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
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
