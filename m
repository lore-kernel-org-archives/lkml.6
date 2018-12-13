Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA7FC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B90320870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEXnddrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B90320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbeLMHIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:08:00 -0500
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:48784
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbeLMHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O9A0389UxzL+mfljNbAvNKwg2EmDnUb/2e4sLOc9FM=;
 b=LEXnddrVyxgNecLZPHhXGwcXxz418DRXn2bdK5RuJ3YND5NpjLyNrNUCsDSOwIS0CzcGLjJHw5VSAOBvX1Tib+X7v7F5eqwLLN4T+8arGZytvMwmyT5xycIWjpeIFHajQbITnv9HPtPhxur5XfjqS7JjAPMucds7/1fcEnDSpR4=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4985.eurprd04.prod.outlook.com (20.176.234.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Thu, 13 Dec 2018 07:07:53 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::edcf:3d61:66a6:8bc9%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 07:07:53 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Topic: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Index: AQHUkrKRyn6yL7TqVE+qZvWvbmx6sA==
Date:   Thu, 13 Dec 2018 07:07:53 +0000
Message-ID: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4985;6:/byrr8crrGuOya/LladdMVR+AhGaH8IOBLyxYyHZLNlC4EDReZ5RJBetoXklMO0A0y88htV3dLIV3FkAWhYOu72Od5KnpR41hI3TkE2cidDC94/pI5BdhKsWRqxzBbZp7YauPRPlKIuebZuYl7FvRiRRdxZFZc+nJEpegeobGIwRHLNU2efatSSkhiz79rw6uf01GJRsnSfyBzPADv2l3zILzm8qMYMMpiNEPoaNSJIMmNek7E4XqmbEwTA3SZyF+e1/AMF9bhn6cwD3lDCU+9o0m34hlxpnA8lKUwFy4Qp4OKisXTtQ/+SjhQSw5qIVIUlFODVswOkOflVXTl1/ApGDK5WcZRjUQ5iBbhVZZQZYh960bqItV08+Qb5WnvN59+KUMkIlbD+AoJjxN/+iOxClfyo+/3b68BP4LUiSjpSk7d0CRhFybSaoEsC8Vxmpy0StCK+eldQC2e1IHp1Y2Q==;5:SPKfc0hbAYbHCY3pHPM6TxITkGrHW9Xzr9oLCGOgiSE9Q4zwV+6OChmHQ+wuUJuHTpUn0q+U9yOk2RNVG79R9/dKafFCZxTpvfz0WkouGmtFK0Gv3Wj691fV8BAdxw52nZFhLq99WqAINLIe2wzLIaCircFJo3m7TsLKYjRsi7g=;7:yy/F5pdsFSdC2ZamVR1K5nD2EnmIs6mtVE/aNM4FR3AB3sVBSlOPaw4nJLMqEozPkbeU5NSdQzUt62Mp0AplaSq353M5S0pM0lezUiKYBHkg1qtzY8z+0UMrRZV7dsMLhOyW8lB0UQNuW02fnIgIug==
x-ms-office365-filtering-correlation-id: f99c57f1-1d32-4ef2-dddb-08d660c9b35d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4985;
x-ms-traffictypediagnostic: DB7PR04MB4985:
x-microsoft-antispam-prvs: <DB7PR04MB4985B9314B83D033F7838F5AE6A00@DB7PR04MB4985.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4985;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4985;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(97736004)(36756003)(71200400001)(106356001)(71190400001)(81166006)(8676002)(81156014)(52116002)(66066001)(486006)(256004)(2616005)(476003)(316002)(86362001)(50226002)(105586002)(54906003)(110136005)(8936002)(2501003)(3846002)(6486002)(4326008)(6116002)(53936002)(6512007)(25786009)(68736007)(26005)(186003)(6506007)(102836004)(99286004)(386003)(1076002)(478600001)(14454004)(5660300001)(2906002)(7736002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4985;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9C21D8Hgs62pOKYLWkHWcxjYhIUunaOn2eARCVLDgbD2YynwnT0wH5q0x37JsRJLtKvU16Hbr9XOd9NFQ3ZMGSz7Kwbn0227NYzOCp3y1HzVuKuFyeMmIAepzCvxKwEKP6j1Wc3ijMQkKHmFjPTa/Ux3r8XGSnAYgKOHM3Qgo/fYEhZ8NwpJqC8d+/3qQIvJSEXPTcJ0HX+WqJmlJ0Ma4EuKbemnDEeEdluKH9yu5Zb1blf2Eu58iI0u5keogf14xLgx0di+SNq0XCsq9TirflxR+kNpwkl/lSgbwCntRuhythY7f6mvkrXMLQEhn0Hs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99c57f1-1d32-4ef2-dddb-08d660c9b35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 07:07:53.8626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch set intends to add support for PE clock source select. The
FlexCAN controller can parse "fsl,clk-source" property from device tree
to select clock source.

Dong Aisheng (2):
  Documentation: can: flexcan: add PE clock source property to device
    tree
  can: flexcan: add support for PE clock source select

 .../bindings/net/can/fsl-flexcan.txt           |  8 ++++++++
 drivers/net/can/flexcan.c                      | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

--=20
2.17.1

