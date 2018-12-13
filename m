Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8FC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD44B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3u5XPIs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD44B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeLMNRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:17:45 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:44700
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbeLMNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IttkqedxI7/eKcmWVjuNP4AGS1Eow4wq+J6L9CzuYm0=;
 b=m3u5XPIsDnHQVpOCr8aw/kkei+U2c1Eq7nojeLxBaP3ydeRbaxtOEOUYg9o/27r8ssxNAsk3x0+9MSGuzMqRTEmv9IhQKVxEvwtcafBBd1mTa7i3WAPsE214+nKIDtEpvHQl2niKcXVbtSyNC0ZMQTeoVz8GLuoMd65WuJUBH8Q=
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com (52.134.65.28) by
 DB3PR0402MB3692.eurprd04.prod.outlook.com (52.134.65.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 13:17:40 +0000
Received: from DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb]) by DB3PR0402MB3658.eurprd04.prod.outlook.com
 ([fe80::ce5:fddb:6290:c5eb%5]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 13:17:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Topic: [PATCH 0/3] i.MX8MQ build dependency fixes
Thread-Index: AQHUkuY53d/oCm2ngUK7tf7BE0j/Pw==
Date:   Thu, 13 Dec 2018 13:17:40 +0000
Message-ID: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P192CA0103.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::44) To DB3PR0402MB3658.eurprd04.prod.outlook.com
 (2603:10a6:8:2::28)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3692;6:sSoL9sSDXE+NtyHzavtOcPL7ehVOBNobph6Gf4ZtdVshrebJHyp5cw8+NduZMf9AZp9BWXt8uMJpe0B3KFzsIZ882bSD2+EZlfQ/dI+DdipP7yULulNwlrzvKTvHcYNUSae2chKy4pSSPE9gaZUNbteLTmylpU+8/uDaFlWC3MJyWYgMU4uf8IV7zj51dQj59jPpJb6UI3Ui0E4UXKsWvCrxdr53tzxZlLxCGtqANaIkW/o5Ji+4X8to0bxqQF2vitHewUzdoMeVEymwtgQ9u89khSDW0O8HmBdHII2hJdh4/jxopsQ9ZKRfCGNHmSPg4qEHSyEW/O2zDUrJVP7YDuaFBN1Tcc47VCfe4imbLAWPUF12vHRJsecnWSiWJJAzgPJivJvR93L7OiXTezoSz7dMs2Mi2L7mwt4rqCdysB7LIxTsSKtDXEYmnI6xuV9RrOshT5HH7qyZxo41TtCFRw==;5:WHwAibX17l9xQwwOLKK8OCrnGT7AVJI+wPxvutak3Kpa6mA41y9br+7KlvUjDqLGiFiMf4bgV8xzgq46xj91sAoZ0gnM3wSG41ZK82aVS6wHNv7gKZ7RerHMomoeKoXgP73HMk6XO51NMo99yoFyZM3jPGCJl9zvrArOs2MY5wk=;7:NMGfMacHLhUmWf2cdiM6fgBFMZyRd1tOuyagzx5M2Zpse/oZf3AHTBexr2BZ0z8PdQqzmMW8dNnfWqbnMshrmrT0Y9Ew6O1OqcxygJUOFPywu6KHXbIs6ud1SrVEslWBbiyxe2nKNTLiQ7BQA4ACTg==
x-ms-office365-filtering-correlation-id: 42726cc9-5244-4b25-e65c-08d660fd5bf0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3692;
x-ms-traffictypediagnostic: DB3PR0402MB3692:
x-microsoft-antispam-prvs: <DB3PR0402MB3692DB5F2303EE85121DFF8FF6A00@DB3PR0402MB3692.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3692;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3692;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(81166006)(36756003)(8936002)(486006)(186003)(25786009)(305945005)(2616005)(476003)(26005)(2906002)(68736007)(8676002)(81156014)(6486002)(14454004)(386003)(7416002)(478600001)(6436002)(6636002)(5660300001)(6506007)(256004)(6512007)(86362001)(66066001)(106356001)(105586002)(7736002)(54906003)(110136005)(14444005)(102836004)(316002)(71190400001)(71200400001)(44832011)(52116002)(3846002)(6116002)(53936002)(97736004)(99286004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3692;H:DB3PR0402MB3658.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: W1lkyMcUT0SLpUzqd0io/oHF2GjKV5UqfkaGLvnyr7i0CaSK/r6zj6fOSq0xzQVFp5x9WTzruemRWNr2yciejdvEvrt7/gMBOFqId6a9guCJt80FyM2g+xVkdUH9846nJ5CUCChzo/YQh2pc0+OkJm8/RU4sdBWvWuOqmPSPK31cOoSH8mXtiR9j5YU3Sf4h2/1gHot+HymKnuDqG18LlNyIKV08nQc8WfJjUneW1JwMdFuKTi1YB3w471omvhBRAR9hAdGbHruLbSG1HemFPo+tRXrjmEkY9Q98c8Sexn7QpM82gucInK94Jww9qHqk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42726cc9-5244-4b25-e65c-08d660fd5bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 13:17:40.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches will probably have to be take through different
trees, but the order has to be kept otherwise this won't work.

I can resend as separate patches (if necessary) as long as we can
get them in together.

Abel Vesa (3):
  arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC instead
  clk: imx: Build imx8mq clocks on arm64 only
  arm64: Add i.MX8 boot necesarry configs to defconfig

 arch/arm64/Kconfig.platforms           |  8 --------
 arch/arm64/boot/dts/freescale/Makefile |  2 +-
 arch/arm64/configs/defconfig           |  5 +++++
 drivers/clk/imx/Makefile               | 11 ++++++-----
 drivers/phy/freescale/Kconfig          |  2 +-
 drivers/pinctrl/freescale/Kconfig      |  2 +-
 drivers/soc/imx/Kconfig                |  2 +-
 7 files changed, 15 insertions(+), 17 deletions(-)

--=20
2.7.4

