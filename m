Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120096-2-5085746107098546757
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
    t=1520120095; b=o8+DG/cghrMIbKzBJKtn+up8iMSRrJWWa3XtQSJ69LG8Rkv
    mTUUGAJm99C5r9hmxwXjIiPypFwM2VW3OQaCRlcluqGAkzknOIV+kKAcfe27I6wl
    NX0nVEPm0BbvF3thSUjicninq6A/BckdT1ma567pPECnFxDUn73l9ouVLMlNOZSV
    8hieemg0mfcUhThuajz6mPhWQ/o1FHDM7kGFa4UYLFgAhtaXQ8o5+2tJXjbLZyQ7
    kQ+QewuyIgvA2MLN+3JHXH6Y8V0SdWfSftS/awTXximjE8+3tqPO5etZs8hInph4
    Xtc8a4aVE8l02HBzY0s5BYfBLpmsXCzEFtrDj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120095; bh=nk9wAc
    bVlykb6VlGB+TiM3SGTjuyLYEq09S2MRfNYyk=; b=OB5H3+5kVar7aomLt7r6dj
    x/xy4o9ZnjOqdx3+0u+XPsIVsoLA+Xi6oX0O+mc/DCCA2FQcaAkRNZSbMuFkXK6i
    dz4egtUfyRyudtqMDEVa7hpmadD9H3tyrr5UvRFx4fC8AmECNIMnCVi5id4+BfuU
    xQ1wJRi0qHD35AxTnMubOyu0w6TNpR7cV+lBJlPIKrccHQKRfSwKOP6QwtJXJhDA
    v61g3QVHqBmXnCHlMF3D5WZs8T/CdnMTTH1KVeJHugnAQPWuRj5HgWrg9MN5IFS6
    c8oPI5z46nbj7upkc1JgphizAv/xR/tOemUlg47/HFd71ktbX9kznAv09XXHtSGw
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dR0hfuOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dR0hfuOr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeCCXeX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:34:23 -0500
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:43384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934467AbeCCWf5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 163/219] Bluetooth: Avoid bt_accept_unlink()
 double unlinking
Thread-Topic: [PATCH AUTOSEL for 4.9 163/219] Bluetooth: Avoid
 bt_accept_unlink() double unlinking
Thread-Index: AQHTsz8ZhmtGHi+kJUWUbuoiHPuGUg==
Date: Sat, 3 Mar 2018 22:29:32 +0000
Message-ID: <20180303222716.26640-163-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1034;7:2RCE6mJ33zF3i5zvOxX6E64LTbcQSXrnuykfMAX9nzEW2fic7MeIfhZMin/J1t8jnloG0Hbv16PVSPgtOHJpc/1XxJx7b3+1OY11FGaCJ0tUvvJv39rRRB8qXELE1eb7sy9PEqlcLaImMQC0YAzpJaTnGmdBIG6mPS1UaRqWm/vZMhggJ8NHmQMqFjlqtz0JSq4m8MyDO6Q60rvy95nQ/QWJELDpW/pLkiX3puf09KWIf/INPPifcpy8nqDpY8xn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d2e99cf-00a8-4aa8-7137-08d581571bd0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1034;
x-ms-traffictypediagnostic: MW2PR2101MB1034:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1034FDBBBFD4E9DC6DF2F5DAFBC40@MW2PR2101MB1034.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1034;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1034;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(99286004)(22452003)(72206003)(316002)(3846002)(6116002)(186003)(26005)(478600001)(76176011)(54906003)(110136005)(102836004)(97736004)(1076002)(2501003)(3660700001)(66066001)(5250100002)(5660300001)(86362001)(10090500001)(10290500003)(86612001)(6506007)(68736007)(575784001)(106356001)(25786009)(8676002)(4326008)(59450400001)(6512007)(305945005)(2906002)(14454004)(107886003)(8936002)(7736002)(81166006)(3280700002)(53936002)(105586002)(81156014)(6666003)(6486002)(36756003)(2900100001)(6436002)(2950100002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1034;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MSRq3lX4GBjKfnc/oIsdfg5sxSu31jeP9uX9y5yYTIkEZaIjrELbN3Qw3rj/Gl3Gyyaya7RbLZM0c7gt9GJvTHgq6ocNxQPW7OAArq79+X6I9ETmLYfK5yYg+/5Zjd59n/FhIzynkcePM0cBWG7sjHwJB/gY9Hs1Q95SnGnCfro=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2e99cf-00a8-4aa8-7137-08d581571bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:32.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1034
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dean Jenkins <Dean_Jenkins@mentor.com>

[ Upstream commit 27bfbc21a0c0f711fa5382de026c7c0700c9ea28 ]

There is a race condition between a thread calling bt_accept_dequeue()
and a different thread calling bt_accept_unlink(). Protection against
concurrency is implemented using sk locking. However, sk locking causes
serialisation of the bt_accept_dequeue() and bt_accept_unlink() threads.
This serialisation can cause bt_accept_dequeue() to obtain the sk from the
parent list but becomes blocked waiting for the sk lock held by the
bt_accept_unlink() thread. bt_accept_unlink() unlinks sk and this thread
releases the sk lock unblocking bt_accept_dequeue() which potentially runs
bt_accept_unlink() again on the same sk causing a crash. The attempt to
double unlink the same sk from the parent list can cause a NULL pointer
dereference crash due to bt_sk(sk)->parent becoming NULL on the first
unlink, followed by the second unlink trying to execute
bt_sk(sk)->parent->sk_ack_backlog-- in bt_accept_unlink() which crashes.

When sk is in the parent list, bt_sk(sk)->parent will be not be NULL.
When sk is removed from the parent list, bt_sk(sk)->parent is set to
NULL. Therefore, add a defensive check for bt_sk(sk)->parent not being
NULL to ensure that sk is still in the parent list after the sk lock has
been taken in bt_accept_dequeue(). If bt_sk(sk)->parent is detected as
being NULL then restart the loop so that the loop variables are refreshed
to use the latest values. This is necessary as list_for_each_entry_safe()
is not thread safe so causing a risk of an infinite loop occurring as sk
could point to itself.

In addition, in bt_accept_dequeue() increase the sk reference count to
protect against early freeing of sk. Early freeing can be possible if the
bt_accept_unlink() thread calls l2cap_sock_kill() or rfcomm_sock_kill()
functions before bt_accept_dequeue() gets the sk lock.

For test purposes, the probability of failure can be increased by putting
a msleep of 1 second in bt_accept_dequeue() between getting the sk and
waiting for the sk lock. This exposes the fact that the loop
list_for_each_entry_safe(p, n, &bt_sk(parent)->accept_q) is not safe from
threads that unlink sk from the list in parallel with the loop which can
cause sk to become stale within the loop.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/bluetooth/af_bluetooth.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1aff2da9bc74..5d3698170004 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -163,6 +163,9 @@ void bt_accept_enqueue(struct sock *parent, struct sock=
 *sk)
 }
 EXPORT_SYMBOL(bt_accept_enqueue);
=20
+/* Calling function must hold the sk lock.
+ * bt_sk(sk)->parent must be non-NULL meaning sk is in the parent list.
+ */
 void bt_accept_unlink(struct sock *sk)
 {
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
@@ -181,11 +184,32 @@ struct sock *bt_accept_dequeue(struct sock *parent, s=
truct socket *newsock)
=20
 	BT_DBG("parent %p", parent);
=20
+restart:
 	list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q) {
 		sk =3D (struct sock *)s;
=20
+		/* Prevent early freeing of sk due to unlink and sock_kill */
+		sock_hold(sk);
 		lock_sock(sk);
=20
+		/* Check sk has not already been unlinked via
+		 * bt_accept_unlink() due to serialisation caused by sk locking
+		 */
+		if (!bt_sk(sk)->parent) {
+			BT_DBG("sk %p, already unlinked", sk);
+			release_sock(sk);
+			sock_put(sk);
+
+			/* Restart the loop as sk is no longer in the list
+			 * and also avoid a potential infinite loop because
+			 * list_for_each_entry_safe() is not thread safe.
+			 */
+			goto restart;
+		}
+
+		/* sk is safely in the parent list so reduce reference count */
+		sock_put(sk);
+
 		/* FIXME: Is this check still needed */
 		if (sk->sk_state =3D=3D BT_CLOSED) {
 			bt_accept_unlink(sk);
--=20
2.14.1
