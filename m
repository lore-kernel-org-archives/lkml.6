Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475377-2-4530398911264363496
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
    t=1521475377; b=UwUZapzhRi6tt3wAi1xRQ48bQTVJaV7+zyJzxhaY+9RabN/
    mDJer9cpG2id5oUTE7kQ6vOHZ1t0u2ylF+OtZ1MlPwZCdxM/Q3QD8T/Pwsmofg8U
    /kU74cx9N7SDaYjv4AUL5ZYq/mKKyYl4IH1ggMtOl/hEjfTIk16SER5h+4DlDsZP
    LsPVl+OUxVXFldq7yctMQAtWDrc8SJ1DyE0CFeXCtx0m4mRz3wnXFyDpscgd52PC
    iqUb3ULI0NYracGX5kND9lcbA13zRb+TqWkk6AaZ5M/F3Xjm4r7Ox48u0SVm76j9
    whn1RfoNMWYemLv61vwnvDpJZqpglOM2VWjIThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475377; bh=seCF4q
    oVeQJ7SbaRrnvpxOFBvNNe8rm1mehJTSHHKHE=; b=mYnXs1ltF5RVbzi+UoHbRz
    iqOxDNqQmuBaW7oEPosuGV4nzSwwH0qA7nEC/jHlZXfSo2UwDrzsHTkO4RQ2295L
    EJwNBwnTAe9kqR/KO1eJNQ2zxK/e9lCKLK/7kdRJe0MJbf/dXXNn6NhkA3qFitzk
    OTaa7lBd7mI/gmUWl/mgDGau52qoDKcqj/FyhAqt6IA0/vzyKu4bXE0rmHNAhwny
    Tt6ZNxohw4DObZYfgrlipU/Cu+QP7lhpYcswY3Cn6qiEZ/1VXRC6xLmqp0xjQOjB
    no++V1Hmu7qe5IAxyMGGJRQrbX2r4IpF8FBENjBKofA5wBcEjtS4WDXY+3brFiXQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UAOs35QF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdeiheenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UAOs35QF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekfeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelvdeiheenucevlhhushhtvghrufhiiigvpedvfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965268AbeCSQCo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:02:44 -0400
Received: from mail-dm3nam03on0119.outbound.protection.outlook.com ([104.47.41.119]:22560
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934816AbeCSQCi (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 153/281] x86/efi: Disable runtime services on
 kexec kernel if booted with efi=old_map
Thread-Topic: [PATCH AUTOSEL for 4.9 153/281] x86/efi: Disable runtime
 services on kexec kernel if booted with efi=old_map
Thread-Index: AQHTv5t2JaofIY+Vs0SOXS3UaKhFRw==
Date: Mon, 19 Mar 2018 16:00:54 +0000
Message-ID: <20180319155742.13731-153-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:XfRNs21ZBqj4SJj79LuW3idJRmZfXH4QgDhmxEFLQzYuMAy1lsdxJqTCzlNm55q9zSAe0Q7f61X42t7sVMPspFbJxdjKjBVrLZUcj2hrNoPUCkirmFJEg6pQgVWRd2HZzJt27zzFRWLUkC8h44qfE5rWD+Shnmy4sbA/HEmgTqz+Zb8JhI5vR0ACIJYN6uu5bacDtD4zocYPBNBb33G/2khquywo8NCxwvJSvIMfrMvkyprgMlyTQSLMyE3stPwm;20:rcabTF85Wo0Xid2DePP4aTCc1KYratH9VJwxyhyoBNHHPg+W3G45Ztfko8rW30qLVTtEWRMEkesvXLMaeSksk8GOFZ3zlC33GAcFozO/MLg+auVV8DF66SAXB7YuzeuNTsP/5puT9bxPEXK9quYsFM8nOhWOw5RLAjEFQ4lmzSw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56c62f77-1d7f-4594-9d4a-08d58db2d554
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB106236121576471BFC4FD04EFBD40@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(396003)(39380400002)(199004)(189003)(106356001)(10290500003)(478600001)(966005)(110136005)(22452003)(3280700002)(6666003)(54906003)(2906002)(2900100001)(2950100002)(186003)(10090500001)(97736004)(26005)(5660300001)(72206003)(66066001)(53936002)(107886003)(102836004)(6306002)(59450400001)(6512007)(6506007)(316002)(7736002)(305945005)(1076002)(6436002)(36756003)(3846002)(6116002)(6486002)(105586002)(8936002)(86612001)(68736007)(3660700001)(7416002)(86362001)(575784001)(81166006)(81156014)(8676002)(25786009)(2501003)(4326008)(76176011)(5250100002)(14454004)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: LXz1BL/gqFUOb0TAOsxbv31//Scz+cLz5J9SBmts/E1qFAimYu1Bt0OxFlsSwTM6zjSeyYzWpYnfedzP45Xhjz4dEI9p41lbrs1Udmx7VV82aXpfh7APhWU4C4jxjp9Pt0YiwXdxqhqjSuRrO2xA6Pli20vrb3VJSjQcnU/Qtg7SI9wShB5shkH31Qok8rjlSp0RKBRsXT9C2u2xN2lf75etDFC95+LsUIA04OUETPLU0QczxLBJgnkfv9Ey9kPDNzMP5RrhEFgrUoKAAe/FnNmd+KQeymgeG1jAEL0NBCULJLDjTM8AZvSe2xmm2vHk6+IGNBD99G/mogVWyGuqcw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c62f77-1d7f-4594-9d4a-08d58db2d554
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:00:54.8080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

[ Upstream commit 4e52797d2efefac3271abdc54439a3435abd77b9 ]

Booting kexec kernel with "efi=3Dold_map" in kernel command line hits
kernel panic as shown below.

 BUG: unable to handle kernel paging request at ffff88007fe78070
 IP: virt_efi_set_variable.part.7+0x63/0x1b0
 PGD 7ea28067
 PUD 7ea2b067
 PMD 7ea2d067
 PTE 0
 [...]
 Call Trace:
  virt_efi_set_variable()
  efi_delete_dummy_variable()
  efi_enter_virtual_mode()
  start_kernel()
  x86_64_start_reservations()
  x86_64_start_kernel()
  start_cpu()

[ efi=3Dold_map was never intended to work with kexec. The problem with
  using efi=3Dold_map is that the virtual addresses are assigned from the
  memory region used by other kernel mappings; vmalloc() space.
  Potentially there could be collisions when booting kexec if something
  else is mapped at the virtual address we allocated for runtime service
  regions in the initial boot - Matt Fleming ]

Since kexec was never intended to work with efi=3Dold_map, disable
runtime services in kexec if booted with efi=3Dold_map, so that we don't
panic.

Tested-by: Lee Chun-Yi <jlee@suse.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20170526113652.21339-4-matt@codeblueprint.co=
.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/platform/efi/efi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 274dfc481849..a0e85f2aff7d 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -832,9 +832,11 @@ static void __init kexec_enter_virtual_mode(void)
=20
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI
+	 * non-native EFI. With efi=3Dold_map, we don't do runtime services in
+	 * kexec kernel because in the initial boot something else might
+	 * have been mapped at these virtual addresses.
 	 */
-	if (!efi_is_native()) {
+	if (!efi_is_native() || efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
--=20
2.14.1
