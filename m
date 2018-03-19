Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480328-2-11451952649698799933
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
    t=1521480328; b=CV4OCyVNFdmkEYQth6VGq+3XCCoy5tOk1/h3UcflcfqX1Vm
    Mq9Gs/F8NQSkcrWCFVqYdL65e3TOn+hdAZoTlk44DjWMI5xdvBjU6wbBd9Ckyt3a
    BvReZhd5qsTR4mevf4G1btBwnmLmaSpHCwtEliRqjGfDGjkwXVW+JWwwadHD8ZMq
    HBSyHOY1hiDaHpm5Qz0Vu9NyijJXucOo7UMG2IafXH22OYfWkQgzZkU638nD6boj
    P2WCJuwt4SrhuzB1k7ze66WrQBQEbGvGl4+D0KzaivkGrB1NevCPKqZXnzghm0kK
    C6ptbZrGKcZ70+9WVDxLINyU37q3opwtp1M8clA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480328; bh=Kjpzc9
    ffYBr2qQJcuWfbKWXUcNhcRVB6zvK0Gq3DqG8=; b=VnB0yoquhNQYKuUcXV4fm/
    oZuRiuMYS7vqFLIDCIr6oID0a6PTmsRc9PGdSEqqpFtEfXJbGDIDQWW+6OnLCUQo
    ro3x0F8FKgIkQOGKjeSotv1wOHd7EWpDpEuXDgHH05HThNglXxpvJKYzbUpBY2Hm
    0FlsQhu3v40XXUAKX6bOQCcsIXWGiVHc5NZK1Ltpap08/IAnbKBVYKZnyP7OPp08
    pRP9ORmR9tQ2AsvoFsnf7j6kBEeAuC+/8/FzrMI5EN+KKEgklAqk5mWo3Pp+D8C5
    W703EUBo9fLAc4/nMNUrseIAdWia8tg9EyXMAUAMcBIRMyiKg2mk1skqkuD20QOA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=id7ycGpI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefvdenucevlhhushhtvghrufhiiigvpeejud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=id7ycGpI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddtucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeektdefvdenucevlhhushhtvghrufhiiigvpeejud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965927AbeCSRYo (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:24:44 -0400
Received: from mail-dm3nam03on0096.outbound.protection.outlook.com ([104.47.41.96]:30671
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966306AbeCSQIc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:08:32 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 060/167] ARM: davinci: da8xx: Create DSP
 device only when assigned memory
Thread-Topic: [PATCH AUTOSEL for 4.4 060/167] ARM: davinci: da8xx: Create DSP
 device only when assigned memory
Thread-Index: AQHTv5xBTvQEAGhTv0SX3KhfeUG7bg==
Date: Mon, 19 Mar 2018 16:06:36 +0000
Message-ID: <20180319160513.16384-60-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0805;7:lOtiBPOSPOR+3f/DtdCwIL0u6kQeN4qqRBiGl+jizkBUGM1H7YpKvoe4yctjqdrGrX+VQk6QRNxe6noLcZNTB7tyP//duaZH9dzRIQa+HSfMow4hM0k4HOK1FwtaYEPuGBsd9BVdp6SeLghu/dU4QYQoRWDSWwKFg0+ERKHXYDRQZA1FIYqEH0EktkIWqTkLQiE/CjyXC4frrkno4RuKlhxcfJTiljYkXe/mxT797swNsDMl0ELE9PydJzRCP/m5;20:B+iYnCC48HMUSB8D6yCK6U9sXXVHX2gkudqQ0L7wAw+wjsjnlHLfimenKWKSnIRkVy7Cote9tQlAf4AJan1OLk3k9MSjNucB05W57CH2GeNFWKL4roi1dO31ZOz4kUQyOVCzgAfZsOOtKcmfWqs1IeXomAQJ5x9nK3pI7jpyx7U=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90012802-5629-4ece-9ac9-08d58db3a462
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0805;
x-ms-traffictypediagnostic: DM5PR2101MB0805:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB080544E9993A5F8C6687A823FBD40@DM5PR2101MB0805.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0805;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0805;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(2950100002)(305945005)(186003)(86362001)(6506007)(3660700001)(6666003)(5660300001)(6116002)(8936002)(3846002)(1076002)(26005)(7736002)(6486002)(2900100001)(6436002)(2906002)(86612001)(68736007)(81166006)(81156014)(10090500001)(102836004)(8676002)(14454004)(105586002)(107886003)(25786009)(478600001)(2501003)(5250100002)(53936002)(3280700002)(316002)(54906003)(4326008)(6512007)(72206003)(66066001)(22452003)(10290500003)(99286004)(76176011)(36756003)(97736004)(106356001)(110136005)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0805;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: llyp7qLht/S7P2vrikKZsxqSUBXgA14hd/8kj19f9LsbgmOQw+ftMPQrVVQY/1mf2qA0/b35Zo6S1SLUqNsBykmGcSTtuz0AK8uVNZK6J5PkStT+OwOySjVMVrNelgDyg+ElGUwKf3xtYp9DDtttQ/PyOQ0IZ2dBcpahMRInPRD1BQjizVxFFoSSbVww6MS47oLGskxRQwFA4mM4bGhVDsjIW0UVv8X/ZFHc0XwO/5oXn48nk4CrdA6Vn4lIhz07xflZH5b9Bc0ZpXGCWastdVhO7LJi07Kz6eZyNKGfYYgtlHA7yirfLFz5ChV1Py+s4JqTN9dWi9t1EUomQXVyEQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90012802-5629-4ece-9ac9-08d58db3a462
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:36.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0805
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
index 28c90bc372bd..78d325f3245a 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -795,6 +795,8 @@ static struct platform_device da8xx_dsp =3D {
 	.resource	=3D da8xx_rproc_resources,
 };
=20
+static bool rproc_mem_inited __initdata;
+
 #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
=20
 static phys_addr_t rproc_base __initdata;
@@ -833,6 +835,8 @@ void __init da8xx_rproc_reserve_cma(void)
 	ret =3D dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0)=
;
 	if (ret)
 		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
+	else
+		rproc_mem_inited =3D true;
 }
=20
 #else
@@ -847,6 +851,12 @@ int __init da8xx_register_rproc(void)
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
