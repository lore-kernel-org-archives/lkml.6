Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084890-1520490674-2-11969398464601964618
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
    t=1520490673; b=wKePzsHKHvFsSNWyj+JTwtPEd8F1sP+M+cM1GW13p4zIqg/
    IaWrsMiOOyZUD/XkgHyS+BbxEKnmVo8+lD5rDZWUHArpaSxiPPJiV0ydLoBdPioH
    Y/1BDzQQLunLD9aNI4lRaM8TMLJhErrQaY+ZPfQypruKy9Tf1bed3nisTS2ds7/S
    6zFK3J16Gwme8ruQqu2i/FBxp8dtxFu6VzHwE0qkWzeJDV6xMJtYqxcrBeqlaBEa
    lyj5l9xkgx8liej2A6tB7/T/U4hn5amFhF1bQcWxvQnfdLnsyxWlq6LyRAU6lLt6
    //4dAfze6rciIouLIu6aq0BDqcVe9jfX56occ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490673; bh=wQRlhx
    h65WDM0fKXCI/OhlnIp8BCAiLmploKKaKT/uA=; b=W4tRsoRcywA3ZY9Nfazu7v
    MNtZ0Eq6qW72mEYNQnXeIhqjagKDtNN0rQg00pFzOpe9TsW88M21+4oTcwoq8+qh
    2AkyubHe1KRAMqX4TiCAtA0/dc1Bz4sKSgEXnb5wKpnIAbdBiLVJeYk19liAEmg9
    BidC5FXoUAyuLuOOpUnUIy8Zq7jVyKzX75pv2ZjoCBpXVo8299YwsW+aaO9O3bh/
    bI29YXUiYYv0pdHTzUjE1CIIlno0A4QP4nZocMK+jaCyKKJmjVm/kibbIfmHyN5u
    +pJ1kj6rdmazfeReYgAl/GkOh/Z9zZD8VXHWpttwJcayChR4Fyte7JiiY+SJlweQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kW/tnzgS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kW/tnzgS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeCHGab (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:30:31 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:44208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750904AbeCHFAG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Scott <michael.scott@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 018/190] Bluetooth: 6lowpan: fix delay work
 init in add_peer_chan()
Thread-Topic: [PATCH AUTOSEL for 4.9 018/190] Bluetooth: 6lowpan: fix delay
 work init in add_peer_chan()
Thread-Index: AQHTtpoqC0vMchKeTE6BX1bbgCr07A==
Date: Thu, 8 Mar 2018 04:58:57 +0000
Message-ID: <20180308045810.8041-18-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:C9znK4iuYoKXS5in7pDlUlWjTvHS42TbCWbNj6wLTZNG1iNdPGcd1ETI5MJmQ0YTY8XL1TsfrPl8oKUuK7VgV6OmqZaYs7G5baoph0NTb05/gZgXxCiUZNutC7sc1h5naQrBcClu6TpDm8gzETJRQer1RLfJhsOVGPTwhi5CSQZJFNtZxMY+1o2nMzE48539TzcOaYHxxW4ogCwIfqEdrjid672Vx20ZEib3Bxm4+8grsy8A450wdQrTWwz4lhOd;20:kjYjAbpPKNakCG92iJ1y4N4itkuCO3JmXbBiMkg3E4e1ul6tgkMETMvrv3AUR2p6T5vwT8dfJGSZVLk4vkM1KE/5MuA/Kai/H9lObUqoNlqkas09eMCG+TJ/wQFgJoeyHjo+4jJ7C7VX00ut7ZDpXV5KoHid8iom6wnB5c+WSTo=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15b43b50-8764-4934-0aa8-08d584b171b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983AAD15DBBF8F57EAF7D6CFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: AW+x4RdbkDd2TXCFUSNbS4wFkBgb5+TMrQqQo46REYukvjztgAdYQ3oiNjHvH6ONt+4HalfNiVrfLBrCXkAoiyr3h7DuWZNYlpbA6Qtu0wEgg2324BoosPoiHyqHqhh8pMzmf7utYRaAu4l1ZORnF+CInbqpiBPdMf0o/N59JwXRA8SVAkDp1f/GfOgBlUo1WixX6WE9cYxkik89kz/9sPzbcptzR4YTDRO9F0lw1KUWudpxOubysYHloz+25qXRRiWomZO7NtZn4gA/wgr0RmxCyNn5RFNy8llVkzUtfcotWtV+jkTgvErCvVbDY1G+DcxMA3k8svmbWJQpA1HvKw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b43b50-8764-4934-0aa8-08d584b171b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:57.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
@@ -843,6 +845,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct=
 lowpan_btle_dev **dev)
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
