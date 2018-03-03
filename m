Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122476-5-17600222284534206301
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
    t=1520122476; b=SEKrtUjAJbMQnUszT/xRwmfrZSgrLNEKle4OaJ9B9VQU/6U
    lm8JXcM0IAcgbprEfyoIUK6b1hr1vLTH5QWUpEJ6/KZtVsTNHrOWcQn+a9x3ivB4
    mlV/UpS6cx5O7Vqzr9Y9vsABACLkdfXHGiRqTVIqMHsiIx0l3uC/1FUn5gp08yC3
    vgVOuvGFlb7/u/ORZCyURuZC3Nd9NOeQqR2aKcOMxH3SdiT0vZOQ8WJX1Apf4hJr
    rF3KKLtyuDqr7nM0ElYKL65nZRcX77OJR17w0zNktjPnU84Jkx67qSB/BVE+2NsI
    sIRNomzvjatT2fyLR6qS3+ymCodGdxEb2T4n0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122476; bh=ZpOkH/
    S221oPWJPDh+NvNH39fozrRvFjTrd+vYxykk8=; b=h2lXH53utmCvuXFiYuZ+IG
    PdfFWl74RzrwqhLIQ9Lf6QNmUSebrh3WHrQf3PDfQFQjFsGOEYj7PlWIGJ6tIMFk
    aeMno3Pf9fLX7NfP7ew0TnROFkupbg8CLz+JQ1ilxBCDlRzVqYBzeQyKkdkDZa6R
    zA6Ycp3sDB6i7aVT3iBLLTvHujvP/VqKHvv7/4vcCCmqB/CgvxISZDPp8D9aowGZ
    T5rQuT0m/+48FDgMLoposcVhMKQ/ikNW8X9C9TTSy5gyG+OcTsCBvQyL0GgJk+iY
    uzoDVwuZ29/S2YBpc2ifa/ga9Owoz9V5onyg/CqXT70O+qg1a4b1nK1NhiYphmeQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X4m+8JRO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=X4m+8JRO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932906AbeCDAOQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:14:16 -0500
Received: from mail-by2nam01on0115.outbound.protection.outlook.com ([104.47.34.115]:14144
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932978AbeCCWap (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:45 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 65/84] virtio_net: Disable interrupts if
 napi_complete_done rescheduled napi
Thread-Topic: [PATCH AUTOSEL for 4.14 65/84] virtio_net: Disable interrupts if
 napi_complete_done rescheduled napi
Thread-Index: AQHTsz6y+2dBloUrREu69sy7fpGZyw==
Date: Sat, 3 Mar 2018 22:26:38 +0000
Message-ID: <20180303222518.26271-65-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:uJezok8AX7C57ydMJ4rPttuRRCbjsc22BdHPlX8ineKZ02lv5VvBGJXN4rYlXD0yZOWE2nhOE6DvPB2jERi9jLQCqfaPq1G7DL8DDznx3ToJvHWLM4t+llIc7Wl5B7XyiUQuEH8TFTbbVVgjgrXm5E6NwuFBsyNKp1QYduEWbBY1dM4pUeqWE3C9sX3HqUEofTxejMf0wZI/ZQrsBIXanB+VF81LyBKGz8hJo00OrR1QJq3LffipKl8WP+QgwMfD045AgE3YgVuee0uY27HSSlh5FTZXrarih6evgHxZGTWNHc9xenqoT/FTZJMZu6/7Xfu48neh+lGQWaYvcc2kWqhPbTdyfvZZwD1/3NISHksYuLfpShMiHSyoa17zft9w;5:TRCQThczNrKW8OhY+FfG00Xa/hoMez8HZwOmetPGHAwXaQeGnQzSkfNceoaU7acwdhn9DbzhtwpfLKdWrrW1cbdMQ7ZerZtyNnZJ30CH/4PNVY2zsWsjhLECMENubyJjEtL7kemBZqROzRuKWYIuLmLyWsduOIgp4sf0byNgw3Q=;24:PoMtSXhALMnlsJh17VxWrgqtA5/W2MSZeHi/apEvuQ+x+GaCOAe1Felj9o8EtguPl1jYxLCb295CYR2i/OYdF7n9QUGM3a2hABQRKROMjkA=;7:cP0KRg1arYWRAwqlA96iK7EHdTsrstxb3WbPbnglHmnCKMkiVvmyJ1pYFWr/xtspAMNKVENQ7jsO7ZeIgIZ5nkr3qoTUsiSrLhfHYKx6tXJ/DD9S7eMbNOReDkZP5h/nqho3KK7kvy32CJyxFtwn8T8L7QW9GldZvtVWRPwZRqgRLVRdLJ01qN/h85nid3RKbLh9HMp+IMCTh5qlb6nw7RvgTO/bs8w0qmRUBpMh+yy8tXaFUUNbhclgp1YqdvJj
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e27c8cb3-dbf8-46c4-7328-08d5815666df
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115845BDEB5088492305571FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(200054503718035);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: eLEU0Mq4SWwFEOlBz5zUDughPik7g7d7DYUcfaZXFfzDzRJ/Km41m+QopWaA4Jz5MDerOOF2dZ7crtKmc20w3QE65rJqFGfXnch09debLMHqpNl5zNQiaLbXUC7SPzwRI9QlmNqKW4c/mB3fAsD2kYwc3YaxcR7o5weS+FO8KCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27c8cb3-dbf8-46c4-7328-08d5815666df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:38.2911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit fdaa767aefc1685f9a41e91f447c9aea94103df6 ]

Since commit 39e6c8208d7b ("net: solve a NAPI race") napi has been able
to be rescheduled within napi_complete_done() even in non-busypoll case,
but virtnet_poll() always enabled interrupts before complete, and when
napi was rescheduled within napi_complete_done() it did not disable
interrupts.
This caused more interrupts when event idx is disabled.

According to commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing") we cannot place virtqueue_enable_cb_prepare() after
NAPI_STATE_SCHED is cleared, so disable interrupts again if
napi_complete_done() returned false.

Tested with vhost-user of OVS 2.7 on host, which does not have the event
idx feature.

* Before patch:

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.1=
50.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32763206      0    6430.32
212992           60.00     23384299           4589.56

Interrupts on guest: 9872369
Packets/interrupt:   2.37

* After patch

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.1=
50.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32794646      0    6436.49
212992           60.00     32793501           6436.27

Interrupts on guest: 4941299
Packets/interrupt:   6.64

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/virtio_net.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7927e28f5336..c366aaab2b69 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -260,9 +260,12 @@ static void virtqueue_napi_complete(struct napi_struct=
 *napi,
 	int opaque;
=20
 	opaque =3D virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed) &&
-	    unlikely(virtqueue_poll(vq, opaque)))
-		virtqueue_napi_schedule(napi, vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
 }
=20
 static void skb_xmit_done(struct virtqueue *vq)
--=20
2.14.1
