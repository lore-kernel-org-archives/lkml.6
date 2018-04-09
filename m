Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523237316-2-3482277718405498285
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237315; b=FgyNhVTIoprzq9H/k+vtNKjVc2UQh7hw5Q/IcTpO45gZHqwqCM
    o/6F5Ti4j2zET+mNZ1a7lnv7mXAvKmo5S6DOyOlhpav+F3JQfkndtDf6dd78gjIH
    bQM7u19gLzNWDh0QFqNf6aenBKXe6s6mBVlak5janhxSE9SCJquMnfaQ2XGDqC3+
    f/CfsjsNHeT7GJ3gSEI8OrMR70qBRUVV8MZM6p2cOBdBhKgbA/Ypms6sbIFUiq+L
    rPL+HUqCwLnXb7efoz3/6BVjcBnLWfB7tWzJB+6spz4oMLbyhKYCpdfX8D418cwh
    sBazBZV2Ex77fa+9udo0gAB9fWC6/PbWDDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237315; bh=w1XtxC+Adn
    j2sCyJ7ENVtJkh+HRgsE9Bzg5J2iMLaEU=; b=E9uMh26OVuCPXobneiKfL0Tj46
    yTBs0rJAOfmhfVargB8r8F7eOB9TUphXFCmRgifrif6qjuY6jL+nFp6KpVreCfmR
    6PHHmHvYbt4mqPIpFfu7ZJd6pnk5CzHrfblA286mZ9Psg4YRmD0AvHNxN/rDXotU
    o+DX1TyFAGNv2j61tVKaAYzBkF3sN8wmNBAtLcpKaEayxZjv9xE/0wRGzem8uaGR
    6wQTrf5pDz+hmTexefdIHPzq/yXlWzyORFzdjjpWKLhnNckgknNGK50PJFfjP/wG
    yhHteXP/zzhKe99K6TrMKfWnS51hn7JXpfuk1g3ik09oEPpJ0AAnk5yCiHkg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IO0xBjiX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IO0xBjiX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC5HZP7eINQ+p7MOf5bGXN/ZtczXBKdNG0qFtehNVlbOXmlJ0NBCM1j03e4Y9pOnciP3LIqIDk6TDlT3STHAFeNVKPLh1PwEUggFwoJgq9RlGG+nwyA2
    90boiSf9uGF0sW1F0MO82opDVOx5pkHX6z0MaDHqRv2hlOp/4ZFHPgfajFKg5Af8/APN+PgXPl1tvIbiO4eCyXodWSACugEw9dTPwL9aDs6aMpEzHl2OQ+RR
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
        id S1757241AbeDIB2M (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:28:12 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755728AbeDIAgL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:11 -0400
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
Subject: [PATCH AUTOSEL for 4.4 053/162] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Topic: [PATCH AUTOSEL for 4.4 053/162] x86/nmi: Fix timeout test in
 test_nmi_ipi()
Thread-Index: AQHTz5mpamERYO3zDkOlC0n/t8mffA==
Date: Mon, 9 Apr 2018 00:28:20 +0000
Message-ID: <20180409002738.163941-53-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:u9XiJz+k7RSKTQ1hI53NcT1GvoV1sZNl1nn4a3SN2b3KmwSJqeoYwX7RtYbaqw9sdBJ5z0pA1Y1d7ch5M7Cvq6e4ZDwFAZJGU/jwRPN4g5lXr1JB0CI2Unu/Tv0cN+ALU3UIfQcDSkPFsdggZ/F8nEMmHXl7OkQUvQMKtzzYGYkVjMPn3u/nivpTOMEpdyhYBvd7gfbM0EA167mi1qun2vFFGKzC6yL9LmM+6KFtMAhUXNi63a+1Sw1KopIqHQiz;20:bwI2jqBv2m5TwDFkgaWRGxNk7hgxtZP9uVTmMP6Q3MWsn9TfVP1bE1d5BICUOKYC3dWUo3iTWCBBoh5X0bj5vlC7xkrNREwJd/d820zE2nlbFxDOUMR23XHiL+EzNHUlIk4DQ656MIPhPXheApBb/wUvN3WZ/x4KKJsLinJHcTc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f349cd52-1932-4ce5-c742-08d59db1e2c3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10154AB791C2F8A506E10E56FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(966005)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(6306002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Ncas7V+rX+ZO8APCEbTSzQuxD8N8kpu1Q4DQ9ipcPm4mYvTVkGYE3+aqXPKoKCsPw62V0fxCwhpnshWSN7arYHJYhI/T+d3/iSel3syqTIMyhSkj5mP3IoeHNaiO13dSmKEeDEdHftpPAuynDZxECQNRdaJw0JwHyEzzRfO/d3qTd8tyPsm9p/Q0QIsVZscF8AxZPUiF0cODPUgiqHq6Z4AAqdLuEvnNZ02frjqBMYWOv3J/iP5ryMXe6GiexvQeBsXXGBA8dMnK8oBOnzb9+4IZm9FPzrZDHk3gHPHYaPQDsROwIjj3dqU9jHQZSN1abdgJ3YM+4PUyAhPOSB10j9XxfglJUH5tP4mpTowENFod5f51lh+eHevlOfjavjUAkiNQeEr5P+kneR7FEFEeEjcGfCt1/G6AcNdeGBVQvqc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f349cd52-1932-4ce5-c742-08d59db1e2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:20.8644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
