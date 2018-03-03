Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520117747-2-14590220597639428661
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
    t=1520117747; b=Q2omYlW3FjJbvvBL/hVW6TyC6Z4rm1xork+3vNd+/Zx4WV6
    xMUm5WZt41LziAdDCfTUTPnp2Lfbj7AbwSpRLGr6PXMrBiIeBM+mmqhopiFLBGoK
    qk7/Jpjh9D6FWX72wjsZ26ot3jrZxSUop+6DHWeQLf7+LMI7I/ePJO+OARChz/bX
    dSEG3vcbBRc/YFWVISPC8KBD6SBzxRKTdmnWnK2ifSnv25DjPx9mDO5yCRxI8zIn
    cPr0TRpSQenOPFAzCAbBR3W1Q5gCFEfhe8S4EH5DwyS2YV7g1fksTSelFH3/XuFM
    0FMNz4D/shPu/FRq2ZKcjZRGKlbiHorUocet5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117747; bh=9WPtXC
    i0t8l4Q9XYo7EaTk9Ss3rIJT6XLZlRMZVwdvI=; b=Qm2Kva/lMmloBrMVGLyTik
    kUSVGzZG6SFGeEd76YKY8UWHGnq7RIf3qqUeghBmusWy6JrVDrGM1167I9PRfydo
    fqyv9TNVVuQx6VpEYx0G49RxO0Hvlszcm+QdphjMwNCHLD9h6d/V6nnAISeJicqw
    WoOOMAkhyPh0Ylz6r8PKxrC5Xo3m6JzSi2x0Yt7BOpQ7ozz5nkpNoa2Jm0yus4Fw
    SpSY5F26JzvWKrp5sNVkC0DL8MT0nWmRbSNz+5GyLo3804xGySCJqNWpYHxPbJ29
    rGhktoFs+CwQFkB5q2SgWSP8PtS6+O1USa21bPJFHg+IQH1JguGn1SEVaA4UdnMA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TW2omVsB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TW2omVsB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbeCCWzQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:55:16 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935373AbeCCWlB (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 10/63] ath10k: disallow DFS simulation if DFS
 channel is not enabled
Thread-Topic: [PATCH AUTOSEL for 3.18 10/63] ath10k: disallow DFS simulation
 if DFS channel is not enabled
Thread-Index: AQHTsz+eXA4gOaT+Yk23uxd0ll048g==
Date: Sat, 3 Mar 2018 22:33:14 +0000
Message-ID: <20180303223228.27323-10-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;7:+AROyijOyn3ZIOtR8JjNJaBIg3PH/R2VX7frBOBTp3Jy2d9Y5MB4gf1EN9g96bWEhoCm7R2i1aG8ASA6Bq8HVXpJHfnSC84n6f2lbrLrgi0En5VzpSLiXpZ8dlqMYG98dRvVGLGLssfxcykUq8WshZ9rbP9k2gO975RynEP3hm5e/MHbLAVWzCpRsQuxVt5f4/EknmyJ/FMweF3EfkZviS6LPNr1fDHWqTYuXlJgjpks57YdMJqgVuJgoQq9PjrJ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1629c902-d1b3-444b-adca-08d58157d5cf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940DBC9F007034274AD8A30FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(51234002)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2kax5gGnN1hRvpuRSs8DsP/rDbOpRoGsrWUQAAgNBZINDNCIfIaIwIDG07yvubXuI6YoSqhxFBicWF7ilXI/GoYZWM2rbv8rmfUJ0uDRBn9otupQzZxY03J2iJv30Brj5q+RrKLCeLoDMCcYlscL7mhXLF3LNv7lnmY4KZAUbdk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1629c902-d1b3-444b-adca-08d58157d5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:14.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
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
index 3756feba3223..d3ebac0d7f7a 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1079,6 +1079,15 @@ static ssize_t ath10k_write_simulate_radar(struct fi=
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
