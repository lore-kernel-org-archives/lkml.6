Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477358-2-11545018908632056871
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
    t=1521477356; b=lT5cB0GFDflw/sw4LAQ1mJ+IKjyfOdzYzn8x2pvM9983EfH
    ZphTg5LtvHI5O7TDkCxbrmWvT9igHDwSToRq5d5uJynzurOzRdopR9zTMy/K1pFu
    TU4J7HUOf+AFWOEZavIspXPyfRIAxST5rbN2y3F9WGGPcFR9y/3iI13ISXuu+Q1J
    t48jLpll5+ml/i6hWnfdhzSqgfrcAMzEdVzwjMZaUAZehQxtibsZu+fczBco6wjP
    92SLZ2n178veIio3Ze2Ge02kNbSRBiR0BIduvf55uf+q95BFEME3AkkX6ytumKRb
    ngKFUxmyXWDivbPIjnKLFoLbBt8YliZqUAvAQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477356; bh=Kb99At
    zmlRi2cGKxZR08hOyvDv9dSnQqoUq8wlkY+aQ=; b=sE1bXY47vID4jQB4AK1Gum
    +lztiCzXa9Aale4ezGQi4YV3OjerqRfUC7NK4V2JPKHNdIl3fBXZdQjzKKIP9nk4
    mVgaVavbt8zVOi/RTUNwVkHx5bX3LfhhkNba8cn5C+cDYLOA1nhQB1q0mykGhswp
    J/0LIHldNv6zrwoV1jfFSiY5DGb3BEa1I1MmeZzUmLIt+Wdn6LbBW69d8uowdRkE
    dXOPiO06iLBFOQSY3ZyPuqkno0Vp/0Yp6PAkAa1I0N4gUdxyp2OHXvXUGajIDITw
    gyHa1jFOsPk5M7xnGlS4yw954EkY+E/kkQirEegOjREvfgyuHTiXOe6sj7KnccCg
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yt406JSg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvkeenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Yt406JSg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvkeenucevlhhushhtvghrufhiiigvpeduvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935072AbeCSQfV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:35:21 -0400
Received: from mail-dm3nam03on0102.outbound.protection.outlook.com ([104.47.41.102]:10304
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935294AbeCSQN0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:26 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 062/102] powerpc/spufs: Fix coredump of SPU
 contexts
Thread-Topic: [PATCH AUTOSEL for 3.18 062/102] powerpc/spufs: Fix coredump of
 SPU contexts
Thread-Index: AQHTv50eL/MWH0k9Bk2oU9tssVK/jw==
Date: Mon, 19 Mar 2018 16:12:46 +0000
Message-ID: <20180319161117.17833-62-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:OJjszBA5CiGKXMgeUB3J3Tyqju2y19M+K7/lZV6gdk9ObSmHzo2nTY56LYjmfNvHKCYvazMiMk+WqZ9V414rpY5pEezzqzs8bFf1+C+miU2kCGxLzlcsMkhxTVLyJ+R1g09dUHssbM9Fe9Y9vkT3AQ2oBKk0xS1yrLqL2+kPUf0Qbbg+mDsBtO9yRR58iRUZ5v9mzC4rxkaPrFUaE8v7jDzgaVFus8bZHcf7NxNeozVzAqFAqiG126liNc97fhB6;20:FeTq+iOA3Ki3Y+U4OzhxEukKRH8qCQ4eQAuhZrOkx9LOWQJ8l52sGASDlNWyD2Z33wZ9oV+vPxSdup/X9g65HqznDzus+bh4E3xOHHVp3pUBeVxW6kXd/m76isbR1mYJEsJ4/cxSSx3HXL6wQm/YRVCe6B1u1lURYe640CaNnjE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cc93ba9-55f8-4eb8-cebf-08d58db45397
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10322A0CD9F4846F33B50D38FBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MjTYOaOHg4mBk34CRT3bBUF7KRLWT/zSrJfBvya2HfSwrQprhH6ahemyjGKJJIwGF/dCcaQlM0G7N3XdURp22hBXf0pQAnodwQrowpi9ORdxdbM0yL6lxEC/ddEAChgEsf5dMawnbzah6TwrFjZUu2WVIu+o+zF68iD8O2P3ktL/ESIBmnm6f0looy0zn6YCZMAwYkMR/DeyRXMlMJGNJb7P0Gc3rIZk3RJnttBUQKJTvJ3SK++HLOnr/Rc900XEVrAll6ZTRUB4ke2lKrCp6M7my6clpP23zTPCsZXienIYkt1S9fdFWKGmF2nmEcyi5+JDgQqTkU6mb3SDiTJmeQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc93ba9-55f8-4eb8-cebf-08d58db45397
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:46.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 99acc9bede06bbb2662aafff51f5b9e529fa845e ]

If a process dumps core while it has SPU contexts active then we have
code to also dump information about the SPU contexts.

Unfortunately it's been broken for 3 1/2 years, and we didn't notice. In
commit 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers") the nread
variable was removed and rc used instead. That means when the loop exits
successfully, rc has the number of bytes read, but it's then used as the
return value for the function, which should return 0 on success.

So fix it by setting rc =3D 0 before returning in the success case.

Fixes: 7b1f4020d0d1 ("spufs: get rid of dump_emit() wrappers")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/powerpc/platforms/cell/spufs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/pl=
atforms/cell/spufs/coredump.c
index be6212ddbf06..7e42e3ec2142 100644
--- a/arch/powerpc/platforms/cell/spufs/coredump.c
+++ b/arch/powerpc/platforms/cell/spufs/coredump.c
@@ -174,6 +174,8 @@ static int spufs_arch_write_note(struct spu_context *ct=
x, int i,
 	if (!dump_skip(cprm,
 		       roundup(cprm->written - total + sz, 4) - cprm->written))
 		goto Eio;
+
+	rc =3D 0;
 out:
 	free_page((unsigned long)buf);
 	return rc;
--=20
2.14.1
