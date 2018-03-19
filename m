Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475980-2-12468871218840964889
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
    t=1521475980; b=iGwN9GdOynMmuViDgPSvssjRQu6MRneH7HFX2R+r5CfCkpW
    Pjf8WgngLEoTM2MlcDRc0o/KUuW0ikiiwubMDmH/mG1effYppLsd63Haw8KcnDFg
    HI6nPuY+vy6tTegnxyMHVZSdSoa+Cy45oIxAE+TUwB2Mo+z59r59hi8dEFNBbiSt
    nIqtWGRNFrTSGJ6a5k5Lnu6AoJf4Ct3yIJ1MyhJ2hZZpVZLqjIvx6sLp3ddGIP0s
    bPHjDNI2bBo0P9nm40ib4/FDiNpboaXpzS8CO0G6AyQg87l2QXFvxgTlzeeITCzE
    76Os8ftov9UFaGECFRaH5DRAGqXDNBEfPNrFWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475980; bh=ugclcw
    zuy6hx1YMIxMGm1L9m0xnoxEvuvxxngJcZT94=; b=SSK0APQEaxf4B65A6gZIz0
    ZJH1ynglU4U4nx8Ly4qz/C83E+y9NoTXo0yFn38JNd3qFzer50eiJat4AeBtq+JS
    1kRvz47Uv6M/9sVZfmneta7rppx7cfLg1qcmstDYdIC9Bzncpe/pvJf4CyGxU7Je
    +ZZWdf7vO96HjXE6bSzClAECQkQnPeO3rL9MWgVnB1lY94//qXD0SClnWdgSubLh
    oFadWZ8mxbtlWTth3PIoFVfHNHZv2dPTYK8mU+ja5vTxA20A45a/N6XT+NsJqGth
    DztH/D1BOOI+Xv6WHf9p6mm695HiAddJbtApxyYylMa2wsjZun/8Y3S3Tk13SpSw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ybv8Hvxv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtfeegnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ybv8Hvxv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkedtfeegnecuvehluhhsthgvrhfuihiivgepvdeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966834AbeCSQMy (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:12:54 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:52832
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935246AbeCSQMv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 037/102] ARM: davinci: da8xx: Create DSP
 device only when assigned memory
Thread-Topic: [PATCH AUTOSEL for 3.18 037/102] ARM: davinci: da8xx: Create DSP
 device only when assigned memory
Thread-Index: AQHTv50OFZMmuBkY9ECUNoUh0zqzsw==
Date: Mon, 19 Mar 2018 16:12:19 +0000
Message-ID: <20180319161117.17833-37-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1014;7:Exv0L4VlBascF67xWrupmuGX4FhTseJFm4mCsF/g0BU4765XqQQPpgwTnIt847PqMLdCSNtkPdIjlO9Rc1rCrH8dx1n8rdt8Lvaz2KO0rGdv7FJDLfDAMGTElIBbVdeCskod/i98ifn/BsSh6er7I8YE/JQYQzxfOQNmNhxp2hadASe3+aqwrAX3RumumVJDzHTVYw3hjAxNXDM9JAntxN6O6I7uI7Zm1gLarBthI77tc3Ob/9JCLMliGCXFDNII;20:t0irFSemJ00BRqya68wJP37+e3wEtdc5ptC0pSDIKfcjQg08lemabtCc3va06nDq4Sxl++6ZrdRojTUJWKPXn3vrnIgNfOvhAH5euIphEOzKV4HsipFLp5XNK46L7Q/VymD+Cw7nUbHCA2YJPCppQdkGRkIC0r76p1d/1oq77ME=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1a74e33-4c73-4638-f095-08d58db4429d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1014;
x-ms-traffictypediagnostic: DM5PR2101MB1014:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1014B1C56024197B5D3FAA3AFBD40@DM5PR2101MB1014.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1014;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1014;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(2501003)(6486002)(478600001)(5250100002)(102836004)(86612001)(1076002)(97736004)(86362001)(99286004)(72206003)(2906002)(6436002)(107886003)(66066001)(6116002)(81156014)(10090500001)(81166006)(305945005)(8676002)(7736002)(68736007)(3846002)(110136005)(54906003)(26005)(3280700002)(105586002)(316002)(186003)(53936002)(8936002)(76176011)(2900100001)(6506007)(10290500003)(22452003)(2950100002)(36756003)(25786009)(5660300001)(106356001)(3660700001)(4326008)(14454004)(6512007)(6666003)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1014;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KWdDD3I1ZHpGjfMUoqk1akC+HEkgWw1tJhPYjDLJDIj9YGV9xCtYCX8fzU6yryMNpaNtg6/2yfKhZOqrbdqGTXNl9TNgrjVSX0SCNDtgQJOBjwpjwI1grhn0e/9dPtA79x7Z5TX34IIp0jmm+DyJ8jglHZW3dlvkGiCjfSXACunyh/gSWU901y+cwhSP717UDtRb8csYN8glF5dusfZ3KVYFiCGezIsopaei0XaHthogK/0APRgGQIw8L9JIi1L9YsG78zDCMOBmXO8vgB0zAK7ewUWfyXwru/Y/OHZdY4fw/kbfGmzaUwfvtnRUUlTZTqs41jzrxb65TRxsSAi2Gg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a74e33-4c73-4638-f095-08d58db4429d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:19.2707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1014
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suman Anna <s-anna@ti.com>

[ Upstream commit f97f03578b997a8ec2b9bc4928f958a865137268 ]

The DSP device on Davinci platforms does not have an MMU and requires
specific DDR memory to boot. This memory is reserved using the rproc_mem
kernel boot parameter and is assigned to the device on non-DT boots.
The remoteproc core uses the DMA API and so will fall back to assigning
random memory if this memory is not assigned to the device, but the DSP
remote processor boot will not be successful in such cases. So, check
that memory has been reserved and assigned to the device specifically
before even creating the DSP device.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/=
devices-da8xx.c
index b85b781b05fd..e83874ba6e6d 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -761,6 +761,8 @@ static struct platform_device da8xx_dsp =3D {
 	.resource	=3D da8xx_rproc_resources,
 };
=20
+static bool rproc_mem_inited __initdata;
+
 #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
=20
 static phys_addr_t rproc_base __initdata;
@@ -799,6 +801,8 @@ void __init da8xx_rproc_reserve_cma(void)
 	ret =3D dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0)=
;
 	if (ret)
 		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
+	else
+		rproc_mem_inited =3D true;
 }
=20
 #else
@@ -813,6 +817,12 @@ int __init da8xx_register_rproc(void)
 {
 	int ret;
=20
+	if (!rproc_mem_inited) {
+		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
 	ret =3D platform_device_register(&da8xx_dsp);
 	if (ret)
 		pr_err("%s: can't register DSP device: %d\n", __func__, ret);
--=20
2.14.1
