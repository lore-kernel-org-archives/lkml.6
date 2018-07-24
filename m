Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5218AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5C5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mndvvixw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5C5205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbeGXMyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:54:47 -0400
Received: from mail-eopbgr10078.outbound.protection.outlook.com ([40.107.1.78]:37386
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388278AbeGXMyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jfr+1Er+dtpqSeM5puS1mnsFLiPqnC7q4+aSr3uc4s=;
 b=mndvvixw6x3VtpEpZj22ogn/CMedU57IWTZmVJTX+wydKmdPK5a8pkCK4ILifleP/bXyaZkkoingAcnCz2jjTZKp/ZORjMqqFe6cZQli+5zvHnsjB4qaay3msY4tFK8OZPdKFj8Oc0e1SGAAgCvbHS64nq9d6gA3YXyhrCJ2M04=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4353.eurprd04.prod.outlook.com (52.134.125.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Tue, 24 Jul 2018 11:48:35 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c96b:d6f5:db75:1273%4]) with mapi id 15.20.0973.022; Tue, 24 Jul 2018
 11:48:35 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Sven.Schmitt@mixed-mode.de" <Sven.Schmitt@mixed-mode.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 3/3] soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes
Thread-Topic: [PATCH v3 3/3] soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes
Thread-Index: AQHUIzJL/ao7CKx3U0KEIQh/qcTgz6SeQhyA
Date:   Tue, 24 Jul 2018 11:48:35 +0000
Message-ID: <a5896a23ac09fc5e904de652bae9cd4f65eb7a7b.camel@nxp.com>
References: <1532425563388.30268@mixed-mode.de>
In-Reply-To: <1532425563388.30268@mixed-mode.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4353;6:Wf9Btl3AZpy52k8d7NrLXepbPvfzM/B8SuTQpUgdKQQeMFvS0XCblgT7Oi7oWc6XSOMY9pzE5lwIlnxdWgxqvzdixO6TxJiAax3xYtPeYCr+wLh/5RUHtLvqtqfHCGgcfowg6fy42E7qq5REg0yUO5jRpDimKuhn6g89MiHgjkaWrmD8k8BS/+lAWhwgOqdIzTeWXDiuFORViQbtAfZlaeNnvdZMFvjVSz8v9uZo8JiZLtD8JH+J6IeKTmccYQRo7MxErthI0tAe+1wfN5X3mKHwWcaplP0FGrL9Y7FTQgShcwSSIc2tRLxtwhJpPDNPBtccjbTDRZYtbBVV63fSOUFZmDq8qYDNfFyi+PLtyQlAsfEW+iLcpmB8Um0USqQrWnhMBZFVelPaybQMDwg80HAaFSdVBhHG/do7weQik/eesr+nO0uq1Js/KaFBt3Wb7L/6yGg6Xyt+XbBGkwRsmQ==;5:+vjhIlS+nc+m79jFTjujjk2q/OnW/bIIzP0iLjGH+l93zdWR0LOWCXV97OKjMk87nxpXuaswwI9Dk7hlr5zj8Z0BksSTOxGg4t31XYOBbdf/3QYAx4CWtq2yvHLoG0o4Q5sBBNE1vuHik+OyGK9FsCr6k5VnObstRNxtzKlxvb0=;7:/ypusjZE+HofzjoTLWNmPcKPQFypZRwauHndI1yaCGdeIrX6EUKgpP0vots3MQCZaW3CBuj2Gm93U1qgu2WNWc3dTj/3o+eTP58hpwA8QLZaKcCPIh7ZiPJJLmw6bEUo9oRXWJjPvdDxYy9kU8Hj/D7HgTpFUpIn3pP6c+TTR2YWeqXWKfVBc2ICQVIEO1/ZhN939rLWXi8Ufs4NfaM5n/LLbGbJyhx1ja2AU1CmTmbOeQqcaZUr5wMV+c//i8Cq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dcf49476-e444-4fb1-5088-08d5f15b6373
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4353;
x-ms-traffictypediagnostic: AM0PR04MB4353:
x-microsoft-antispam-prvs: <AM0PR04MB435330226116F2676152E93EEE550@AM0PR04MB4353.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4353;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4353;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(366004)(39860400002)(189003)(199004)(8936002)(229853002)(25786009)(97736004)(11346002)(5660300001)(105586002)(86362001)(6486002)(106356001)(446003)(50226002)(110136005)(68736007)(6512007)(2906002)(99286004)(4326008)(76176011)(14454004)(54906003)(316002)(118296001)(6246003)(26005)(3846002)(6116002)(2900100001)(7736002)(186003)(305945005)(5250100002)(478600001)(2501003)(6506007)(486006)(8676002)(102836004)(81166006)(66066001)(6436002)(476003)(44832011)(558084003)(81156014)(2616005)(36756003)(256004)(53936002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4353;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Eu9IkHWv9nZE2ZKI5jOWCm8yd2RXIMg7/q85p7YynFjqf88pPL5OSC0NUaHQxUfBbB5Zc82+z1h2DM9u8Y0UEb/+Mt1KzaXW4w5ZflD91BFPuTgNOBLKbjUX9laGvG36DY2jq+jMm59x7U0lYKEZqlEpZpKN0krcz6tk2NQpIvHvcYFkcnewE22ppELbI/flQ4u2RDE1ZpYdeSFnR4syXXgD9BQOHmyMtaXnk3WbIOBq6956RxANFsDIzwadfdHHrzUKGMhLp/dUb76CmhCSBnx9emf8448xo2XUyC81NOmEs2bsZWkhWtsMzxoMecMWxzaVY6aq5Tj54Z7RNvLONH7tMWSLskSYd7NZUnzJg7I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCF3E1C24F3AB4087507805D142F97E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf49476-e444-4fb1-5088-08d5f15b6373
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 11:48:35.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTI0IGF0IDA5OjQ2ICswMDAwLCBTdmVuIFNjaG1pdHQgd3JvdGU6DQo+
IFVzZSBHUENfUEdDX0RPTUFJTl8qIGluZGV4ZXMgY29uc2lzdGVudC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFN2ZW4gU2NobWl0dCA8c3Zlbi5zY2htaXR0QG1peGVkLW1vZGUuZGU+DQoNClJldmll
d2VkLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg==
