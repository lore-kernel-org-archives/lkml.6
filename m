Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240352-2-12106597773410737274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240351; b=jIwSHGnLWjfNOwbP9Jhj/3aQDGUKcIFJo6hjsPwLJ3emPoT8Sv
    ZdenViOTQtNl2NHQxjMF+tcsvajeRAG5k2Khs+o0BuOabeaH/BETtBa1eFRrsLYM
    nQWXL8D/Qw2ZzliVFVUoKBsl//Gn4MTPnB2zhTabZhp20A/XE2Dw+qoDXOtW+5SI
    21uBZ3jAAeEeoFJ5tih/iXI3NIaxfWQOPGyTgrKL0jIHBaEVQwQSM/uSLKTq2ciQ
    Z8B9g5ObuMqF8p+mfMeiDt1c5EJ9YPllgVy85vOXn9ph2+M1UqRhxRk6Osog07z7
    BD31fnZeLZf1jYynvUxHOmgbW9Y8PnW9Ojzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240351; bh=qIcuBoq0h8
    rdpF8lkqrOjj41jJavqWe+ICG7ddZVsO0=; b=nXjlNzEQhozq8uWZUnUhCo+CPc
    gDAgtIwTv3CM86kZE2R5KH0jiNr618N98mA3OYBI17+zxjn6xy3MO+pGRsi5j1lx
    KxDe3izfu7wkrZ9GyMl0vvX2UAjCvV0X5kIr5YWJqkhF5VYM39QvGcDVbhOF7k06
    05AAIWN2aubDpGGxVswLtFIkPM1s002tJ7cVuuQDaV+p8OfB+edT3waKhjS4W/XX
    1+SE7hNH1WgpE8M56wrQfy1DbrZFarS4y7f3Ypl2SJkFgTbUxvO/KoTaMYf5Qcfp
    6WQ+yI1USkwOrBoijbRPyxK3uKrjk/d6w3/EqhshfOljBtcZ8wG4YA9FqzRA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JoZ05pTf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=JoZ05pTf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLrRSd45g+CguH9dSb6ZacXHhexxpdVlobbNM6T/VdhvbUcfgjka9F2igN7bKRrB50PYc9M0AuaIGDj/Z9uRuhO7C18iwcAq4RjDBXZOmbKaWxuEZxdc
    FO7219k40dBoLKbIQ8ec8DeXkZjS/ZtDgUaXh//Z/zOLekqozDsOOIiHF2rp8tbT546sOKHthbu27F8zg2nIyApmtV8TqbPiAL5QZ2XGAmicKFQ6UHrWskHx
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=yuAWDxbY4ZfwiPynzscA:9
    a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756185AbeDICSx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:18:53 -0400
Received: from mail-sn1nam02on0125.outbound.protection.outlook.com ([104.47.36.125]:10314
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753157AbeDIAaX (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 129/293] iwlwifi: mvm: don't warn in queue
 sync on RF-kill
Thread-Topic: [PATCH AUTOSEL for 4.9 129/293] iwlwifi: mvm: don't warn in
 queue sync on RF-kill
Thread-Index: AQHTz5kimmIyfL6n7Eyh07bBWW/8MA==
Date: Mon, 9 Apr 2018 00:24:33 +0000
Message-ID: <20180409002239.163177-129-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:Cv6K2zm62pxKsE0rp/S+VzJtlPnt8TMMqtapOtzdH0FGkPBucqTXFg0y5Q2tM42cgShQiP34nPVZVZjOgKaejbdOKbLZmhg4hvPdxWmpTqJ+JvxiBvHQtNyQdG9WXhbdZO288sHYL65ColKssrjHeENvxi/T4nQzQETt7fxnSsKf12TjjPehyOUbawboNChYgZR9a6DCQQoVitDZ+4RyKtYxnuLEepGHd9UttqV2oMNHDg6Caml0kKDfSTHA5d/j;20:Uknc+uSSq+U8H2ROC9vIDR5LaYcoy0C+iGboHrJLQe2upNqbEaoSgGbiQc26a+bv+mDhqRTbypfbQ4BqLdn5oTkaxWqV4kFH96cdPzLr5sAoNUAB0OlMucpqV5f98NmfP9uTT5t2L8PCT6D1GCrHkM3o8ujkEiLfeVQjX0Me7CA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6efff0ce-9fe4-43ee-ddc8-08d59db1124c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1032B49B990EB105E37C7BF7FBBF0@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300001)(76176011)(99286004)(10090500001)(2900100001)(105586002)(305945005)(7736002)(107886003)(2501003)(5250100002)(14454004)(53936002)(4326008)(8936002)(68736007)(25786009)(86612001)(3846002)(66066001)(1076002)(486006)(316002)(72206003)(22452003)(106356001)(186003)(97736004)(6436002)(6116002)(476003)(2616005)(478600001)(6486002)(10290500003)(2906002)(110136005)(54906003)(6512007)(81156014)(81166006)(8676002)(36756003)(11346002)(3660700001)(446003)(6666003)(86362001)(26005)(102836004)(575784001)(3280700002)(6506007)(59450400001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: DTNrVj5pkbrF9jd/eaMyeVUvy9e2BrYlBgzTNiOJIXfpnP6hp9lr7x63fNbV3LV67eLbm/h/29JXHwg8C15pzBDs8ztZPonJdbEgrldTXJ1NSDAxkD6gP/w6+tVIyKOqTHzIII8ojwzmI0qn0+jjIUWRuRki0KZf/CYv6d0oMlmrmAdiXdUV8Dx6aBHHYSgX3wSKfcBTHev3SxPeITNbjFk8wHrfKbTLvRqKcC7MchB11CeiLXlDmuASPbGK10i+9VVZk0dULs9mzcY1twOPXiRAEph0ML4nj0hm4L+U90hUjfJj9z8A3OHJhodZs5TjiF5ixbZSAfREVhZVvpiUKmFW4qWbQPCIh4AEB0dcPh28Gdoz84vZgXYUrspjBIjWgr0qraPU95VX6APfB6EJYSHAnz1bo+uPkMnl6TLy4HQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efff0ce-9fe4-43ee-ddc8-08d59db1124c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:33.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 6ad0435991482107664f65b7ae3fd588f10149d4 ]

If we happen to be in or get into the queue sync when RF-kill
is asserted, we return from there and warn since there are
still queue sync notifications outstanding. These can't ever
come though, because we're in RF-kill, so don't WARN then.

While at it, also move the warning to the appropriate place,
if the request is not synchronous then we shouldn't warn, but
currently always will.

To make it fast, also trigger the waitq when on rfkill assert.

Fixes: 0636b938214c ("iwlwifi: mvm: implement driver RX queues sync command=
")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |  8 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac80211.c
index 3d6401eafe52..a9c4ced702c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4157,11 +4157,13 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm=
 *mvm,
 		goto out;
 	}
=20
-	if (notif->sync)
+	if (notif->sync) {
 		ret =3D wait_event_timeout(mvm->rx_sync_waitq,
-					 atomic_read(&mvm->queue_sync_counter) =3D=3D 0,
+					 atomic_read(&mvm->queue_sync_counter) =3D=3D 0 ||
+					 iwl_mvm_is_radio_killed(mvm),
 					 HZ);
-	WARN_ON_ONCE(!ret);
+		WARN_ON_ONCE(!ret && !iwl_mvm_is_radio_killed(mvm));
+	}
=20
 out:
 	atomic_set(&mvm->queue_sync_counter, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wir=
eless/intel/iwlwifi/mvm/ops.c
index 4d35deb628bc..5d0b9bf8996c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1049,6 +1049,16 @@ static void iwl_mvm_wake_sw_queue(struct iwl_op_mode=
 *op_mode, int hw_queue)
 	iwl_mvm_start_mac_queues(mvm, mq);
 }
=20
+static void iwl_mvm_set_rfkill_state(struct iwl_mvm *mvm)
+{
+	bool state =3D iwl_mvm_is_radio_killed(mvm);
+
+	if (state)
+		wake_up(&mvm->rx_sync_waitq);
+
+	wiphy_rfkill_set_hw_state(mvm->hw->wiphy, state);
+}
+
 void iwl_mvm_set_hw_ctkill_state(struct iwl_mvm *mvm, bool state)
 {
 	if (state)
@@ -1056,7 +1066,7 @@ void iwl_mvm_set_hw_ctkill_state(struct iwl_mvm *mvm,=
 bool state)
 	else
 		clear_bit(IWL_MVM_STATUS_HW_CTKILL, &mvm->status);
=20
-	wiphy_rfkill_set_hw_state(mvm->hw->wiphy, iwl_mvm_is_radio_killed(mvm));
+	iwl_mvm_set_rfkill_state(mvm);
 }
=20
 static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool =
state)
@@ -1069,7 +1079,7 @@ static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op=
_mode *op_mode, bool state)
 	else
 		clear_bit(IWL_MVM_STATUS_HW_RFKILL, &mvm->status);
=20
-	wiphy_rfkill_set_hw_state(mvm->hw->wiphy, iwl_mvm_is_radio_killed(mvm));
+	iwl_mvm_set_rfkill_state(mvm);
=20
 	/* iwl_run_init_mvm_ucode is waiting for results, abort it */
 	if (calibrating)
--=20
2.15.1
