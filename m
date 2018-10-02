Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA7FC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E7B2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TBOz52an"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E7B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJCBqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 21:46:40 -0400
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:57649
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726881AbeJCBqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 21:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fjM5DlSTcqG19/QDkPj7kuldjDjPmE5YSqnYVUF7QM=;
 b=TBOz52anwo6zHsIkv+TW+gGL1DJ1Ku1k9jmhkcuJq5Fbeqi9u0VONcEgZlJgqJrSnew0UMA714m1UTR9hLbbdpL5NmwJUaGv5NxuqUv3Kv82zbKu7F1JwPj580T0QgWKzKEdGW3xOIs5eOOykswpnbNsvB7Juc54NmlaA0bVVAw=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4578.eurprd04.prod.outlook.com (52.135.149.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.23; Tue, 2 Oct 2018 19:01:46 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:01:46 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] crypto: mxs-dcp - Fix tcrypt on imx6
Thread-Topic: [PATCH 0/3] crypto: mxs-dcp - Fix tcrypt on imx6
Thread-Index: AQHUWoJdHSYoCZJ8aU2EkbIHywJZiA==
Date:   Tue, 2 Oct 2018 19:01:46 +0000
Message-ID: <cover.1538505573.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HE1P190CA0020.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::30)
 To AM0PR04MB4290.eurprd04.prod.outlook.com (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4578;6:NnBLhWcS0VVEYiG3F/ORHdvbWW/q5MaufYIKA2QbQPtm3R82actAPaQ8zE86bC4cq2EhQ2f0NbQnD8exw2YXi217vCeDcJFwPu/YHC84M78ol0cUhfMn/WhXpWlIU77DEmKtW3A3M2++SsbWLlKRSycLep88mKiWckv85m+Dsq1TfgmhkLqCv6UwpEHo3VBRvmzC0X/jtSD2j2BAEJQRJhxvm06Krkt9lu/fnSU8AczxI/iRMBxkuNb3B89bslysfzjw1yzSMBUEJSHKoVKb78CNWJGIkIJysOXkj7EQ//PMf/dGAMXZFKEdXhqHLD5i4acJJzwVTRUg3hXOgSvG7WIFxXyUor1sw7pkffKBQjyGvu4yAmwcsTaTf/zlaeNtKZcaImCE6dS6ToTxUMfheGUT7kJRJggptYKmqD3ZCEQqZ86AnOLySdlPXveVBJziTTl+HIt2/qtAxpEDJzfkvg==;5:LXImM5LbkkckcM30rwtlv3EY/5LSmSvawKUV//0IQVxYHnaaAbVQMWAugn0NfK7RdMwGxd6tMO8JpH+qJR8uxKir8SUZPqcUKj4nybDrALLzN5mmsv6vuc7bjAhk4vj3z0KsBGSaXgM8x+/qZ+tIuAO9NmtqLkwRX7sa49D6ONU=;7:3cI1QAGZtZbL62Yv9OOtF4OFhvCwbNp1J20Z7+86dIbhERTGFcxErXgsl4OwjXtdsMCsV/7hyNlhB9sJyinzru9VuwEjMImpOTQRDunAyxWm1Qj7TD7xR4mjyCBxilqax8UE8dujJkB5JuPdNznw5n/FwZdFkUSbazs+LX74a5hLr/Az/VM3md/HzmvOkYTxseAaSeIc96ECLfYN5wkvff7yxgeAvJDPWN/4NvNKKMznIam95HLsO0IwQZgzvgHo
x-ms-office365-filtering-correlation-id: 3a27ac07-b69e-4d31-cc38-08d628997ff5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4578;
x-ms-traffictypediagnostic: AM0PR04MB4578:
x-microsoft-antispam-prvs: <AM0PR04MB45787D80365ECAE2FDA81F1AEEE80@AM0PR04MB4578.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:AM0PR04MB4578;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4578;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(25786009)(6506007)(386003)(966005)(71200400001)(71190400001)(8676002)(86362001)(81156014)(26005)(81166006)(66066001)(68736007)(486006)(186003)(50226002)(102836004)(256004)(2616005)(44832011)(478600001)(305945005)(476003)(7736002)(8936002)(6306002)(53936002)(39060400002)(97736004)(5660300001)(36756003)(6512007)(2900100001)(52116002)(316002)(110136005)(3846002)(99286004)(4326008)(5250100002)(6116002)(54906003)(106356001)(14454004)(6486002)(2906002)(105586002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4578;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: guX1DWRGvNKO3f8zHimjePPLH8dderm7haUd2w2lvfU3cu3k8VmU4ml+CF7PqVY8nO8U3O1mkdEZarpITfqdzGAbtToZff14cF730F9hwTgvOVc931V50X6goWP5b+PCLHmeTbN44pdij8AEHS3yBirESifXiEro+EVV1bZg84bzhxhXTcH0SwSxUHDuDfFltPMdNr58fsfHlJrEJYhbZiZxbr/SYbIdaY/CAzS/FUB1K8J0sk1eBFkBZIa348+Mzqg310nZJDpfR/lmaXXjQeybY2Dar43xJcInip1Z0XYxAN+F+vsIsVMNX4TFI+NeQIFI9ym1Rbu5gFOzNnJhkJU5FfZySxSMXIk6bZkXnUU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a27ac07-b69e-4d31-cc38-08d628997ff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:01:46.6379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mxs-dcp driver currently fails to probe on imx6. Fix the whole thing
by porting a cleaned/squashed version of fixes carried in the NXP vendor
tree.

Tested with "modprobe tcrypt" and CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dn
on imx6sl imx6sll imx6ull: no failures.

I'm not very familiar with crypto and did not write write these fixes so
a skeptical review would be appreciated.

Previously:
  https://lore.kernel.org/patchwork/patch/989652/

Dan Douglass (1):
  crypto: mxs-dcp - Implement sha import/export

Radu Solea (2):
  crypto: mxs-dcp - Fix SHA null hashes and output length
  crypto: mxs-dcp - Fix AES issues

 drivers/crypto/mxs-dcp.c | 121 ++++++++++++++++++++++++++++++++-------
 1 file changed, 101 insertions(+), 20 deletions(-)

--=20
2.17.1

