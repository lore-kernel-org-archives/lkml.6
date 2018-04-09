Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238987-2-17264706472445289642
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
    1523238986; b=t7vn/a+AxVNQ9YAIaOHlpLEImkBKRB7x4A74q0SFA2bhsS7sEE
    W1aH0X/pdPt0i5wIB5BZIUs+Qyur9vVCV7c44VrbVzm09jBf+TWAQMq0SJuhHhsz
    BmNld+/xCehZIHN/7ItVR/WimxIOZaSPmmZXC5NYX0Ju4XvY6zpkaGx7k3zNF045
    coFV6xeqLM+zHY9BWlTWls3zUNoBYtwu1a+DZdBeip6xQwfekQJ41BabdngpT1Gr
    ZGM1QmJ8T1OvQLu7GAapUYQQ0WNGnomBeJBg7lJeJL5cQIqoI5FcJBetr2v/TSYV
    OqwQJoYE5Pw0nYrrVPUi7l255tvNYkef0vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238986; bh=paVkpnR0WK
    3nrFXj/QrAZJTZV8+ALcukEC0hwXPyDSE=; b=pjBfokvcqoLUgaa7JjSksl3wVt
    /f6ErU4bP7vLEymM1K9mF8txjpFklk2dTDOnZatc+1hgKrMycy72ZpDO6TJ0PEPo
    r604CzUKEEpZApJK7HzVPqTT2O+rFvOgFRa6aq8xvMCfLKyPwF2kSpZgE422CAEW
    MYP7A8I1HTTHET+ScebvqR9Ml2BecZYZwZ2Q9t+Rjj6qux9eK3S1bK5cDy+7gOU1
    Yp4xRSKdlNp2y9HfT5zBrDe7iUYwTMvurigSZV7lklJnW6Or5M2Oa32+zrLL7amZ
    8td+O9sidFp9TYlfpVhgd3Jj7R2QQayrVwGINNhyPm/TJfxOOFNK1etQ+24Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SBbpjwj+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SBbpjwj+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJmo3XYw/bDbrFibnYASkhtkzhAANL77V/o14StNpRe/SeOUQZb8OsInT9n9SRrZ4lgbPXp1hft8KMRiRkvgZK1iiMwBaLQxIJRyloFiWoP2jDuGmfkV
    4zECIxj+m2YE9IAQO9ABslw6kaOwk7zfJ3G08ZRHcVGrAKMadLT/3SAwtEhrnVp9bkS5wmhGKFjQi6ILz+J7N9N6m0D0J7NNaKHlh8MV5otl2ZviWCei4+A+
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=yMhMjlubAAAA:8 a=5G0AJqgLdFttAFhcDZgA:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeDIB4N (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:56:13 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:22599
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932167AbeDIAc5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:57 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 224/293] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Topic: [PATCH AUTOSEL for 4.9 224/293] perf record: Fix failed memory
 allocation for get_cpuid_str
Thread-Index: AQHTz5lPJdji/cI8IUKOSbwOf750RQ==
Date: Mon, 9 Apr 2018 00:25:49 +0000
Message-ID: <20180409002239.163177-224-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:EfZc8PzMx9mXcUhac8lPAoqGCv0yjpO4BRmG8QeFtH6jxUF4kTrKH6NomB7wG74SLdzwJLL9Ifu9+qUjWaeg2j6+KNic5tvtlusp2MqoiLkziKQYAh/JgAyz2pzVZyKqfKaTNeb4ATW0g6gk9doSsI23/8A0hGr+WcBgrpeVX12sDBtbYdf4dU8SGrEMyJzQDYw+i0W7yAlY9JORFBim80adqzFBVCKani82Zm5ThjbyO9ATlguviik6/9yHk1UI;20:CLCCMgSWJrwgSAnLf0q6OQYttwskmDSLI13HmnZJ/FHTq5GQHt1P644zvnj4V8uBNo6Hn5OMhe0NkCx1r55YodkxRw8m/1Z53PxOzefaFJK1Dcrsg0ffxaI2xb44Xczh4B4ev2SpRIChbQpTV1DOrir4nTSSw4mSs/jl8/Q574w=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc3535ba-a9f1-47e3-06e7-08d59db16f82
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0902F31F13EC68825A84471DFBBF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(190383065149520)(42068640409301)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(39860400002)(39380400002)(346002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(25786009)(6486002)(72206003)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(26005)(486006)(10090500001)(36756003)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(6306002)(53936002)(966005)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(68736007)(54906003)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CWaaifOesKQIVFrCQQqlsSHyj4jQ0ix8lO2rufR/gV5XWXAcUW3jNRIIvVYbq4FhCBHPAHoIZH+AbDy2P+NNSxYM5kCemZF1vKuHiplPfYCyePeySli41ZHgBKXkgfjR4PBcYaud5BT6zWXx2A1DFAZrTz1xMSvAecL1SJB86FICj9ZH/XFI3tb0TGKFuRgTgDTMyNDKkyNreoyIidav5Ij5COB5Rg7nhB+8qT62BoCeMEpOtGpl1MMjkt1cj63KqoOk8F2LOcyKglMVRQwVH8+WWzDk82QFu9ImXBWfQ2UTPsZtbFuEtCTX3uBuZVfQcz4U6blrXxzV7FXt5fuiT37R+6n7YPIOcKgPWpC7hGASUlwshYXzYodhZuADW5wT+1hvxgsHwv7fU1bvdZ3mFdM1IRSd++WyQ7/8W23iYy0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3535ba-a9f1-47e3-06e7-08d59db16f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:49.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
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
index a74a48db26f5..2eb11543e2e9 100644
--- a/tools/perf/arch/x86/util/header.c
+++ b/tools/perf/arch/x86/util/header.c
@@ -69,7 +69,7 @@ get_cpuid_str(void)
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
