Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521481313-2-2578648337352910362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481312; b=Uo3hAaN3sirfnTVAHmivpa5JRLaNwKcjr6dSyturH1i7GVa
    xqLcCxjNPk2SRpmgGcQzeJBEcAS6Xr98LQ0gOWvXubLd6ewEabdYsQ/qUZnLlPmI
    EabDS2EL0I3n/xGb1hcAyHx++QBpGs8nhKehdWY7lLrs4FnFBidtyJD8sRNTowgL
    ZusDrMPSerg2L0tpcb8iYGIrl+pt39VLZZncSeFI134rtyIFSf2YJns+WFKazHy/
    nSIsdDPgEQw7+UGgx1HFIZ7BZ1FDPOrCn1gpYjMqGuk1RJAxVeIFTx4TZMAq2qZF
    XdDXXNGZoZlEtuzZKTYWk2gH5rgY53Cga9Xeecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481312; bh=GLXxJY
    gAmZHaCO7KbZnoVED1Mf1gkMURkZcxfooQf3I=; b=D5oZEjodoF9zE1SL9X04sm
    gTVqH3q+EoGasivO56g009UTXzWakrirzPlaV1tN5uNw2sHmPN9xZaCw+56rHSuG
    84ad+yR8viDoKmc1pw8sXDnkvv97c8F3KD/n58YfGom4B1TWWLSFinnYTrksyd50
    ZvWTXIIZJtW+Z4eIkKXBWZbo/0s9VwdXJQxSGd1m4Q/8mAY0Pxhy2gkFS6ohELgh
    A/2gT6AM8yWM5kN144FvnMKwGMbkAfRIsCJU4IWQ8ym90lr5bEfQDvI3G+a94tmA
    iD6zvdK557SOFOhHSwTiyQoODP2ARC1g8sUHGN2O8lvLgo7zjL14xA4ZO7PLUv0g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFEK/gyN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvkedvnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CFEK/gyN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedvkedvnecuvehluhhsthgvrhfuihiivgephe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966017AbeCSRlY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:41:24 -0400
Received: from mail-bl2nam02on0128.outbound.protection.outlook.com ([104.47.38.128]:47286
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965868AbeCSQF7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 254/281] ACPICA: OSL: Add support to exclude
 stdarg.h
Thread-Topic: [PATCH AUTOSEL for 4.9 254/281] ACPICA: OSL: Add support to
 exclude stdarg.h
Thread-Index: AQHTv5u9hOJ7JRcJoE24K0lERsNpGg==
Date: Mon, 19 Mar 2018 16:02:54 +0000
Message-ID: <20180319155742.13731-254-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:kspoMcUuLvMx0NS8GY5h3xh5wE9tqS1Qle0V8ZaqXt5MqFAxiMxwBo/875i8yl8K75QClw06PvxLot2331u7hHC0eMJ1mTwpIKdNNBv0EQ44oYfs+9mBSFLHTKe2cU8JYDAAoymxMdh6QNUZGi0buwDao9YoQ1MDKS/UfYWUzLusLdjgmCOKp6XANqpxJL8XfAP43Dy0MhttqCF1k59zZjR+iVSOMvpgoGd7dteyVzwjdbcWdcvhIfAPabm4BLgE;20:SX+mk3L4GWvebjSkOpqC8vMqCLMwgIGzM3wd5dlKDQWKs9KKDsDfXHHP87A2ZS0wi3ORTERoGn1hMEeWh9jaOQk4B3P8kMWaO1R69AZ2tOoCtZyLj820MSwrtVESjGCa+y/HvxQwKG3nRV6YzXDq/NHZr5CRj+xjUVwe2re5vCw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cb14521-f6cf-4c0f-6228-08d58db33f49
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072727AFA76DB0FF0C7C5503FBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(166708455590820)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(6306002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(86362001)(105586002)(6666003)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(966005)(3660700001)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: M+3Yegyr9eOTZh9kVs9N4sCXELYkDGXcb5IJTA58QBs0MJ/rcL7vs0PVXds4072BlrOhywDNlrF9KloemRwJJoN0YfkDWbI2NLpCobyGyUj7g3YRHZQkJjxn9jHREPTxq8y7M4TjNwwjEX712XuPFu43PkHESHcdSbMWYcd9TEuwy4jVhCWTNkRqBq2LKaAjbzVQ6QhoFiAT3Vq232BDnmO8pmxJfqDEESscdiFBi7iN/6Qq/W6WXCfTh+lz28RsAbMPorIPhWWNGutm25pocR5E5dJ2mo9Z4ZmVdfLBYQz1DF621C7sVckA8UutajN1V0Um9IGa03LU1DfkYbNgrw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb14521-f6cf-4c0f-6228-08d58db33f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:54.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lv Zheng <lv.zheng@intel.com>

[ Upstream commit 84676b87b27d8aefafb9f712a5b444938f284513 ]

ACPICA commit e2df7455a9a4301b03668e4c9c02c7a564cc841c

Some hosts may choose not to include stdarg.h, implementing a
configurability in acgcc.h, allowing OSen like Solaris to exclude stdarg.h.
This patch also fixes acintel.h accordingly without providing builtin
support as Intel compiler is similar as GCC. Reported by Dana Myers, fixed
by Lv Zheng.

Link: https://github.com/acpica/acpica/commit/e2df7455
Reported-by: Dana Myers <dana.myers@oracle.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/acpi/platform/acgcc.h   | 10 ++++++++++
 include/acpi/platform/acintel.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 8f66aaabadf7..9e3f7618593f 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -48,7 +48,17 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
+#ifdef ACPI_USE_BUILTIN_STDARG
+typedef __builtin_va_list va_list;
+#define va_start(v, l)          __builtin_va_start(v, l)
+#define va_end(v)               __builtin_va_end(v)
+#define va_arg(v, l)            __builtin_va_arg(v, l)
+#define va_copy(d, s)           __builtin_va_copy(d, s)
+#else
 #include <stdarg.h>
+#endif
+#endif
=20
 #define ACPI_INLINE             __inline__
=20
diff --git a/include/acpi/platform/acintel.h b/include/acpi/platform/acinte=
l.h
index 17bd3b7b4e5a..bdb6858e2458 100644
--- a/include/acpi/platform/acintel.h
+++ b/include/acpi/platform/acintel.h
@@ -48,7 +48,9 @@
  * Use compiler specific <stdarg.h> is a good practice for even when
  * -nostdinc is specified (i.e., ACPI_USE_STANDARD_HEADERS undefined.
  */
+#ifndef va_arg
 #include <stdarg.h>
+#endif
=20
 /* Configuration specific to Intel 64-bit C compiler */
=20
--=20
2.14.1
