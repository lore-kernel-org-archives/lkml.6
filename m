Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477963-2-10016514772725748098
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
    t=1521477963; b=lY3k9rbVGLb7B9c1flRAqWFDzidC1+1gpLnxDowcgY1PnyQ
    Y2lVrTwsZbozU/bbo/VZgEXVrbz0Umz3/PlQIR67h1ICsBTOKOk0ftBt0lcT3lBy
    ptORtbYTAE1BD45yPEJ5wXb6Px+bjiEIsGxrjk1iKNXhxD1H3HoJRD79W+9qCNhR
    yOIEJ23O3thubKUKgT5Hnu0YDdxlLUU5FXtqJ4eD4db3tjI8eocy8bbAmpdBOaWn
    IhWoocXXgpn15skqNQtgnaP9xIeu6aNsU68GlKVVGbHJsv0anWEREjfPZY/oBJW4
    sRTS6oECd1p7cKYioYcq8N/zB3BSYwCMo/u1DhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477963; bh=rfPzSO
    Q9y1mxqKzrBqZvPPOCyau1tUIZj53FaoTYsfE=; b=M6PEJuv0nM1BoTkCUPiKsj
    XKzjiS4A32sa0LDwtpcDFVgM+B8IkZKoUeH2ZVWwkVNarcS3ODizjIl3WbrA+qfg
    aQCMnI6EuBkbdlC9J0rQO8QZxGO4eB9OgF3eRpXr1tR+tYz5Qih/5fPwbX5JQGJf
    GuUTCb3bvl+36pPjllr1wRkBYLzCBozVCtfQ/ap14K+ui1yat96qL+vg/oJ+BFuI
    ml6lIBH0Ym1WVO2BnypptFESHmg1VBTguyGoTUe8MWjb8DlhnzeekenBlukXKkmT
    UkOqouKA/zmjBS89zA4zewX0fvKAg47e/Z09sBfhmM2XUQSP1+VjCjx+5282szaQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I2SWSVSY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeivdeknecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=I2SWSVSY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeeivdeknecuvehluhhsthgvrhfuihiivgepieei;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934717AbeCSQp6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:45:58 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:30227
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935138AbeCSQMP (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:12:15 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 027/102] ata: libahci: properly propagate
 return value of platform_get_irq()
Thread-Topic: [PATCH AUTOSEL for 3.18 027/102] ata: libahci: properly
 propagate return value of platform_get_irq()
Thread-Index: AQHTv50DbNsjX72xZUS/ASiUuj7D3g==
Date: Mon, 19 Mar 2018 16:12:01 +0000
Message-ID: <20180319161117.17833-27-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:p7rlXO8OSDoQ3Uqn9AMAE18UOH5UwWTN7Nv5yr0Mz3PKecabVJ8vPH1N8MkLsnTTnErsFFvYFQS9gZtrNgWxpVr1MLAnDRcrZUR+C6p2JvoELNejcDRfSaQbcab6AqcOGwnnj+rRzWtmHS+7KQfXir76D9KYfbf8OZ5c60FRN7NerSD+KG50mcroxi4TvORMHoaF3mThpOlB7q+4sVu4mx8mcJv5+Xb79euQXiYne8LoxTnNSQi2TEGv+Bha8tOw;20:R7VqibYy21PVyXUjNv9UWLatuXt7eJbympOHHRKpu/XwNZYgQyTppwJKkQIBVI/MytbB5/b1Or7clPU9aBaX6iwnhgOep/hJIMZrWr5onOkl4UbjG3XPAI0CvndtwFd7WUcZTLc7v80OpUAcS4hpPXt3t6JvgZJRNAMGcC7Mqes=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ce2f5ee-a636-449f-d734-08d58db429aa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09200351B1F7CC1730FFE206FBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: kSLGzGbG/K/SewOdDl/GkHKzr0cnthOA5Gcl3/u5Oab6iBVeDcCHpw518xpaaZcS7h1W9kK2HzYF8SZ+u4yLSdunYIO1hasPEPpSSM1tJJy1thTvandvEqhrXubIi3bhcpQ0woFqxV4huFvLKn8wuSXHkC6nsKO/4c8LaGkAZpQEww+axG+9gudcVdf4ONOJjv5mldw47qGIREpddIgomo7uf+9b2HFu4cwr9y0GPmx6MjtbZKfrMkoGeiEpSEQwu7QRGEzot0epZxcFETH4jsemZa0HxRnweKS+dslNn6wrssahQj0jvDAbwUV6KP6reYvWHdrW/YkInHSqFD2jBg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2f5ee-a636-449f-d734-08d58db429aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:01.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

[ Upstream commit c034640a32f8456018d9c8c83799ead683046b95 ]

When platform_get_irq() fails, it returns an error code, which
libahci_platform and replaces it by -EINVAL. This commit fixes that by
propagating the error code. It fixes the situation where
platform_get_irq() returns -EPROBE_DEFER because the interrupt
controller is not available yet, and generally looks like the right
thing to do.

We pay attention to not show the "no irq" message when we are in an
EPROBE_DEFER situation, because the driver probing will be retried
later on, once the interrupt controller becomes available to provide
the interrupt.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/ata/libahci_platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.=
c
index 0b03f9056692..94249ceb99f0 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -419,8 +419,9 @@ int ahci_platform_init_host(struct platform_device *pde=
v,
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq <=3D 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		if (irq !=3D -EPROBE_DEFER)
+			dev_err(dev, "no irq\n");
+		return irq;
 	}
=20
 	/* prepare host */
--=20
2.14.1
