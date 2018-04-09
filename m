Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233013-2-17362753975801524355
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
    1523233012; b=vwFCwWH/Mj5dTDcLORkN3gVLtbRs5gJCxPCEfs5HU1rHSdw2nN
    gsR1lB7O3Ylfu9JDhDp8PW8UibaKS7/RxZuLz1qpqtQMHr77VXRiLN1DHjvbwQzT
    LsCRfKmtqMvb9A+C88Fi3RACK9iKwUjMr6m9wLQZwzdyJV+HWgpgkb0kDCC1KLFN
    IOO+22N4jvTASTPt9bHqJPnHQJ0TuMPTaag6KDttxGEIr0+htHqwEjwGE7PpxYJN
    eJGiK3/2C94nBHe5+KEYCrJR9phAxTd3gyHOPxtm3L4XK5aJRDpL78unAri399tS
    YhurcKwuRW1iQz8qpvwpxjPE6ZiNz9+3dyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-transfer-encoding:mime-version:sender
    :list-id; s=fm2; t=1523233012; bh=cyLyUudzxd+SYlMT9SXSmO+DFj27A8
    0isja3MVgnOPA=; b=ODRf9ukhgCPVZ+Wz9Z8Qw573k+t9ZR/x2CeOZxYJQwOX3I
    rJ70we41l4QjhwlmCG3DLssclgOYMKHL5UmAK2yMr5b8P6WvDe6LxnH7aQ05Qljg
    JHXg+AZfFuTc9KKNsmN/KMc/N8WxoDJHIS+W39UG19OgeXXXbss3bFyQoV5WmMYN
    GEAelAuYz/sH4Nus08AlkzXAPDN2z8R6fg6OR9VMwYKfOW2zs6mH2LsCNhj00Zu7
    HxgViGhxjWVn1xSSe6EhAeMTt20TKE+boiO3Ce3X/HN09298hetjBe8zB6Q4f1S7
    9Lvihim91P/g5NUh9PgNmaACkUir4cAFhmaE56mw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LM+ssAqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LM+ssAqB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDn8ypeEbGIYIH/bK0EdPpWL7l4/ikFPN4Egdwsx7tUMNRMw5kPuDMDO8TH7vUxMG1K8wRCcNBXzsfRL9hb8WIFwomkR4rXvlooYNVrUv7cOrYTmGI/0
    G7imk8kKLOaQefQkTaJndRPXDS62YaEDlNrFF4M88UeeWxsY6zmZY9jVvWQGBY/DgzsCkgJ8fhM2+LICJfMUmo42/teQyeYD/NdAtARHdYQKbFjUavRVGlPc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yMhMjlubAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDIAQr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:16:47 -0400
Received: from mail-cys01nam02on0097.outbound.protection.outlook.com ([104.47.37.97]:28800
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeDIAQq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:16:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hector Martin <marcan@marcan.st>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 001/189] firewire-ohci: work around oversized
 DMA reads on JMicron controllers
Thread-Topic: [PATCH AUTOSEL for 4.15 001/189] firewire-ohci: work around
 oversized DMA reads on JMicron controllers
Thread-Index: AQHTz5gKKJGVd7y6pUmh5HcKqg5SAQ==
Date: Mon, 9 Apr 2018 00:16:44 +0000
Message-ID: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0968;7:wsALSiM65uqmmHdI8j/ywWNWM7C+4FWTeb+GKpkWLQ1wkc6J1vC91n+tygluQEtR2jRVa9GJ36yeBV5asbDg5IJk61J7ced5hGYEBGZJ7XPmXz50Q/+nqk3FIDeak/eLoitEoeOerHEwgZgtmLNmSDAbG0RAKRcuZJZiiKQ/XWxhtcEWr3ZO0kHC0wJdZkOQWRvLPxLSmHbJIU81PPovit6ZiC290+vuzgzTmSgcqSSBnjt9o/2kIfPXbr2MnJHf;20:sBm1NaGIqoG6mfxPhE4ptFGlMWZ05nvBxJA9uz/KRKWOyQhfVZ84Ca0To+ufIi87zFuimVwLCL67wTViMFgfWK/PEXEViYUNltsIF7tuCBgFvez4J3QXxqGQBJLg4PmaARaff84uvK5+1V4+GHh7ckstk7fUeg1etb77kN6/Jl8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 1b3532cb-8f05-40e9-5d7e-08d59daf2cf4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0968;
x-ms-traffictypediagnostic: DM5PR2101MB0968:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0968B123E62A58608641A6EFFBBF0@DM5PR2101MB0968.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0968;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0968;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(39380400002)(396003)(189003)(199004)(6486002)(53936002)(107886003)(81156014)(36756003)(10290500003)(6436002)(81166006)(5660300001)(478600001)(8936002)(8676002)(6512007)(106356001)(105586002)(5250100002)(2900100001)(7736002)(305945005)(2501003)(10090500001)(66066001)(25786009)(476003)(3846002)(6116002)(186003)(2616005)(59450400001)(68736007)(6506007)(486006)(14454004)(86362001)(99286004)(26005)(102836004)(22452003)(2906002)(316002)(3660700001)(110136005)(97736004)(86612001)(3280700002)(1076002)(4326008)(54906003)(72206003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0968;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hrSH55N6QBor+eaTVjCGvX0AOTQwN4V8QPxChCRtwqQFDLS/NL8GxTtK//5t4igMnebX06sLugfBGlR0WwqR3VWcPD+NNthYYH2Sm6K0AlMYpp8OsbJsRmJPMv0otLouxUL31Q+t+YcioalbR7usmqaPi83pQGNhFwRzXT82ffcH3H1jjS5uKsI202E1nk3opXTjqyU7fLJ5HfG5Zqm7V3qbKQL0mLLrcEgZM14zWDU/fOK8MvnA3y/eR0c9nlW8eq/6NH/oYcr/9J4/5iaFeGRjaoqB/RXumu5TIS3L/kQ9dgbgsWV3vAQTEd79Os/qW2ERK+ED1Y0t00uFeI8CvHLecqZ5R4VMNKSHEg6tVHaj9koXjxM+ybt6VNFOS5mv+EYbSsiPc+PEZGB5l18P6KVwU+90rDIGXFZwLnC2Sbc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3532cb-8f05-40e9-5d7e-08d59daf2cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:16:44.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0968
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hector Martin <marcan@marcan.st>

[ Upstream commit 188775181bc05f29372b305ef96485840e351fde ]

At least some JMicron controllers issue buggy oversized DMA reads when
fetching context descriptors, always fetching 0x20 bytes at once for
descriptors which are only 0x10 bytes long. This is often harmless, but
can cause page faults on modern systems with IOMMUs:

DMAR: [DMA Read] Request device [05:00.0] fault addr fff56000 [fault reason=
 06] PTE Read access is not set
firewire_ohci 0000:05:00.0: DMA context IT0 has stopped, error code: evt_de=
scriptor_read

This works around the problem by always leaving 0x10 padding bytes at
the end of descriptor buffer pages, which should be harmless to do
unconditionally for controllers in case others have the same behavior.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/firewire/ohci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index ccf52368a073..45c048751f3b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1128,7 +1128,13 @@ static int context_add_buffer(struct context *ctx)
 		return -ENOMEM;
=20
 	offset =3D (void *)&desc->buffer - (void *)desc;
-	desc->buffer_size =3D PAGE_SIZE - offset;
+	/*
+	 * Some controllers, like JMicron ones, always issue 0x20-byte DMA reads
+	 * for descriptors, even 0x10-byte ones. This can cause page faults when
+	 * an IOMMU is in use and the oversized read crosses a page boundary.
+	 * Work around this by always leaving at least 0x10 bytes of padding.
+	 */
+	desc->buffer_size =3D PAGE_SIZE - offset - 0x10;
 	desc->buffer_bus =3D bus_addr + offset;
 	desc->used =3D 0;
=20
--=20
2.15.1
