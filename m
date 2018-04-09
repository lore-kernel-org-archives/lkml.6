Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523237066-2-13944537198016605454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237065; b=EWxfxiWITn4abCMqk9GGt0OIRKFYt4xaIVr+IE0CWknX5hr0/X
    KnH8WDy9PDXRP2I4Yr3TIzBRJdDgCLeN+Ri1PP8X0zHl46EZOoSNS6zxo7s0OJuj
    SZgyzpFbnL4hqrykTjB1rcVmcuRmKPKOdfpYKbjP8GVjVHDdCKdXffXg3Q8PpB3E
    d6e09PHSRwNbxLlulrHHmcXA6g5pJRLgqu76rc0CH0h924NlPeYY4d4o0f8py/Pm
    P58nk+ZYedZTdtEnKMbjbmSlzx/MsbsUVDO4BL+jfAZQNaQ3dhuSIfmzddl5+WAj
    PGDaEI8RZ1V+jmXOKn5T8YYLd2L5fTuniyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237065; bh=4qe8fiHPx4
    ephX7oD1NezBoHlnEHVtHancXnAgUDM3E=; b=Vs6NJO56Pmt6d2+7QzJl5yfrtP
    2UwGCygLCcN8p3oa4AG1hpIr6CkAHqL7iMImkrU5uJIJ2YB2gWuudIJTrcHmLRcw
    wErSwFtBMsnqMYXa9potz41KnTzHwqfzMK2RR0SBOQtrafl5+0wVGga5UFrnAeYN
    g4hDC7VsXCQ4h9rKnTSiuGOuvy0V1iv+83NF8eWNYlLa1dPR7GeoPfXC4XHKJ6s9
    YmDbozWFnLxc8hT97zCsoi5VTB95ZmXY9miUcdGMTS4WfX0ZVqVbIUwx11VuOO9Y
    zJRXwEvKGOeuKCYB+se5cialzRoeObYSPMPN9HCQgEo7kvXKnK7cShJVT9mQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IwUIki9V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IwUIki9V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLTNSnz9KvDonnmz2lF2Tfe5a3WDQsqoVFnzLiRjAXVYk028t3n8uyYOYz9Z1nKDW4pwvEKY8Yq1+IFX/D+zXWOcBD1gEkPnsiMCoaj9fyj7kiWFYlxm
    +bhpg0lKzKTcsrtnm+ZA6w7fn7cTg94/vitUUf2hgm4GadGtbR13ru8EjmK/P2GoZuYdMmwq/GP7EJp226y2Vh9QlP1S6hPcxEo5AG2aylujgPRCrW6yIh9v
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=Zpl72FV9JOtj03B-N64A:9 a=tKdapozv5oSVPNbD:21
    a=Xcm1s4lnTE2yRkDo:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932706AbeDIAg7 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:36:59 -0400
Received: from mail-sn1nam02on0113.outbound.protection.outlook.com ([104.47.36.113]:53303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932682AbeDIAg4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mateusz Jurczyk <mjurczyk@google.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 070/162] af_iucv: Move sockaddr length checks
 to before accessing sa_family in bind and connect handlers
Thread-Topic: [PATCH AUTOSEL for 4.4 070/162] af_iucv: Move sockaddr length
 checks to before accessing sa_family in bind and connect handlers
Thread-Index: AQHTz5mxYAFzkFINdkWAkJcjZpqzUA==
Date: Mon, 9 Apr 2018 00:28:33 +0000
Message-ID: <20180409002738.163941-70-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:i/Nfy37XWzdMgf7vT3s8I/TM2MX8bdrlwGmxMV4hQLG1/brR36nJH8ouwXDYSghcNO5FZ9Lscz/O7b8B43GQn69HbI/8LPM3/kmslUpMm8X1zcj0YZttRGyuPZ/03G/cT+/nHwPFcrxkeIhTKWQd6p1xXCykk8u+U1TcB3b5F+NicvZeNvqnUcDbnEA1xnO36h47VZQF6oC8jdMoSaRU/Alsw50MEzwaHANkD+R1b8ITYMnKeU5gsoEo4X3OCPwA;20:CwuqXD1jWa+hTjU2VlQ9tLJh28gv7oPscrmn/W57l0PI65h8Ieabj7b49FCHqjA75Ek2KXk5nIdfXldhfkGDJ7w9ctraRYOmr4KN248teeR6kJHjUMSO0VmYYg7EvwIqBIs5DLmSG1r3QmE7SNNoSarM282X2gHbNq5RwdKiPLs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebdb365a-433b-4d92-3b32-08d59db1fb93
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08855F5B364DB30FFD167659FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(104084551191319)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(376002)(39860400002)(366004)(346002)(199004)(189003)(66066001)(3846002)(6116002)(59450400001)(86362001)(305945005)(10290500003)(6436002)(5250100002)(3280700002)(10090500001)(3660700001)(6506007)(2501003)(107886003)(446003)(53936002)(11346002)(2616005)(26005)(76176011)(7736002)(478600001)(476003)(81156014)(25786009)(8676002)(81166006)(186003)(8936002)(4326008)(97736004)(102836004)(99286004)(14454004)(36756003)(6512007)(316002)(2906002)(22452003)(68736007)(54906003)(110136005)(486006)(6486002)(6666003)(5660300001)(2900100001)(1076002)(72206003)(86612001)(105586002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MDme4cpkD9fsEaPld5brLCRGHWjpgzKORRt7YTWTvKwz2Y7wUKFZDNX93UB9ffJb+lVZBFLjemXctLjWybxgmWC5yc0P0fSBGT7xQgqgliVjQ0bBZm0MYjCQHEF9Qr3ipkBVBkPmEuOPS6gmYhYOnNNDjrizJ38HIX4FwEIEEhL/TaxpD+q82hUvcPQmEGQAsluKv3uOdkhZocXSd/iaGwFZjBucgvywmHrHYU+I3fXkNN8iQv/GpawAOoSkLVcc8qccVrK0UunstZH1K6WMgLR6qPmzmFaHxgvWz0AOkjrywJdwGLTVtJjGYghiVvC7rwibKYoA3Yg9GSI6Y94dFzYYr8uD9uWtBD2CjHSw29nvIQr1hzRsodYWpTEtZnamXODBZ9qW4CxS/eihpjjgK4Kv+eJC0ggXhY7GUvnQi/Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdb365a-433b-4d92-3b32-08d59db1fb93
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:33.9739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mateusz Jurczyk <mjurczyk@google.com>

[ Upstream commit e3c42b61ff813921ba58cfc0019e3fd63f651190 ]

Verify that the caller-provided sockaddr structure is large enough to
contain the sa_family field, before accessing it in bind() and connect()
handlers of the AF_IUCV socket. Since neither syscall enforces a minimum
size of the corresponding memory region, very short sockaddrs (zero or
one byte long) result in operating on uninitialized memory while
referencing .sa_family.

Fixes: 52a82e23b9f2 ("af_iucv: Validate socket address length in iucv_sock_=
bind()")
Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
[jwi: removed unneeded null-check for addr]
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/iucv/af_iucv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index aeffb65181f5..5984cc35d508 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -705,10 +705,8 @@ static int iucv_sock_bind(struct socket *sock, struct =
sockaddr *addr,
 	char uid[9];
=20
 	/* Verify the input sockaddr */
-	if (!addr || addr->sa_family !=3D AF_IUCV)
-		return -EINVAL;
-
-	if (addr_len < sizeof(struct sockaddr_iucv))
+	if (addr_len < sizeof(struct sockaddr_iucv) ||
+	    addr->sa_family !=3D AF_IUCV)
 		return -EINVAL;
=20
 	lock_sock(sk);
@@ -852,7 +850,7 @@ static int iucv_sock_connect(struct socket *sock, struc=
t sockaddr *addr,
 	struct iucv_sock *iucv =3D iucv_sk(sk);
 	int err;
=20
-	if (addr->sa_family !=3D AF_IUCV || alen < sizeof(struct sockaddr_iucv))
+	if (alen < sizeof(struct sockaddr_iucv) || addr->sa_family !=3D AF_IUCV)
 		return -EINVAL;
=20
 	if (sk->sk_state !=3D IUCV_OPEN && sk->sk_state !=3D IUCV_BOUND)
--=20
2.15.1
