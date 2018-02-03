Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517682535-2-3657485289621313128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682534; b=SWLYj5qXDpMTUxrOhOAfh7FvP56ejoNJ+5iPBOZJW5mxGG3
    l9lp0rYPeJu0ycz5UsoclLxWBXg7FRxBwzmUbo2VLPkKLkiW7lvGVBJVpJmqrD1f
    qOzzMlkCoT/gl3PXcSUecO9DbM0ni0d/oLoJKd0Osc0yFmOs5D4k9ReNPzNmH4Se
    jymYtK7RGJZEgFHygXPjnnK/0t2ftNpNkOzuap2XrDTq/UhoQfy1JF6Pn79tEAM9
    EGwrqqqlhd0goAk4oZ5Ueg6P7gIyb6Ep/QvveiTg1H4miaceAdXwtYquUufrmV2A
    y6YUlJXwCWmRBhwiQRuxJwxHMmpL25fwqPkjp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682534; bh=5xqCVF
    rFwE543HlSqAhGfcQuH6saAstRpvJYeo2tIdI=; b=vGSoTUzu9wiScu8A31e5WE
    HtuKilxlk7M/4NyeT5HdPfeuok+4/npsCNdbLDGdZsdgXBbdLhu3YU2mEVmXVSyP
    GwCYin1Q5IadEq3geOUxnILwZjBjmEBLMD02qbYaqmVSScmIfQuX1548+lEGEaA5
    wouYXnacjNHv8O8x92d4rCOslAgYLhGkRV3fVo5s13ExT+hdbstUnHvty5p8bdug
    iMH7MlKqqcj4Zys5hfvUAlYB4ogoFXyUTMY1vdjxGwYM0H6nCeMkZzc69lFjB9F7
    J57rkGIzsEhcnVhILviXDH4Bf4L2hmK1Gfgitmr6b9RwSA9/VGs7CO+DPK1fbk+w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ey6ORSZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ey6ORSZq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754043AbeBCS2t (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:28:49 -0500
Received: from mail-bl2nam02on0127.outbound.protection.outlook.com ([104.47.38.127]:37417
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752688AbeBCSEr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 093/110] bpf: sockmap missing NULL psock
 check
Thread-Topic: [PATCH AUTOSEL for 4.14 093/110] bpf: sockmap missing NULL psock
 check
Thread-Index: AQHTnRkDvCnymrbU0Uqy41wVbJxB9g==
Date: Sat, 3 Feb 2018 18:01:27 +0000
Message-ID: <20180203180015.29073-93-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1041;7:lWvcmvqftcy3H0vki5Efkvb2iDs8Yu+g+KbaTUtH1TvS7HBwJm5ME9V1Sfo/KraY1UH51UTkDBsOfe1l0kSnaDmuMH8mKxhzRGsWFQF/obxiLTE/NDxGuV4XqgXPnIGd1YY8lRPlpQgoPjTKQVOx7HCej9a/Dbw9LYr5meM2++k7FFAIJduQECj9yrePkDdsLN5KKt9LnHL7at35PTQZocQq+EB9bfIwc6i9c3VjC3ZJOKCofc+6cUA71O/JfvqP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efb4e84d-eeea-45e2-53f5-08d56b30554e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1041;
x-ms-traffictypediagnostic: BL0PR2101MB1041:
x-microsoft-antispam-prvs: <BL0PR2101MB104107ADE8E033BCE3A211C2FBF80@BL0PR2101MB1041.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1041;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1041;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(2501003)(305945005)(3660700001)(5250100002)(81156014)(99286004)(81166006)(36756003)(7736002)(10290500003)(106356001)(53936002)(5660300001)(316002)(22452003)(8936002)(54906003)(110136005)(3280700002)(478600001)(72206003)(4326008)(39060400002)(25786009)(107886003)(102836004)(97736004)(76176011)(59450400001)(6666003)(66066001)(6506007)(2950100002)(2900100001)(68736007)(8676002)(6116002)(3846002)(186003)(1076002)(6346003)(105586002)(26005)(10090500001)(2906002)(6512007)(86612001)(14454004)(575784001)(86362001)(6436002)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1041;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 43N+CTZr9g3yl9Tpt9dIsJPIUw6O35M28gvB0ADmTGVht+XM2Cghc5hY2kdD6VEKAvRJz9raT5dtB5F4vCq38g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb4e84d-eeea-45e2-53f5-08d56b30554e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:27.7690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1041
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 5731a879d03bdaa00265f8ebc32dfd0e65d25276 ]

Add psock NULL check to handle a racing sock event that can get the
sk_callback_lock before this case but after xchg happens causing the
refcnt to hit zero and sock user data (psock) to be null and queued
for garbage collection.

Also add a comment in the code because this is a bit subtle and
not obvious in my opinion.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index dbd7b322a86b..1890be7ea9cd 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -588,8 +588,15 @@ static void sock_map_free(struct bpf_map *map)
=20
 		write_lock_bh(&sock->sk_callback_lock);
 		psock =3D smap_psock_sk(sock);
-		smap_list_remove(psock, &stab->sock_map[i]);
-		smap_release_sock(psock, sock);
+		/* This check handles a racing sock event that can get the
+		 * sk_callback_lock before this case but after xchg happens
+		 * causing the refcnt to hit zero and sock user data (psock)
+		 * to be null and queued for garbage collection.
+		 */
+		if (likely(psock)) {
+			smap_list_remove(psock, &stab->sock_map[i]);
+			smap_release_sock(psock, sock);
+		}
 		write_unlock_bh(&sock->sk_callback_lock);
 	}
 	rcu_read_unlock();
--=20
2.11.0
