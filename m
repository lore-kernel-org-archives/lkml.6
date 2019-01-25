Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD234C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4F21934
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="QC6mLgiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfAYH5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:57:55 -0500
Received: from mail-eopbgr780055.outbound.protection.outlook.com ([40.107.78.55]:36736
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfAYH5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO7uFtEKA0UAOFypLjcC0ZuNhLwaB6UKgZzHcT0AmOY=;
 b=QC6mLgiC76nOYUx0pdeaBiXSUs9nRX1tdV8AvkoVofsnPAF4MWIcV+/I9MLja9G2YUJuJHMGib3lv/wW1gWEJNSA0ScQNUXKEx3lC4VTYfHdPpVW90pT7U/rJOKdKQ0jIh0FVDqwvgSPDzq83UDsE+HbOxMc++hsYoKZHHVBZnU=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3741.namprd03.prod.outlook.com (52.135.81.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 07:57:52 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::59c4:7034:c325:36f%2]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 07:57:52 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: dw: remove useless pr_fmt
Thread-Topic: [PATCH] watchdog: dw: remove useless pr_fmt
Thread-Index: AQHUtIOsdl4IOOpus06gZct6yWgfpA==
Date:   Fri, 25 Jan 2019 07:57:52 +0000
Message-ID: <20190125155138.2f914f5c@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:404:ce::22) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3741;6:iQwrK3RYx646VhuxW51EzEVIr3bfJO7T4yY0pIniLsls4aAXlTCECp6hYINYL6k1EGjh6cZj8zf5LrOGOzq1dnRdmk/c6v4Y5q+HsEhPnOeePc6FB0kBDfWjgFdSSGn++U43C8g0PSPqXlmEOtZcyGIffddfeDyGyne1BIgOgN8q/j9dLopzMHMT1KKLcn0i237dG1nmR6R+BnEb+0lT1+p1FFkek/b/iIF5KaW4Go+q1jYRDdpwCBoWQP63xd9JM3tFYjjihgnYFFBTiyna5ySX7647yqPPKBQMzaV+Ak/gl8mfwvwXM9pcNoyqhq8J1DPkwKMNmn73fnZP8tJADy2Gkd2l3iHwB90ktveWk7jMoBrpJ/sWgNlVyI+aOV8JWMFYRS/2meN4KTkALXKgTN0mqTO4L3mpqu9Y8ZLN7SB/fPUyU7566/ydRpHljVa9BQicLrDToOWLCbZ27wqBiQ==;5:fPGV2c7nvEFn4XS4piD4lTYc6EEWvbSdiMHzs5qfUWFNw7ZwpHSJP3MrRZOXy7YAqtLI2k1Ig7n1ZROYC4PR8eAHTUcvN8iEs5puLljagAbVHwL/XkaQ9D6CqgK1xTmYqL+E+ULdqo5hl49UM8yvN0QRs2g3/WbXqknJsmyhMRVRNSHzGs6TB0TrAv7RRRAM0Ui4WcgKKbFBSWu69PbUPQ==;7:NI8pqcdREDF+emYbAB76sObkcxIbMt1e9HORo4oP4RHRESoaXlsqPV880d14ZjK9Q6L8aqDAQR7KEaNLvXy9IPVpBt8/48m9rmbw0YGWGVW68jf2pzhAyjX3IlsnNJO0d4ka6HCmIBh9wLE5STLpnA==
x-ms-office365-filtering-correlation-id: 6f085cbc-b9de-4f70-7288-08d6829ace61
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3741;
x-ms-traffictypediagnostic: SN6PR03MB3741:
x-microsoft-antispam-prvs: <SN6PR03MB3741C871CDD8CFB4B133498DED9B0@SN6PR03MB3741.namprd03.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(26005)(386003)(6506007)(102836004)(99286004)(476003)(54906003)(110136005)(2906002)(6436002)(316002)(186003)(6486002)(4326008)(71200400001)(71190400001)(68736007)(1076003)(53936002)(6512007)(9686003)(6116002)(3846002)(50226002)(86362001)(256004)(25786009)(81156014)(305945005)(486006)(7736002)(81166006)(8676002)(52116002)(97736004)(72206003)(8936002)(106356001)(478600001)(105586002)(66066001)(14454004)(33896004)(4744005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3741;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BjE6gOHhLynwsjyZeils4umYsxzrej5U5cU3Jum+X4HUGawQZwZLLE+UKLYIQEQWAJKtTiUnNFoTgQ86Yo6GByioUoiQEwgaBUyciWeHt+j/cGV9gI0TVESVs92opc1acmrRwogLnMthdMSYrNJMPp43rF3/DnwLxlp3ovxAIoBm5yTWNKWBJe4dG8mAe0NwbV4NdPFGUlLEVsuX5T75C0aZn7LqeEr7PJrxR1bCd42R3Uoy8mGbt7jadteWu2mT9MrlQGt4woF1OrNWeYN6wERYReFhHJ4I1JZWqyDWT7xesCeoxzUkyIeDUGsLClHnPEy19vIiRlWeYenX3YjpRogq2G0DCwGnD3mOvr4bwhATbbZGzF3/dQNiNCJFr3ktjfcLr6wGEgXrBa1o5XDPqMx1xNqqa4nRZf+urTUi6QU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C2AF6949BA2604CA6DC423F49C2B8D1@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f085cbc-b9de-4f70-7288-08d6829ace61
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 07:57:49.8917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switch to watchdog infrastructure, pr_* usage is removed, so
there's no any users of the pr_fmt, remove it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/watchdog/dw_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c053c2de5c2f..0ce8fa5cfbf4 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -16,8 +16,6 @@
  * heartbeat requests after the watchdog device has been closed.
  */
=20
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
--=20
2.20.1

