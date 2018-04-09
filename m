Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523233554-2-99452359952702748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233553; b=Xoi4OvTsAulBcoGewsPqTF3HfPGQwsnu7zbG1bFinlwXFjffjp
    y0mqcFs7uOE1vgNDZMYsdILZiSOL8Z82UsoC6bh1zZMRthFc6CoLe0rB3d6uF4Br
    CxIMWb4XpTrwhaB+je7hP9P6zjIUpvuRgpvbNH0TtkCcEcpUYR2q4X6vPgc8e6N3
    FMjjxij38lt6Kfddo8z3wrRK9zOWFKw749OHrGdeQOEDEvkSqp8Lc6jbGcTmvtVU
    pSOBRTI4m8s4/5DEyjp0cpaB7g3hCzuz/129Onn1JDNeSLOpgMAUvXCd5zb/WFaL
    NPoZXeUnsVFPdNKhe09uKFO8HjulmPT9jhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233553; bh=mY6JM3pvf3
    oJYEPJYnAkS49q1yYsAfSvGIYMM12pfXo=; b=sMpKP/NrhDhiA1dci0mRXseVFU
    yO+mngSJU6rXM8cUGJYb8RlNWEy4y6+XQQR2oZJSrq6iSQwcSQgo+HiddaO7sIOz
    BWi4hb5DtusZzmov2hqvvCdqtgtMHkFgEumpzEARJBOmltZo0VA3aW98ijv7jBRi
    8ypguHooDSCBIMe3KhO51WHODSwYZ22LU8jIaK5Gi+xuoW4P5x0ZRBp63VR08SOt
    /O/bCEQiIp2/fTU7Gkz4AhecCexIg0anhqy+HwPlg+lylCtQvcltm1owijUtZ0v+
    Z8a04oXggNqW5xmZmeSjFKiLuHJREhAPUh3/r2qc/Y4u/fNWSmEdTBIUOtuw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K2bLKbqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K2bLKbqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBzxppQiAowE3dwCBtk3+jIih8yQ4FZC0zBdbjbr0uTJ/jeeeC1/yDDE8ydRCoZj0iySfdcbtBER5CYcgfM7yaQu0ITOJayOj2sdgmVeJ1MeoTH1koK9
    pCvRFrWb7rH3B93bFzUB/LKGzdkbubw1hIS+4XHWbPOn1VUmqrWGWn+gc1OVH34Va+557r6l5LPPPqs5afxhH4YLP6QTDK+u1oqQAvQ1omz+wq8ZPDO397kA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=DYjp3tQfXsJm4qdJRokA:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755269AbeDIAZt (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:25:49 -0400
Received: from mail-bn3nam01on0139.outbound.protection.outlook.com ([104.47.33.139]:14848
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755165AbeDIAZm (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:25:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 130/161] bpf: sockmap, fix leaking maps with
 attached but not detached progs
Thread-Topic: [PATCH AUTOSEL for 4.14 130/161] bpf: sockmap, fix leaking maps
 with attached but not detached progs
Thread-Index: AQHTz5i6XVCjRUduTUSxwSCDJr87ag==
Date: Mon, 9 Apr 2018 00:21:39 +0000
Message-ID: <20180409001936.162706-130-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:76dDk0EE8tP5PPu+EjS5BM7ZXr9c/AJlOZgM6iDou+7tBeWmip0plYMOuT0/ANMjabk9RqtP8i1Ld+J1MEkZXRJ+a3Bg5OBk+KyNt7i+OixX7/6ygqU2yYVYgwiK/nWSjSxbp7PGtmmJ7+u/GE6Q0we1vun8Jqf2dkpD4oFenrMcRyxxVX6HuAsFmpsPwMM6c12aBdfNdO6butWWdMWd3MLZguRrJ26hQraxr5y7FA7123LGK53bjLaP9DSEoENv;20:uaT3vnS6FJ3BrjSyHUDrL9oiBi/Q8IUWH1hZJEpBgCrw5qmUeig0BCAGp256BKuSEM/6Xcy02XWOuUwUbDxS6xC6jTP800hnoPoJ82QGUGHpacu9ulDv1ZI5M5vHOS5giyXMsF3P/8yA4S9KU+MJm5sU/9fQaD/I7gl3KWoQL0E=
X-MS-Office365-Filtering-Correlation-Id: 91b37cb9-87ac-4520-a457-08d59db06ad1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1013BBC48D8DE872D87DD43CFBBF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39860400002)(39380400002)(189003)(199004)(3280700002)(2616005)(8936002)(7736002)(476003)(446003)(11346002)(53936002)(3660700001)(86362001)(86612001)(81156014)(2906002)(186003)(81166006)(105586002)(1076002)(8676002)(26005)(97736004)(25786009)(6512007)(3846002)(68736007)(72206003)(106356001)(5660300001)(6486002)(6116002)(14454004)(4326008)(305945005)(6436002)(2501003)(5890100001)(5250100002)(10290500003)(478600001)(2900100001)(59450400001)(22452003)(110136005)(39060400002)(316002)(99286004)(66066001)(10090500001)(107886003)(76176011)(102836004)(54906003)(6506007)(36756003)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PrX+k7lIisO5pnsXzIG92naOhB1770VIHGZCEqf5nJOgc5qPkFnF01XoxmI+Lx1oAGUjezBGMmVfhJ2oUBkPBB8mvU06b7ziNweDZr3Bm9+dcH3EGv4I61vDT3n/lRfAaXkUYZz1QPebR6bSIRr4dcpThoQK2wsgCchytFTTi7+6jJBk9ZpXL/zDU56gfmEnLr2Z0QdmoqVEqfhW5V5WvvMJ36gM8EzG8zQTQyICRkyRISMTD4QwowYtuWwp98l4VvvEO920C/NTdw6emQ0ejkAKnABSbKq1wPqcBRpmn7gYYsI3U1jSt1L3js9lszkpAvc5YYUwsLshn0qI2VvtfUFdaLshGDscTjuSI69PxnhWjlh7/P2L8sBsYYyMxgKjFblferYOH1g2/GQ0bnzzQb1mGmfosVNluDNLnwfVSoQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b37cb9-87ac-4520-a457-08d59db06ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:39.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Fastabend <john.fastabend@gmail.com>

[ Upstream commit 3d9e952697de89b53227f06d4241f275eb99cfc4 ]

When a program is attached to a map we increment the program refcnt
to ensure that the program is not removed while it is potentially
being referenced from sockmap side. However, if this same program
also references the map (this is a reasonably common pattern in
my programs) then the verifier will also increment the maps refcnt
from the verifier. This is to ensure the map doesn't get garbage
collected while the program has a reference to it.

So we are left in a state where the map holds the refcnt on the
program stopping it from being removed and releasing the map refcnt.
And vice versa the program holds a refcnt on the map stopping it
from releasing the refcnt on the prog.

All this is fine as long as users detach the program while the
map fd is still around. But, if the user omits this detach command
we are left with a dangling map we can no longer release.

To resolve this when the map fd is released decrement the program
references and remove any reference from the map to the program.
This fixes the issue with possibly dangling map and creates a
user side API constraint. That is, the map fd must be held open
for programs to be attached to a map.

Fixes: 174a79ff9515 ("bpf: sockmap with sk redirect support")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/bpf/sockmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/sockmap.c b/kernel/bpf/sockmap.c
index 1890be7ea9cd..53a4787c08d8 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -601,11 +601,6 @@ static void sock_map_free(struct bpf_map *map)
 	}
 	rcu_read_unlock();
=20
-	if (stab->bpf_verdict)
-		bpf_prog_put(stab->bpf_verdict);
-	if (stab->bpf_parse)
-		bpf_prog_put(stab->bpf_parse);
-
 	sock_map_remove_complete(stab);
 }
=20
@@ -877,6 +872,19 @@ static int sock_map_update_elem(struct bpf_map *map,
 	return err;
 }
=20
+static void sock_map_release(struct bpf_map *map, struct file *map_file)
+{
+	struct bpf_stab *stab =3D container_of(map, struct bpf_stab, map);
+	struct bpf_prog *orig;
+
+	orig =3D xchg(&stab->bpf_parse, NULL);
+	if (orig)
+		bpf_prog_put(orig);
+	orig =3D xchg(&stab->bpf_verdict, NULL);
+	if (orig)
+		bpf_prog_put(orig);
+}
+
 const struct bpf_map_ops sock_map_ops =3D {
 	.map_alloc =3D sock_map_alloc,
 	.map_free =3D sock_map_free,
@@ -884,6 +892,7 @@ const struct bpf_map_ops sock_map_ops =3D {
 	.map_get_next_key =3D sock_map_get_next_key,
 	.map_update_elem =3D sock_map_update_elem,
 	.map_delete_elem =3D sock_map_delete_elem,
+	.map_release =3D sock_map_release,
 };
=20
 BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, bpf_sock,
--=20
2.15.1
