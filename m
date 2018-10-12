Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25896C28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C74C2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 02:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rgOWlHN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C74C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJLJxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 05:53:12 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:65294
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbeJLJxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 05:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsPVUi6OXWRa2fMMAWkOg08o4dv0oKHQ7BogU6z1s8k=;
 b=rgOWlHN9EaLtLNQHs+YYZx532S+yETQNWBa8ImRveG74ejUE9hLsxLGwW8EE04isseMgfng4RxezcmIPIRhxKd35pzTGJ/tUVuCpotkNjwfWjtn1OJVL8Ew0xAXj/Tz67By6+Q5zkH2MCXU0JyR6zvNeWP0Rz8eUBcPStwUYaxA=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB1166.eurprd04.prod.outlook.com (10.162.121.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Fri, 12 Oct 2018 02:23:04 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1207.024; Fri, 12 Oct 2018
 02:23:04 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Topic: [PATCH v3 0/2] mtd: spi-nor: add entry for mt35xu512aba flash
Thread-Index: AQHUYdKBvyhL2SIMqEmG+Yt2wUcV3w==
Date:   Fri, 12 Oct 2018 02:23:03 +0000
Message-ID: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To VI1PR04MB1038.eurprd04.prod.outlook.com
 (2a01:111:e400:5092::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB1166;6:Pw0UoiNzO7yIy+5I2RFNe1QH6qox9LjANbRvDZRb3NKXn4s3/e4VprATPuBqgEY1liprzvzY0FHqWxnY+nbk+JF7SOs3049QFVS6q5j8vjXkeCQFuwxIQFqyLXVjNLPQZ8cuGHzKbygl8+XzW885jafTA63smI/jaExhRhBLeIkBqRTIDnDHrOgUrdSl1PBs17XMVbZxezzNyD+dpSD3EfSjdXzrjOYVsMg2cSZS0Ar9TN4ejSglv9RAr04eYwWCHhuTrpitJz4taseo7KIArPdXzQIEd4d0bQWnpjY7eI+/nXfvX6lfSlWjCnH1hvCOYLdGK+6VgEGP6ypHZ2gfknKDzrwJSIz/UV4pFr+HxRVOoju6LZKu5fafPzMhIV9vx+lRmlA4oWvjmD1xX94eSXK+Ih1kgcnzw9mirLUjyJJABLEY2vJeLndoKU04cgZ1Q79Eog2k1+IyYGkCgN5+cw==;5:xEWNSVlhMKwl7E+kR+7Y8vvRav+IE4DB26gLgZTuzaCsuqbtOdOAPIWVN4zAJek6GqSmTgwQUoCkocnhn/9ypdZVyUnGZD/BuWA3PMpoVG/Gsg48aOdaObrUOhntWzgzvuqbQfKOEyBT+5iK3xP3lPh1DsLqoAVwVN6TtYaORCs=;7:83DixbVIaCtNVulCli8CdzDQqZIQOSGtlHAaroozJ09JYIhgjAj0dbcM/3ZtxNfKSYujeRN2ip2o000hrLOf3uPX/YoSB1iXAkSKFZSvjqEwaETNSZy210KHv5SLPLh9uwfwbqCb0wWNS9qqDousKdI/ic0VXHRe17rkaRor378TaZQZldDk2c3Lpk2bQQJCNLl+lo0gCQ6kYeca66WbEjyWTHpJC70TZM9IdSf51ejFfYCZZDlkQORP+Y3CPdw1
x-ms-office365-filtering-correlation-id: efcf29de-881d-4f0e-3ac4-08d62fe9a33b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1166;
x-ms-traffictypediagnostic: VI1PR04MB1166:
x-microsoft-antispam-prvs: <VI1PR04MB11663E857D9E1106AC31A13899E20@VI1PR04MB1166.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(88650276678806)(34377916053724);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1166;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1166;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(386003)(6506007)(486006)(55236004)(4326008)(53936002)(52116002)(476003)(6436002)(25786009)(110136005)(54906003)(102836004)(99286004)(2616005)(6512007)(6306002)(316002)(66066001)(3846002)(2906002)(6116002)(97736004)(5660300001)(86362001)(2201001)(2900100001)(5250100002)(2501003)(39060400002)(68736007)(305945005)(26005)(14454004)(36756003)(6486002)(81166006)(81156014)(256004)(8676002)(14444005)(8936002)(478600001)(71200400001)(966005)(7416002)(186003)(7736002)(106356001)(105586002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1166;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I6y3YhJDynRmdgfo23X0h7W7BmJwD28ArrLHTsg50c/X2AfI1XdpKDgA9LXs5lgGlvJv+8W9ZMOsSbg9P9/uT/jth4ocWPb+jdKpN59LdYhZTEjvEbouZEQ91+KC8ZtbMvHDzK9ssN+ehZyhyJ+2v2c88J9KSPD+QGdZmwuFwgYghz4KlEo3zBMr51pLBn3s9hW9BGdZN+LjYj/bsf2Yry6s+sndAAftB9gnj1B/IUs0G+MAdeGM64oR9xr0UPavptT6NdqYskGGcEVcMU+WO5he0WeZFkywlJXl6sNmGMs5jdd3N5DmLZAA8hgiG6/lCOck6TJvWi0QP0dY2dcvbCcn6pe73RjyPR6OwAhFseg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcf29de-881d-4f0e-3ac4-08d62fe9a33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 02:23:03.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFR_ID information, 0x002C, related to the Micron flash.
Currently, MFR_ID 0x0020 is being specified as Micron flash ID but
these are actually CFI ID of STMicro flashes.

Rename SNOR_MFR_MICRON to SNOR_MFR_ST and add entry for
SNOR_MFR_MICRON having CFI ID value of Micron flash.
Add entry of mt35xu512aba [1] flash in spi_nor_ids table.

[1] https://www.micron.com/resource-details/0b74b806-bbf1-4c24-b07b-35e2799=
bb6ff

Yogesh Gaur (2):
  mtd: spi-nor: add macros related to MICRON flash
  mtd: spi-nor: add entry for mt35xu512aba flash

Changes for v3:
- Modified flash node style as suggested by Tudor.
Changes for v2:
- Removed checkpatch warning, 80 character limit, in patch
 'mtd: spi-nor: add entry for mt35xu512aba flash'.

 drivers/mtd/spi-nor/spi-nor.c | 15 ++++++++++++---
 include/linux/mtd/cfi.h       |  1 +
 include/linux/mtd/spi-nor.h   |  3 ++-
 3 files changed, 15 insertions(+), 4 deletions(-)

--=20
1.9.1

