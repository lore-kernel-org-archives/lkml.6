Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682580-2-3382964625345992512
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
    t=1517682579; b=CuiA02/qi3czQNZprcMukltKdwPxpIhqOHV7+HJWoAxgBCN
    kMSUDCx9UR6ocEunzQN0WJ7fWef0NfiW768UP6BQ73XsoLgzjgwfy8temqQLsSOl
    fkOtOJnIdtdTsDxK9qo+FJvOun2rithnzOxukdw7CxW+h8f9h8LCzCOWUJh01JRL
    GGMhXO5Xeu4C5KkKZ7KVbdJKWWN7O5k+WtqfeGYiYo3dNHbIR7cznxkPuXeXCtUk
    QCNWQmwajrAiT+mHwyfTDWEv73jzZtBDn7+Tz/dQoGfn2OAP+0MxsQG/EaV2fCLB
    GRiOkwyq9ign1hdVE1/+0fhc8jVz3i8i87LafIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682579; bh=vc1q+5
    RPDAul2ZBJZWg/boVLcRjiFYZSSb923mXxmbo=; b=F9uMtmbL1Yz3GFfIcKm50z
    KORyJfae6msmrxgmNTFffXP1432iSnaCKmOshJN1mp3U1Dc7L+7lCkDNfieyPj2P
    UORafFUwUVIw1xg6BtghwZNItfP3NYtVCxfbh7inEmxGZuUs7Dq3cmB9TJ73XFRD
    erCfKWHEbSDqAId0mymv9ji3LSGcKppI/Wzk1U4Y753DIrvp4Wb2PZv8mckEY6DN
    uI1UEjTo2SzRD5UBDq2LRknNOKKb+XOK8gYPBu9ZRPasMKiRwUT2ZDdbk18dxWJW
    JNXJDMg3Re9Lrph0vv30nIhckVCoyBp5Ltnkqw/MNFSvSHiWUE4sc7+xEX6+lOVA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyzfeU7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HyzfeU7R x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeBCS3g (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:29:36 -0500
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:10688
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753035AbeBCSE0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:26 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 106/110] sctp: make use of pre-calculated len
Thread-Topic: [PATCH AUTOSEL for 4.14 106/110] sctp: make use of
 pre-calculated len
Thread-Index: AQHTnRkHPJIjJuHpsUCsjJ1wl9v6/Q==
Date: Sat, 3 Feb 2018 18:01:34 +0000
Message-ID: <20180203180015.29073-106-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:r022H7osyfH8PVaHklZf/hai+zHqx0sb3MqOaaPl95bNlXsekglkPzV/IsQuNkKxwOdt3esxD2A44FV2oDHeZytyoezre5dYj25knVmdQshtjYvnC94cIZ9Io4O+6qTf0L5XIPJyHonPlljdFA+Bt/BL1HkZgaaDPhwYBMtlgKaki61d1UO7OoMqwCz9vOF0LFos726HCDwTQcrqi1DOexkT3/x/LphI2BkstKdbaoN0asMBRIJ9N/cRR64YV/vT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb64639a-fc57-48fd-11f3-08d56b30591b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB09935B5B216585A08D8FDDE0FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(575784001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(39060400002)(54906003)(110136005)(66066001)(22906009)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 5QyCyFe0guWl03auGSDowv1Psp0g8D1QnHnfk+Y/QI7t5+ceKxV8Ai6mtPR29Ih+K/JusP7AyxJiIw/KhixVdQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb64639a-fc57-48fd-11f3-08d56b30591b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:34.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
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
index 978fc7d1cf53..53e3634afea0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4948,7 +4948,7 @@ static int sctp_getsockopt_autoclose(struct sock *sk,=
 int len, char __user *optv
 	len =3D sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5579,6 +5579,9 @@ copy_getaddrs:
 		err =3D -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err =3D -EFAULT;
 out:
@@ -6015,7 +6018,7 @@ static int sctp_getsockopt_maxseg(struct sock *sk, in=
t len,
 		params.assoc_id =3D 0;
 	} else if (len >=3D sizeof(struct sctp_assoc_value)) {
 		len =3D sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -6185,7 +6188,9 @@ static int sctp_getsockopt_active_key(struct sock *sk=
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
@@ -6197,7 +6202,6 @@ static int sctp_getsockopt_active_key(struct sock *sk=
, int len,
 	else
 		val.scact_keynumber =3D ep->active_key_id;
=20
-	len =3D sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -6223,7 +6227,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct so=
ck *sk, int len,
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
=20
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
 	to =3D p->gauth_chunks;
@@ -6268,7 +6272,7 @@ static int sctp_getsockopt_local_auth_chunks(struct s=
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
