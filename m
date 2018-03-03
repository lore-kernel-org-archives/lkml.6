Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121980-2-1611957971429523679
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
    t=1520121980; b=XJMtNRyZSubMaX2dDqBNsvHPUR8gC59Eqs6tPUWIxO8SAlm
    SYvHZuaSqjZxE6OgR/6wg9FhtC4gpaZyec2nu++UapcJUyjpgNCJJ0yfOWBSCEO+
    TX9XHJi9AOt/ekyvwwoWh+dkT7cXdCYOrQFF+mv+5ogxeRXF3Wy9P4RCfbfk6LB/
    Wg0qSXaVoTnoLbeyOyGhHmB8e14YaLALsLCeWDLCanWsijojgxZfufhnWCKzO4/4
    V7OZsu7GDYrznVOP20rYfkl90NpcEGmgoSXLNCJEOjo5A7t6gGKIsfebTOsb2VdR
    NH9o/jaaFVmHcuFCVJ9k1gUcJ3k2/aMHI8bh92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121980; bh=/DYhRs
    wmBzGg+rYJKspsW/mFF/8bPhEoBf5UoKK2fPk=; b=jEj3lFS+1ZafgKrU56Bb7n
    QegHPNM+xVjz2mJW1kGVavzEaF+HUWQs+DSKOYXF8ZkNpheR14u2/uWyyMLq/l2M
    xItV2GPiV0oviIfgS1z5qt0U4ZBkI0KIP7P1BVGfFz0LneVWFAAel4pBXoyovvm2
    +kueP3W809L949a+xAV4wiyYbF+dnAWwu1t6PahaZ4ciB3CCj8T6EYL54mZHANOd
    NFoXr/biNnQs0w99yPfRqDkXrdtYq+VEYFAvdGYwHxYch2XRuYOwK1mEjnwTfzRv
    ohlqxS/2631JUYXQ09NU+uczv5Jq+vhskoRb7J+fFx4BRe1DP3i+bUt+wRelmOlQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lknn8ZxM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lknn8ZxM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeCDAGQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:06:16 -0500
Received: from mail-bn3nam01on0111.outbound.protection.outlook.com ([104.47.33.111]:54931
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933626AbeCCWbN (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:31:13 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 017/219] ath10k: fix a warning during channel
 switch with multiple vaps
Thread-Topic: [PATCH AUTOSEL for 4.9 017/219] ath10k: fix a warning during
 channel switch with multiple vaps
Thread-Index: AQHTsz7lPIobGbjG+kO+5AlwuwG/9Q==
Date: Sat, 3 Mar 2018 22:28:05 +0000
Message-ID: <20180303222716.26640-17-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:9aNxgZv3Ng8OHHxUyxWsvuNcrHOXxsqEMbTloGyxe4itI6x8gdqex5eSa8I+AAU5afg1sOEsFFy+COmsmiOi8y/o9d81kt8TyNXSj2iNRdVGw4fDGwXQk0IJUgCU0xc+hkGr/rMb4IxsBR17Jf+aze18RVbsvmEWI6EXsYJ5+pb43jSNsqxhrMBi4MKXvTVmzjwuyHUksOayZEJGd2CK6J4ecprZnXS4Awi6ogMGtK01ImEMX9U568zEjd0jop04
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e751eb6c-ba02-46f3-b909-08d581567515
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970061DFC3FFACFC9F119B3FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: AhdLrBht1j7PXhLXpwm5MlERdx9zoyM4RFaq9OmcAX+CyDUgOq32gw/2Ahh0BrbcA78oJhZbIpcmJYeBJxh9qU5OKmVJBJPIgRDcmZgkR3iEcen7e6c0BDyp5V5rDAXhENTHprUF64pnrU19RfAFPpb+Epni75fBC+u9X9hkjd0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e751eb6c-ba02-46f3-b909-08d581567515
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:05.2600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 17ab8efdac35..696b90270615 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7070,7 +7070,7 @@ ath10k_mac_update_rx_channel(struct ath10k *ar,
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
