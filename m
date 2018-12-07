Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFFAC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDCD20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SALBIjMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDCD20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbeLGGFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:05:41 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:10123
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeLGGFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9oyanS0PbIVVkCehD+9WLCBOp4R13C4OHu3WDHmTRY=;
 b=SALBIjMbwJJLHHAKLdn5TM8yqhyjMbaIWXEICfol7xKv9eQSfnI8i9vJv0LBY1iHjggchLtVFoyoW5GKqCWePvflvXPxgN0Zs8K9HcfVYZY8YJN54oGcuZ/v/XhLzjE7wAyvck8DQPruLA4ManjMcH4HFQilhOXsOvQAK5P+BfU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 06:05:36 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 06:05:36 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] clocksource/drivers/timer-imx-tpm: Specify clock name for
 timer-of
Thread-Topic: [PATCH] clocksource/drivers/timer-imx-tpm: Specify clock name
 for timer-of
Thread-Index: AQHUjfLeXk3gSu8ux0GAdzuTlJCQwg==
Date:   Fri, 7 Dec 2018 06:05:36 +0000
Message-ID: <1544162387-22980-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3772;6:XRfdtGzPIgkhkvkvoxc8C9+hE/84AprSSllKWNBMd2ByM9/Hsorj4Br7eYP6FSmdXm8BlrYZu6w1pG+7y4eZ5x5MT/aPXWyNVASvKmjl7CSI+h4RGGjLkv/OEZ7CoGfwfzR4jlOfKQJmg/zD7GDYJ4ceyN/HelM4ltpqHe3LMYtaIA6TS9NP5wnqRT5ZiUl7GoLJ8l6dW51HKbzmPNd3NepgX/B03l4A7au7wMoSS0Cl+eUUi+xIXlv2qv+0hNyZ5GSbYuBAckMcfapafwG3R6+Q9JF6m/Na+m6/5486K4Tq6Cg6i+PIlYlTPSY/Cqul6GrKUqnKJHPBBoXuh8H8KVSoOYm6kmjEH69+RDOFNwFTQ7mXDsVi97DgY6ANrR0XLPLtHF0F3MLehQKDn/G5uRAHMPY8quWyfmbOf9OuoNwQvEjiS5KdWSAylkWwqiIe5LyLeLbrZ3WYXspiI55uPQ==;5:HaVLNvtkb35XVnawD764WZr7kE7hCkgTZOkaHP+9lpiab/nm2uXS5rIsEHhP4ytTt7LWyN4kxhCJZ/OtZJ6v0mkC2QdibXMfKeCye765AacezJotWOpAulJRB6D01XTr5XMXmO3ujHjlN5RsY8RuzUlLrxbeHU8rPoVaz3UQFV8=;7:1FWPHFRpZSkdlQYXXlQ1ZMHjea77MEL6Ww0itHYwe3L7W1QTKOBQ0ioDzGb5Kq2D3VwTwCtkfdBbqjfVDUM2B2JWRhIZ3/IvFwWYjXbjvf030VbW2krDOjPPBAis8c0rhbokDtU7esBZh163IOoMXA==
x-ms-office365-filtering-correlation-id: 0ac9ddde-ea07-42c6-1c4b-08d65c0a00f8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3772E767EF91EAD454BB3836F5AA0@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3772;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(186003)(2906002)(36756003)(4326008)(8936002)(256004)(6512007)(97736004)(6436002)(50226002)(2616005)(386003)(71200400001)(105586002)(71190400001)(102836004)(6506007)(66066001)(26005)(478600001)(14454004)(106356001)(316002)(86362001)(14444005)(110136005)(305945005)(2201001)(476003)(3846002)(7736002)(6116002)(99286004)(8676002)(25786009)(2501003)(52116002)(6486002)(81166006)(5660300001)(53936002)(81156014)(68736007)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EJiFbQqR8q4IeW6gyx2ZDoSIGoX4Z5fd/MqUQj+RGnIKSYcWO3iRshpfxOWfv8Bn4K+iNab40DLAiPsshG9DwPe81Tt+NwLpOLE4aXOWZqzyosjINw9HBifeD3jGpmUag++0uuI2hh3+NdrRls1zoIuujCZY8HMEqtbCJIXgNdDyuoG9U7zj5Es87i2wPTkHQpVFI05Jnw8nXEZhYmBphtoZAqv1Y5BFlVU0ghyZlZq9ZYJLDy89zPIu4zQdW5CgZXvnyFTvXB/QpxQclQ2Zb9RB4A3otBkJzc5lZBlgFMSSri1DrS11BO7/upqPhFa/3lQhILp6PeRMlSGjqqaVzCSO/Ure6NRYvzNYJubhw1I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac9ddde-ea07-42c6-1c4b-08d65c0a00f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 06:05:36.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX TPM needs "ipg" clock for register access and "per" clock for
timer function, the driver gets "ipg" clock by searching the clock
name, but timer-of initialization will get first clock in device
tree TPM node since no clock name specified in of_clk, that means
the "per" clock MUST be the first clock entry in device tree TPM
node, this patch specifies clock name for of_clk to avoid this
restriction, it makes TPM driver work properly with different sequence
of clock entries in device tree TPM node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-tpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/time=
r-imx-tpm.c
index c3dd4d2..c1d52d5 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -139,6 +139,9 @@ static struct timer_of to_tpm =3D {
 		.handler		=3D tpm_timer_interrupt,
 		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
 	},
+	.of_clk =3D {
+		.name =3D "per",
+	},
 };
=20
 static int __init tpm_clocksource_init(void)
--=20
2.7.4

