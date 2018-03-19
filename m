Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3891259-1521497584-2-10033228470643303283
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
    t=1521497583; b=OTqU+CX8JWRDJvj8vXaaxvJysCaw7PdM/vOxr24+QIpPQyd
    ETUSAuMt0dKtaecdoE510RzTuj7BL/Mrp+EGCyet2fEThMlpP4U5sJLjW7a0a7dP
    hKvogz5JyPdtHYCvEZhgMFPkFDUKgQGFqzQYwM2wOMI5DMdgX++6c9e8R7S+RYos
    wo6DKyh+cUCiVbKu81pnPxD7zUBC93WLhN0bgYUx3lyQV7OOhqPqEbeMAz0JYmt+
    GgYv/U1hgyJGK4QCBc/w5Mkxe4yY2Fb+WHiUx+iuBNE+NiQAkV0CChBdVFaKW+uT
    aZiy+ncDeoRkM9l35Zy+kVw+s/ry0wVHnrVMLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521497583; bh=snZz6Z
    J1ASBFpyZdPE7Sv/A/B1LDx6fBF7HDyIxof40=; b=EbRvxHgxYLLrSf/TBAQrsq
    /MYvFUAbwiK62O0afv3tqOkceaSbCtz55ol/BEVf5zM+DKUO6gr+d/ARI7xkXnuF
    jCZbLgPzzLGcVNIKoMG4+fa5nYHlZY+lzNOI+md/Odnw3CYq4Ydubg+FJPBJvsFz
    FUznC1QqUuWDJmQl4oLMYapzaY23GqUP9xufaeODiQ+3lnF1b1BjB1vrQrbtpyGI
    QQsoRtgRpLiHfGwQwU2Da8t56z4xh6r2JxNuKGbDjjwp19DGuDZu37vigkknrWCa
    U57RHiqJMhE1wOJGSbUcyHEyVSStIhp5HoolaoqKfaGJzcfIlk+6GdNoVFCugqCg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bXPasWNS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvieenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=bXPasWNS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedvieenucevlhhushhtvghrufhiiigvpeefud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934072AbeCSPy3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:54:29 -0400
Received: from mail-by2nam01on0114.outbound.protection.outlook.com ([104.47.34.114]:57771
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934043AbeCSPuG (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:50:06 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 109/124] gpio: thunderx: fix error return
 code in thunderx_gpio_probe()
Thread-Topic: [PATCH AUTOSEL for 4.15 109/124] gpio: thunderx: fix error
 return code in thunderx_gpio_probe()
Thread-Index: AQHTv5nNdCE9hYZPNESoh0qMb8cBmg==
Date: Mon, 19 Mar 2018 15:49:02 +0000
Message-ID: <20180319154645.11350-109-alexander.levin@microsoft.com>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319154645.11350-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:aX1jrjNUaqNWLdsB5/VWFTOqcuW2tJ8b1S2wdGTNKwLTuvZpO70RxbizQVAwklUYOjYLf5hHMXURV6kQ+bcrJRYG+LUmrkRXJesYUC/hysaIXi20EnmgDMiBl/N8utk5aBK1iMvRkSFPJ+FN6sLEaIyC9EHPmiZ6vB9ClXhIqYonqAZ5ZsgoYYXHD/LyRtPetnm+tMid88RUdFnYKJRUaX7/O7Cg2lQL74vz25+YYwGXLtLDYqYfs5zy2wCdopc0;20:tRd1qCcMA+pztLumaRmLiJBPcJnXgJUt9dMMn0wQRVls9+vffRxGJbWvKb9dMJjEw8vnLZkpdRbMG8xwNZtdahnUlsjloyt5cLo1z1wEF9NFRCIM4YP9vOJRbXPHjOlpwBkBDYW9ZyBSoTEg2lCCAC2HaNijDl4sb5bxe3m/fhU=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82b1a518-730e-4483-01c5-08d58db10a79
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11090CABF4F35F4FC4D75F7EFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(50582790962513);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(199004)(189003)(81166006)(10290500003)(107886003)(81156014)(106356001)(6506007)(8676002)(3846002)(36756003)(8936002)(97736004)(6116002)(1076002)(102836004)(68736007)(6666003)(3280700002)(2950100002)(3660700001)(478600001)(72206003)(59450400001)(2906002)(14454004)(76176011)(66066001)(6512007)(5250100002)(10090500001)(2501003)(53936002)(6486002)(6436002)(26005)(316002)(22452003)(305945005)(7736002)(4326008)(25786009)(86362001)(86612001)(5660300001)(2900100001)(99286004)(54906003)(186003)(105586002)(110136005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: rfGUgvBUXzQ/uUdP1r/BeJKzrDoLwhUHZr+MENAXMw1dImMKalGQX5oFjDbkTjpuOvE/oYj7vIDGa/vRCg+sDIPUb6QiUHAcnPxuMpbPWYmTkD2a6ReuPFEUkrkPov+tZLI+5b95ujD3KdEgXtVg3aTARFv6Qt06C3h7ByjN7+lMcAb5bojXGnmdMQOB727nKfXF9crBdh0oB9yX6TDR1nDCdoaKeguVvTCAImL2Eg9C5SHJVgsQaiL22pBGseK4g+D5KaBY7MkqQi6pOvR+BWx2iAoCyHhHfZFrsLj+QG6amj2kqAERuG5MiuurqyR4cJudBx42pxh4KvLq61ij5g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b1a518-730e-4483-01c5-08d58db10a79
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:49:02.2512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 76e28f5ffed82b1e81a86c4eb8d0420515765620 ]

Fix to return error code -ENOMEM from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 5a2a30024d8c ("gpio: Add gpio driver support for ThunderX and OCTEON=
-TX")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-thunderx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index b5adb79a631a..d16e9d4a129b 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -553,8 +553,10 @@ static int thunderx_gpio_probe(struct pci_dev *pdev,
 	txgpio->irqd =3D irq_domain_create_hierarchy(irq_get_irq_data(txgpio->msi=
x_entries[0].vector)->domain,
 						   0, 0, of_node_to_fwnode(dev->of_node),
 						   &thunderx_gpio_irqd_ops, txgpio);
-	if (!txgpio->irqd)
+	if (!txgpio->irqd) {
+		err =3D -ENOMEM;
 		goto out;
+	}
=20
 	/* Push on irq_data and the domain for each line. */
 	for (i =3D 0; i < ngpio; i++) {
--=20
2.14.1
