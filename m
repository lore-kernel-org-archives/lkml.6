Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E81C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 05:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jHRadsL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A54B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeJWNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 09:52:30 -0400
Received: from mail-ve1eur01on0077.outbound.protection.outlook.com ([104.47.1.77]:33696
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbeJWNwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnixT7z44QuBsde/Gi4c9Wbhb35qXMWQo1EITnkOOn8=;
 b=jHRadsL2IV2cV5zycfYthXMOb0A7DrvyTP7NJRMQloTf7yBjpwfk9RHyG6e2xz3/eaz1ufJFn8iouqfZF01YPVLl2MG2AEFfVXrH9EA92VzRWUpmq6+Z7RpzhnsdCmOkheOewQT7lLY7tHly5tWlDqYEKkSGy0CWtLmdx7ZtC5s=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4794.eurprd04.prod.outlook.com (20.176.233.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 05:30:40 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%4]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 05:30:40 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: [PATCH V1 0/4] ARM: dts: imx: Add flexcan stop mode wakeup
Thread-Topic: [PATCH V1 0/4] ARM: dts: imx: Add flexcan stop mode wakeup
Thread-Index: AQHUapGIb0z1wDICiEWnVe49xe6BrA==
Date:   Tue, 23 Oct 2018 05:30:40 +0000
Message-ID: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB7PR04MB4618.eurprd04.prod.outlook.com (2603:10a6:5:36::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4794;6:y9fYfNlCM4zieXMNYN3W+l/S5n7hbMvN0PwFm1pq3fGdxmY+3aTKQ2wp88XJW3FCzF6nRCT2hqaIKr2V5SWDsk0Imy81Il/8oV3DZbCDMZcxqaJG9HV0wea0s0fxsrSji/jvUa7gKP9jsrAZxytCqcNmak0ozGDBK8cJ1v8PCX7PUy3Cf3GsttzrtS92AFIfpWE6dMpva+NHEGQu1agORyD+lcNLp8ZZKl6O4yYmrnIv5Oj2MIZOx3Xj00sdKVi0zER49ss5oozvbzTzWYR/v7JvErFQo3ZF2K8HZ91uFxOD/UETzQz3Wpe65cIabzTLTxQz5gSWTNtwHWcNzXTyQ5eaCxnhLKPIwxdn1j2fe7c6SZJ9APHx9JWRLavEB1O8cjz8kyIjX49O6ADJFVqMvGJ4r0iYt9+rgAWevwD7C4hEyaZBq2qncYfXCR04Bj1R8F4aV9dSKWZp4LqOp8MYzw==;5:sMhqiqWxUYiIlEN6kIegRKsohAUS3gghPFKliSdPx4k1JhGHetE3clXIydv9DWz+KpWS/tF6xKFZrXOsUjV1QIr7tEv3fZfJj+5vF9BusgiiPZdkEAEB8C5GOzl2W28b6LLQwM+h+Z+sI6ctx0ES92ATpOut08ODLLbRAewE7aA=;7:md+I6GJpl4iFhMicnOlFKyD6rn330uWbfdl/Ir3Lh0s0uQ/Ju0ugQgfRyqZTzFQ1lYAwHryryWnEEH2hIwlVsFZKPT2v2RBSD28kkfjRYlo+B613sTCoWbJCiGXVy9vFTChfWuLP7KaobYUrtey5L1OGgB2w51i1L5Uk/aN5xsknrGLSpd7LF10zcUaT4cF4oEe1Xx6nzMpdWlnWSua3Wu5XEFiABbbxOsDGgZqPhdxWVTCoF3l1NOuskVgINhV4
x-ms-office365-filtering-correlation-id: 6a3f1534-386c-49cd-c6d6-08d638a8ab2c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4794;
x-ms-traffictypediagnostic: DB7PR04MB4794:
x-microsoft-antispam-prvs: <DB7PR04MB4794167EF55E89A709FA7201E6F50@DB7PR04MB4794.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4794;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4794;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(81166006)(26005)(8936002)(6436002)(25786009)(2906002)(8676002)(305945005)(7736002)(81156014)(476003)(6116002)(2616005)(3846002)(53936002)(256004)(5660300001)(102836004)(6512007)(6486002)(50226002)(71190400001)(186003)(4326008)(52116002)(1076002)(86362001)(71200400001)(486006)(478600001)(14454004)(68736007)(6506007)(2900100001)(97736004)(386003)(99286004)(36756003)(316002)(5250100002)(54906003)(2501003)(66066001)(110136005)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4794;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: A3FdQOFtaACi+notd1KUKwVE5ckJNqHPHIZgAuXeuDn1cw93+ZT0Yqw2sJpt9lwjRbTBHNw4D30opnToJEMYQnUs3+n0RpNtIsBgfIqFm7iB2gPJbyVpWpMl9gt9k47rYMcbtHSVapiZ+uNrXIlLmQBQXfK0ONZ2hdGRRgCVeoD9aMHbWfrTgyWxRWC/N8SVY8RLxIxyG2+BXpRjX+7zLPgFfg16aKOPhsDITDk26xFMY8xbFdasuEIqUWXy+JCrcnA8gTO5a9RCc18RmGquz8KRS2pEjOIPjEZQ+TtYqI6qK7VGLlJOe0Q3yROFczVYkeXzRm991ZVoai5M1yLOTxhaRTZddEQe/AtQxD/EtBs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3f1534-386c-49cd-c6d6-08d638a8ab2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 05:30:40.2159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset intends to add flexcan stop mode wakeup support on IMX6/7
platporms.

Dong Aisheng (4):
  ARM: dts: imx6sx: Add flexcan stop mode wakeup support
  ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
  ARM: dts: imx6ul: Add flexcan stop mode wakeup support
  ARM: dts: imx7s: Add flexcan stop mode wakeup support

 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 arch/arm/boot/dts/imx6sx.dtsi  | 2 ++
 arch/arm/boot/dts/imx6ul.dtsi  | 2 ++
 arch/arm/boot/dts/imx7s.dtsi   | 2 ++
 4 files changed, 8 insertions(+)

--=20
2.17.1

