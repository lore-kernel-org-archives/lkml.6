Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE870ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B122081B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bAEMp8MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B122081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeKEK1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:27:34 -0500
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:37904
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeKEK1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:27:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIkGZMXVXSXxyUN3hHa2ZZQhAbHt1mdMF6gIb2bcYZM=;
 b=bAEMp8MYG2JIphnWhmom5aIohnPcdiLLD73RCRvrwSnNuk6CnZICmO5rMn2dxXKKMyPuZzEhhZCvizDy792ni9NIPOmW5sSAzdMP9gcgkc33gNmI8ahqGMbf0zvQd/xrxmL4qDmw9YCzVNFZP+FpYl9ptvc9Mb/BjOou2r/Bjk8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3642.eurprd04.prod.outlook.com (52.134.65.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Mon, 5 Nov 2018 01:10:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.028; Mon, 5 Nov 2018
 01:10:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
Thread-Topic: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to
 avoid resource leak
Thread-Index: AQHUdKRXRzpml7CMi0WCytiW4+vPCQ==
Date:   Mon, 5 Nov 2018 01:10:29 +0000
Message-ID: <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3642;6:UIo4tCzsLa9E6MeHe1ES/wabb1nTYtQrUQbMEit3SpVSwzTd4rgN/NX9xyCm1UrmjDYICPNt7cj/E5mqEiMFYO8qWjwIaCbdpPccA3Z+wOdaa9/jfWT3t40/Bppu5kGrKn9F7auJSPOLPrGPCGWUH+4On4LZl3jihqfyoiByXixvTw8QZ/eiIYU4N9O/oCCaewT+NlpE72XNt7IkORm32S6dEmLXUvyHWSj6iTWvW1MlXjjg9feSRIl6dxacA/JZ4n9tSnXdBJjjkTtbKxpuRE4Q3YbLw63WPohsYIy3llD72B/KBLZzx8ZcosE547xOK4oAjhqs/5vafK+L3PDmuGnTIQRRM7tbRwgLLM3sKtN0nXFUXWk6mIaJhBOQCGhIQ72N9foqDzGUCcvQ4e3Cn4KVPBaOdxYZHRZM3Zm8wJ65XJg79NUhYUQgmGiGqaJOvAEQS2FXzjZK0Onr9BwvBA==;5:H0McmyIAHumQQGZS+hUa9rdFMgPhzxua19CiQ4zuckpZ1boNA8NLWStqQTDgf47i3ubrWSvh0jfyzODzd8uPP/i9+Rlvq8720rm5pj6DGDDB+2RDRp5ajjA1MM5IO4+JUioFxaGgzQFytbmgYEnD4fvtQQLnNPeiTb3AF/TCrsc=;7:M1iCohhyDrGMDOYWbUEZ4eZZ8P547epjLApPAwDo6rcTYWvsQzrYFsmZGE1rrKQWZ0k9fhJm6sES6ulmS4Q/QEUvIXk8l05EpvOQjVG7wu2BWbLwUFSMDbRst5Dx6vgY4J/zbwl7w6DtPVTWbkPLoQ==
x-ms-office365-filtering-correlation-id: 2a3d314c-9e38-4b43-6881-08d642bb7a0f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3642;
x-ms-traffictypediagnostic: DB3PR0402MB3642:
x-microsoft-antispam-prvs: <DB3PR0402MB36429DB8B4668C4B0E7B6CFCF5CA0@DB3PR0402MB3642.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3642;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3642;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(346002)(136003)(189003)(199004)(2616005)(11346002)(446003)(6512007)(2900100001)(2501003)(316002)(66066001)(6486002)(110136005)(186003)(4326008)(53936002)(305945005)(7736002)(99286004)(97736004)(478600001)(36756003)(68736007)(5660300001)(105586002)(2906002)(14454004)(26005)(8676002)(476003)(25786009)(50226002)(3846002)(6116002)(8936002)(71190400001)(71200400001)(106356001)(6436002)(86362001)(256004)(2201001)(76176011)(81166006)(6506007)(386003)(81156014)(52116002)(102836004)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3642;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mw+eXUbwT/XY9gyrORMinqrriMxcy3ek+tWhIs0+/607TfCBt+3CKrhcBryzcts2rSyob8jD/gu51PAgo6Ktw1qwqaNv4WHWPK30KDVRY0VLKw57d55frMN/qcZiPGzXEmK69WQBLcTc9SNsPWQIHZSNCGP1OEj3bMBk4Vq6GQakGugFP2uX9a9dAYvAy270Qwj6mwSC4zNcMmyzDes3fhqyzdqBchqQHSnh2zrQmq0ILS/mkgIudfcCfNvKQXEt/zKP20DbT4ctbMqKoBfxqsyB5UdHzaQ0Wd7WwhhxUhL04NWrwWVrJhstfCGhEQTGsM5uG4CbP3w8yHxbdwjePMPRQzA3SCqSq3y7S/e/nTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3d314c-9e38-4b43-6881-08d642bb7a0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 01:10:29.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree should be called to free resource in error path
before return.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-gpt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/time=
r-imx-gpt.c
index a3d6ccb..0f78b30 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -477,12 +477,16 @@ static int __init mxc_timer_init_dt(struct device_nod=
e *np,  enum imx_gpt_type t
 		return -ENOMEM;
=20
 	imxtm->base =3D of_iomap(np, 0);
-	if (!imxtm->base)
+	if (!imxtm->base) {
+		kfree(imxtm);
 		return -ENXIO;
+	}
=20
 	imxtm->irq =3D irq_of_parse_and_map(np, 0);
-	if (imxtm->irq <=3D 0)
+	if (imxtm->irq <=3D 0) {
+		kfree(imxtm);
 		return -EINVAL;
+	}
=20
 	imxtm->clk_ipg =3D of_clk_get_by_name(np, "ipg");
=20
--=20
2.7.4

