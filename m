Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1E2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B362B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVvFj3UI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfBFLwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:52:04 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:62276
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726750AbfBFLwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6RJm7LGU+G5D/LDt1dZcGyFr8vRxwBG4mHbqkmFlro=;
 b=KVvFj3UI30ryKY9sQGtUS2gJ2wklGg9UHkaJZlszDJYCo3RZw6bGZUJJv52YK6CzKTYROSfifotQCuN/oPsFz4gglBmUgcwyYbhX5fIiWirV+laDkDNBuz9oZvWQ/Ui01/8Acp9sX+pCf3x256P/mZEnWM7VbKAzYAlf2OftQdQ=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3743.eurprd04.prod.outlook.com (52.134.15.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 11:51:59 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::74fe:7d24:1e75:3477%4]) with mapi id 15.20.1580.019; Wed, 6 Feb 2019
 11:51:59 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/7] staging: fsl-dpaa2/ethsw: code cleanup
Thread-Topic: [PATCH 0/7] staging: fsl-dpaa2/ethsw: code cleanup
Thread-Index: AQHUvhJdjPlcfvL1cUiqgblpgdxeiA==
Date:   Wed, 6 Feb 2019 11:51:59 +0000
Message-ID: <1549453888-24593-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3743;6:+49Qls4gP+dfx37RaT10MdUDanERrdLw1aZqW3/ios5exB+9NjLkgN1MSXRqdil7q22+hH+4j+ezluCGynsZrq4t7qJi7ehSAeusK1UhQlyj7NxsoXBNkn4T3RU8/GSB2l8I2Qv2p/AFmPH2vj1PppPi8n8NszAzporJtg7rPisdau6M+Y1wbhWTdq3k09MnN3fFpYoDoHmTN5Or+XGCKUGMWEjLgFfdNV8fBOWuTZEJLOnUnrQPoe4ZnA0JvMqYBNhyMdzj7b0TsBITX6+oPncvwUYaaqDJofqFVtjachRzplveEMhoDlaeXl1zewt+6JbJrXfbgJpinJj7JHl9ND56+DEPWAumInFrJ5DPMk0KUuEd1w7r5zDcGlhCFsO9sPL1ydtk+zekNEzGlwpcdl+xWuwjf+FpQTm55STM9nrLSKJsuYO5oKtgu6ziBSUS/ppSxsrX7hidzDD5rg7FZg==;5:eraXxjE1W36pNRKPP7vf1qMYaPrnRGhVrW5u13dgvxm9vsIUlMSd4/NQSPt6uOub71+yL2Zkb+SrJ0SUTRQkuQ9Oi6/7BtTljU/PAWlyP3dIF75Fz1Ap4WQfXM1+CEAoDxGosFNnQ/Wd+yidMcYvaYdBhCGTzii41Z9/Fb/Ih9fdTQWNq3tXQeE0ZrIH9kCTNXFH44kkVCHC/L6RAnyz2A==;7:J7oisCBidOHqBSaaSQfexAcnuxtX2Tz7xDPABcXqEyri6e1KV9b8gpN9xE0SLDF8jXHHKov956l3LANnUTAOLSTGh4UDFxj36MHBsET1S0wZq6C1tgpSOPFLbOdQ2TXj8e94665rwW5GjZOPOUn0DQ==
x-ms-office365-filtering-correlation-id: 64519613-883a-4411-d89d-08d68c297ff9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3743;
x-ms-traffictypediagnostic: VI1PR0402MB3743:
x-microsoft-antispam-prvs: <VI1PR0402MB3743A5C959FDE47B292E5CC1E06F0@VI1PR0402MB3743.eurprd04.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(256004)(6486002)(386003)(6506007)(486006)(53936002)(68736007)(102836004)(478600001)(86362001)(2351001)(14454004)(105586002)(71190400001)(71200400001)(2616005)(106356001)(6436002)(26005)(476003)(4326008)(305945005)(186003)(7736002)(81156014)(97736004)(4744005)(99286004)(14444005)(44832011)(5640700003)(54906003)(8676002)(6512007)(36756003)(1730700003)(81166006)(316002)(3846002)(2501003)(6916009)(6116002)(25786009)(50226002)(52116002)(2906002)(66066001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3743;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6SbInVP4i25RqH2KOUlKzn06Ng2pM+6ovciHPLzKNXXwfWlYIZmt2QUAGXcH9+HmXmnraiWfbI3iboM9nl4uBJM9HkYV5LXtk4wRWiJBKJZt+K1cKzAuU3sqjJNHHi5alULK8Uej2uB34nOjsunM319j2I/+2SEU6K9phFahyxWpNHLcTjOyVULolORedTbO8FA/n/6c75HQdFk5ueahHyEgIl/f3h/+OUUEB7f3y8PoL8Ce6ya81kKFCDpxtrTOk0QVmxB0qzgPO6bXKXy3StHyq+l1RZ63Hyvk6k9MCbQI1qzP2H/lm9ZTn6FqX0SdRqo3E4ocK6ZbX73DcbaSzBMcfo7LIRgR38CkwM2WAo4WJ0TTK0I/iCu5cJ0+Yng/OE/jw2SvZR+ihIcnHan8oaKdBcGozjjJMv36dZLU5c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64519613-883a-4411-d89d-08d68c297ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 11:51:58.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3743
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set contains various small cleanup patches
for the DPAA2 ethsw driver.

Ioana Ciornei (1):
  staging: fsl-dpaa2/ethsw: Check notification relevance

Razvan Stefanescu (6):
  staging: fsl-dpaa2/ethsw: Fix setting port learning/flooding flags
  staging: fsl-dpaa2/ethsw: Add network interface statistics
  staging: fsl-dpaa2/ethsw: Remove netdevice on port probing error
  staging: fsl-dpaa2/ethsw: Add ndo_get_phys_port_name
  staging: fsl-dpaa2/ethsw: Add switch driver documentation
  staging: fsl-dpaa2/ethsw: Add comments to ETHSW_VLAN flags

 .../device_drivers/freescale/dpaa2/overview.rst    |  6 ++++
 MAINTAINERS                                        |  1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 42 ++++++++++++++++++=
----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h            |  4 +++
 4 files changed, 47 insertions(+), 6 deletions(-)

--=20
1.9.1

