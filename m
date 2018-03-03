Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120020-2-12884750786931213648
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
    t=1520120019; b=QOjcjR8etZmfYGRFaSIptqjqyKfyxnE56j39mc3pEseuEFY
    SMZY4bPSvlzw6j8xyCDyCCHh3M7ly/qfRLW93+7hdSh7DykGAGnsClzgJVb7480x
    Pk5NhQ6He7rvDw7/ie344sUXqT/BJ/sntzUMH+ivotw4+IP8Hi4iTnYcLE/q2W+N
    Z7LMuhoZv7lotQPIFJkJCCArHTMcm1ztpnoVbwfpO0Uu+mn+K2/G3vAxCHsev3Lg
    5iuDNq98p3PP5DWJf0WRs9Af94m7E8bB9QFMMyfex6m0KRUAjYR32Lia/3b3/02H
    bLx6uHp07SqNTrarM0G/T0ymeMPwBC77ZO3YwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120019; bh=4ga8oe
    VdBwLe98n5aHG7kjzGegEveYoZvua6OXoUy2k=; b=OwvQmuciONrFHVYubOEriE
    cPNMySJQXvi6a3l8usifDxHeO2zjgIXW54sTadh8HqGclsmt/RzYvMxDS5goSCjq
    NGe/ZigJFa2n6q/Un+yQLwVuHZI+287dIwykE0jY7vy2hHKYRu05CYgMYX9luvSn
    PrkRZum1IyZA8S9FuejXDyoH3rRP57dQ3AtSox3gerxvXysf+ueXvAxtjKK/hpH8
    x1w+SyuNPmMwn0H9WYbb2zbu9rsT5wyo8P/rP7+mI4t3+mppFxL5LhEk/7OITpCQ
    u+ky4H8PWef2SmIRJNoqHQyGJmuJ68lOxsKLLVLhJAFSlB+dhIRsfXLRSBrYN7WQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SRDquE9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SRDquE9o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752389AbeCCXdg (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:33:36 -0500
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:45280
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933950AbeCCWgF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Scott <michael.scott@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 164/219] Bluetooth: 6lowpan: fix delay work
 init in add_peer_chan()
Thread-Topic: [PATCH AUTOSEL for 4.9 164/219] Bluetooth: 6lowpan: fix delay
 work init in add_peer_chan()
Thread-Index: AQHTsz8aSGewpgldmUmM5u3GZ5VDjg==
Date: Sat, 3 Mar 2018 22:29:32 +0000
Message-ID: <20180303222716.26640-164-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:J1xesqNJ3TfhzJeYqvq9DFWOrWirglW5czAH2fHFBjzlz1SC44O6Ll/gs5zZKMuCE2sTHXfR2zCBcumXpF2bDmbqV02oe5sPFFIQGAcXSYp0L44U6pnNpO6Fj1qXX13xkmi3KkltTF5c5TnGOwbZ9ORkIR26ZYd8x4Jhcvw/JFNBNPPrpJ5u+ekL7gcNhfJcq3InuX6P/gHAM2nerHmEBKGf4JtOSNkYVkzl+ppTeWTLoknyAaa33RVnM+SwX0F0
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1aa422d2-50e1-4adb-d10d-08d581571c10
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034055420AF28A514BD437DFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: XUeB9TEkgMlElbHgwFRktjCDzEVmWJqqo1cdXrm7V83EHkVUuXselyOJ/SAsmfLlSpmoFzswVAL/IjcJVNiu2sxLuXyd383T/6U0K8iHNIG9eJnia5RJOwfbW03IeewITHD1cSBZRjr7Z+Vs2lCjRODp0/JW5POnLoGDf9G/CuU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa422d2-50e1-4adb-d10d-08d581571c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:32.6507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Scott <michael.scott@linaro.org>

[ Upstream commit d2891c4d071d807f01cc911dc42a68f4568d65cf ]

When adding 6lowpan devices very rapidly we sometimes see a crash:
[23122.306615] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.9.0-43-arm64 #1 =
Debian 4.9.9.linaro.43-1
[23122.315400] Hardware name: HiKey Development Board (DT)
[23122.320623] task: ffff800075443080 task.stack: ffff800075484000
[23122.326551] PC is at expire_timers+0x70/0x150
[23122.330907] LR is at run_timer_softirq+0xa0/0x1a0
[23122.335616] pc : [<ffff000008142dd8>] lr : [<ffff000008142f58>] pstate: =
600001c5

This was due to add_peer_chan() unconditionally initializing the
lowpan_btle_dev->notify_peers delayed work structure, even if the
lowpan_btle_dev passed into add_peer_chan() had previously been
initialized.

Normally, this would go unnoticed as the delayed work timer is set for
100 msec, however when calling add_peer_chan() faster than 100 msec it
clears out a previously queued delay work causing the crash above.

To fix this, let add_peer_chan() know when a new lowpan_btle_dev is passed
in so that it only performs the delay work initialization when needed.

Signed-off-by: Michael Scott <michael.scott@linaro.org>
Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/6lowpan.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 1904a93f47d5..de7b82ece499 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -755,7 +755,8 @@ static void set_ip_addr_bits(u8 addr_type, u8 *addr)
 }
=20
 static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
-					struct lowpan_btle_dev *dev)
+					struct lowpan_btle_dev *dev,
+					bool new_netdev)
 {
 	struct lowpan_peer *peer;
=20
@@ -786,7 +787,8 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_ch=
an *chan,
 	spin_unlock(&devices_lock);
=20
 	/* Notifying peers about us needs to be done without locks held */
-	INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
+	if (new_netdev)
+		INIT_DELAYED_WORK(&dev->notify_peers, do_notify_peers);
 	schedule_delayed_work(&dev->notify_peers, msecs_to_jiffies(100));
=20
 	return peer->chan;
@@ -843,6 +845,7 @@ out:
 static inline void chan_ready_cb(struct l2cap_chan *chan)
 {
 	struct lowpan_btle_dev *dev;
+	bool new_netdev =3D false;
=20
 	dev =3D lookup_dev(chan->conn);
=20
@@ -853,12 +856,13 @@ static inline void chan_ready_cb(struct l2cap_chan *c=
han)
 			l2cap_chan_del(chan, -ENOENT);
 			return;
 		}
+		new_netdev =3D true;
 	}
=20
 	if (!try_module_get(THIS_MODULE))
 		return;
=20
-	add_peer_chan(chan, dev);
+	add_peer_chan(chan, dev, new_netdev);
 	ifup(dev->netdev);
 }
=20
--=20
2.14.1
