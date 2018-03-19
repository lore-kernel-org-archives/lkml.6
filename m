Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827995-1521495563-2-15064560091898927495
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
    t=1521495563; b=lMpt/q2DqkdcK4INK+/1NDVzxYX7+voYgtlbYHuqssXfy3w
    iMO/SDDV6y54MeK9jjPUQNF3Yaim+VQaUEPZJ3h/uth8bobWIE5TgGd027g2H63M
    l8rbb4z9932JDeLFv+CkA5uPziYSyQ9r3sAnX9DU3CVnGQwIoq53JoWzo81pgDlq
    AM6Uv4DYvT9tfQH0g9y/RMz6/tnTn2sZb4cza/3vK0+8F5gBf26S8qfEfCBuz8q8
    TZqh5HND6r7je5ChovdJ+HduXmvKdhcBoXlVlVu+Xsg6gleBXevXwkyyhRQxCfKc
    ohfD281yQ8t7ZAvGY+PUAVFdmOLYDM1ltlZpL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521495563; bh=XPH04w
    VMNXf+RwnvFtd+zvagxiIoDUlRnm/QXq3theU=; b=ERiU7OSAdhKyyZYY4MWsCM
    B1kcnUTQNNbhWdzLSL666bxEoqzKMLY3LYV4bOdHIwfvFFlA/BXk34MFAXQJZ1co
    QFYfwmf7p8C/fAozBj7tGda0f/Ritx4JfLGfQ3d3DgeyTVBWL83tUuqIEupM2OA1
    Wzmt0OLrKNney7pBlR7ZbmU/HYYjL28x/0uyfk+ygq/xmELSmymGyPE24xq1IZPw
    /+nFjdpFpFNFlX/MOwvp3wp/2v9Sh0cbowYuL3KyOAhgZwwDactkmNMNdIVYGvA0
    ABrsG0qOqf0rDe1gJq14AXrVhyDn8W/aKGWADLi8esNr5KG/L2jHISdSKT+EB3oA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aDDs/4KJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeguddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aDDs/4KJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduhedvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeguddvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964859AbeCSP7O (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:14 -0400
Received: from mail-by2nam01on0118.outbound.protection.outlook.com ([104.47.34.118]:14025
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965047AbeCSP7J (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: MaJun <majun258@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 037/281] irqchip/mbigen: Fix the clear
 register offset calculation
Thread-Topic: [PATCH AUTOSEL for 4.9 037/281] irqchip/mbigen: Fix the clear
 register offset calculation
Thread-Index: AQHTv5siAnk9DXECuUyaVkFohBHn/g==
Date: Mon, 19 Mar 2018 15:58:34 +0000
Message-ID: <20180319155742.13731-37-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:ze2hcy6hw77Fk0zWtoXe1uIBFpty72qHdUMSXwBPMrd3WbAuYpvhDeleEZH9HKPJYNJW+MJEK2zlSAUO3z79kiWg+1kJpG1kzzVW1VVX3GzcXWE0BWcUuBdvE5mSchv3fQG1zgPtiQjdq4RfErTcN9p00pnFlDnm2joPK7r46R9FBi8OfbdgY4pJZEkXw95HL4gFfRz5gNMGKX764SEA2oPE4iqXN4CmsshvDFe/sZ95PtJOO0DZC/yjeNZZu2b5;20:kODt1CZJGsxiuadSjvUaQKzXZwmoxtHWvd2jsagUQxEmRmIvPkyLGtejFpzF5usx8xtWyst5NmbRev6bhCs1iGttGUrG539wgTSNPdmsrEuCnrZJwkpP1ZUY5Xtnt7yueQsUn7ci8/FFAoL3pTgTxQbXY2gMMh+B2NpuZltRBWA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 910deda1-1311-4314-4ed7-08d58db254f3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072669A1B1D6BDCA64533AB4FBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(50582790962513)(42068640409301);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(54534003)(189003)(6666003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(966005)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(59450400001)(186003)(1076002)(3846002)(25786009)(6306002)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: yUgtH64TPBPXW59vf3WSJbM4w5BCyXFuBl4/L76Vvr3rFtkScIojzHLD+Qbrfcj7wguUGF1cYE+pQg3Fc8M7UdqJRuxSENk/ro+XnNnviFqbj/TKx8AImD3Hn9rV+MG50Irwq/UJPI8wTkugqhY3OnwHucoOJmt22w9FtOIYUBN3h6VGW0C2a6aAYCEM2lnITPROwXuwKIP19eIotR7pTndEfPDU/72yAeBOsxpe8hzVBo+c0Cibflm/+bALNAvnHnQ/aeTX/E8vNryCQHtrYTbVKEA1QAfWYcGS5Xc5W0MSVBOv+GiqpFr5cUnZH2hPxEj4chcg1xisFJfxy/TfZA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910deda1-1311-4314-4ed7-08d58db254f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:34.0883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: MaJun <majun258@huawei.com>

[ Upstream commit 9459a04b6a5a09967eec94a1b66f0a74312819d9 ]

The register array offset for clearing an interrupt is calculated by:

    offset =3D (hwirq - RESERVED_IRQ_PER_MBIGEN_CHIP) / 32;

This is wrong because the clear register array includes the reserved
interrupts. So the clear operation ends up in the wrong register.

This went unnoticed so far, because the hardware clears the real bit
through a timeout mechanism when the hardware is configured in debug
mode. That debug mode was enabled on early generations of the hardware, so
the problem was papered over.

On newer hardware with updated firmware the debug mode was disabled, so the
bits did not get cleared which causes the system to malfunction.

Remove the subtraction of RESERVED_IRQ_PER_MBIGEN_CHIP, so the correct
register is accessed.

[ tglx: Rewrote changelog ]

Fixes: a6c2f87b8820 ("irqchip/mbigen: Implement the mbigen irq chip operati=
on functions")
Signed-off-by: MaJun <majun258@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: linuxarm@huawei.com
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Link: http://lkml.kernel.org/r/1494561328-39514-4-git-send-email-guohanjun@=
huawei.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/irqchip/irq-mbigen.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 03b79b061d24..05d87f60d929 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -105,10 +105,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t=
 hwirq,
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
 					u32 *mask, u32 *addr)
 {
-	unsigned int ofst;
-
-	hwirq -=3D RESERVED_IRQ_PER_MBIGEN_CHIP;
-	ofst =3D hwirq / 32 * 4;
+	unsigned int ofst =3D (hwirq / 32) * 4;
=20
 	*mask =3D 1 << (hwirq % 32);
 	*addr =3D ofst + REG_MBIGEN_CLEAR_OFFSET;
--=20
2.14.1
