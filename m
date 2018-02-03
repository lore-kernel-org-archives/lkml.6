Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1486374-1517681212-2-9305413441302151849
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
    t=1517681212; b=uZCX88SNndYbupyNQf1YBPwScZTpFgMNLdNKyHChT5glwOC
    nGdo0ciM2MoaOuCT1HY8Oovs/tXPTiuM6Ifm4KnbZvwIzcg6Us3RDl/DKqgqVkIc
    IXpeuu44KdNvjq9oVcl8UfCuV1W0fyMmITpkJQ4isw0YUruYQUacqA3xaNpsbtC4
    6UJUtAnHgFZc6yY7dEamUOgVgpAcHKnrTYo/cOugcUFj3fHcRC29TDA6njDcJ+xz
    cndWJHb1Gp+M33Fw6812fMa0P/AFnOcGUV9woJLUAEv69yT6lRl2APLND9Ohvs51
    P+7iFQQrxIk3Dktb/7zcEQz0Wze4XFEZF1f4U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681212; bh=9LAAjA
    gcsETiPWLuJdgUL2zXmnPrp4xn8XzeBszs1vY=; b=lu/qiLjAkRhMLbwAnXvaHO
    z1hsm//NxrJwHjrf1oQhpiq3yI76nM8mkLmJznPKHjeqUgut9Hr4ZyGJwaYfqE3z
    EGDXMIM0mb/G4I+r2F6RpEGSdofbk3/5OuDzP0Mj2o1Yq1GdNTydDHglDPFSXES7
    PkOIOfbfTYmwM0B6pVtB5jAhuhCopcODJi6kicaoVzHpEQjTvn12i00u1BXVS2hJ
    Z905RUadguTzbeKFUVyc9GkR5SEm0Yo/KYcKb4D/0KCAa9JfsjEdgaVnwOhYDPmG
    vyc/syY/m2xzg7BDlYKACwdonfkLrBw3EoKDpSckkmFnrWGr/VDbHAv3hY7fozOg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z+ab/ZEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z+ab/ZEv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753475AbeBCSGk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:06:40 -0500
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:52828
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753399AbeBCSFj (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:39 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 51/52] sctp: make use of pre-calculated len
Thread-Topic: [PATCH AUTOSEL for 4.9 51/52] sctp: make use of pre-calculated
 len
Thread-Index: AQHTnRleZ9woFXJLAEyffMTx0sUprA==
Date: Sat, 3 Feb 2018 18:04:01 +0000
Message-ID: <20180203180303.8490-51-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:SlKzGdQwsbyuBdfJLkVg1i/3ptMc9tjDgOwLNcXNEUgE/N6/QqhBiyEmhjpxZ4/oLRPdRFlxJYJGge2FPQRi6DUfefOpVHeTQUcxQBJAcWTEhaZWyDL3jQDP+v/UWR4b9MSdbNK8CwrORxtZTdcfoKRO7IK/C1v/47tb0sTkYMCPvtDKrfdq1U3nNhdSZCVNzRahbL7luZUrUHrtuHTnJUzx5pwg+GV11II9yiibQhUVvSERE693oo6DDn7IQWRT
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52048eec-bd5b-4ba7-e496-08d56b30a41a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB1089B38C195BD7CA4080729DFBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(39060400002)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(21314002)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: mbQr2nxiDPch6NUUlS34AfzaKh/QcWNjY9QHm/Hk5oP7i3YFRdW13rU/iCfyoWowbijAXvhsUnxQOjfsXw+GoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52048eec-bd5b-4ba7-e496-08d56b30a41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:01.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
index c472b8391dde..019e3b27a061 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4756,7 +4756,7 @@ static int sctp_getsockopt_autoclose(struct sock *sk,=
 int len, char __user *optv
 	len =3D sizeof(int);
 	if (put_user(len, optlen))
 		return -EFAULT;
-	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, sizeof(int)))
+	if (copy_to_user(optval, &sctp_sk(sk)->autoclose, len))
 		return -EFAULT;
 	return 0;
 }
@@ -5333,6 +5333,9 @@ copy_getaddrs:
 		err =3D -EFAULT;
 		goto out;
 	}
+	/* XXX: We should have accounted for sizeof(struct sctp_getaddrs) too,
+	 * but we can't change it anymore.
+	 */
 	if (put_user(bytes_copied, optlen))
 		err =3D -EFAULT;
 out:
@@ -5769,7 +5772,7 @@ static int sctp_getsockopt_maxseg(struct sock *sk, in=
t len,
 		params.assoc_id =3D 0;
 	} else if (len >=3D sizeof(struct sctp_assoc_value)) {
 		len =3D sizeof(struct sctp_assoc_value);
-		if (copy_from_user(&params, optval, sizeof(params)))
+		if (copy_from_user(&params, optval, len))
 			return -EFAULT;
 	} else
 		return -EINVAL;
@@ -5938,7 +5941,9 @@ static int sctp_getsockopt_active_key(struct sock *sk=
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
@@ -5950,7 +5955,6 @@ static int sctp_getsockopt_active_key(struct sock *sk=
, int len,
 	else
 		val.scact_keynumber =3D ep->active_key_id;
=20
-	len =3D sizeof(struct sctp_authkeyid);
 	if (put_user(len, optlen))
 		return -EFAULT;
 	if (copy_to_user(optval, &val, len))
@@ -5976,7 +5980,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct so=
ck *sk, int len,
 	if (len < sizeof(struct sctp_authchunks))
 		return -EINVAL;
=20
-	if (copy_from_user(&val, optval, sizeof(struct sctp_authchunks)))
+	if (copy_from_user(&val, optval, sizeof(val)))
 		return -EFAULT;
=20
 	to =3D p->gauth_chunks;
@@ -6021,7 +6025,7 @@ static int sctp_getsockopt_local_auth_chunks(struct s=
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
