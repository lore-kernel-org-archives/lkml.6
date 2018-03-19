Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521481985-2-1168466451156637043
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
    t=1521481984; b=v4YKUzH/dfwpqNT3oMocx3RmXeXvVZvf4YDwUAwwmPNHveD
    ZOTF5K5huzN0qHiNhVjA9MrpHPlVVEgBl12NezBt//JpNakU9QjtL5OyYZSkJ3fD
    NghSMSFDk3EaXy7ZQtiAt9Sx3qzbWxM+ZWKnF4CIzUuMG1dtElbS1nqwxH6IxwTD
    Tx3XKJ/1TBANYrkTc+aZJYusF5I3mAQvEcaQsg0Ko+ShP6/MJ4HepGzKvNNY0mxo
    TZHoW10WYsTN+JcrpyV7rNJA4KKCCK69bNmDOyOI1/kSw2Z7ARWKlJOpmqWkJdx7
    Xjcuv8Eu3HdY8wspbv1H/aja4bs9m5bFzfEkFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481984; bh=xQQaZF
    jLCc88D4oRJO7pP1safPqkWIwyxWZ1GmGADT0=; b=ZugtTDWVqkYTUbUO2aKsjs
    1kvol0kahjEXv8c7HMPSxT6mE0VfiRLabMSCs9kBaW2wZQdZhUx5d8454D0ZcR8e
    1ksIiUiYR1fIHgyXs/oTy7fMEEiliqX8H5VIEpaemDSIPsxV5XLCJq817H4pLpai
    i4LV2r918Cqmu0RR2KhZ0bsb5WEMQNOQQtUcZDDhQDAq7oD/r8xOjI9cxP7o94wz
    gtj+esbqzpOAfcEX4YJpFTcoj6Ru9u2mkoQ2c+lwmmSdUx8MYrkgAH271lQthW9Z
    vpFiyKt7VDhgN0KV5OXS2+auOOORlu/V3a9MipkrTV0eRzHmVnYCPCvGc7kx6+Ow
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNQKfq3W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jNQKfq3W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehlihhnuhigqdhmihhpshdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeekheehnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965708AbeCSRxA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:53:00 -0400
Received: from mail-dm3nam03on0125.outbound.protection.outlook.com ([104.47.41.125]:4621
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965706AbeCSQEv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 223/281] MIPS: mm: fixed mappings: correct
 initialisation
Thread-Topic: [PATCH AUTOSEL for 4.9 223/281] MIPS: mm: fixed mappings:
 correct initialisation
Thread-Index: AQHTv5unxFEiZFzzPkWcOLPXjKkNaw==
Date: Mon, 19 Mar 2018 16:02:18 +0000
Message-ID: <20180319155742.13731-223-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:or4W+do4ZNSjbj+puYEF3XFmcbD9XM7h9UdAEXOfVLYvLgiKo5wAvqVhtJdxjretrfEQ2SaC0dYmN1GAHmIc3Swb6eqQ01b24MnrHQL7Gghb/2LTL51eqcdhtKf3JqrH3vmQkgr2zvwFf1YyFGkll8EjmO/BK+uDBpOauIJNjPEsDmF/IIVAfD5fvz+i3lMHNG7lX0uQUlkPfNrrrGt3bY0Grh3t0PMGeo9+gaBkYylJs3zbe7OJicOMEAETtcu5;20:ZhT3znXsrztJniBW9BTEKLkQqxlzwXPealuhgUiUkoxCJKdmOkrR7Qst1aa5vYy4K623ZRMAzUTlStDVT+x+m/48fypuDv8p3rD0+jDwaEC4VA0V5zRoNi3eagrl6VqeHBr/rvqgWf77GH3/ycAn6zCDeIwdOTA4U9VOTzb8Iy8=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1ed4f48-fab1-43a4-f873-08d58db3220e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0805FC1F58AE613C161ED2F3FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(376002)(39380400002)(199004)(189003)(54906003)(3280700002)(316002)(966005)(66066001)(22452003)(10290500003)(4326008)(6306002)(6512007)(72206003)(478600001)(25786009)(107886003)(53936002)(2501003)(5250100002)(36756003)(76176011)(106356001)(110136005)(97736004)(99286004)(26005)(1076002)(8936002)(3846002)(2950100002)(86362001)(186003)(305945005)(3660700001)(5660300001)(6116002)(6666003)(6506007)(102836004)(81156014)(81166006)(10090500001)(105586002)(8676002)(14454004)(6436002)(2900100001)(6486002)(7736002)(68736007)(86612001)(2906002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: ibVNOWTGQN0LjhJws9zTxECHHRi2MHx2kt5DpNWBOWa4f9Sv8zw0kJ4pH7xISImqYAjqy+b/4+jshwmUSjdM8QwcdtO4uGc0zgE9Ng8rsY+TU0mpf26XO9HrJQRNnP4GKuiW/rd2B8f5XjOfSH9CTyNQI0gCWL0TL9uweW4nVfj9uuqLAigpLf4sUkWw4Yv/S9mir4GSKdjqU4+axgYg202fE95jlEF6N3m+BTBt4ANh2+UhwcQg6Jj1F7ZL5XEmgVRdFxs4hI9PMIkU+GBk15KhI4RKDyUGSoFKgHWqAzX4t6AbEnGWG9rCNM5aoKtw+yjgYJuRs6UarfGQVoz3zA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ed4f48-fab1-43a4-f873-08d58db3220e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:18.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 71eb989ab5a110df8bcbb9609bacde73feacbedd ]

fixrange_init operates at PMD-granularity and expects the addresses to
be PMD-size aligned, but currently that might not be the case for
PKMAP_BASE unless it is defined properly, so ensure a correct alignment
is used before passing the address to fixrange_init.

fixed mappings: only align the start address that is passed to
fixrange_init rather than the value before adding the size, as we may
end up with uninitialised upper part of the range.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15948/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/mm/pgtable-32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/pgtable-32.c b/arch/mips/mm/pgtable-32.c
index adc6911ba748..b19a3c506b1e 100644
--- a/arch/mips/mm/pgtable-32.c
+++ b/arch/mips/mm/pgtable-32.c
@@ -51,15 +51,15 @@ void __init pagetable_init(void)
 	/*
 	 * Fixed mappings:
 	 */
-	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1) & PMD_MASK;
-	fixrange_init(vaddr, vaddr + FIXADDR_SIZE, pgd_base);
+	vaddr =3D __fix_to_virt(__end_of_fixed_addresses - 1);
+	fixrange_init(vaddr & PMD_MASK, vaddr + FIXADDR_SIZE, pgd_base);
=20
 #ifdef CONFIG_HIGHMEM
 	/*
 	 * Permanent kmaps:
 	 */
 	vaddr =3D PKMAP_BASE;
-	fixrange_init(vaddr, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
+	fixrange_init(vaddr & PMD_MASK, vaddr + PAGE_SIZE*LAST_PKMAP, pgd_base);
=20
 	pgd =3D swapper_pg_dir + __pgd_offset(vaddr);
 	pud =3D pud_offset(pgd, vaddr);
--=20
2.14.1
