Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3992186-1523244729-2-7284630953835502603
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244729; b=h8GA6FbtdwsBG9AS8f/S3mTZCXgW0ROJtpfWQG1u0C94X1zxX9
    MsDkKYSQJdw4k1ET8ZA5M9oLDtXu9fg5JAb77SVdndxW6ew6dNro+o8ohi1kiEVs
    Wn1v3eEMTye7KcCw7wxlkpPBQeXbzf7vl+c/qcT3Kot8fWSx/WvIUxB+7Db/9uVD
    0IaKnDjqhrKjrq9+LA7mqg0Q2DmWuH2HsD4EQWX1NFsiDCBrvw0LslTqelF2tLj3
    p+vq8XUzeOaK0neLr5fXfA8NXiUqArJcQh6DedCkaqMNPVdSe1LD6oYId+wALTWg
    ofGnxV0tcl2jMOqlHH5kEctsSLxxdsy6VJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244729; bh=y7O79CQMNj
    UspdHeRfaZIZ3J6icjKWafBqwgOpZFhi8=; b=obZEDtvrubfLUsZSTU5BDm5XYp
    +gqwQMzSQC8os649usWJ+CneLZ9wGgvKi0yrJkvJqK6L53LZdfTKABEmBw31DUK2
    6B5+Bi7PUgInS9OSnJzTvjWw+2tPlssIFkcyn8Qi+G7yQboKoOAdAx2VrdR2MdYV
    c8T27DUUtO1JoGWIoBjglvO+92qyDmCDT7HI1eSbU6QIh9X0lgYyYMGOEV56NWlh
    WwzO3L2iOCxk8H4PvF2edZmkDe5o+B1iA+eru10e8ARdWLSWfl5rf0cnxwCGkH3k
    6efywRDyjRgv0/uPv4JtRKzZkPd5lZWYWflMvWxKjrY4jDh3DLwROaBfDGjg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TGfPq/4o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TGfPq/4o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF3Xnp3uEfP0wGBTRZOdkC8qU0dJ9sg4Bh9dgvOcXsqLrZ1UI3jewnKUANsqxSN+iPyO6Huh2pyH/xIZahUE/Q8q3h3jr3q77iXFdz077UrA2RO4EgBV
    o9hZYUR/F4WqnKK+A5IL4IBpv47W2Dqeo3pxEzowr4WUgL722NPOsJZ58xrlZ0nwTObnqbsHVwuzvaNlWOvk8l1LbmWtv9sH9tzoUgBWTjRMAKoi9WzV+hnD
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=MvuuwTCpAAAA:8 a=Z4Rwk6OoAAAA:8 a=JfrnYn6hAAAA:8
    a=VwQbUJbxAAAA:8 a=eJfxgxciAAAA:8 a=yMhMjlubAAAA:8 a=JCfHVUu5gEkzvycj3xwA:9
    a=crMyCahZqQ5rOvfK:21 a=CESwFkRpyRYus6Mw:21 a=wPNLvfGTeEIA:10
    a=dVHiktpip_riXrfdqayU:22 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xM9caqqi1sUkTy8OJ5Uh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbeDIDby (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:31:54 -0400
Received: from mail-bl2nam02on0124.outbound.protection.outlook.com ([104.47.38.124]:27520
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754502AbeDIAVw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:21:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 183/189] x86/platform/UV: Fix GAM Range Table
 entries less than 1GB
Thread-Topic: [PATCH AUTOSEL for 4.15 183/189] x86/platform/UV: Fix GAM Range
 Table entries less than 1GB
Thread-Index: AQHTz5hjIKLAnWYlfk+K5uAuW2BIew==
Date: Mon, 9 Apr 2018 00:19:13 +0000
Message-ID: <20180409001637.162453-183-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:IkQldqIzenIrHJOOKnw0/EW5x4dpiRyIE5ALwdrfsHgAJp8i3R1WZNdGa5wafhUU6kZTWmRGRBYZuBcTuzd/Pp+SlbsoReTcHV6lwCDb4Tha1ZzLDFJZfJku+SuRNZjE8jev9oU9OKzdyXe6XG6Db51NrOKz1y03NfUATVo4//e7uHMqlGeobLV5GyAYLZ3qe2Ba/s9kuGCJkHukaKGnu+6Bwr0JnrByt5mgOnjrGxlPGbbfK46XoqZTMmboMsWo;20:FJRo0DDFaDfAgaqMDmiF+tjWugFfOVwWlpeaBM83LOrpniGVVsaN+UFGHBfUK/bbIg2bKuUtFTkM6x5C0AG0BwUecGGB95bCgZLUPAJSaCHbF3cumEu8BrOQxYPCTA0COmm8I2V+WzFe8amJ824I6/zGmtLDSaj5rUBmOilyhiE=
X-MS-Office365-Filtering-Correlation-Id: 0cbe7a99-9ff5-46a1-fa3d-08d59dafe33e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB112543E665C1A6F6E47F86CAFBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(227479698468861)(89211679590171)(42068640409301)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(105586002)(7736002)(8676002)(97736004)(81166006)(59450400001)(106356001)(966005)(81156014)(305945005)(14454004)(66066001)(1076002)(102836004)(5250100002)(478600001)(2501003)(2900100001)(22452003)(72206003)(68736007)(26005)(86362001)(8936002)(76176011)(6506007)(6116002)(6486002)(186003)(5660300001)(6306002)(3660700001)(316002)(54906003)(110136005)(25786009)(2906002)(10090500001)(6512007)(3280700002)(6666003)(10290500003)(53936002)(99286004)(86612001)(3846002)(6436002)(486006)(4326008)(2616005)(11346002)(107886003)(36756003)(476003)(446003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DQflqopYSwEWpXHwESPQ1cE0QuB1gHdcloyBEZsgC/0yochCcS8Z+gAVbK8dWMpx+fdZga2oZ4AmonHCc2N1GwgvkdKfrA7LjiTUcnTnjVSlgQPNeEDbfD/VTw0S2ZwOCEtl7s0qFAfjGn66zltRnZ7ioz4PrtsRhRHTCQRGgP4NWGwXNXRwsb029PKuOGo7jCzuzvkvI9qbfcXt/Dr1O+FNWybhLzZ/duBDMmIOaE7ciz5VjLK+ZyKdQG0imxTxOeezh6xY3/sybHcfwWxjGAxA1DmtK6R6Miz3eZNO0QquAQIjLC7kHslDoHt2zOTuTm8/ghVnkaYXNpC0z0WcojsNU/yiIB7vm3oRgOPlTkaGaG3cOxsi5AgdbZbnjGZjM+RafB/KuBliN78ThTZRecPvgxbeK1jUVPRUfaj3F+M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbe7a99-9ff5-46a1-fa3d-08d59dafe33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:13.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "mike.travis@hpe.com" <mike.travis@hpe.com>

[ Upstream commit c25d99d20ba69824a1e2cc118e04b877cd427afc ]

The latest UV platforms include the new ApachePass NVDIMMs into the
UV address space.  This has introduced address ranges in the Global
Address Map Table that are less than the previous lowest range, which
was 2GB.  Fix the address calculation so it accommodates address ranges
from bytes to exabytes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180205221503.190219903@stormcage.americas.=
sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2ap=
ic_uv_x.c
index e1b8e8bf6b3c..256a9924b8d8 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1174,16 +1174,25 @@ static void __init decode_gam_rng_tbl(unsigned long=
 ptr)
=20
 	uv_gre_table =3D gre;
 	for (; gre->type !=3D UV_GAM_RANGE_TYPE_UNUSED; gre++) {
+		unsigned long size =3D ((unsigned long)(gre->limit - lgre)
+					<< UV_GAM_RANGE_SHFT);
+		int order =3D 0;
+		char suffix[] =3D " KMGTPE";
+
+		while (size > 9999 && order < sizeof(suffix)) {
+			size /=3D 1024;
+			order++;
+		}
+
 		if (!index) {
 			pr_info("UV: GAM Range Table...\n");
 			pr_info("UV:  # %20s %14s %5s %4s %5s %3s %2s\n", "Range", "", "Size", =
"Type", "NASID", "SID", "PN");
 		}
-		pr_info("UV: %2d: 0x%014lx-0x%014lx %5luG %3d   %04x  %02x %02x\n",
+		pr_info("UV: %2d: 0x%014lx-0x%014lx %5lu%c %3d   %04x  %02x %02x\n",
 			index++,
 			(unsigned long)lgre << UV_GAM_RANGE_SHFT,
 			(unsigned long)gre->limit << UV_GAM_RANGE_SHFT,
-			((unsigned long)(gre->limit - lgre)) >>
-				(30 - UV_GAM_RANGE_SHFT), /* 64M -> 1G */
+			size, suffix[order],
 			gre->type, gre->nasid, gre->sockid, gre->pnode);
=20
 		lgre =3D gre->limit;
--=20
2.15.1
