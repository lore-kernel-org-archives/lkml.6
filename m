Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1086562-1520490727-2-15480871654956682616
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
    t=1520490727; b=OHQJ1NsI9Kah5eeG4S3g3RZWgEsrPIktvokzMfZg3pH4r2k
    N1jZZeqqL3i4R9PHAOfEiFCpCKbgKBtljY/W287p90LgBFL/hOUxa99tFkZM2cyO
    JE3jkHIsxTA2bEIHMZBwKBPRD7ccRyLAZF0XBIw5ScwQ+UM1SPuj5p6PjxNz+gp8
    3Q9JoOkHkTaj2XyH5yRaND42mNk1Grl22VEn6QnNmCHgXwAV8C0Eqx7g09sO20DW
    uMHbpQFlbEHyoOoTqNNDCZDeLbO5+zrcRO8C3iTp2Yz6fr+6+OejR+K7IQ+BJ95B
    cZl0Zgo8JbzTe6NvGiIqqkHLMK3u6sRM8HzDTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520490727; bh=nk9wAc
    bVlykb6VlGB+TiM3SGTjuyLYEq09S2MRfNYyk=; b=sKTImeD94+itSoP1WFR25k
    QV6T0gu3Q6BFOMn4Wp+G7pY/83QtggYqz1QutDTh04yIhO5mQgXZg3AevJsGePg8
    E9lL+cXIS19jjDVNXw4HrQRDBGOtg3DA2mvNdOad2QW3h/Hg47KptsMYKXaDtvWj
    HSXr3FXQEqRWpy8ndHv7gPGRUfZQzJusUycTmFGSOrhq4i6FZf+3/vSDEQwQ6kxG
    lJ/G6j/jlkdfBblAe6IXlhax9/KW6tDX80O2w6fwky3KELbFQFZelNFhVwGsYxqY
    jugOngRbN81QyzxFoxhfx2FakAK4SPGv+I+VJ+TXq2aFxrJC4LRS6wsRLnq9f09Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iD+mWYTU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iD+mWYTU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCHGbV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:31:21 -0500
Received: from mail-bn3nam01on0114.outbound.protection.outlook.com ([104.47.33.114]:8240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965578AbeCHFAF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:00:05 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 017/190] Bluetooth: Avoid bt_accept_unlink()
 double unlinking
Thread-Topic: [PATCH AUTOSEL for 4.9 017/190] Bluetooth: Avoid
 bt_accept_unlink() double unlinking
Thread-Index: AQHTtpoqWwKDoLGBU0q7HRPXnSDV+w==
Date: Thu, 8 Mar 2018 04:58:57 +0000
Message-ID: <20180308045810.8041-17-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:LLTt3dSi7ZN08E9i/UQHkALZfQL9AEF4XoBxR6jMHC0Dt/y0forgsMfFjdsQ9PuyidTbbayYdszzcQlHJoTA498LLMb9tz/CsUOMS9Dwn5TfpvnUK021MCmEXiggG6zoRaty4C7m4HvVyPQZo1Ctg4kznZJqs8Tsmfs7h/zk57oM5ns+ZcbJ5sf6US/dli6l7YW0CyJNWIJLIWvEAp/ob9gCcW2NN6xuxusVsGoeHryyMaoHvbvxftW/HTgK8tR3;20:ZqKdh78Q76Y3vxzxmMMJ/7Mir74b5ypnPBonsP/DaXzs9sgC3IAZVwrw2I8znWEeRW0qsZkzZScmpfXo3LvAqjpo0Mku5YdI3Ok/0gFzl7oTPbtJiZGoGD1KnDGMFRbqmN06ApliIJCJ1VCqo34CICPqHO/GctIgEGc8YyIbCP0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94a052dd-ca8d-4e7f-5c57-08d584b1714b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09839830220CB2B7C960190DFBDF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39860400002)(39380400002)(376002)(366004)(189003)(199004)(6512007)(22452003)(54906003)(3280700002)(186003)(316002)(6436002)(110136005)(8936002)(2900100001)(10090500001)(5660300001)(99286004)(6486002)(106356001)(86362001)(575784001)(97736004)(7736002)(107886003)(25786009)(305945005)(76176011)(36756003)(8676002)(6506007)(5250100002)(105586002)(10290500003)(102836004)(59450400001)(26005)(1076002)(53936002)(81156014)(2950100002)(14454004)(81166006)(2906002)(68736007)(478600001)(66066001)(3846002)(3660700001)(2501003)(4326008)(6116002)(86612001)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cP+M8lmKqMfywRcHS8HA0g1XK+UcfbOXytYygK+uh7ZxAB+S6Gb+JML7JlnM7Ekhc4s+qkpBqk3sgu5MMR3NGUVImU1WZ7UoaYTz6If1zSX2S/Jzvsk2KlStSH6MmXRKGKNMk0LaihLjzj9koLhZ6dvdiVIFDFF51JT/AyRFxmx6fCXmzTKMH5VDV0uyg/zdKjOvwyWPUIGv+DQdRdVS0nT213E5CZPGLN8ShdNuzMN0gSH28uZevlrZDxofbOdIvpM2Ffu0Bks0cJvKiX7OqyUBRYBhhPegpm3i1Dza1vYHWRFq6lWln+a83QD7BWt54yNJmvzVZ+hKRuZOeDlUWQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a052dd-ca8d-4e7f-5c57-08d584b1714b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:58:57.5091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
