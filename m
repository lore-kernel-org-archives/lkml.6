Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240110-2-725193679483943474
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
    1523240109; b=dJo4eCfFesPxxgX/jWlD4UYxI4EeWGIaGTgA4fQqygsV08as+g
    ZebDtHmeu+sXO5F5vRdQRLQMf6iQ57uMcHb+lPf309Lplg3vUlkUbPesvL/RGH3f
    b1LZd1dng1YEQ91Ac8O4Max5kKfFH3vS3Cw+crLgHkGsWICbu1VgaMFqyfTdtb/n
    6j1n8aKChH40q16QuO7NXkb0ZPfaPmG9GuCYn/9dyE2xQ2schokwBI/hNu9zH2ap
    0PaJSm/cw9eS2dEpI2SP0CjxDhpcp2uPyl3TIIZzM4tQT7ju4jbPOxNj/5kjHhEV
    7dtvDbe2GA742WBGCYOfOr31Gu0l07gwXsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240109; bh=HO4DGROzvj
    yqyAMFH38P4aGXf93h8j1FAGivl6aN53A=; b=N0ygXypJxdicrH4woYaWkpbaYV
    JPPRwiUyUSW54J63jmK9RpTIavOiJTd/k2iDs4QbCnnEnqnZYkjdtpsS/pYxpS1o
    ZHLBEBctRo//8yNpyizKL0nwJf4YnbgS66OKpxWrhzKeA7GcF62UtQryK9e6GZCU
    MZUkomafQ8M4j4JcRo65lP3LtphL93140Gu66KSfwHZfw18UZM6gSS0GLbmWbW8g
    K8E/MCpcJfKzb+Rw5t1xUP/ltwzLBnI6KPzPbft627QWr/8EfkLjTzsLtufRZ9xR
    aq077ssYrwSqZMzN1V8/N+aYr18UH5b21kUv0W52kRo54oBRv5Xb5fsRBndg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HHQlnK5S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HHQlnK5S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCF3ReCMJ6uMNl0QWQbGuzpUKlPbwfMvrO14sxVvNg/5BF9b8w9K9C5fNpjtdwOI0Mc0T0AV7U0tgoW86hPl5XKbvot1W/evxpK0HKR+rsKVEbXGGFiD
    fI7b4PWkK0xEzcZ9ZUhN3nJcVGrGjI61P8PSd6CtBCk6aTcLXgLOg0JDRg1qWMOZd5PZSpyS5tdPcTVvg38SC3d8JE4PdoLcIaUXpYmY7TVJaVjPu8Wm1vQN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=nawXQgyF3VrdwyxV4rYA:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932168AbeDICOo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:14:44 -0400
Received: from mail-dm3nam03on0104.outbound.protection.outlook.com ([104.47.41.104]:17478
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756109AbeDIAag (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:30:36 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 146/293] arm64: pass endianness info to sparse
Thread-Topic: [PATCH AUTOSEL for 4.9 146/293] arm64: pass endianness info to
 sparse
Thread-Index: AQHTz5kqEJjZeBYDU0+UFEjK1aG7Yg==
Date: Mon, 9 Apr 2018 00:24:47 +0000
Message-ID: <20180409002239.163177-146-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0807;7:xFMDZmlRVAzDZFurWDWW552ohq88Lcqhq/i/pu67W45ufWCks53sg8ekptnKf712Hbdd914QQUXSrVicyyDoIWukZQV+bo5ONcwLDXznLYMz/Hg7tqXMKq/DCQctYmS6wKF+cubvkVIdPeZoesJ6SbdTvAejQWBXd6vt966o41Ebt58nJqpgO/W9wpuMkAQwITb5bmq2Zgzma/KD99lKQf6qSEbULQ+9j1CHvK0NCZXDz4BBVqA12DqO3ENHtyRl;20:60FIFHctz/Ir7gMSnKhdzeaqgbOJRWzTTkONyRiY2xS/iPWXQB/yv7HkxNEd2nIMNqqd5vjWDtCuINl2tSFYT0I3sPyNvhqLNc0DyaBMd5ohkYnMh7RfBzc8Uy+qU82ttymGP9Y5WwcWreP0eBY0HdRlbP0mTfDJyOfZBS0snpw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e153207d-6775-4f8a-f9cc-08d59db11a5f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0807;
x-ms-traffictypediagnostic: DM5PR2101MB0807:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0807A8528D21B2D6B25D10D8FBBF0@DM5PR2101MB0807.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0807;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0807;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(14454004)(4326008)(54906003)(25786009)(53936002)(2900100001)(1076002)(3280700002)(6486002)(186003)(2616005)(68736007)(110136005)(11346002)(10090500001)(6116002)(107886003)(3846002)(36756003)(8676002)(72206003)(22452003)(66066001)(26005)(39060400002)(6512007)(478600001)(3660700001)(81156014)(86362001)(81166006)(86612001)(7736002)(305945005)(8936002)(10290500003)(6436002)(105586002)(6666003)(316002)(575784001)(76176011)(5660300001)(476003)(106356001)(2906002)(6506007)(446003)(2501003)(99286004)(5250100002)(486006)(102836004)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0807;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: WQzL4koK2EM7Q5K/XeO/1gofuwH1rucFctUOAxV598BRn0birZglIL6AP455k8GQOX4fm2wQBT9QjNKRC6b4gZa1OYMTvqchwsPvqUZWFW07EmSfwflG+f6jyoRqg+3DxXgCUOA1GeeAWc+6rfWtbkUj8+xSZVVYE4HAgqSEC1Z9dihjUF4JYCEpTNsCV/iQURYVBVzHuhK8ueiZmboOCgylmv+z21JVmYWELAaO+w2VXI24p2/RYCMsxnp7ysce5Pdsj8QMcB7z2KU4FLrSo/aPPbmM7jqZUluUT6Y7VsChxwmMxkzpf7xX5QzYj7GqQ4wuhYVKF+J1bCF2OFSK+CWYSPHrTYA/fTaZgiY7nOopgY6q/+bxYkn4pmr6+knDilpjReX9bn8Llwwop8KOmlxh7ltddStFDpqx9iFPYAQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e153207d-6775-4f8a-f9cc-08d59db11a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:47.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0807
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit bcde519e8c325f3cc1fcf443eb6466e6bb3a3aca ]

ARM64 depends on the macro __AARCH64EB__ being defined or not
to correctly select or define endian-specific macros, structures
or pieces of code.

This macro is predefined by the compiler but sparse knows nothing
about it and thus may pre-process files differently from what
gcc would.

Fix this by passing '-D__AARCH64EL__' or '-D__AARCH64EB__' to
sparse depending of the endianness of the kernel, like defined
by GCC.

Note: In most case it won't change anything since most arm64 use
      little-endian (but an allyesconfig would use big-endian!).

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index bc66f4b6a1cb..b0babc09577d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -48,11 +48,13 @@ KBUILD_AFLAGS	+=3D $(lseinstr)
=20
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+=3D -mbig-endian
+CHECKFLAGS	+=3D -D__AARCH64EB__
 AS		+=3D -EB
 LD		+=3D -EB
 UTS_MACHINE	:=3D aarch64_be
 else
 KBUILD_CPPFLAGS	+=3D -mlittle-endian
+CHECKFLAGS	+=3D -D__AARCH64EL__
 AS		+=3D -EL
 LD		+=3D -EL
 UTS_MACHINE	:=3D aarch64
--=20
2.15.1
