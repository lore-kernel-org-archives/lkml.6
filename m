Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3230508-1521475942-2-8565802648604194629
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475941; b=CzL0gQ6UsqjgGhASjPj0AYBWCCOA22ERyU3gOKftsDX+Akk
    WLg5JOIiSQd9K7z8B1CTUiHIMoIjR/Lmvx1WjPKkbRwRITVb3+PytyfSaODosIWH
    JqlOT9zrUlsL/4bJD4WL/xNVUDi5IwH9XJE/Tm1+xzZZu/pQQ+uel4QfkJGyD7Jg
    i5732GDQgEsU5xgpGSUd2X/FMVKOGdkcuis99+r7nwoXJfy4mUEKot7zjpulqrmZ
    kKjbr7HqsKrbwtYeR0t5jKJeFwvRQjkMoOOHfvxG9FgjvV9EjljbjIWRmi+k3dh2
    g7iWpZoU47lhvKmO6PrryP4W9lnXlPn4L9+acNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475941; bh=y2EQBN
    mbx3J5gonRlrfp2mmmolLwseq12tU1qGn9ViI=; b=D8sGC2prDoC5nrSvAEixrW
    86RMd624U6y8WXMtekb8QjdXSae0hkiZTrEgFOMJTHDgVfc03wM9cGSIRJ2GZ+po
    hXyBb5oF2cA150CDSaAWia96EYLRlxqzM4FDwnPFlYL51AJnzCO1fJqV6T4VAzea
    7BjVgNjYGXSplQh5/Cli91nTTgwZRfUmqU6NxW/w9fKDfQxGWjmy/WVuRo9Sw4Rj
    e1nSAXhlDXCUl+1QjTetRX8NHdw8+tjGfCC8mqUUYFBhsRqrJrqz0Ec8KrO+KQqG
    27Fk/33nlWpHDok+Ao4JaQH8wLU8f85aI+fbfgoJ/6BGlXeH/5obeUylj9kd1Pmw
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0cIUf3S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedufeejnecuvehluhhsthgvrhfuihiivgepgeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e0cIUf3S x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedufeejnecuvehluhhsthgvrhfuihiivgepgeeh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935192AbeCSQMS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:12:18 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966803AbeCSQMO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:14 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 025/102] usb: dwc3: keystone: check return
 value
Thread-Topic: [PATCH AUTOSEL for 3.18 025/102] usb: dwc3: keystone: check
 return value
Thread-Index: AQHTv50Cm4yKqxrpFU6zKO0ildIvZA==
Date: Mon, 19 Mar 2018 16:11:59 +0000
Message-ID: <20180319161117.17833-25-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:xOPhD4TR8lerZ5QvW2Md2i7LeA+xfxPQLy/9qYj6G3uLZ6Km43AWcheJUsE4kDjoymNbl1N7Tq5rnfDZebOQFQ4gvEJayOpFFUF57GbHWOjW6ZEUgRa4EUl9Xu+d9Rdo9u6UpF0kI956R0yWvQn5w4V2wXMgpczChnQOHKVhc6Wqe4fdtI4mVN/DBwmJbckEDfqggku+EUpWpXQU2uW4UIO6qSpU8+M1c2k/lL/sn4psX+guChiWn4xNtKAB0YE0;20:UtJSR0Rbwrv6INMtwntbxrsNi4HMANQCi1mQUlknXs08fG78lk/ION3R4k1P/JE6lHFTu/OrkNG5+XCYeC++WHzd93Xnmas/a3weCeTBDQFPzq72h/G+AsgntZSaUwnfK+9TIylrOjf8Cht70B8WT0Az05ojxyJ4Fx7rLtD5VAM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89a3ac67-34eb-4b99-df63-08d58db428ee
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920109F69F4876B9498932EFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: l4W8IWK61cdxgYIbMB2Qrq3tg5kScfU1hYTwkQu98CyME42BP+ws/KejlgbAavI52z5l3N6BWn4eC9s72Qvu6eMIo7A9IaNSXipXHcnLV+7EnXSu/jSqK/dyw5xFplPWkZ0zjWHZroqD4w4v8yBXAHVe7SmlFP+gQk4XXlE/KfjCZI4v3xbM7NJd2e9r1P6HOOKjnh5PRdrRbks1qaPPR6+Z3ka5nZmC7E0R2G25EPhfFcU9LwfTkHI8e9gUyw1AEDpP5I3YZl7KxXVHkQBmFJrcoKWu4G84ivA0+9vSHIimAMHhokzyytJ6LmZESa4zEEvbXzzadkp600aCoI4Y1Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a3ac67-34eb-4b99-df63-08d58db428ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:59.1335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 018047a1dba7636e1f7fdae2cc290a528991d648 ]

Function devm_clk_get() returns an ERR_PTR when it fails. However, in
function kdwc3_probe(), its return value is not checked, which may
result in a bad memory access bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keyst=
one.c
index 7ec8495f4523..64539d84302b 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -117,6 +117,10 @@ static int kdwc3_probe(struct platform_device *pdev)
 	dev->dma_mask =3D &kdwc3_dma_mask;
=20
 	kdwc->clk =3D devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get usb clock\n");
+		return PTR_ERR(kdwc->clk);
+	}
=20
 	error =3D clk_prepare_enable(kdwc->clk);
 	if (error < 0) {
--=20
2.14.1
