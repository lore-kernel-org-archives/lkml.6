Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479711-2-13839542054977767589
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
    t=1521479710; b=f8ZHlF2byKwHnu0XUtCcvIsfZwl/rrmwjL3xyXglJljO4h7
    1snEAjYC3Fm9ObOWhygTz0fBp2Vu1r7JBvb9pcxMo7okxheicoE547JA+fVL+0UJ
    TmTVxdZfSPnoYvOKjaPLfFIisixj1IBeMK6HhIyyK1I3vqqw1XWtAavzuyWRmPOP
    OKCI9EA1RNNpwAbHU1QLJq8JaAfNfEdFQ2McD/t0taHUoLLXQV5F/wbho4kHantH
    KiYSyMifkIkGt4g8IkAF6IBj4p6sqtwWJKTcNpdsrn/OyjNS+kXbS1Tv9RPSUy6w
    MHour1017gchLzT9S7U1+pLURGcEwTyM8lFtong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479710; bh=Kb99At
    zmlRi2cGKxZR08hOyvDv9dSnQqoUq8wlkY+aQ=; b=wyhsbch0IJtSRTtE/6CB3K
    kIoCkb/BVoMDBHwsoYAQMqGqZQMCE3w62POv0JiICvOU4D7bmaBU/+U/hE/3DJw9
    0AUZvarQNBIpJwYRj7eW8qpKUh7Jjcv9QxaWrAui8IvLK3PTz/uF70BYdgpKeFax
    8eerjJrv3aJxJQv8I56f+CU1Phw7VFIHGmt4EWmnFVt6cTgcXWRq/LCkGMbfeeTB
    6aY2TOMLAylJBChjytKZuadjm3Q9URKOVVKcwvIZnVSnz7CQoCKhvzvxpxFAnjhB
    nYkJ763X4sHfHpWA4A/zUgSRlpH3d7Vg/fsME5jnwAyMCrzLC1j6CBTSlCuppi4w
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A0cYYxt4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvjeenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=A0cYYxt4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejhedvjeenucevlhhushhtvghrufhiiigvpeeije;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965146AbeCSRPG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:15:06 -0400
Received: from mail-by2nam01on0091.outbound.protection.outlook.com ([104.47.34.91]:17618
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966567AbeCSQKI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 113/167] powerpc/spufs: Fix coredump of SPU
 contexts
Thread-Topic: [PATCH AUTOSEL for 4.4 113/167] powerpc/spufs: Fix coredump of
 SPU contexts
Thread-Index: AQHTv5xpZTrW+DDEU02bROyS6fogsQ==
Date: Mon, 19 Mar 2018 16:07:43 +0000
Message-ID: <20180319160513.16384-113-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:IcaV+FSKW+rdqk7gDNAvxI2BrJrmN2IQujLP171NfPrJier79364KgUr1C9Ow31JADertqeotirUzWFdE1vI2zqMIrSRaS59Iu83bJOl7FGK7qg0T8tMJfX+oR9jBJIKS30boA3HLm2I2WbdK5xBtRKJlxhEFgXzjnX2etqfnDirbpwoomSOEpAOOBwjCChkqP6Hse9n/Yvz0PTIW78Cz8Hlq/FY4AH9XQ+V7LffVeIcPQnj2K3ycm/EsL1KzX1e;20:iPc3CYeAvfkBpBqp+a+HR7lXHI4iIk+VT2+/ay8oJPsaQpCPMJtVrczNTgq0aIjp7XL+W11YGP3Bs2f51aVJdSN0TVqNgooTC+0bCxHiNdS/2+MuPekQlCH8aK50f1JJkcYCyMGcSwbQNP2nZI0D6FEcRRRSrbo9rz0SYydwK4Q=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60624ba4-8d88-499b-f6e3-08d58db3ddaf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091989639E079B36BED41185FBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: xxgk4Nqdg/dRrcpa7KqF3AiUwti7VKpn+l3UfKBNXsHhVIzgPcjj6Zs3Xn4BP+oGHXsr3TZDJXT2lXrEvXF6qz6Cu2i20aZhLUj5mlk1W/O8xaES9Cu4+PrDOKitSUJr4Eyksa9lxs0WUAqFa1ec+/5/JWmB7sy6U8sjm979m0FNp/pJMbLPnRq1leY2lykGk8rU4FK4FLmfJs1GjJolvYu9ycM1eHMqG3ni1xdWmRMWpxGb4XsZGYvet69BHZwsO+fgy39zefULf+RwGXz6ZyJOaNyH/3BVZTLK1eBGsgiQZPKe1+UoGsTltatYjdUaCxIRFKcyempJZihUXrZpwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60624ba4-8d88-499b-f6e3-08d58db3ddaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:43.7756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
