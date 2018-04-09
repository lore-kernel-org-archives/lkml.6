Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237636-2-6286271323913862037
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
    1523237636; b=s097uvflFVbs1FwfNZW6oYqN8euEXZsURxN798VwB6PVfZByNa
    ZpMi3Rd6vM0eup5etGZdmsVpPIn5sjTHRKOkMpBTe3rTMjl7KWao0hLbaVqzhaIU
    qKD81yNifr4LqUjJ3QRAtetUzabac7DAEgOHGQ2LHGj7jzJSArJeguy9DOCGXfCu
    aKhuPF8yTNyhv/Q0e3S/M2jfPsnq7hAEOc68KXvGn6/7o1oFagBefOPR1kZAWtIu
    Jlbj9LigTU8CLlUjS8+ucG3IpxHZos7oPet+mAYqVSDNSOj2HLKCnmEPX8G77oLg
    AJl5BkfA/IWj6sY+5GSC11rwUxIKllctD1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237636; bh=pOs6kG4LvY
    QuWuMVvucKqakX39kwgmqLdGxM6rPtmKE=; b=Jgp/n8r5uiMBqdjREsAowjemYU
    /XnG+g9ujZ0cOHV4yy6wwtlwOJvJhJp0eAZRfw1IqpQfgwlSbtFpfDc430RB7+KF
    UdbTjykiNAYYwrrmEnmRw7oedDQnk94v0M/i7TNH2I6kLfI+dnpYPKeMfp0F21my
    w8Mt5RVRCB0q/Fx/7fCPgQ72ZFzcqzOvfdVigLL/M2phmU7cJxKo9xr55oVohaFO
    16mfhCo62TPfrB91+7vMOh7SEvGADHJdQ2T/0vtYZi48cBdY7/uvJFquQrASRFxz
    uYpDlmvKYcWOQaaO031jq9nP3oatALqYb5/Yckstp8Y1NmsFcrdzVorzqbTQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kELGahcQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kELGahcQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9/Fey0wOdKm9hcED2mqVb54bP6nvwIPx+Q+a3wGCOYzM/MiFmYy2qR2lxKh96z6itnz49hP151E2bOl28f/ppiNZLxv26+CpJE6e/M4MH31Pw4F5BY
    ZBS0CoGG8nx+UdN3gmq31n0rBNXh/XhLxLjSqAsTquSHjGBfsNKc2mBWwtni1tDYuYV8LWulZeGxfYypRJ+foa9OBB8/iKCt74vsNnkbhxbY6pu1e6buLxt8
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=Crlv7Caxbz3YXNOajsAA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756685AbeDIBdZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:33:25 -0400
Received: from mail-sn1nam02on0135.outbound.protection.outlook.com ([104.47.36.135]:45331
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756139AbeDIAfp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mateusz Jurczyk <mjurczyk@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 033/162] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Topic: [PATCH AUTOSEL for 4.4 033/162] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Index: AQHTz5mhyHUVWh4c60qTx62hazffoA==
Date: Mon, 9 Apr 2018 00:28:06 +0000
Message-ID: <20180409002738.163941-33-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:kaMdXJJ4WApY8YbDfkwOln0HsBZbbKOEXrTipMhJAumS2S+ugwOeGa1FpkJNTpRYiDDU00QlS3AO0Z7PQ9+gDG/Ueot1qBicqvaDH3Hqa9eaZeUNq245MsV75ky652e5I6jYfPUJopTUUy8JZI96DmQIOv11WtuPEtA2tVHZtIoglkbLTqsRPSRwDD8Re5v2EitzAQyz3GEYk+CYUJFxrDEL/3QHwBhfvCfV6kLRK+Qi9SjtWSEYMCxJw0bKGkkF;20:syW8nZryMSCvsvL3V72Z4PgYNai46g2qd950ta33E/xj4idYOv8SUxxUpOt+4Z4aJkz8pQ7EgP1dMLFM5Fc1l/ZxwRVKZbUKfTn1y9PEhKIlN1tpJJbSpe90siwe65kNVBTxy0XmyA8l6ZwRccJFQFb84rGY/YvTD32re47FeB0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19591b8b-15be-4462-b4e1-08d59db1d3f9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07252D91D06D846C79F7CDC9FBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(59450400001)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(81156014)(8676002)(6666003)(6436002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hd31D+KbqVtgAusGcB5QXw6kBlUVXvMwza92BMWWkvyAfD+WWu0q0J2+bvQq5G8bQFkFePRf1w3+djHJcSrfF5C3GbXIdej2H/5tdMvbofaztR28faSs+5ITErIDrcPcuqvMEZ1wKIhAEpqNOQ3tGJiC6hkDewSlFvpXifqDC6+sXdlm7m8lvD2LfXh05Rv+XZdmv4qzqmSN2Oz3eMHdnQv//CTsBcvyzguXtWfXKCTNqg61XikmVgySYu0PsV0eluynquJsrQETjWlL/LleW6rjKo/EOY3mWdYM4vPEBjrokmeIr8ers5eycajRJyw4U2hpRObp6BxaNrUZRDHUC09zUgbGv65syZXCQECmM1irjDnfwpjyDNoMiawxk1V2Ayq80J1zNO4h9/U5fpqEHMUSMRbz7NrLaDvRCWAMGSw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19591b8b-15be-4462-b4e1-08d59db1d3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:06.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mateusz Jurczyk <mjurczyk@google.com>

[ Upstream commit 20a3d5bf5e5b13c02450ab6178ec374abd830686 ]

Verify that the caller-provided sockaddr structure is large enough to
contain the sa_family field, before accessing it in the connect()
handler of the AF_CAIF socket. Since the syscall doesn't enforce a minimum
size of the corresponding memory region, very short sockaddrs (zero or one
byte long) result in operating on uninitialized memory while referencing
sa_family.

Signed-off-by: Mateusz Jurczyk <mjurczyk@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/caif/caif_socket.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
index aa209b1066c9..bbc80e4e08f5 100644
--- a/net/caif/caif_socket.c
+++ b/net/caif/caif_socket.c
@@ -754,6 +754,10 @@ static int caif_connect(struct socket *sock, struct so=
ckaddr *uaddr,
=20
 	lock_sock(sk);
=20
+	err =3D -EINVAL;
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		goto out;
+
 	err =3D -EAFNOSUPPORT;
 	if (uaddr->sa_family !=3D AF_CAIF)
 		goto out;
--=20
2.15.1
