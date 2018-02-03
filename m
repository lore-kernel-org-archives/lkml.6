Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681648-2-11800884016721375730
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681648; b=bkvPQduKJFoY60nrt6EJOVJaBSGgtqA5Rubbvef3E+P+D3F
    OgaOwm8hYnXcKRre6sOnLsDp/YMFwWszxm5PKV9gS/umGKTl0vzm0dukEPY2KDkm
    D2wFas88GHmCXATbNsz2rhEJdvOXs2NazGm9Aj28OtKsTl1FwhMPBc7evNjD+XWc
    g19HAmn4Wc8TQ+e4EIVAfsSNuFFYTH8QXcS/YYlDOR5VyXTzjqGOzNsT2NPqS9dC
    AH9AdPddMVTMj/Uk7sFQmuuYFyLWtrD7ZUPnWenZECtInhQIRdG5KbNgwinxKAta
    jsip+xMkz73pMouDxHPg3Es9j6sgGAQ9zE6ANMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681648; bh=butHat
    //8/SgKDJFO4XpqC5Wo797q4ajwvzhhksrmCY=; b=nt+bBgN7d8bb3YxSUqeZ1/
    a9w2owT/4QunNJIRTGau4PhZwWMx4qvDDtfXE+9kr0P2MJ8HVVUQaIBWY8QiEQoT
    +hYTHqaHeWpu/U2ppceO+ARtlDkP6IqQhiMp65V7WxUd8iOli3cpwRroDePqolrN
    wmG7X9hFJuiEMW6Kggp7GEXzeYf5RnzrILGNz/mkgoAN+ehY/RuO0tHCxT/I0HLT
    WXE7gmbfcefqGN4CPbZIbJW/MylhRpVlSH4POoTre8MMMbv+YvULsRpLuO8NrqT4
    GNL5qUQg7Vm0SGJCBRGsLOE9KF+hoDje6AbfOVrV9n98p4TFUpg6ugEv6H14YFYw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fzwzx8dH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fzwzx8dH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeBCSI3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:29 -0500
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:59967
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753554AbeBCSHS (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:18 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 31/32] sctp: make use of pre-calculated len
Thread-Topic: [PATCH AUTOSEL for 4.4 31/32] sctp: make use of pre-calculated
 len
Thread-Index: AQHTnRl22Avb4klrD0+KCwTSlA8CRw==
Date: Sat, 3 Feb 2018 18:04:41 +0000
Message-ID: <20180203180413.7438-31-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:/laOHvgGGZhOHiDoCWwkNH5ASDDEvZWQCA0VrbJz+8l+nHr/b6iK89pxX4LxVBQjZHtv+QPXasqPwZSoe3SqSV169mMgc/BeI5A0nme0Q852ZsZWZMEoIRXO5parwoI6PYDFKUvDoty68iYMe5TGLVQIOrjQD3DRArfx50k1RGjykAvdPPoew9kwXLhB/qffIj9HaaO5KHJJLHQB5PqbZl2tp1J5k10XxGYqMh20hB0s9QCPLNe2xP4tLC9JAX23
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 185abacd-95a8-4a89-0760-08d56b30c95e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009B03A4C65E04FBA3FF40AFBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(39060400002)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(575784001)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: a1/8SASLqaj2zrE8jl9odox2Ul1dFI/hgtJEQ1xnq9YHAP9/9V2R4bQ5vtb5NNA5HxBr+gjGpQrTpWBJk11T/g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185abacd-95a8-4a89-0760-08d56b30c95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:41.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit c76f97c99ae6d26d14c7f0e50e074382bfbc9f98 ]

Some sockopt handling functions were calculating the length of the
buffer to be written to userspace and then calculating it again when
actually writing the buffer, which could lead to some write not using
an up-to-date length.

This patch updates such places to just make use of the len variable.

Also, replace some sizeof(type) to sizeof(var).

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sctp/socket.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e9851198a850..df6a4b2d0728 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4445,7 +4445,7 @@ static int sctp_getsockopt_autoclose(struct sock *sk,=
 int len, char __user *optv
 	len =3D sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5022,6 +5022,9 @@ copy_getaddrs:
 		err =3D -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err =3D -EFAULT;
 out:
@@ -5458,7 +5461,7 @@ static int sctp_getsockopt_maxseg(struct sock *sk, in=
t len,
 		params.assoc_id =3D 0;
 	} else if (len >=3D sizeof(struct sctp_assoc_value)) {
 		len =3D sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5627,7 +5630,9 @@ static int sctp_getsockopt_active_key(struct sock *sk=
, int len,
=20
 	if (len < sizeof(struct sctp_authkeyid))
 		return -EINVAL;
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authkeyid)))
+
+	len =3D sizeof(struct sctp_authkeyid);
+	if (copy_from_user(&val, optval, len))
 		return -EFAULT;
=20
 	asoc =3D sctp_id2assoc(sk, val.scact_assoc_id);
@@ -5639,7 +5644,6 @@ static int sctp_getsockopt_active_key(struct sock *sk=
, int len,
 	else
 		val.scact_keynumber =3D ep->active_key_id;
=20
-	len =3D sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5665,7 +5669,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct so=
ck *sk, int len,
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
=20
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
 	to =3D p->gauth_chunks;
@@ -5710,7 +5714,7 @@ static int sctp_getsockopt_local_auth_chunks(struct s=
ock *sk, int len,
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
=20
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
 	to =3D p->gauth_chunks;
--=20
2.11.0
