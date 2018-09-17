Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AE7ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627552147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="F0GWNou2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627552147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeIQI2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:10 -0400
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:15894
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729637AbeIQI2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHAPQYMoUmGFn8F8WlJ/vjlYsS9tWhv2zoVLPXkGj9A=;
 b=F0GWNou2WryOmvt9MzIjZCSyBl0WwyXSSrHnXPTdv0o8VdUzGf8KCnltJ58G705waUZ7HEwVisuX+vDL9pV9YjgGDSKu6ibwjaew7WA5bcs8lS5xW4NKEp7KwZ7akIS1kSrDcKj4G6TXiXRWaBq3cChHramDoc0+q+BYtWXv5qM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 120/136] gpio: Fix wrong rounding in gpio-menz127
Thread-Topic: [PATCH AUTOSEL 4.18 120/136] gpio: Fix wrong rounding in
 gpio-menz127
Thread-Index: AQHUTjK5+zuNQXKFtkyVW7SsSBW+zA==
Date:   Mon, 17 Sep 2018 03:01:27 +0000
Message-ID: <20180917030006.245495-120-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:2nATijBvQ3OZeo/1Met5IivZ5o0MEui7/m0qpJXorQ88vhQVXaOx8vRClem9ZGc1eMy3PC/C8PMmz9DWizcndKx+nVYpE8jv3rWL7pDazmbYi4V6JtDhTaS51bG/NaapHbvxM5gK5Us+aBv1ZpJnPgRln2u7La3UmbLsa2cVKy3ISFeX9PpgSoGYoW5O0DNy1KoCvwSX3OFzg3GkjWRUjiMn5ta0sUUPJBytFbv4wi2ePZWp+54bTcgSZ4OFsODDRmLxP/Xqej5CLzUjPYGNjeAVvwMXNO1V+OujjPmxz5o7uvVrbUqJ8zvqx2nRYVzaKk/ptXQDIafI62/PP3p0550Z6Ww1VQ/5EzNOeVfSIwzLQjxvcyDTo+Y4mv6JBk0k6FnjnvMzxBSQvnOE/VNggkjvJadTXgk6HUn62zuU2jXhJxEl/IPmTesoZzXwoavRrmT+kKXh5oNIsHJzEVuq4Q==;5:Zl3BYOtSOBGZ9trHOkQw+T5017mooLC1sT+z3rfQk2eJ2gRYDhl9NS6/Gly29BUE728I60mL4XdrW3CFBKkKicGpFyA7ihRMebeldCHsokLIWcMIn1h2VcaZ0oSqy2quybUIDOnLfvUeuq8WnmaAP711IzhCVCarVCxvDEGNM4w=;7:2S5+iGv2dOoXsPnErX9Wy8Y2EWd3d6So5bOSXvgptcN6nOQvVcPjPvpTI4FTftCR7rfO2CUaX7BAFRePLFPaj3So4NlaSn+Wu6sgRhh5+E+NBQd90LjKZ9KpZ3dR1zNC66KWGCQN/pHn48aceNfs405/pDfg4IU9f/hNr0qAKrLPf9/pnlXcqFm9mvXjj7ovky0xDWI+RV57i2SkLSyF9vBC8alxQZIrET3D/gd6Y2SJjFw7mEI/YDA2+p3RteUM
x-ms-office365-filtering-correlation-id: 3546f061-edd6-41ae-22f1-08d61c4a0cd9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168222998870A365DC725A8FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(575784001)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jxcFg9rsHXq/iZ+0nTwaWo02vgdSTMxHoUWJKccYczSiKUGCbQIHVz9QwUYnT6EAZOWL5FO7qbIG3S+MQN83MYzZ5pd6W1qe0NRcHnl0ECYld+0KN3q3aLKm3RD9PWgz3aA6Z3b8gqaeGNc6uL3NXfjKofMhsmeFa0o87L90GwVyB6Ll5dQbfgWEtOsQm90t71U28AJvMLaBWLyCBqkTwmRSjLaMCtUakpPas7G9tbji0/hrJEBPk8RiBTLmXBt651jN9FFloRYSB37CTfn/VJ/KQz5OHMxYC6p+MYxXS5LEKKVhoY9c3HiH+bbwWzNJO5d0PFWjuFDwxOuDEfmWddsw/mv1vzRiScV6crEo4dE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3546f061-edd6-41ae-22f1-08d61c4a0cd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:27.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

[ Upstream commit 7279d9917560bbd0d82813d6bf00490a82c06783 ]

men_z127_debounce() tries to round up and down, but uses functions which
are only suitable when the divider is a power of two, which is not the
case. Use the appropriate ones.

Found by static check. Compile tested.

Fixes: f436bc2726c64 ("gpio: add driver for MEN 16Z127 GPIO controller")
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpio-menz127.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index e1037582e34d..b2635326546e 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -56,9 +56,9 @@ static int men_z127_debounce(struct gpio_chip *gc, unsign=
ed gpio,
 		rnd =3D fls(debounce) - 1;
=20
 		if (rnd && (debounce & BIT(rnd - 1)))
-			debounce =3D round_up(debounce, MEN_Z127_DB_MIN_US);
+			debounce =3D roundup(debounce, MEN_Z127_DB_MIN_US);
 		else
-			debounce =3D round_down(debounce, MEN_Z127_DB_MIN_US);
+			debounce =3D rounddown(debounce, MEN_Z127_DB_MIN_US);
=20
 		if (debounce > MEN_Z127_DB_MAX_US)
 			debounce =3D MEN_Z127_DB_MAX_US;
--=20
2.17.1
