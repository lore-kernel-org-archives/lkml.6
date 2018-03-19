Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339826-1521479298-2-5889536808642902581
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
    t=1521479297; b=m0Xh+W+1yBdgywuj08CGfAa+7apDufTYhulF/xQyNrjAPHZ
    KNlRfFV4MkbAavYEtUYB/PdzzzoqXasHKzsn1V42ryUuhKX9OdI+uR0ewNOMtJpQ
    8it1db53/UVbpTpnPREuUWI3TH94x1Uu5z0mXc0bxHRZJYRd7GQ7okmInFmDbnc0
    RWPD7mm0mVXSYFy5n+vO67GVtfKsBg25LhtUNHPCGdW0oEnWVU+uzKih55hMhAhm
    z+E364wSdhA4Tn/x2oo/F+QJfwk+4aBQPRB7dH+IurrJL2cEq2QXHPE7xBYI55QF
    hUdKEli1TIF7L2WSF6eVaSf4dWTNsTRkwTJuscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479297; bh=RNE9NX
    tDRPPzNjTeHTMMr9VPQZDs52EPGiJIu3Njzcs=; b=jnyDwyLSkDlnfsMekSLe4a
    3tiPlHwKp3OvXhZdZWct6Qlew2PzWBLD6tz/sf8cxXedPr/hjWPj7ttLD2uSvlMy
    RP1C80pXZ2ZKN5Ec1M+5/k9qRUvh9ml9OW6MOq+K98lJuux15DQ01bYSoMroAn8Y
    kW6v70eXntJzm9yRKzpEcvdaITTTZfKT33nqgBKL1Dn0CejEGpE8yWPR9v/o2V3k
    HJWapUf+E6eQtO2Irji8BeUw14mlA1jE2H1MkSIxTlRjWcgdMFUEZUO/nOQl10nJ
    +mqYacIkSSWPZqqcbHzaChruT9MrQh6X5ASNzq2fv47v6pkXwPqzuC5t94Nvn6kw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G9azBC4P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtfeelnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=G9azBC4P x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeljeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedtfeelnecuvehluhhsthgvrhfuihiivgepgedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966660AbeCSQKr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:47 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:62326
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966650AbeCSQKo (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 127/167] tags: honor COMPILED_SOURCE with
 apart output directory
Thread-Topic: [PATCH AUTOSEL for 4.4 127/167] tags: honor COMPILED_SOURCE with
 apart output directory
Thread-Index: AQHTv5x07x6wwgBqYEGxNI7XSdTRLQ==
Date: Mon, 19 Mar 2018 16:08:01 +0000
Message-ID: <20180319160513.16384-127-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:iOGB1iEevx8ge7S1YMevMyaCHv5uoDJ8Q6EzohFnHnooGCtCBR+NtZKMIhFqJAMVL3FcVhU6W1rmAN9Elk1ZAvgXSZ27hAeZutf/ZERvXnQyCepUqORQmXKaQ1DmTOEAsB1uXaR1bbzODDew9+8DBfM+RTh89lKLWXsNYfIuFpdxDbr7iU+Z7LqqYhamZV518YbdgpcTcIzXlN8x5oYO+7rsMFdBzimRYfpWWNcYOTGy83GhHtnm8MgPLlCgZr5m;20:teYvVLSpsSWE0LwPsvphSd5k38d626B3AZgPXbGdnEjY5Aa9kJMlKCW3kb+D1pUJ9xEssQriz79U1oAzVi6/KmJmTojpPCiJI2IUUPN+dSnpg2m2rjQkiqNu5NRS4JNAK6yrl3o8DRb4uR+uLcd6M9w0oVurCwBiIuKUGC89o7o=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09be1325-858e-48e0-ff4c-08d58db3f3a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045853726558D5EF70DDFFAFBD40@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(86612001)(66066001)(6436002)(76176011)(10290500003)(6666003)(2950100002)(305945005)(8676002)(97736004)(6486002)(86362001)(25786009)(26005)(575784001)(102836004)(8936002)(6512007)(7736002)(3280700002)(106356001)(107886003)(110136005)(68736007)(81156014)(22452003)(6506007)(186003)(54906003)(10090500001)(2900100001)(4326008)(2906002)(14454004)(81166006)(316002)(105586002)(6116002)(3846002)(5660300001)(36756003)(72206003)(1076002)(53936002)(3660700001)(99286004)(2501003)(5250100002)(478600001)(22906009)(217873001)(15866825006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: cDcHuBGxF+HShJZt93GpM7HLsFlw5r9qlr1xnOrLoV1/LCSE4Ld0bk/GfFa2bQG0u64gV9u14sPs/yJtLVCVdtmTVNxysZvnqlDIHESzGn4AtxC6V/YqxQstaEayqlBSAJAfUxF5/FyZZtoFAgVlr9P9R9VqdNR6/qmu+vfuF8/wrc/Ty7FAxEJvSavSzdHZPqIRnBI0OmVKjrH01GIGvoi4d9wqpYSVWQN0RLFts03BrhuOf6gTCrpTF8Lt3crhuC/sbOTgnd39fZpVxsXcKagyln8smFjkAscsJJQA/xQ6OqfJGu+zV/Yt99I66O8dbe9TRDWNHRhQKZtV86u4UA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09be1325-858e-48e0-ff4c-08d58db3f3a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:08:01.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit cbf52a3e6a8a92beec6e0c70abf4111cd8f8faf7 ]

When the kernel is compiled with an "O=3D" argument, the object files are
not in the source tree, but in the build tree.

This patch fixes O=3D build by looking for object files in the build tree.

Fixes: 923e02ecf3f8 ("scripts/tags.sh: Support compiled source")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 262889046703..45e246595d10 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -106,6 +106,7 @@ all_compiled_sources()
 		case "$i" in
 			*.[cS])
 				j=3D${i/\.[cS]/\.o}
+				j=3D"${j#$tree}"
 				if [ -e $j ]; then
 					echo $i
 				fi
--=20
2.14.1
