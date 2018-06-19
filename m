Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F009C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EB12075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jI4+JDJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EB12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937137AbeFSCAF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:00:05 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:64928
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S937004AbeFSCAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BixfJBJ5QsavUV900iYr4LP1K7MqsqZKImjT4uPRP54=;
 b=jI4+JDJorhj4nxODYjsflUFbKQpTuCygjUjcefsc8iDC/IokmFOvv5wDqfh5OTPranbnerP61p9rG32Qfvi9weJ0c1FkAlyfY3mhUSV2Ssx21w5kkzYuwT8fDkONuX5t9Yurm2K+tjtkhbN3uiaz4gnMhsPu8yG5Yz3WD5mv+xE=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2567.eurprd04.prod.outlook.com (10.169.225.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 01:59:59 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::59ab:5d0:bd07:9799]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::59ab:5d0:bd07:9799%6]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 01:59:59 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Cochran <richardcochran@gmail.com>
CC:     "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ptp: replace getnstimeofday64() with
 ktime_get_real_ts64()
Thread-Topic: [PATCH] ptp: replace getnstimeofday64() with
 ktime_get_real_ts64()
Thread-Index: AQHUBw+eFJ2c+Br8OkqmjAqwyMxAgKRm0+ig
Date:   Tue, 19 Jun 2018 01:59:59 +0000
Message-ID: <DB6PR0401MB25363C5E9FFA9C6AF17EB4D7F8700@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180618142109.3445025-1-arnd@arndb.de>
In-Reply-To: <20180618142109.3445025-1-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.121.218.217]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2567;7:hqLXMH+AAw03qvD0L8m8rmqz9+u0mAxgIbvsjt4zxsjwBga28SUffb0ehcxpXOyv/NMGSwvkB0AP+DAFH/nVRxFg5lX/6XyyVlvLEvGTWmsZ/ik3mcpsU5EZgL5RXour7yzgAmsqBoJqtBm1OZlLDTMjPy3MfQ9ThxVuAHAhxrKAsLw3RbfuW4BCwl/NVV3zRUOv7YAf7aMyuJF4lDvrSMmDaVxC72E2e2TodXTCQmWfYg77YKJMgo2E9wcKpFv9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5275e833-93e6-4328-5f17-08d5d5885d2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2567;
x-ms-traffictypediagnostic: DB6PR0401MB2567:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-microsoft-antispam-prvs: <DB6PR0401MB25679742E291A01B22A6D930F8700@DB6PR0401MB2567.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(788757137089)(1553240931313);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2567;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2567;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(39860400002)(39380400002)(199004)(189003)(13464003)(446003)(81166006)(6506007)(8936002)(7736002)(39060400002)(25786009)(186003)(66066001)(8676002)(81156014)(26005)(74316002)(305945005)(99286004)(4326008)(7696005)(33656002)(14454004)(478600001)(53936002)(476003)(76176011)(3280700002)(11346002)(2906002)(5250100002)(3660700001)(6246003)(9686003)(105586002)(54906003)(102836004)(106356001)(53546011)(229853002)(6116002)(110136005)(316002)(486006)(3846002)(2900100001)(68736007)(86362001)(55016002)(15760500003)(97736004)(6436002)(5660300001)(9126004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2567;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AsNXDzT8ZuPwo8HvlXn09871iSOV3WSoVYuC+KuDvnyiNHIscjRooY1FrLCP6xMDlecMMYANV5Nr0UqfBoOh5lJIT7FEcGBzWtQp3YyzavGT/WpRgYmZt2+IoUTJeluC0o1i5oAJkxBjXh3w+FmNItTogxqPsjyxDEHyMbzju1ql0lFzHw/SNAZ1nr28yOcK1x0p46bgbduXZ0RFshcMwlFolhTj/MGMYLDEzgggdTeKlkZ9goGPUagBf3tqnqmWPp0+zIbJ2OOWvwW97vsV2oy8pyDCkDofSaZMjI/2eXttSn6ABD6w7uCMon3HMg08
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5275e833-93e6-4328-5f17-08d5d5885d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 01:59:59.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, June 18, 2018 10:21 PM
> To: Richard Cochran <richardcochran@gmail.com>; Y.b. Lu
> <yangbo.lu@nxp.com>
> Cc: y2038@lists.linaro.org; Arnd Bergmann <arnd@arndb.de>; David S. Mille=
r
> <davem@davemloft.net>; Fabio Estevam <fabio.estevam@nxp.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] ptp: replace getnstimeofday64() with ktime_get_real_ts64=
()
>=20
> getnstimeofday64() is deprecated and getting replaced throughout the kern=
el
> with ktime_get_*() based helpers for a more consistent interface.
>=20
> The two functions do the exact same thing, so this is just a cosmetic cha=
nge.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[Y.b. Lu] Acked-by: Yangbo Lu <yangbo.lu@nxp.com>

