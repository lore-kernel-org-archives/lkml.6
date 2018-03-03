Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123713-2-5778137983611155819
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
    t=1520123712; b=XVjvfUUYGFb/QMf67AWj5KvpHIenuoXgBrSGixHHwL/Ti1r
    WldCMNbElGDpG5hlfrfoLxe9Gdqn2g49V+kqPxnGXUyaT/gUXw/+igiV5vE+NAbs
    cl19xjNGKitmEnLc0WHutOOkCEQYy0fazzcAKdRuMMSsYeUIqASddv+4tWv9l8fU
    t1XjX9Kf/YIJW8vgar9hqs1Q9DX9VD5Uqkf9DvodOyyRqU6L+xzdpuzqEVz0cKS+
    1O8k+yxZXj0oGl6TZByJZXFBZ97Hf27r8U9DqChth+zik6kKDD0RZ2DB7PC3+bLD
    UpDelIsrDMgb7zHZZ2BO8Zu8Qd0cUM81t2U9VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123712; bh=QjlkUX
    kt9+g+DsBpRdarvSP//xDGWElnUmwimNGRbOM=; b=uuQM6CZLM9OX2/Sl6lGtiP
    RXAHs3u9+o1Xt31dZue1J9zfaP1n9zMK4y68D6+iXnbTQOEAKbqP8T9DAoSLx6XW
    KxljOCwaEPBoQqWoFmtVnTBDOvjxGq4dg4xQhmY5FkjUOqUrNTKZ55hKggfrHmYr
    v+kBasAXXj+Do6gLqSxIco10r75Lk+qAwHONA3Z8YYw8etbNnzriMpUAwNZc5Ly8
    ZoXgVmNNbPjEmzmODfLL3fnX7jzy2xsFw2WSgNSLlGzzrvSFM/C8vjm/AcR20iyG
    vXI/I3hBYk9XZvOXHFqWM3n5OwEMIslEXbDJeJ8eUC0JcjPTG0bFWD5bnF2w7zvg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BmmtdnX2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BmmtdnX2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932249AbeCDAek (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:34:40 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932848AbeCCW1O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 083/102] virtio_net: Disable interrupts if
 napi_complete_done rescheduled napi
Thread-Topic: [PATCH AUTOSEL for 4.15 083/102] virtio_net: Disable interrupts
 if napi_complete_done rescheduled napi
Thread-Index: AQHTsz52rhqX3D26ZUaNdm/bKDKwcw==
Date: Sat, 3 Mar 2018 22:24:58 +0000
Message-ID: <20180303222318.26006-83-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:8nE5VHGvaQmimG1KCiFvBXR7N651RPxqHc5mbxG3x0ay6U+PQWrp1kQiGh+vj/eyllRtz/fCmACKhiby8Dz+2Aul0bJJGFRll/rL67wLrMWPQxDdZKUpHGK3YTuKYMtxHHh/4BWKdkxTRZrtp77rnZbH61U3YeeTTSyrZ3XDhDI2VrflqYE0nl0oh+tidRyDRyVVf48SKfz/X33pzlk6C+aH9h2fmjD2xzZnIrEWOGEvXDP4yAvbnfhi0SErph3lj6jSlKkqU1wpMDZl4VNAmPGcjM2rNRUhYo5GYs6LCs8vDeTeWlfbdY26ZcG8n6vgiHd9uaz5D1LHVmRWfLQt5ycd5sYO4HtngIUmcgfPlI+6KczAznsvZgNPi9N4XGLD;5:7gBSJMLazZVsoW2neBCzlLtSAwZsux+ZcuuS/03XdO4+AR4bmn4BsImcDWLlTjVpubgJP3vr4Upe/FfwcjGd3SJpC2EXwnOXCDtyfeWWSnQbOkyFCnUUgzngJjSdXRTYc8UPP73Lzr9Ey6je17W9eef2OM7bxphY7LUPYVvzjYc=;24:HSuKZL5Lg2ZRQhTonGejLNjjb7wTRyqO2zn+IRyCxa57tlUaHCDzYGuSRNjVRpKqUQU2rvx21NOMjVh49TTPUhRuoYI9rnJL4gVvcz8fWek=;7:p8AhopqKkWCC4vxz91wRiPIGOM7bHkZbfwXX7FLROA+si57etUq61p6k8qCpwnnykpWUAgLaRw9wHavU4mzdmz/oIsnYdBm60q28ORimAmXgLC6yUaZ3uoqwd7jkNr/q1FZIK1K2fZXPOsphkChIolkplgzPLz8h1BQnM/e3O+9EE2Zn/oEa6ksGsK1viWZ7Jus+YfYfwYtGov35XEfccKOaHknmdc5/v2oITLkJ7RUJJEsAZlpr7+ySXzcjxs5S
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7d6494f-e536-4b33-aabd-08d58155e90a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970FC10724E1F43C864D2DAFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(200054503718035);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: AZsLeh6uaC8tbO8snXGwfmZfuRI+T04FbgbbKAx43He8pd49LsjlEXga1TWvAe85O3RsAJia1rcpUv1DR9wezFbJJrIS4nNF9/eIDeWlTpO2/VNbgYBHyShWV9sNrKIZj7oD9eCjYz+F2nV48AcLWiMvpRnufLHVL1+cd+GEHCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d6494f-e536-4b33-aabd-08d58155e90a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:58.0253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
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
index 559b215c0169..6fb7b658a6cc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -261,9 +261,12 @@ static void virtqueue_napi_complete(struct napi_struct=
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
