Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520119217-2-5771382439534076297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119216; b=fM2e/+TsIz3jOopQ66Cysd/bAV3ZUoi2GgR0Or1YKIQATW4
    aM6Clvdlj+6Xogqn0SO/L3sLIrmbxk7rMdtnYatD+axZskRHbOLwuttTvBtSX9vn
    NBFmGfYXCBquU1zea379fu9w9WiRdxCZYn9D0H7CiTJ9V13Jny/L0Oh5lhJHfe96
    9E/vRNBi8ycxzvqrexK/22EPnfDtecaZntauE1Tv5A0F/jac2uuozrBBTunDHPa0
    7bGkXLXcuvMbDSO8vyMRDkZ2P2xy8wnKXA7IONViDs4t8Y1hBT//1O/uy36rZlNx
    LYvZj4zJI2bf77Cw4PCc93H+tJf8fGoV5SnRENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119216; bh=6sZ8nL
    zrBuC4EEJv6+JH9IlRrRE+Bk39uw/6oe/JHzI=; b=JU3fSNOe91iFlOuQcfjBmG
    Ngc7EEdpya3NIiKLMK/ijMQ0BLhFVepSCisbFVIilvqDsCs12+th17ykpTnmI71Y
    A/JB1wn1/82uGY7aWTWiv/7yw6APdCFZXcz+VMznuh3v9BZ0zrvGH/AG49sHB3tI
    94sgU4yYPbZx9eM+HdOV950mLk5GJHCRQeOTwLe57wxIPUnIDUOW1rN1fBfIgJNE
    3oJHz51KS77Y+qnisqTJkqkW8wRxBufKP/pYZwlo2JC+VsU9B7fq6hIUEDiFnnTR
    YnK7PqEq0k4yNO8qZTdLYTRybWp2A7vAjupIInby5Xch4IcnFv7F29m1PTc2y2Pw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FO62udmx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FO62udmx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934790AbeCCWiB (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:01 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934420AbeCCWh6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:58 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 007/115] ath10k: fix a warning during channel
 switch with multiple vaps
Thread-Topic: [PATCH AUTOSEL for 4.4 007/115] ath10k: fix a warning during
 channel switch with multiple vaps
Thread-Index: AQHTsz9I63Ym+8EJwUSIKTTZKR4dUQ==
Date: Sat, 3 Mar 2018 22:30:51 +0000
Message-ID: <20180303223010.27106-7-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:Nhq0J/ziOfEpaYwWeS9wRXr64QfRPVEhCm+F0vCwm7dfINHBFkZLJDba/BJDLWBOspDhDhHgvQ8tFMuYY55v4SWX4RCsQwERYCrRp+p34r8rnvsXEwKEE3i5fmk1O0hHzXx64oJEB8myMndbVAxIAo9ZGeLCzs3fDJcGgnUQh9D2zCGEAHZYq00SwPqgi545B1mEFW5He4iN6IFNe1628pSfE/j5myO2Y+5fqNv8NMXA2O2qBjQjqeEAiUK1iKb1
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 790dbcac-b5a9-447a-7f52-08d581576831
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100E703C7B4E6C7DCAC782DFBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 8aGBCefC8mBKujQomFpzTGt2lcDjPXja9M+698+sLM67khZioaaiyvptG23UOvoB7mheikQKVOK7vYb5vsYwuq0IlytM+xHwndwFPEHtOqU1+ysT6WOjmxARMuw9WEdxNZL24A7GkyuU03cQ0pf3MixLn0AOdsF5naAbRtoGC5o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790dbcac-b5a9-447a-7f52-08d581576831
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:51.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit c73f8c00330f59ce9b1ace9ff698aca83390d358 ]

Doing a channel switch via hostapd_cli seems to update
the new channel context for each VAP's appropriately as below
in 'ath10k_mac_update_vif_chan', hence we can safely suppress the
warning that shows up during this operation and dump the warning only
if no vaps are available for channel switch

hostapd_cli -i wlan0 chan_switch 5 5200
OK

ath10k_pci : mac chanctx switch n_vifs 3 mode 1
ath10k_pci : mac chanctx switch vdev_id 2 freq 5180->5200 width 0->0
ath10k_pci : mac chanctx switch vdev_id 1 freq 5180->5200 width 0->0
ath10k_pci : mac chanctx switch vdev_id 0 freq 5180->5200 width 0->0

Call Trace:

WARNING: backports-20161201-3.14.77-9ab3068/drivers/net/wireless/ath/ath10k=
/mac.c:7126
[<c022f2d4>] (warn_slowpath_null) from [<bf7f150c>]
(ath10k_reconfig_complete+0xe4/0x25c [ath10k_core])
[<bf7f150c>] (ath10k_reconfig_complete [ath10k_core])
[<bf7f35f0>] (ath10k_mac_vif_ap_csa_work+0x214/0x370 [ath10k_core])
[<bf7f38b8>] (ath10k_mac_op_change_chanctx+0x108/0x128 [ath10k_core])
[<bf782ac0>] (ieee80211_recalc_chanctx_min_def+0x30c/0x430 [mac80211])
[<bf7830a4>] (ieee80211_recalc_smps_chanctx+0x2ec/0x840 [mac80211])
[<bf7843e8>] (ieee80211_vif_use_reserved_context+0x7c/0xf8 [mac80211])
[<bf7843e8>] (ieee80211_vif_use_reserved_context [mac80211])
[<bf76e5d4>] (ieee80211_csa_finalize_work+0x5c/0x88 [mac80211])

Fixes: d7bf4b4aba05 ("ath10k: fix ar->rx_channel updating logic")
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index bed8d89fe3a0..d5c9ca47219c 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6427,7 +6427,7 @@ ath10k_mac_update_rx_channel(struct ath10k *ar,
 	lockdep_assert_held(&ar->data_lock);
=20
 	WARN_ON(ctx && vifs);
-	WARN_ON(vifs && n_vifs !=3D 1);
+	WARN_ON(vifs && !n_vifs);
=20
 	/* FIXME: Sort of an optimization and a workaround. Peers and vifs are
 	 * on a linked list now. Doing a lookup peer -> vif -> chanctx for each
--=20
2.14.1
