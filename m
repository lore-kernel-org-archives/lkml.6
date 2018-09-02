Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4BC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F73204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gy31zlLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F73204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbeIBRXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:23:34 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:59648
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728127AbeIBRXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptx5rCM07ijhceiI0mv5sUabHra0jJ6Lc32cK2Wg4iM=;
 b=gy31zlLLtmsZToymC7TrsG3gEhX74xqW52SImMxZffQEDuMwUx7Ju3xMnRaMIfzFRV+656FLG2CPWyPQaESrajXTw5fR3e++clh/FN9q2l6fQjnUmmLJzikAjO5V6fRPfhuyoo4d7FPJqjr/CCtTNmhdqExqQp6gu01GTnJMvyk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:07:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:07:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 50/89] pinctrl: imx: off by one in
 imx_pinconf_group_dbg_show()
Thread-Topic: [PATCH AUTOSEL 4.14 50/89] pinctrl: imx: off by one in
 imx_pinconf_group_dbg_show()
Thread-Index: AQHUQr3cY8XzJxb6IkC8VfGP5TTkNw==
Date:   Sun, 2 Sep 2018 13:07:12 +0000
Message-ID: <20180902064918.183387-50-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:Ha6lpxUQiuRjH1eOnak/x8Me9pA659wN9i/6vRRU+rzfm95EVT5oAXxB6Q/br5KSHn15KkmnMO0AWxBsG0Umgk3lq/kk8BQWqgsKkF3xXG+Z0/KnvOwWcCnrz43H4o8+VHABbNYaJcLRW9rCis00ynKOQUSszt+Ka7vhjZoUGZJcTvCuarBcyxyKDCvWSGZ5IuQB7o/UMPMPJ8H36xo9Um6KqjbWuma/LgLzrAHVFR/lpFyr6VgH7TNcOXHyDeL/ywFFVlCO8eFYRpG5xi36ODACC19CXT4S2vUd+2+fttqAC1eFAUDwsK/W+bQUtqSx4ir1e2Ggn1cI3F0RxQ7GmDcr0EMO45Tdj62uL0Yn1n9fyNhnxrtfFdUpVJ1skjrZRaDAFSImfR0GwKIpjZ5l+CpC2jjdqHOLRTK4C3iLjW1sRkJ8AhxwV3lRANuCSUbBwrKyiATGqp3NItS/vUZlzA==;5:D6py2Ogbpfu7U9OzTykAa2krrR5n5wPx0ugxbRphe00HFqxSTmieW6fUJpyj5tSRYIk47zivmYBVT857Dk3CsgJ+hMg2m4aXCcCzsvm8fXuAmX127iVsMKS4zjboMSpinLQuB0YCHFuFzFlSSuftLbZ9zFZ38ymZY38FyVK7yRc=;7:b7HobfoYjwmpLCtcwyAy80wg/XvKzxZr++VMQ22sgzkCQmqVwmeF8lfY0Mj68EAWNw8jnb4PHPMDHBTcqAHFpIEEazkPSaX/kdQmI4i2Sj2TCozl8VBDnlHmlg5cEH4FObAnqdmM2q1zefsS9b7Asy5e/tUbYLzUpu9Gn0PQGDcLTrGMjGSZnKsKG95xt0drKgbm0PAnMbHJHWvlYWb0jjDlhcB/JmgWwqCwdQZakzcHeRSnPMwfNQ/sJJKqBDfH
x-ms-office365-filtering-correlation-id: 7f9f28e7-cea0-4b61-376c-08d610d512bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503947F681C95A7F25B2FF4FB0D0@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(10201501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(105586002)(8936002)(102836004)(6346003)(68736007)(2900100001)(6116002)(217873002)(186003)(36756003)(81156014)(81166006)(1076002)(99286004)(26005)(5660300001)(66066001)(6666003)(8676002)(54906003)(256004)(316002)(305945005)(22452003)(3846002)(10090500001)(7736002)(110136005)(14444005)(106356001)(2906002)(6506007)(10290500003)(2501003)(478600001)(2616005)(72206003)(6512007)(53936002)(86362001)(86612001)(107886003)(6436002)(14454004)(76176011)(486006)(25786009)(476003)(97736004)(446003)(11346002)(6486002)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: p1kpMZa4o9zqh38bXUofYNq38WGXdmwlqso+KJY+DxMJ48J+832Dekao2c3f6dEFVPa+IJG5VCEvfUH8oxpZrLY9/FjyoJ2U2vHRwE4vscYBXxi2FPErCovhrrwbIMKRe13WuDdxIxrupFD1JuAXZqE8H3UFjcCjmq8f1O21eXeuZULRE3PnQUNj1NlNlf2pZnvP6JDVOVwQ6jQFpmePQQGuTOjKuwwX20wNbqKSzEC/Vjfjmbtaptj9JGnT0fGKPtfbQij+0EyHbms5h/AEOz75dkCBotcbwO0apmLjxbfpey/p4/GU5nUe7uRxAerGJaPq3+h795quUzhIml+gBQmzNkMkfqgRPE0DCCFWhJo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f28e7-cea0-4b61-376c-08d610d512bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:07:12.2573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b4859f3edb47825f62d1b2efdd75fe7945996f49 ]

The > should really be >=3D here.  It's harmless because
pinctrl_generic_get_group() will return a NULL if group is invalid.

Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
Reported-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/free=
scale/pinctrl-imx.c
index 6e472691d8ee..17f2c5a505b2 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -389,7 +389,7 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_d=
ev *pctldev,
 	const char *name;
 	int i, ret;
=20
-	if (group > pctldev->num_groups)
+	if (group >=3D pctldev->num_groups)
 		return;
=20
 	seq_printf(s, "\n");
--=20
2.17.1
