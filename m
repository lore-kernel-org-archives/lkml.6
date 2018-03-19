Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475721-2-1710224668381198795
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
    t=1521475719; b=IDP/5aJMfXLLhicNh8mk7ZFkdvA3wW+NmR8UHFUvUu9QnNl
    WgsrNaKqvkaWqDOT4++3fH8lm41fjhELKA2lyoicp4xlh7zbxamIT3uIiBS/LCSk
    kJlArvuIsn8C7aAOVuXP0Y1yxfF5wi0FX9vxHo60Vr46RPjlYTUOz8CFBbrjws6E
    o1soP7OdNbL1cL9keDetQ70X3D4mB8TU/oNCnwmaz1n+BtwGGpnu1fH+aYCLC3gD
    zzYzs17dTt68cXdDlwbYvNZSkczwugHkXGXrkY+5iB3uWkW+1r0ygsv6BtP3qvW1
    yHQEwriyv0nVmy2AvL7Q1iXi1rF8dEB9HklTozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475719; bh=hfS62g
    yul6WdcBB++E5YlGeU8tCEHXeeCwU3Nqx8aT8=; b=LLMviCtYBCzkjonmHXH52n
    aIGfgGoUv3ArT1D5wRMov5D69IHu7/vAeymj0hrT5HPSBa/mIgpqZbhW3EExXYHK
    z8N8iCH75lnuSoL5VlDzJZuj2iXi+hq6SRoIuwXCPWMfgAJpiKM8cnXqgSnKU2Vw
    ndrZYtuA40cujapKGzFa4lOPZfbvg+Dq/oHoTkXi/klnepWeSzOzZdEU2cqmDSmQ
    ykvTiIRrEMT7iVm7IAp+TNG5p7QA2E3G3YH2HATV2/hvjMV1oVwm10HWh9oAY6Ng
    H32bXAXYBnTqFdli5U/X49tst40V1CSOjyjBqQ4Xs+hJWG3gW0clBQiPa2cP7X+w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nP6CyGjm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeefieenucevlhhushhtvghrufhiiigvpeeltd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nP6CyGjm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekgeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekkeefieenucevlhhushhtvghrufhiiigvpeeltd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965912AbeCSQIf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:08:35 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:3328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966289AbeCSQI1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:27 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 052/167] powerpc/mm: Fix virt_addr_valid()
 etc. on 64-bit hash
Thread-Topic: [PATCH AUTOSEL for 4.4 052/167] powerpc/mm: Fix
 virt_addr_valid() etc. on 64-bit hash
Thread-Index: AQHTv5w7aRmllRoGc0q9j8Avm4a2eg==
Date: Mon, 19 Mar 2018 16:06:25 +0000
Message-ID: <20180319160513.16384-52-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1094;7:aSqSTqZw62IWcdQbAuLQXrCuWiPvKj5XJWcRTSgBKuouTnveREZx8ba+2ETfAU9Ey4PlnrxMWVg90TZGFd9iP3frJ26WoATkm1EiCxqUPPLcWThfo7Ww0kPoN8w0GR6NQbAju+eDq9fwuj5ygpkehJB9SBqi0D6zzISmS0EnqraayYBIiyiAKXcTA5agnU3ToE9RSdOm4HUUG+HxTLEYJlqJEeKL9aaeEeRBJJl5blCMvd1qsMmhR+VAOiba1GnJ;20:p0N8s7+50qqrXwwDwjXcI1WIeayB1ZgX26k9eMnygJoBcX8gAflxCXHNX+Tj/lawSVO4In8xH5MusDfYi4pm4WKG+yVqFUnNsGFCGQ3KxPImatHccxSQNSHzIJ4pPmhyxB3O0mEygnlDDmG3LQcaYkKiCD/RAzMBtogMbjIRuv8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1c1eb90b-6ae4-42ff-4cac-08d58db3a1f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1094;
x-ms-traffictypediagnostic: DM5PR2101MB1094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10947F1F7A4BB585C5A51C19FBD40@DM5PR2101MB1094.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1094;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1094;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(106356001)(10290500003)(110136005)(22452003)(3280700002)(478600001)(6666003)(54906003)(2906002)(2900100001)(2950100002)(10090500001)(186003)(26005)(97736004)(5660300001)(72206003)(66066001)(107886003)(102836004)(53936002)(59450400001)(6506007)(6512007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8676002)(8936002)(86612001)(68736007)(3660700001)(86362001)(575784001)(81166006)(81156014)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1094;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uLCYFc++3YYs0VKBsVGjvZMgccm+Mc8VXcmbxnupOwHam1T3tK89DQ1VQSOdNMbyeI5X43GKyJkk8MgkU6ZLuTdoS7fY9w03pvLHw79l4N8LKzJnuXVEvn+DD3E5HTpcgfds/mMJUbdJ60E/CjGD0TEB6+8oMSln9xQ2pNKj8uSIKfT2OWm/vDQIYSlr8P+ukcFzUCK7lkgy6lXE8bnpYIdkt+PTpZ9Paw91PDHbw0zDk48Rr1F6OBTP882EvMrw33NCEicX+JUEB/LFLgUAOHqpI2a6nuwdqCHnLm9hblYxup4UyR/4SwDhbUXdWejfMUP5eBNa8LViUSf8uyEvJQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1eb90b-6ae4-42ff-4cac-08d58db3a1f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:25.8614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1094
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
index 3140c19c448c..70b379ee6b7e 100644
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
