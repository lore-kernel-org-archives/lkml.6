Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED96C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB18218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 02:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xwc2RsnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLSCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 21:13:04 -0500
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:10560
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbeLSCND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 21:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ed3hScnqJa36i2cKps4VcPzK1KfWrUFAS5+LbJvUo4=;
 b=xwc2RsnU6Un4ElnJ3492SSMg7RiH/Prxj5vLyV3dSVQ9ExuBjMIpZXepSYXmCdClpWK2NCkK7FPKyz4hpY1dUL8nPv40EUhQx3np7hzfZ75oJ4Cot1Ny1ndh6LjgKJI3CHpAY5moiVueDuwlfxnALsNzmOhBVh44LmC4FXTlDGw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB4145.eurprd04.prod.outlook.com (52.134.125.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 02:13:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5507:f6c1:df5d:ba18]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5507:f6c1:df5d:ba18%3]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 02:13:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: tee/optee driver pm question
Thread-Topic: tee/optee driver pm question
Thread-Index: AdSXPr/chwsB0N9zSZmQ6jruJcAgQw==
Date:   Wed, 19 Dec 2018 02:12:59 +0000
Message-ID: <AM0PR04MB4481CD18AC19D03D98358DEB88BE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4145;6:6UPuSobBe9Lkkckh3PgK/ID7pxCsRJ1o9ysOqB4xQ2VFhUq8GRprjn/EQlh5omasCeZIEFdByxET9+wCqt782Ds4LNTSFEMvNTSrJNTvA2uSiZzQ5GVh+usyke+f29UDMLnfRiW5+BwCy/7nEmMq+yqbq1M/NCe1Svg5X2osNu5eHn9yfOjefklDaBJQ8u9v85c+hU8bz0ZLDP1TvFtxTGOUbyvL71kHcbtDWQVvxU4SjGVQyVVxlH3i4wvxsIcyoNkstDdFYPoz4FaT9tonnZzGmColLra38X8Lj3kFsCmp+Vo+waOIob9wtteVqlKayVfS8+0Br2+pZspfUc171L3oDqk5/FAn/xjN0HStKJmO8zvCgByJu9EFDh8fpB1NrOwXsh0S1L+lHUjCjE5AT2Tsj84BiBw1cCP8kVsKcsu2MkhIBJQX2Fsne45WmfI9fiv32P1b031ayZKH42ZkcA==;5:5tw+lxZVmzM3veKXtaeZMo5PLNw0cJSZzHxF/PBCdS+l/jiUHzTallWydPzZBMPsD50gZEay3gC4NX9AOsJj0wQ3mfw+46SdZ2Dv0BJr8Y9HUitRrQYhEkAl+oABHXddfa9F5nMp13Y2ebz6ePfkYrVF6MaZAy1GICLU1gIFZrA=;7:WtpTIs6AjOpbhkkOyV231MZHAErkC//BQHV2vtmVDZOFcmCOaJQW9gu1jMZYseKsbkweZSNv+A9Oly6Eod6AG1hZYZiYifrqIPhj/io0K5mUV66Koq2GLzU4kJ8TqrQ1NF3nTXacCNSD6STeY+VohQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58a9f462-6d00-4c1e-a09f-08d665577fcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4145;
x-ms-traffictypediagnostic: AM0PR04MB4145:
x-microsoft-antispam-prvs: <AM0PR04MB4145F8777C9BD856E0571EED88BE0@AM0PR04MB4145.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4145;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4145;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(376002)(39860400002)(189003)(199004)(486006)(68736007)(44832011)(14454004)(14444005)(2906002)(5660300001)(99286004)(256004)(74316002)(478600001)(305945005)(3846002)(86362001)(7736002)(3480700005)(6436002)(476003)(97736004)(6506007)(110136005)(71190400001)(71200400001)(4326008)(55016002)(9686003)(54906003)(6116002)(8676002)(8936002)(81166006)(81156014)(33656002)(186003)(53936002)(25786009)(316002)(7696005)(26005)(66066001)(102836004)(105586002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4145;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kw2E901ZJgjDgy4mUFnkF8y4ohgGz3Ly60Fgb8BJO4ZfBXSY9AwBP5fb2W7dQVKHlfti4QWDQ/LtzFWcQaGf/G0oFdcKWqdrzgTAYNNKGK2TLN6l7NYvh4bHGEFT55aie6cIcfjKb+Z5au79jitxu1Lnr44+3yV7NjyinXZy5vFDKJToS7OGYQubVAcnmkYbdk7LWZVzwEtJm1gfOjEn4El9YKR/5ebAG6mGEE7SNMOkbiHCtbfEW85kh9W2psNLZlvcqu7nbezmsz6+jCySYrWaGSqFo8XLwNalLqtAP37XYg5B8ucqmJGerOpEARf0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a9f462-6d00-4c1e-a09f-08d665577fcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 02:12:59.9076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, Ulf

We met an issue is OP-TEE is actively doing some DMA operations, such as CA=
AM DMA, while Linux is doing some ddr freq change and will let ddr into sel=
f-refresh state, this will cause issues.

On ARMv8 i.MX, we have code request_bus_freq/release_bus_freq to ask ATF to=
 make ddr into/out self refresh state. On ARMv7, we use similar code, but t=
he request/release will runs into OP-TEE to make ddr into/out self refresh =
state.

We have a RPC design, that is OP-TEE issue a RPC call to Linux, to ask Linu=
x to not issue release bus freq, but this will introduce complexity and not=
 aligned with other drivers in Linux Kernel. We are thinking to add pm call=
 back to optee/tee drivers, but did not find a good method. Do you have any=
 suggestions?

Thanks,
Peng.



