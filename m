Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241156-2-10379262650853014783
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
    1523241155; b=exRwUArbomMbOd87PhWi1MVrgGbSCxKgBjB8txWjY4BGtfniqz
    2zJpzFrqz98QbmYyKLNkzK0qnq3f8wkeQjlfUtdtrtJ3+zeocRSXKHuZpKco0GQu
    q29GQBwiCW+jduo7gFgG75m5/3vh1Z2VmDrF9IfX2LqFNaqCgwkI0ObLZI0jI7Nl
    9mzr0TGROaiUwg1K9i78R4ZVICtIjF6R0rkN2c08ULX5P3ePfWc1jPo2uwQr+UIA
    upAHpHBfwGoYWQpB3sSnhZiVzUEhCplNT8PYm3wuDiTLe2YOoy9MtUP4jSL71e0x
    W/eXg5leBgS5cx0ajhCqZBJowk7WDU2tswpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241155; bh=ikSI50jWfS
    AeV+oUKD9C3pu5QJY9R4eI7Agv9k195+M=; b=mOB+X9VwMWka4MnJnKM/s58tDz
    73iGBaP02qJlTLO/SJCA0vi/FKye3JsAf0bmFVEn0CUKtpnO85T6e/TKcTF8aUWu
    4Eo8Tb2s5+7Ohqvcukc8qJK5rPk2YNiMrJMKencj8C5uM39AoIbL0Y2DH4TZI8YQ
    Qd990uVXXV0HhMX4VWnSiv1mLm17rkKwh/qB6lGW5U3Iv3lafISr/bt3ookdIJiH
    91BDAcvfoABRbZW0DLXz/uIthpnf1bau3Z5WA27wcFhsQx6Xnu4gRPWu3CFmZsgE
    zTg8YEx6DJ9YGwPkXSf2lvNi7n9UW97scPvb6sRlBm2Byn//qdVEt1kUVHAQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EgsuejMw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=EgsuejMw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBNm1TINRk4RWiqeHeKSt3VBh4DaHJWLtPLaaOB5NgLdFW8i9vaHtdtrbirzXvr9g9PuUwDyrtfObOnMg7XMkwkhW0KUJpl5H12ZqCXvWNr1lT5kgFB8
    We0NABP8JK2NCMhtyZV2FC2om9wR8TosnNIlFT9bOloN+XxwKH1s5xDyjqzvuBxiuUYmWvWBdLtUg5Tl02ypPhGB10vPrGmR3ePT4g6YLAKz1ysTu3lDF3KM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=Crlv7Caxbz3YXNOajsAA:9 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754540AbeDICcO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:32:14 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755767AbeDIA2N (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:13 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mateusz Jurczyk <mjurczyk@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 066/293] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Topic: [PATCH AUTOSEL for 4.9 066/293] caif: Add sockaddr length check
 before accessing sa_family in connect handler
Thread-Index: AQHTz5kEo5DNZFbFV0+s7ix47g19UA==
Date: Mon, 9 Apr 2018 00:23:44 +0000
Message-ID: <20180409002239.163177-66-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:iLUAaebEI0hB77mbn6zuhEAPzfNrWPnwg410flFgSXddCGW3QV462N1UipDgU/uLN0MxwduhRrqQpb+8+1aNPqFMGHX7xkHwx0AfP1hoxWrMod7191KVax4shEyO4h9pECHlwL2IDc1omCGBlrQuhL5jxIMlbo2h2Ge/VJK3B3/3mAGLEVlqDr+4LCWpHaf8xpWozk1LnuKLJEPp1+5zJ/ydVqbMqvXwmUMkEZvcViQ8GdqanKx2o3/EemOEsieX;20:uND9Xkl68/JpnoFrgyzJr8xk2aPOTf9WT/sQHfKgyxjEJC8sd2hTpSL7el5r9F5CbgYYFd7e0YcogQuVfGLfy9oddjdeE/rztn4jRyKciy6fAY9kcva9cS920SVytV43tTg9sByOKppx1qw0yV7BzJsjPKBrDJS1ji5eEKsGcdY=
X-MS-Office365-Filtering-Correlation-Id: d937247d-2de5-4dd5-b28a-08d59db0c523
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871762180F403C5800A055BFBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132)(21532816269658);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(59450400001)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: V98KW/sO86xJhOnqx7IPf2t1TObhhaW7gZ3s3SszudMtl+joOcQdDuy84RRbYo1L2xQDenBAKnIPMyE+qdHEm60e9MEWORuHRuvUjeB2HIts/f9TkJRo9acOUe9eAIzl9P3/gYJOAu1y+EQxiJGhILFmgpvg8/tciJSTQ2pXPY26ILHKs4joNbwMEMaxVDRDhwA5iuyRnXttT7SKwitU4ziMDBFoi1NnXKUn5dMXsBg07VGXVSa5gdju6HkVONTbsR/rarbACHIboiAIuaMGSOkQaZnC7LL56RctJ8I6ucVDCQQWXBmflUG+2L9RAKPOMiUDM8/yMLd3trOL4MgZ6fS/t3dmhvLh2yJOymAkxUTdCYor4pZJ2FlRe3ocemkbhpJXFNoTe3ccvc7ZoaJ6IZcrxTBqueeACLLOc2nhNjg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d937247d-2de5-4dd5-b28a-08d59db0c523
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:44.3624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
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
index 92cbbd2afddb..d9e0170aaacb 100644
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
