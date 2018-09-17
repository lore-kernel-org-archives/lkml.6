Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362F4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BD9214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JkgezKkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BD9214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbeIQIa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:30:29 -0400
Received: from mail-eopbgr690116.outbound.protection.outlook.com ([40.107.69.116]:54124
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730455AbeIQIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHAPQYMoUmGFn8F8WlJ/vjlYsS9tWhv2zoVLPXkGj9A=;
 b=JkgezKkdL5bqLlfEn7sBYW8n4cSo21J/SPdnLH2/GXDPaDdeacrr+jBH3RGDbiN4xt3hYUB3XHdlrreYMSylear1HhsS4TyJeCsxlpCm8XRnecEYRxJxi3pKGrD7YD7nOzMr3HJ9vgom9owVcgHMmwqKNqxOCmU0cMKKp3ibw/c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0133.namprd21.prod.outlook.com (10.173.189.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:05:02 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:02 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nadav Amit <namit@vmware.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 80/87] gpio: Fix wrong rounding in gpio-menz127
Thread-Topic: [PATCH AUTOSEL 4.14 80/87] gpio: Fix wrong rounding in
 gpio-menz127
Thread-Index: AQHUTjL61hVtZpjUakGVnOkT5/qXXw==
Date:   Mon, 17 Sep 2018 03:03:15 +0000
Message-ID: <20180917030220.245686-80-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0133;6:orLFentOFF00KfZiU1vKLnc0pyZWaGQngIpFqhpeCloy282gQm7yC9aotXydrBiHW57GqAl8w+tRH7QvrYca43Xvtst6u7AiJ/VSVaRTG0r7pA6RRmt8MUVHWaL8cZCJDCChY75viWX2Y3uhXC51jcHtS97SVCevFXtGaTuzqOiFsgCsk+VNT66RJp0ZgwS5QWSfMUvPo9O2/QzOi/vkctGNHvV7jixzySZWv/Cc+8PMdRNagPk9p5j3zyCyKL3yI4eUTf/DcC1N7x+qQ7aiZWjZg/uplUobM+Z9jaXX2/PO0jh4eVK8aUEmx3iEfC4dJzpeh0irMJiIdLonC9naaaEeRqTydn4VdNQyARBS8/jPonZPiaPevKtTgxCZ+h/8LYAaTEVAqufVjsav7DWdUccyf5bceS/haNScFg5GCGKQK1Qfzd2GBo2ewHIgICu7xT/EzsAFMNr42Vu+ZZRuJQ==;5:J5bDz/+3yi9w9U1mIMUO5umWXYomwLPxW7ZBJNMIYIREYA413GBmKkYFLTbu/ElX93hsukeg1nWJSNnCR3w7KfEuhkwDegr832Gr1TpbfEKu+SrkAcp8/kfg772u8LKd2TuYwq/pngTdMbfo6kB+uiWhz2/T/tWn648JeAEPNZU=;7:ZOYBGHrCwzlvNPVkxMoNmjfdXsV/SPx1GacrXm07s2Mda6eYY+f//7S27O4Og6HAioH6hSrR667qItkj19rkI7ouJu2FrVm9/75XJwY23SWVS0kughsDInC077RrGva5YTxLUYycdKIP/A3yKZoxD6QhCBwlDbJDVt2gNgRteMjf29qRcCXIn7Es2x31h/aq4eknHzzo3VfrgkjTZUoRD5lbOf4awKOijWR0bkaeqFMJIhzjRvVFUSNr80NtpSlo
x-ms-office365-filtering-correlation-id: 761a25be-23f5-43f1-ca12-08d61c4a5c8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0133;
x-ms-traffictypediagnostic: CY4PR21MB0133:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01333565324BC85978CAE403FB1E0@CY4PR21MB0133.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0133;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0133;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(102836004)(53936002)(8676002)(486006)(476003)(3846002)(6116002)(76176011)(10290500003)(97736004)(217873002)(256004)(5660300001)(107886003)(6506007)(478600001)(110136005)(2501003)(10090500001)(305945005)(7736002)(446003)(11346002)(36756003)(2906002)(1076002)(22452003)(5250100002)(2616005)(26005)(316002)(106356001)(25786009)(68736007)(86362001)(575784001)(14454004)(72206003)(105586002)(99286004)(6486002)(6436002)(6512007)(86612001)(6666003)(81166006)(81156014)(186003)(2900100001)(54906003)(8936002)(4326008)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0133;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZmmlZFP2rukUIES7F1SCba6WyJsC6krbEDJqZq1UHWz8/Enlp5wrWK5kgrzT65dZtnqFAvnn1/rvs8j+33q4hsrSxSeYw73b6spf3ubSqEMMzDIl6WVjRkVQv874Sp1kC770ta48o12OrgGkUPibdx2OtFcqY0DeedeTlc9ZlyY5tIzXmJAht/3IQBKHoak4XriRlSOcE5phECTURMlW4Uc7yXgfAGoIl8c9LWWK3PQt9lwj9Qyp5CE0If96AVJOr9CHVN9bVdIvZ4Y9bc1t4jjS2sagHIUpbvSUfCGI2lcoZmeEEcQOJpeNKZUKTmUuIyFyUlm24nwAGRVBzr2j9/Fh0SIDl4edCZIq9lNDqJ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761a25be-23f5-43f1-ca12-08d61c4a5c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:03:15.7902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0133
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
