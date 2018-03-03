Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520119181-2-6803626194958677213
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520119180; b=i2uXLFL+ihjpiZ8v18L1wCeEwZRY2txN5+0XbpF/LbAEzQf
    B1LVYu4Z4hYr1Mc8jIFkQ1TTlGqXY5lbFhsWaBU9qW3BKSoyHyZM6bpQlnUSC1eW
    HR9ZfSenSOjE9UX4wDTApOhpfxYFvc/cE6Byh3cwhpXjprUZxS8TUGd4UhXrm+T6
    zcqrH4njXU2dv8YMb0OE2tNY5mI4MZ91XLdWfge53J+hBNULe6a0s8TNvcHqtOeS
    hd+hQatFoKo4nogsJRO7NBKHV57Yikc7Z9iM52w6nr0bBMOY60JEKG44chMSI1b6
    1uHF02ktRHDZtpqnRSaICKdDV1OpocAdp1fBkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119180; bh=7dmPD3
    7ZDZb3Gv1EKVR6nIk5YUH3e4tQgSROSZK+gtU=; b=DBlS9qGGkp3T+Iw7MiaKUe
    I9boua0liytOahOhT6u37CeRyGvm/7OaTIOSZnHNgeVkL/ivmxf9pbNPcoHB3raQ
    AbB1TFghTUzDXz+TVYi31QozNrsnJFw3rjRgkLfWqzNJMJqSomqzaqD9t657ZMT4
    4wwvdiGy8HkROd+pRTURTfg0dtRVQpNadr29i9LWAmbaPyazVx2rA7LnWx1WS/YW
    CPqAFP6DSOvarclZGmUDKrpP+ZBr6Cj3/vlSYDamyJSxbYkOlkSADLem8KMyDEdH
    iePKZCxwl6WVLGmcGcQiXWeBaX03EeXlzyXsTren2N/ZQOeEAGNyBAzFw4xhwk+A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eNC6dGT1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eNC6dGT1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934813AbeCCWiD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:03 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:21314
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934812AbeCCWiC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Changbin Du <changbin.du@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 011/115] perf sort: Fix segfault with basic
 block 'cycles' sort dimension
Thread-Topic: [PATCH AUTOSEL for 4.4 011/115] perf sort: Fix segfault with
 basic block 'cycles' sort dimension
Thread-Index: AQHTsz9K8EkUdqSNB0usyqvOgmAUaA==
Date: Sat, 3 Mar 2018 22:30:53 +0000
Message-ID: <20180303223010.27106-11-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;6:T8uEBNl19uymppHXMBSlhSFJPCbBvy2Lvwo/Kozzsjn/rqruKXeTkG2XZQpXLPn+AP8Zmx/3fin9pGGA2k878PKvvpA6GJN+fX4l57/bHDfx51eML9+12uPZSMc2kJWQabUcbNdqPebT8KKvA5aRFP3/q2ZhjjCpKRq1OwHg7bIm3I91wljnPT+8Ci+HHA7yYzVvMeyP5AL3l3Q91txf0RnBUmBjLz2XgR8EsI8010fnW+va6/CKhY0rNN4bi0wchm7aAyI/OpfWCh8eUyI6yANQnSlSUqv9PVrkrLxDHohHjfBKmg1OvYbCw72WkmPBDz4eudd1C4zaBTl+ZnG6LCQocHGXKBXHTv/iKQfjFgKfAoGq0UdyDDtrKBWRXZ3s;5:TDzOukjUWPnW6PZhmn/8zJ/ihDp1NYHbiLEJfKNaP6sdEPIlQFu3Od4/QO4fsKOXgrRpQApNn8fEFa68PBcV8/vzp1pARYcWHleqfvvC5//3T2akAh5IcgFgOJZVBzZi+zl82oFrPRz6Wu7rZLVVymGqriExuzH1qO+NAz2D5aA=;24:B+Cevwplx/bLEvugW3Cx7uSIhwB2CSqwujJRStpY6psrbxhEYx0C94TpmHbz4O6Xb9vLpdlb758X0uw/CqfOAbaRKkXQD+hSC6qonEUgTmc=;7:DKdLmvvISjEg0iqjGQO/Cm9pQqRrmr6NBCd98/eIFtA6OdHmDt0XxvKNnP1iouZbuOJtsMG6v6rZK6/1W2aeGDJ9i4Tor4mAiHD0Et4P5JpzLtteJiSWyayVSALs+zGPn68NQY0Q3TjdbhIc/R4oH3HA1u4V95eC53DUZZY3Rl8YuURe8glRe9cQG3F8qZ6MDfllTxRy+M7DL/oBFN74u7xxIPLoHNDxQoHsQlcFMQwkYJFCY6oDImrJug16XAl8
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61b21306-a772-4e4f-5a1c-08d5815769d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09380BBD615A58BCE3E3AE76FBC40@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(54906003)(4326008)(72206003)(22452003)(478600001)(25786009)(66066001)(966005)(6436002)(6512007)(14454004)(6306002)(53936002)(2906002)(6486002)(105586002)(99286004)(10290500003)(3846002)(106356001)(6116002)(305945005)(5660300001)(110136005)(1076002)(36756003)(316002)(2900100001)(2501003)(5250100002)(10090500001)(102836004)(68736007)(2950100002)(26005)(97736004)(186003)(6506007)(8676002)(107886003)(3660700001)(6666003)(7736002)(575784001)(86362001)(81166006)(86612001)(81156014)(76176011)(8936002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: e4Lf4rRvDj1eC72OFdJcKN3PjBUN/5nx1X1gsGohSyWUWd6kgOwwJcnLqbHg4dIh1JUm6xQJG/CBO7A+QRV9Mk1NyZC6IhplXM4R+h3n/QYWU8B1XcijFCNwhQ8EzOxDfO5gpKqARXwseB5/2/BDIIMqb5Z5p8X+6ddXTCrcJw4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b21306-a772-4e4f-5a1c-08d5815769d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:53.6508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Changbin Du <changbin.du@intel.com>

[ Upstream commit 4b0b3aa6a2756e6115fdf275c521e4552a7082f3 ]

Skip the sample which doesn't have branch_info to avoid segmentation
fault:

The fault can be reproduced by:

  perf record -a
  perf report -F cycles

Signed-off-by: Changbin Du <changbin.du@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 0e332f033a82 ("perf tools: Add support for cycles, weight branch_inf=
o field")
Link: http://lkml.kernel.org/r/20170313083148.23568-1-changbin.du@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/perf/util/sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2d8ccd4d9e1b..87312056f75d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -604,6 +604,9 @@ static int hist_entry__mispredict_snprintf(struct hist_=
entry *he, char *bf,
 static int64_t
 sort__cycles_cmp(struct hist_entry *left, struct hist_entry *right)
 {
+	if (!left->branch_info || !right->branch_info)
+		return cmp_null(left->branch_info, right->branch_info);
+
 	return left->branch_info->flags.cycles -
 		right->branch_info->flags.cycles;
 }
@@ -611,6 +614,8 @@ sort__cycles_cmp(struct hist_entry *left, struct hist_e=
ntry *right)
 static int hist_entry__cycles_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
+	if (!he->branch_info)
+		return scnprintf(bf, size, "%-.*s", width, "N/A");
 	if (he->branch_info->flags.cycles =3D=3D 0)
 		return repsep_snprintf(bf, size, "%-*s", width, "-");
 	return repsep_snprintf(bf, size, "%-*hd", width,
--=20
2.14.1
