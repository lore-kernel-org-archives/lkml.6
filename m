Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233068-2-4314001030660478297
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
    1523233068; b=ciGKHF3eag7V8quTNbL7cZyH1j6ILTiGQDz2ftFXlmlCLp8uZd
    jn3HKX7af7xWgfKjRQdxLZnnvS7yngQVGPefS9PNL+Jtr5KsLw1Fov/zq8/QPNGi
    Meym1CqMHa6P7okIZvuqFA3FCUQwSCidPl1ROstTB7A2dEwV+gbzCW6NP6nyThQK
    f/jAzxovKCgaPrfcs/hYza+vlLe7yR6l9zvkSf81g4Dk2Vairq8NpkbZlqWXRfje
    MRyzPZZUWa9gtmev9m+H1eQKML84zUq9OvccQJ2kS1olZmhlx9jZhqPa8fqPcR/M
    fc588UO9+SdbVebK9TXbG/mvx4qHC6xKh3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233068; bh=uwZWruFT1s
    5izsM4iBlpLiSlqYuatOHH7dlzwegdLFI=; b=u3pp3aVGxKEi4IPv8wRTM+z5K5
    6+WCN91XRukPy+p+wdMPHibXT+rcDgCGj7YTnxvj0plL/ceLwKp01xKy3QPRczdn
    6umNWINhB8/oJ9S6xGMmrwA/TWSp/97W2p95jtHXU7g8STqLqObwJi6KTNVO+Zqr
    CwR/gcAP51EjJcx0DBfTTBQJS3YiGYkP6xO+nDGiExuXbK9CY3bBQieLWI29cEZS
    J40jYjWnSGMx5Wf4HmOIIDt8A2pgYyvHZ7w6RJsMPl1I9ZJ9giXPBP/2bzkUoRHs
    OSeGswqYO7y5hZ3SqpAPQQOmEzyOPGkFm9F9ZiZ36z3uFlvcj/rbt7ihpoHA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O3w3mb0f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O3w3mb0f x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOm8iiOJVWn+0bSmFw5YgKJcygMmm5CsB0LPb+9iWM34XycBLDDZwP1IvQPMbs3pLaSy4vC4J4SMESP4yov5HlGPhiDJ4qMIZjYMEhDabFfYi2n30Uam
    K36uRzzl0SOT+7KIsyxV398ayw0xGLDZ+dwvuBBcrUeR4iVDi/LYMgYQ30FmFl7vyQAPeGRZKKifb2GIwHoWJjmlWrkBQif2/LboCHmyOsyG/xZw4jfCyQpz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=5G0AJqgLdFttAFhcDZgA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeDIARq (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:17:46 -0400
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:51875
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeDIARp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:17:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 032/189] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Topic: [PATCH AUTOSEL for 4.15 032/189] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Index: AQHTz5gaV2dhpZ8b5UGuTO8xjGrF0A==
Date: Mon, 9 Apr 2018 00:17:11 +0000
Message-ID: <20180409001637.162453-32-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1048;7:pGzsp5fo4nkDVcdfV4NO8F/oBZFXn/JN/eSQ1VRN5Gh1Pp26WQmViN8jGAuwJqdOce6xpcfeHWMlUQXCU7i73TwiJAwY4uhpB+yxf+ylHCj50cjcGKD3bVDDuFg2hLltUVkIpaCY5qQQwkClyBen5doCUiUxA6T2mwIk7j0HW0vu7NrCZizKvgVhlpzMSe2EqBII5Yd1kptoREcW+uMc2UEgZTE6xRZXesm7W3W1v4wVuezfMo7aRtKn/OPLITqM;20:+Fvq/e5LDupOlWTjunEQPeJWi3sAlZ+eSz0q4klURF7YcewvDIntHK8z3e2XAbeyRU+Go9j0KigkGUGZ5MiFQVM8n+8+rGiSlXOOSRPEsXt80M6ZiIxH3kjQRff62xhJOXtFs2PA3CJ7+t/gJGFzN7HRscOdQyXzcqjxCJMjsRI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17426a25-974e-4dae-8f8b-08d59daf4f39
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1048;
x-ms-traffictypediagnostic: DM5PR2101MB1048:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1048E0C5C1C0E60850E0C455FBBF0@DM5PR2101MB1048.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1048;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1048;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(189003)(199004)(86362001)(1076002)(99286004)(6116002)(110136005)(3846002)(54906003)(22452003)(3280700002)(105586002)(2906002)(76176011)(4326008)(6512007)(6436002)(6486002)(3660700001)(6666003)(7736002)(59450400001)(86612001)(25786009)(2900100001)(14454004)(97736004)(6306002)(53936002)(107886003)(68736007)(102836004)(966005)(36756003)(6506007)(26005)(186003)(106356001)(305945005)(5250100002)(72206003)(478600001)(2501003)(10290500003)(81166006)(5660300001)(8676002)(66066001)(316002)(81156014)(2616005)(10090500001)(11346002)(446003)(476003)(8936002)(486006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1048;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eHYUPvFykCkoW4EihIw/LB11t6ZBHN31FvXSjIonjn2HYh3ndTIJVjuIvAmYKZinIb6uwfejIncAE6xhMVdGC7QLB0PCoG2aj3w35AhKW2u4Hi4k9pFmrSQQLtKmUwcfx5zrqMiS5GqZdjYIekMBIH4ijGJhJPRViaiQqBdpIh3LbjGbrpyPoPeGCZaomvGFRqajd/x/0VK5pBQVakDcoQijtXRtDuwDeBT30ml3hsoYahNpcAO5jwkpbBWLJZ1hLZaX3BNForI3n4Ob2SypdPuAUrCATzO8QCEoJLn/JNZdiYDMc0lo3E/sPVjMkUa6OFgdSLMFuqAmYi82OenmC4MIL5CxbP+12uMc0H7xLs52cGfzxmW8DupqLSW2Ed7zcW4Nu0NJtd00neTXEsGeMdA/pSu5vch8SlzwR8WTHzM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17426a25-974e-4dae-8f8b-08d59daf4f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:11.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1048
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

[ Upstream commit 81fccd6ca507d3b2012eaf1edeb9b1dbf4bd22db ]

In x86 architecture dependend part function get_cpuid_str() mallocs a
128 byte buffer, but does not check if the memory allocation succeeded
or not.

When the memory allocation fails, function __get_cpuid() is called with
first parameter being a NULL pointer.  However this function references
its first parameter and operates on a NULL pointer which might cause
core dumps.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180117131611.34319-1-tmricht@linux.vnet.ib=
m.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/arch/x86/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/header.c b/tools/perf/arch/x86/util/h=
eader.c
index 33027c5e6f92..c6b5204e0280 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -70,7 +70,7 @@ get_cpuid_str(void)
 {
 	char *buf =3D malloc(128);
=20
-	if (__get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
+	if (buf && __get_cpuid(buf, 128, "%s-%u-%X$") < 0) {
 		free(buf);
 		return NULL;
 	}
--=20
2.15.1
