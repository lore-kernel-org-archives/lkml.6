Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240152-2-8932073211637652425
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240151; b=CSFNXwaHJTc/od0SgxxnFLnvuGynn0Vyzn2/h2zfGzs4LgqjYZ
    r2rIYdZ5BivSCVquGn71Jc385JdCDkGxR3EX4lvcrMTM7ABvLju75Fp4l01g59MJ
    H5FbqQfEgrVJCbORf+77x6KxwWUUTLE5d62PN/KeZxaLw5JNofatLWhe/ZpHW4Tv
    y02OSAXcbro7nTTYFFUIBliJmYtyPIrIFHjThK1FymXR4X4ZGoVoUY0x4naN2xVX
    /2MONSgMMVye57dad9oQX6JFLkk/kfYrXtCvUDp5IwLu7WQBpYxU/C0D1X4ouY2j
    UKtoJv07nt2BZMrpeUPvOxqld9tGwkKqYLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240151; bh=qIbc/BZ7sP
    tc7m/ZlgB6XlhM3+gExiQkZtplwRjz4VY=; b=ARWG3fpa+Fgc1rI6pk5jzP9DOQ
    UvoPvuEzxNrSXA45q0yrPi8mdV1N4eehNZ0Y0uIoxike1vw5Iw9jFV0EI2GGpnjV
    inN2W8mPmjzuIQ8yfHLMzlLiJfWNJ0j3iEHQnLAW5gNc8iEPYmvsPqjaoZgbZgNh
    qSkMGUCOTHEB3TrcCEo4AqZnimJynw+/spYt3jZV8lwEDYq+CVZAw0+1R2MDW0CJ
    pUgMwV3nCoGfj4kdSQmPSzpx4XscxkdMJ19pFmb3Hj6dUupggcDJjTJLN+4el96X
    wruUUTpBoXhbOfb4sLxR0IrfiBDEF7gyinFnc9mwvCERPPZSzKOZ2eqeHgdA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ppz8GjDI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ppz8GjDI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGOI/TrDbSUw9CCFVbZ1KZsl8e8qnshu4TbwW861iTuKHmNJXlwKMlg6GYo1oUyhsEVRM1hrS3FIfYX0uUbg8gAmjdUVBXXVVLtqTdhUeJuT2eLhJ5iK
    KglIgTfJ58L2jWUsvdP5qsxhP4AL5jtisubI6LyprfGn7wp3hNw9hIIGXU4zR/Q6v7TJDzcGZUPEGDXkauDz99yPA+BXNKAJF0doH7ma37yNm4DCWs9LweN2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=Zpl72FV9JOtj03B-N64A:9 a=tKdapozv5oSVPNbD:21
    a=Xcm1s4lnTE2yRkDo:21 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeDICPO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:15:14 -0400
Received: from mail-dm3nam03on0093.outbound.protection.outlook.com ([104.47.41.93]:60032
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756107AbeDIAaf (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:35 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mateusz Jurczyk <mjurczyk@google.com>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 143/293] af_iucv: Move sockaddr length checks
 to before accessing sa_family in bind and connect handlers
Thread-Topic: [PATCH AUTOSEL for 4.9 143/293] af_iucv: Move sockaddr length
 checks to before accessing sa_family in bind and connect handlers
Thread-Index: AQHTz5kotnHqDknhCEixYxwFMqGesQ==
Date: Mon, 9 Apr 2018 00:24:44 +0000
Message-ID: <20180409002239.163177-143-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:uTnPIqsSyc2235+Ikq+1kqTAR7oM21VAfrh9WvUSJGL72mQPs60uzW1Br0E3oCtVwwcDpKXc/AjY4RGrsT++SwtZX9LXXQcbmtvQDRmM2MqfN3TYxcGfp2XLab2W6i070rAISIB1p6yEp0H4YQxNn+zegvgrNY5QuI3TAeXbAoQVoKO+0Oke9iti0Y5fJBjqOdJNKZzaZgDAsxV7qBrTvEwK9uGM2erm/5i/dAHogfLzcJT9Rc6TWDTw6IPhUAjP;20:w/dKLY6EUAgh0sn2zwQIpZYsb7m8EipuToVq9ZypnELD7ghjC3bidZG503IVlt/MRynchB5pAwvemW4h4uqO3NYTKXH795L3Zak2A+l1WwrRWkhJGXcq6xBTTNhnadwq/+weJizN9T6IByGWGGl9BROvlWYnj4/Hk1zeRnE56JQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d5d6eed-bd46-4a98-a368-08d59db11946
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807CFF2E48FF326792C0B9CFBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(104084551191319)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(59450400001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: buG363QraJXpqMVgQvEUh1TjeS4rFLVdA5AKreMjEYzqAEjhdvv1euCOFGOvDbuHSn8lOZE5sZ2Uon3cnxbCD4QSn/USEkwgn7heCxs78wn5YHx/lt/qVeWnlc2Q/8EmIuZxUtfuZnTKwurh3Ed8+DqjGz6vAGTOCKMqXcn8etFsnGwaFVDO10xi27SK+0ATBuYQJ6JQrGmdnw3LG4t7kFvfZZX/fKNwEM4KJ4v6tReE5QtY27JElWK9ZDPaPGCRnhGpsXTp7hSHx55oJi7F8+88Yot0ewC91eKBHTHtYS0smKtrNaY7dcMKOZcRHpj5jyXgCtGXkXnZ87LaMQm+sX50lJtXTM6qMZbZEaZnlD3NaWmALTOM/UmBqA9Cm9DBMIszF7njEnCliZt4t0/GrBHYQQBuNKwlK6Ds9IS2g04=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5d6eed-bd46-4a98-a368-08d59db11946
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:44.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
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
index c2dfc32eb9f2..a69003fbf5b9 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -708,10 +708,8 @@ static int iucv_sock_bind(struct socket *sock, struct =
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
@@ -855,7 +853,7 @@ static int iucv_sock_connect(struct socket *sock, struc=
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
