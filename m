Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520121755-2-7043298679143748884
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
    t=1520121754; b=dmF2qr1JNWuuhpKvpis9t5KsjCfgSGEuZDRASho49gC9CpM
    ORuFN9F3dNAfkFjRaGvf5kS7mhpfSD3IVn44TX7UAC6vL9UTBTEgJ4vbrFYsswUP
    z2Gwskcz+iz5v+ghRyJx/otNNSrWI6ZWBx824AN4zWq/+bno8XJvuqbGA3pfEM3T
    eG0F3Jc6FG3/wQDNSBLKhqwvd4ja7qPuCECzHk+cy9Ls4QgQdpLDsW23trr2xT7x
    ToskWJ2H1df06G3gxzgJ/a/8aggAV21/A7VqW5/fCG0IMkxKCNH5iDm5PmPh3O5a
    UGjaVFeQLCoQ67uvZWGdDc1zUpSIrhtijimi2jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121754; bh=8uxBtF
    zSYYut3mgdFh6xyXjOfpwQW/Yqdlv9BDcGsAM=; b=RbreIAa3rORZGWQCTp1IT1
    0/QgC8WmWQjPmoZhkNX46MqNC33pUIjg/VzrUbw9+UkGb6NSO6P5tv9qeU/sQ6Gn
    DPzi8DFSue1gKVFe9Ved/JQU9QAqHs3IiS9y99esAF3IDquIFiu/+/TCrZmK13QB
    ZVn08XaDOB7Vl9eLm4FZhpzpO6XAxd4lT4DktxT9voW525h9K95iwg8wnUsJ4qZ5
    KD72xQDzruGOnqEunHbu/96Svj/4uY+4XZ3Og5mHCo3HORKvHnwZPWqf+KaKC1hX
    GbBAJdf9EZ0rkWt4fA+Y68kixs3ZnhfxqjuhjNkkouI+Pn7eXIWw9+G2qfCTNeIg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZVGd9IEt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZVGd9IEt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933861AbeCDACF (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:02:05 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932266AbeCCWcA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 035/219] ath10k: disallow DFS simulation if
 DFS channel is not enabled
Thread-Topic: [PATCH AUTOSEL for 4.9 035/219] ath10k: disallow DFS simulation
 if DFS channel is not enabled
Thread-Index: AQHTsz7so3Yejx/TIkKsC/Q1+M3y0A==
Date: Sat, 3 Mar 2018 22:28:16 +0000
Message-ID: <20180303222716.26640-35-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:aNAgzL19s3HEL01/b5OFq8D/EoXPNnMeBVPTnu6ZMLtFYWb+xPh6gdeZ3YnQ5vyPALFcywAcovy4zs0f8f1zTsGE1jiRqFGd5dprLNSzrDPnVPFrohJ49Uqnm5ukVIQCA5afLHZvNB7RJIh6v7ZoNt5ArdpwvmGtuegzaVOIH/4kjwWaorBYSqDaLeouDmKo5ng11wd4RVkEuDggaB+J9LNbR3bGISZp+kTyM8VeJXmJXRdG81gQ47GxWmvHtpW5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbff3fe4-4126-4cb6-1e89-08d581569358
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB108309642B6AEE2317A79CA6FBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(51234002)(189003)(199004)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: YhseWechbAqCxOOxhiBhSaiL8ccUXNH83QsdFny8EJbigcgm1Jj3FOESP3cjRSRPcuzJITQ28a7cn/K8pMUp5g7t8uZ7s+Ns7d23+CQnfPeXIeUqgRj/+lOy1UD4tN3tA/Z9zWjHMIa92rjnsjF4Sfg9DW0nqdBPi6g+B3wPi6I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbff3fe4-4126-4cb6-1e89-08d581569358
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:16.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
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
index 82a4c67f3672..6aa2b93497dd 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1942,6 +1942,15 @@ static ssize_t ath10k_write_simulate_radar(struct fi=
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
