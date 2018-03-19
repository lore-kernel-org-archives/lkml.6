Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521494630-2-1457561014466212595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521494629; b=mZLcQ780C177SsSmzZlua49avmZBWXeNn+KdQc6odqiJM/x
    h/u90I/NK1y+oUWi6lHavgXc3qzJHgAbQqktjrTvkBa0AMLODQM537fciVvG2jOp
    esVc/rCMqKOOcgLa3BHwtaixyJxU6SkZ7hAr5B9tzon+VRjm3WKfxxq1rQQX4Qu5
    ISgP5p+VVhPmWvXT3768kyzh6n43t4HSyVc8rT+GPXO+0+8iNRP5pP7GHxm+iSoO
    qwQ1xG903n067d0fqsPOhN1UOhpJ4nY6Rf88Qc7Jri2jp6iQ2zeLTnFhRQZqCUPN
    uFydLIgEpPRJUNB2CkzcQDBZiUbl8Vb5/47TVzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521494629; bh=jh02gZ
    X1MbgvkOdrMR4BxponDAU8fNU7LdHjgTs8zrs=; b=PG/eoAcamWgiOFxCvWggxa
    /wpG5JWhqEhlE2aaA5nRjlrgcqgrso3gtVLLis6mWgFGL+zbDqMWIOwWdL1HqTgj
    Fa1sW8O8WC7+YNx6tKSAm5XFI27R6YNCWwB3EDH1+ybnwWmKKAwmgBMxa+yLv9kC
    q9kOg6Y437cNDUPJzzNROG+/3H0SpzhagsORwYDjbid/mPJvQKgLsT32kz+0Vlxk
    tgtrsRCID1FGRGAxACQwVlavt8aPLXq+9pBR+zMKSw7tl+qD7WWhbDzzm/wHE4L4
    OyDb3LgkrJX9vZy/fRNqqRNX2OAt6kisHA19PG99+etXWNqK/FInDJc01fiDiW1w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ORfjBN/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeeknecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ORfjBN/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeekfeeknecuvehluhhsthgvrhfuihiivgepgeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965415AbeCSVXp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:23:45 -0400
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:22848
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934790AbeCSQAZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:00:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 079/281] powerpc/mm: Fix virt_addr_valid()
 etc. on 64-bit hash
Thread-Topic: [PATCH AUTOSEL for 4.9 079/281] powerpc/mm: Fix
 virt_addr_valid() etc. on 64-bit hash
Thread-Index: AQHTv5s+Nd5dz1KJn0e+tmKCFSzYFA==
Date: Mon, 19 Mar 2018 15:59:22 +0000
Message-ID: <20180319155742.13731-79-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0869;7:955gLkH69TpaKT9Zwa+/ibxk3Ua/5Ynt2GySfw3csI1fV63DKnUyh30Z54nV8uhkKt7ROBwavKYnUcGT0ziy3WxCi5m+2CPM1udV0EeEQL5N06uca5V+kWsdMP1nRk4Lt4kToj48nAyHCGnp1ueyw6cXNvSE+Ulj/IgyYJ/jgwu/3m7IQQOP4apQI8FsKtYaHOqxh79PCHcTwX0VR3YGA3DTjLa8H/VAQsxbfY5hCAPjurXMLUJ7D2qO5eeH8EuO;20:HL6BETuv4X6WQWwqPh+QH5SaKnWsVKq5hkun2yCqf9/ovgqvX4W5f50bYkM8QFcA/wFjVks13lpc24paAGuV39v3c0Nfl72+Vx1U8Q1BWHq5qU3jpVassRwlsqiOaixrwP+QiyeJtPPYVlQPBfUTDk/5v03cjuEuWDRzi+EDZZg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da53d9c6-48bd-4bc7-c00f-08d58db27a42
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0869;
x-ms-traffictypediagnostic: DM5PR2101MB0869:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB086914CFCD55AFB84443C79EFBD40@DM5PR2101MB0869.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0869;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0869;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(346002)(39860400002)(199004)(189003)(76176011)(6486002)(2950100002)(6666003)(2906002)(5660300001)(54906003)(14454004)(110136005)(7736002)(2501003)(10290500003)(106356001)(22452003)(59450400001)(3280700002)(5250100002)(305945005)(25786009)(99286004)(107886003)(10090500001)(6436002)(26005)(97736004)(53936002)(86612001)(3846002)(6116002)(186003)(1076002)(8676002)(81156014)(81166006)(68736007)(102836004)(72206003)(3660700001)(8936002)(316002)(478600001)(4326008)(36756003)(6506007)(105586002)(66066001)(6512007)(2900100001)(575784001)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0869;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: NTRGTT8hbiADZN75pLVlX9CjVX1PlgyCuw02juw545Hgy0c47l/AltxPT0xIPrIHzNJ0RCsI1wDPqhR8CLeh4q1oji3boNOmiJBRi1X+AuJY0z3tZ77v4lTZL4yiYr2vfNJ1xStxXhOPmEmMInggXLxyhpkcLSGL3QtD9AGbli5ERJt/09UAcpV0LqbN3NNc6gIBVvuh6aFCrJrZ+PF9HgyFn3bKIxQHAtmLFsBHKMHzwkTquc9pV6UxIQJhSXbUe6PoCn48/hYnwks1wn0X1eK5OPj1+ay1ZFmkYxn3vj5VJ9JFrrI7q20bjnBzYqQgL3RVbfRdIdMPjZAKOL0Qpw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da53d9c6-48bd-4bc7-c00f-08d58db27a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:59:22.1762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0869
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit e41e53cd4fe331d0d1f06f8e4ed7e2cc63ee2c34 ]

virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page()=
 on
an address. What this means in practice is that it should only return true =
for
addresses in the linear mapping which are backed by a valid PFN.

We are failing to properly check that the address is in the linear mapping,
because virt_to_pfn() will return a valid looking PFN for more or less any
address. That bug is actually caused by __pa(), used in virt_to_pfn().

eg: __pa(0xc000000000010000) =3D 0x10000  # Good
    __pa(0xd000000000010000) =3D 0x10000  # Bad!
    __pa(0x0000000000010000) =3D 0x10000  # Bad!

This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the defin=
ition
of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET=
 from
the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would gi=
ve
you something bogus back.

Until we can verify if that GCC bug is no longer an issue, or come up with
another solution, this commit does the minimal fix to make virt_addr_valid(=
)
work, by explicitly checking that the address is in the linear mapping regi=
on.

Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on =
64-bit")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Breno Leitao <breno.leitao@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/include/asm/page.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/pag=
e.h
index 56398e7e6100..71c69883125a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,19 @@ extern long long virt_phys_offset;
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * On hash the vmalloc and other regions alias to the kernel region when p=
assed
+ * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() =
can
+ * return true for some vmalloc addresses, which is incorrect. So explicit=
ly
+ * check that the address is in the kernel region.
+ */
+#define virt_addr_valid(kaddr) (REGION_ID(kaddr) =3D=3D KERNEL_REGION_ID &=
& \
+				pfn_valid(virt_to_pfn(kaddr)))
+#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#endif
=20
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
--=20
2.14.1
