Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681346-5-16989074494188261259
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
    t=1517681346; b=aAO2NpDM7h/ycoXVlGrn7hmbLxC5Bc07xoEH91wYCpxpgqU
    YASdA3vtPqU/y3kzP4jWV83J3clAk35D9JMfKrAmAJ20TSUz8m47M7VKIgVuAXsZ
    xnk3nr6Lm8tWuo7Vkvx/NrQLsDu5PWTCeM7VdozAJDiPOcq6N7GwsOOURlBGcuS9
    Yr4EN4yJ28Jv7C/7M4t5EaiDC0ppcxoCvCABQE+HZcSRLS/XrFMay0nGmQR9MvSl
    a8nDDqeXId+nhEvm/8U/OTppdHiD0pqf2/InHx4S+2dJ9RFAtdpU7lkgzbQqIia9
    JaSLDmUXbJy1Wmap/qY2CKjm5raHg36QnMrYSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681346; bh=qBr1Q4
    7XrrOh/bU1RnsEpRvMXGhz1EpHVxJbNSAuvYc=; b=Nin6twzyN4eWIMbuSD3s6B
    Yk5UPwo1FmaTGFHTYDkSYQZiQAIQAlVpznepCf7BPh2JksTQp9is00DmX+j5D+SQ
    D7I5t501YNZSJ17pJw3WuTw997qSleoP+UQ1fnqVa29aQ6CDvmoIdkBvWXAz+8vl
    7bR8w7wKbQJJPJ+qYe6W7fCbgHCPaeP5SI2CARNN9oVTuzrGtktTfQ+6N0/HXYWF
    dRuSqCRXhtYNqL8RZB7kgrK614v+8Bc8TMGVgcMvcgaLYLFQ8vZP4Zt7avxdD8e8
    1+x3KYMl2ybkuKoV7UBsLdmp9hWosZNCsHBHcM7wh6IZZnCfdRzUXOj/AFh9xIUQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KBrb305H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KBrb305H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbeBCSI5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:57 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:39758
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753578AbeBCSH2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:07:28 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 23/24] sctp: make use of pre-calculated len
Thread-Topic: [PATCH AUTOSEL for 3.18 23/24] sctp: make use of pre-calculated
 len
Thread-Index: AQHTnRmI54HiCNbYwEie3UojUTG8UQ==
Date: Sat, 3 Feb 2018 18:05:10 +0000
Message-ID: <20180203180444.10801-23-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1025;7:ofSPbXSOaxQ5gmmHUcv0N6M0cmZFQMS7gc6UHCznR1cMB3cFeOMMy+pJm0rcRAjUtGaiucWBa1/yYxacc1bG2oPai4Knj9cAyiE67JlzQeNiC1Vrc5EKpJkj9jSvp8i0tZVXwJn0my1LZ8Kdz/QRXq5EfBnhM6NHcj7H6Ypd+k0GHyLknB+XbwRXx972eU0YfW+sjGNvz6qJAvWJ6zueTDNiCV5hqpBpJS2Cj5BbatX6jajl32M4r0k2M1Hi2sK6
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3082a1d-317d-44c3-06dc-08d56b30e43a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB102584D089C571ABA9253D60FBF80@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1025;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1025;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(6506007)(97736004)(86612001)(6116002)(3846002)(1076002)(76176011)(2906002)(26005)(6346003)(68736007)(102836004)(186003)(72206003)(2501003)(66066001)(2900100001)(53936002)(6512007)(14454004)(106356001)(10290500003)(25786009)(8936002)(107886003)(478600001)(6486002)(81166006)(39060400002)(4326008)(81156014)(8676002)(5660300001)(5250100002)(2950100002)(3280700002)(7736002)(305945005)(36756003)(6436002)(6666003)(3660700001)(105586002)(110136005)(86362001)(575784001)(316002)(99286004)(10090500001)(54906003)(22452003)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: l9fWjrnaynardixHe47bQgzDe2PoreMztirUmdpLOAlVDhvt0o9t8amTTzU3oIVFjk1mDZpHNnghv59N+debfg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3082a1d-317d-44c3-06dc-08d56b30e43a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:10.6746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
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
index 06d9626a1678..225019397bc6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4458,7 +4458,7 @@ static int sctp_getsockopt_autoclose(struct sock *sk,=
 int len, char __user *optv
 	len =3D sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5035,6 +5035,9 @@ copy_getaddrs:
 		err =3D -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err =3D -EFAULT;
 out:
@@ -5471,7 +5474,7 @@ static int sctp_getsockopt_maxseg(struct sock *sk, in=
t len,
 		params.assoc_id =3D 0;
 	} else if (len >=3D sizeof(struct sctp_assoc_value)) {
 		len =3D sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5635,7 +5638,9 @@ static int sctp_getsockopt_active_key(struct sock *sk=
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
@@ -5647,7 +5652,6 @@ static int sctp_getsockopt_active_key(struct sock *sk=
, int len,
 	else
 		val.scact_keynumber =3D ep->active_key_id;
=20
-	len =3D sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5673,7 +5677,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct so=
ck *sk, int len,
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
=20
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
 	to =3D p->gauth_chunks;
@@ -5718,7 +5722,7 @@ static int sctp_getsockopt_local_auth_chunks(struct s=
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
