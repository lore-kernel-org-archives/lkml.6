Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235428-2-1798374102661716033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235428; b=s3BuwPCESaJW9bzAXgHeSrGZHvsNcOn3VBJ7iN6yn6uxi5fbpg
    VUkJOV3jdh8W+BFGfgOd/VJuSt3Ndp9DzwaVY/G9Mpa8BH+yZD+crWa5w2JuORql
    YBuhKY5kWEGuRnlSnC9luD0QIANICcUieFh12LEDy8z8e/ylamFp4ebK6EY6E1f3
    gOtGK7Zi5i4C2tuALrGLfn/DEo8NeJNmbikH4wV0a1HmdvYMSK/0vMOF40rHYOFa
    +3PBmVtkTB83Wy8axNSLQnpDW6UlGr5XT2CN6SVOfc1t2KlyuAoBYitLxVppIt49
    o4gj7on/NXgVZLe/zzu6Qfo+A5d5f4/fkCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235428; bh=w1XtxC+Adn
    j2sCyJ7ENVtJkh+HRgsE9Bzg5J2iMLaEU=; b=e7bPPrP88D9xlg9c2Qh0njs51j
    PIo7LBKYm22bNouTXdjL/EtLVndMBdpl0a3nCSWqhIOsY3L8CgxUeU1JawDVIkLF
    i9PTD07jKL9iqFbO9a0VX8iOHORUh+/Gi/4TviWeQ6DnJ7sC3tFpjUhZLKetqtdy
    dpU3sp4CfqoepiS9YcPLzauXx/h2kKZr/B5qGjmYvBYXgS/7QdhaoP4e5OV+VykV
    PdHQmqz6IIKmUYyESnuB/ji5UOQLTxQ+Y5apfseiKClZpy0hunJi3vEyRjH8dXXh
    H/wRR9EMO2e+z0p0oSuuo0s9Nst2ln1o+IUHN808YcUzbRhME7/HMm4TpoYA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XDs+eWYY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XDs+eWYY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMVIf/DGWFhfS6qFkpcLckXlmU+k4O5Qe08Y+6MhR5cCZLSbtEnxoIi8Y8b4LbBvdmnC9nW7ZuptkrFGbwG9eOs04wEsXlUbldZcUlSnhWcMYimpDNGc
    Vvz+Q0G8BgHmAXkAns8EBo+PyzUoD/Ghb0rWt18M8LsPDEJ8QI7EXP2RtV2PAOBgsnIG2c51LTEv+zcVWYx7vlvR5RCyKnR1qQ0FNK/gs8d9uKKbKM6sYmaQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
    a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=Qwlc_dSzXDkvjYzUon0A:9
    a=wPNLvfGTeEIA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeDIA4v (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:56:51 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:64040
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933268AbeDIAkW (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:22 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 039/101] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Topic: [PATCH AUTOSEL for 3.18 039/101] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Index: AQHTz5q0GfVUfSzo9UKBt5ZT0E6K6A==
Date: Mon, 9 Apr 2018 00:35:48 +0000
Message-ID: <20180409003505.164715-39-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:PVmVc0D+zMNBM69xRNTK8qEv1KbzaNyoGDJDO3Vt2bUS9sxx3hpiyGDoZebmJQW4x+axxR52CNRq458fcmqkRBzJEaOKIJgW4bftssPQQIWeZadB9/a9aVUgETkQVIqd3JhSRxJsNasqraS/gpBvxa2Ww80o/lY0M9KqJq/gNFQLlFzcAGgLMi59oRp+zb0vTTndMxd5A5cX45TLCVaIG9XA0oXAFYVs0p+cx4OswOh+sBcZlgABRKnle80yqIXA;20:dtgh4rhT6nn9H5S7qTLqCIFAcwngm4H/nZNzI4VXugkd15SlbAwLQ/vdrDmnO7WelrFvYVjX1mbXsAQiT2tsnrrO0RTPPpyknPtmjjEwPkJrOkzCJRu5W+CS8JQyt9PKOsUjYMnEfDcZ/jrp3tp9ftY88uslAbaph0BwlyKej/Y=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: debaa459-242f-43d5-a079-08d59db27898
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870F44870FE500D8C4CC209FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(486006)(59450400001)(2906002)(6512007)(6306002)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(966005)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C5G189F/lRZ+BlNfYHJvDFZP9qO18CITLzUGrSl8dCz4UyrEelhIQEI3Bz9bdHCHlW1Z3Q/nM6JXkV4IMKRj6nQDNW1WOwvcJWUZSf8+euxPC7O7pjPaLZGtyhR3snzk2HliwBTzNpSCcvMtFqSKfWS83wJVu4LsOYBSBPcvonxZTn6Cy/KaZeXJdsM3FWHRsuYCGAJidUucIjmt9XhIcxEr4UHfwn6T3q/hM482NtbHeXqH2nvhcaM5nv7UeAIvx1QCZSQnEQVDM/mIbUp2C06gHVNtceDeAd5x/msLBOcNDA1w9nUUHo1ekVFuRcp3rFtjOkVHX9dsGllPD5zpFTdWXpn6UqIaDqcruYnxjHUi932iMBUoMZeh/GjfLVBoEk5E6OJeFZ9fgINg4tb3dXCBJrU9rkd2UFgT6M/wgMg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debaa459-242f-43d5-a079-08d59db27898
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:48.4391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c133c7615751008f6c32ccae7cdfc5ff6e989c35 ]

We're supposed to exit the loop with "timeout" set to zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Don Zickus <dzickus@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 99e8b9ca90d6 ("x86, NMI: Add NMI IPI selftest")
Link: http://lkml.kernel.org/r/20170619105304.GA23995@elgon.mountain
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/kernel/nmi_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.=
c
index 6d9582ec0324..d27f8d84c4ff 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -78,7 +78,7 @@ static void __init test_nmi_ipi(struct cpumask *mask)
=20
 	/* Don't wait longer than a second */
 	timeout =3D USEC_PER_SEC;
-	while (!cpumask_empty(mask) && timeout--)
+	while (!cpumask_empty(mask) && --timeout)
 	        udelay(1);
=20
 	/* What happens if we timeout, do we still unregister?? */
--=20
2.15.1
