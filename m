Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479791-2-1684912200801789791
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
    t=1521479790; b=RYJr89w9Oda4i099VjbJGg7//AAD+XbOOg/OVQKfW/pP4Xo
    OMbiuZs+06iifCvVac0oaYftt4jlAcV6yZObdPHrRlLayoaGj2tNuMtxk2+/hhxJ
    COvrFBhFHZnYKVe1LJUcaD1mO+Qv6JxXcx47nXry0PLdsIzrQdR1wCal7hAiApWD
    4n8KDXPtoVNIxRZueF4zrk/ddvUl5QdvYTy9DTJadTcb4y4JNgcrktAhF6hXkGg8
    yAu6weRJZW198Nc9TZGLNDGBx1TrTc1L9ry7mKXCeghA9fxHNs/xfLUwfRRDaSVl
    ZxptFbXh7r1TBVLz2MIw7q50/YD16b0LrgT2KNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479790; bh=b4+Ywh
    gG4ZUmmnJY/U7FlS/Lbbtrem+F8Eq64fSY2m4=; b=tkwCIO6QVRDLQe3weXuTHr
    ls4W7wIiOpl03Iku5ug68Ir5y5KKGG5q0vIZnKtdBFQUm0aXHLTYz4pQ4QUF5/yc
    snv8Vpa6rTPs55NPmDsko5FZ2dcxY9dQcIlDNSn1m3Q5L5TQ6sJzMsjboX6UM+QL
    A0KHul2YY3km71zt6yGQeoMwfNigTvBCiBFY4wZfdU2RSCxG5eU/4drxHA8zLd8Z
    1j0Mitkn6t3S3AEQyJgBvJBjjWBiYwwRen6Mbeqjv9GN6KAfPhRRzQHWn5xDa/JA
    JCE/OwCXwwL5mA1WVtudLvaKOBIsMwnEXkX969nkIRjbvEBTODmnSi+NJGtXW/GA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IVmdSJu1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IVmdSJu1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjedvkedvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966596AbeCSRPI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:15:08 -0400
Received: from mail-by2nam01on0111.outbound.protection.outlook.com ([104.47.34.111]:9825
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966566AbeCSQKH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 112/167] clk: Fix __set_clk_rates error
 print-string
Thread-Topic: [PATCH AUTOSEL for 4.4 112/167] clk: Fix __set_clk_rates error
 print-string
Thread-Index: AQHTv5xpf91FZabC5k6/vcjqLg/fTQ==
Date: Mon, 19 Mar 2018 16:07:42 +0000
Message-ID: <20180319160513.16384-112-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:23jMqymyl9Ga9WNX6m5yFzYOJv1au1nMjxBhSUYHbYZsXRur3vCY0epinzZOq+2a7D6HPvBOMOOZfDOIw/XdkomXwmMOhw0Xo4W5Eb/ZPb/mszPKvrl6MT2hbgUDoCM29kfL16GfM+Sdpu/mlBZbpfMdIfJcA0X9lr5ucJbLAF8YNZSjk4rmL/zHfBjGgFXudFZt0BvBBPmNn43Ms5bKNQAOYA0THawZZNn3InXusnI98LGZ4IIy9wBlxCE90V2t;20:wy5RO2546BmqLGweKQ4W+QqS8O5LCAWpI/FauQDcIFD+OOmM3wZvXXZal6+s6gZmP7atZiw4SOyUzSBpLp4PrJvqvHg7sbTXmvBqJh94l9UAVwfcDFg9j7D4yTS/NHg9NkFJ4wgXKI5xS+qRchH4VAMCbQ3WMP+x1rCt0orye98=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dd555e3-48a3-46d5-3a19-08d58db3dd64
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09191492C0E1355560FB87ECFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(66066001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: lhhtrbz4VZXL+SEfaBzGPeuger2shvpwagVF5M0ST0Yegg0xS1x9IT1vJaooPjS+LmoFfD9/WdvvVwNm1PTvRZDKXBvbqTrgvhEvBO3z8irUYe+E8q5Iz74I4eGQl0nl/+CJFD5pDhJGeZqkbR+JR6HuMLN+zUHSCOCFmtbwY4XMDgsANOK11sFIhR9Z5S5rPlLprGPj5s6RwMoF90lc+Y3NII+oVXfrhx6QuP18475RLncie4yJsc7LjyAF0hIufxhGs/H6ChH2PeFq8s09qi2v0F2y+v32jDEImqAsjV4fz7GWqbIPKhXVqkJcHx9eE4oMnQ+YcfAQQescxDiUMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd555e3-48a3-46d5-3a19-08d58db3dd64
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:42.7089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

[ Upstream commit ee177c5d6369f8e5d3e4793dce501cf4431313a1 ]

When failing to set a clock the printout emitted is incorrect.
"u32 rate" is formatted as %d and should be %u whereas "unsigned long
clk_set_rate()" is formatted as %ld and should be %lu as per
Documentation/printk-formats.txt.

Fixes: 2885c3b2a3da ("clk: Show correct information when fail to set clock =
rate")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/clk-conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 43a218f35b19..4ad32ce428cf 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -106,7 +106,7 @@ static int __set_clk_rates(struct device_node *node, bo=
ol clk_supplier)
=20
 			rc =3D clk_set_rate(clk, rate);
 			if (rc < 0)
-				pr_err("clk: couldn't set %s clk rate to %d (%d), current rate: %ld\n"=
,
+				pr_err("clk: couldn't set %s clk rate to %u (%d), current rate: %lu\n"=
,
 				       __clk_get_name(clk), rate, rc,
 				       clk_get_rate(clk));
 			clk_put(clk);
--=20
2.14.1
