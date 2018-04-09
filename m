Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245264-2-14715526688741540073
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
    1523245263; b=D1OYZ9UYRQcGuL485W9IWqWt6cg8vf5XSzDiY9iR9JQd94lSnj
    1UuodPB/kJq3zqtR+p68pdQ03d9pw0sV6UE/cEFAoJCPokhgAzS8Q9KI/lLsHvWO
    kNAMK0OaI/GBlDLx383SNVtLVfgmDvPdKjeA/B+3EfMKFFYLjOi5XucCvIoCEe33
    12kqrlC4JdorPo5XUI0q29m5+10NCMK5BLbm5AR81/BPz2CwRPBJ+/7d2oi0fTMX
    NdQoo2QWHRriC0998B0aP9N07wP1l61ZuiiZLAKH2jpeE9t1GWJgzzSzw8kXCgMc
    MVQRLiCioPBhVA85172jX/dcH0LH2XbmQflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245263; bh=dpV9QLGwP3
    N/UUhXkWLaBUwQqAdSb3liWX0HvdnJ6us=; b=uOzC9AVZrn5asHKjVlQKfjif6j
    z3rM+AuJ16M2YM8LAPNm1TgjaErGLyHQlMQlZw51Hy+eRv5ubC3DXN8gtFea3gkR
    VgJvxptgUsHzkmLaTmgpx9cY6gmxZRo6wywzo3/mPQNlhWx8KdquhlvREgd/elMl
    UJLBiXjthcXc3+NJHhN9Eo3vT1pu/pmUG76hNGYWQW0JA8BdJqy9Tql0KX3Rz/WZ
    v/GfwWVeS1oFVsYWYeLTire7UVCtRYbbNxTMW5leKM2u50rx+G5eWN5MSd2Tis01
    mrALedXfhN3wfApUsBZy+c0Rrljx+czRlIB5xs4cQvoJvi7l3mKdXIBRqOcg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KAtlc3vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KAtlc3vD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFCpZQsOriRfhBgQH5Z0Ars5Hl43qOyqgXWp6Uoq83Ku9JOYrSI6l8FeISm38aDh5axVTD1END58zb9RreaR504G/F9FYWhgL3kvHh3mmPKNJGcOUZU5
    OmiFPfMbHeCmw2WZkbptg5aUWgQyIx5dVfj6txVrnRcX4uaST/aJngfEvSWvzJJR98sYrnkYF2no0/IkU8pvwQJJYdnLqPleleKdXdzNyG2N3Z9NQLi6my1Z
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=hWMQpYRtAAAA:8 a=yMhMjlubAAAA:8
    a=DYjp3tQfXsJm4qdJRokA:9 a=wPNLvfGTeEIA:10 a=KCsI-UfzjElwHeZNREa_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeDIDk5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:40:57 -0400
Received: from mail-sn1nam01on0114.outbound.protection.outlook.com ([104.47.32.114]:12752
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754344AbeDIAVE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 154/189] bpf: sockmap, fix leaking maps with
 attached but not detached progs
Thread-Topic: [PATCH AUTOSEL for 4.15 154/189] bpf: sockmap, fix leaking maps
 with attached but not detached progs
Thread-Index: AQHTz5hW5NvMazAU90e2uNvhFNr63w==
Date: Mon, 9 Apr 2018 00:18:52 +0000
Message-ID: <20180409001637.162453-154-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:ZdaAuVnV7WNFXmGI/mYNeIRxN4MbY5/BFiKl/c/vtP/1DVk1HPzHvkyaZu7BmA70YPxmHYzt0WCmXQsY+2F3Lt7pq7eEd09cGyJU4VpBnJPIoiXHbg8Roker2nfeOe3sbyjRW4LwOOLz+f09Hv+BVYlizMeua/wbSpK5V6Ns1AwJV3lJfczDxrS84mK7XqkqY/sU8ei5KB8oAziTR74bPWAQFWMUyL7pAvKTqdpmiSxJafrRGg6/P7aBAitarm6R;20:V3d1hHsxH5vaHEIfetngP683wIO+9VDLvlNFv53+UfYiONhEM+Cw4P8/I3JjSMegB/qOthB7W1u75Ou94P5K69Y6U5fxOKEu/B0ltFQ8sUWcFemrSUPB1X1VE6OmMpBsBlgB6VKz0KIqO2tdLbWu4K9lIPeBTas5GiBhfKX3IPI=
X-MS-Office365-Filtering-Correlation-Id: e365e2d1-436c-427d-498c-08d59dafc4b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB092046E407015DD62D8ADB6EFBBF0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(346002)(376002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(25786009)(5890100001)(76176011)(2900100001)(36756003)(6506007)(2906002)(99286004)(86612001)(6486002)(102836004)(305945005)(1076002)(7736002)(97736004)(2616005)(446003)(11346002)(476003)(486006)(26005)(39060400002)(6666003)(6512007)(4326008)(107886003)(5660300001)(478600001)(6436002)(105586002)(10290500003)(5250100002)(22452003)(316002)(186003)(8676002)(110136005)(81166006)(54906003)(6116002)(8936002)(72206003)(53936002)(2501003)(3846002)(68736007)(14454004)(81156014)(10090500001)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: axQ/v37RJraxh0hnCHCBcb+Aq2PkW/UXOGiEFv4bFFDwo8kGq99AZry9bVVB5tAHxaEKO9quQr/gKTQ4RE1o2DNrsQ20ecA15a6LhNlVy+UOZegHdE1zgDiNL1FUDRZcO3FN3PAX54CMnX9EPd0hapsxfZqiI0pJ5B2dUMdrew+EXk+Txqyfqixq4TqRBPbX2XDE2G0qoAPjQVENHQA4JXBm+Be9a8YJgEg10bGI+DMxo7q+aqJ0RkvjsPBSnGDShom7n1ARHADMl+NefJdrLiDK9tOtmJzoV7ze5tUpHLO46SXNEkbIt+edmR2kGfk89DI3WCRQQ3TgXOE32i2bi7ATuHKJ0SfJnHP4+BWqyuMiov2ihndMvbPpm2hOBNeJpFythaHIrhWOOxSYe8mYQNXX5e5wMXfrSwwcnue0/ww=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e365e2d1-436c-427d-498c-08d59dafc4b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:52.2840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index 1712d319c2d8..7965398a3070 100644
--- a/kernel/bpf/sockmap.c
+++ b/kernel/bpf/sockmap.c
@@ -604,11 +604,6 @@ static void sock_map_free(struct bpf_map *map)
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
@@ -880,6 +875,19 @@ static int sock_map_update_elem(struct bpf_map *map,
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
@@ -887,6 +895,7 @@ const struct bpf_map_ops sock_map_ops =3D {
 	.map_get_next_key =3D sock_map_get_next_key,
 	.map_update_elem =3D sock_map_update_elem,
 	.map_delete_elem =3D sock_map_delete_elem,
+	.map_release =3D sock_map_release,
 };
=20
 BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, bpf_sock,
--=20
2.15.1
