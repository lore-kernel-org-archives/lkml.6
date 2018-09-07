Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65132C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035382075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ms5O2lt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035382075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbeIGFiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:38:51 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728769AbeIGFO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CleZwbPKpa609Ad0W9yX1fP8RfbgrLqDHWMIc/bskUM=;
 b=ms5O2lt5OBPENPSAyekw+AT9hD/pqyXeWbq39/HBhhivHXLZfPlpM0PEJraXdbyoJBUH5Fw459/wUmyk3nAjnElsZg71Zd/Saeo2EF8Fdw8JHzt1KiwHAtPX1hwCXkefnsqmcy7CJJojtbbPXADEUHQbYOK/oyygR8/FLRuYEI8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:05 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:05 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 17/88] clk: imx6sll: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.18 17/88] clk: imx6sll: fix missing
 of_node_put()
Thread-Index: AQHURkLCAQXP43uh7UWhbIRVfuOaYA==
Date:   Fri, 7 Sep 2018 00:36:04 +0000
Message-ID: <20180907003547.57567-17-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:2Bligw/3mKrTyoxZ9zIdk3T+xjDDFHtm29u/4Ta1dJN3UwjdzEOdYtXp3p6WiWbozvArrsEyZ5dkJQ2Zk7uDe4eKcK+8dmn5WxWC96hx1d87GlC7wbBatipeiwIWsBtoIIizVUioHjHczTEeQ5KyuP8ID2mmfjtl6/Mimf8x0FMMi9hx4bAHUhaq28igjwPbITOAtZKTUnUPEW07gRkyqF2u/ifu9/5ZDqbSIanSGmT7xhKrzameyY9Su+1JH4KL7pc3I4cuTchUF/3sWQ0A5Uf6/JBIdfiRAQBDDY/oUCddSr3+4mAmDomHWzoA68c0px0NLECRK9F7tuF66h5qC9OOjPce24kobBx2XdDIFeomMBTOMnG+FxWjsqF4FI4UF8MreCe+7QrtUa1kCcPSslmU6gHVqsjdu92qEIr6oM2H0YqSSQgkd1Hs4tnRrw2KMUrSOFajsVCTWdMCzdj9hw==;5:/uN07U8YmELFmWIaHjtsJ4/clevFZYsDKbIftO1vNW6uuRuOd2N2hSAfZx9urSxwd/qIe1y7cWxvX/XuWPm6h/II7ddfPoPFyJVOyKg/+Eu5nVSWjm6Ofe6N3nAq9w8Db176acx72FPV7tedXJlLaWE7lAXHVlpCdEtmTxjpyhk=;7:raukxNWW3OEEw0hX54MqIEuDoSd46/0xILM+nFkylOSY9T0EnfpW/Epj4FRqmfRwowKCPHjRg7mg2ovF/Gc4J6zVsz8gSBnQQ/sDai7F2i1eBdyRD9MEIqm1EYZtyyqHpoFbP0b6grY2BoTC5MkeouyUvOkBFpaLddwSW4WuZesqiyjzk6tN7OkrlT3T7DJFORiG9ErWVM4t29v809RFrirf6/Byw7S3144w3mez6RxKeY1/A2T/Od1OXENW+nRU
x-ms-office365-filtering-correlation-id: 31d724bf-503b-498c-9577-08d61459e53e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773A67C6EA780A605F79D68FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fM0epYqUfZcUHlFsR+ROxjFz2yp7Ra/ZNH/wlp3YWta+iNpHwEyHigVinjJC1FC5pTupMxjfO0y74E/CdxqP+1jdVD3dHJKx2yb6piCrIoF/uw6iHI3D53Fa7hVm3BYwfA2IvdkjivJI0svzDuukV1rSmfI5J8IcGe94g3x9J5ML5e8YKUcFmuXUektwwfpIcavwMQ2KJQxrEzRVeZcUElinLM7rY3YmADIL93gNNLUknwEMuZ23ASPXBW4Bc+C7z+q7k4DslRm3n3VKKppe9LuQrRDT+pMlWK4bhQ9BknTW8rJqvb+VAAOV33UZMQ9fWIX9bKmOWrYKg4mHV9RhvZX4EmHG1MqjXPG/L68U1NI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d724bf-503b-498c-9577-08d61459e53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:04.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 7f5eac5934d747535f9ffc997792a0a6eb289374 ]

of_find_compatible_node() is returning a device node with refcount
incremented and must be explicitly decremented after the last use
which is right after the us in of_iomap() here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4a5f720b6542 ("clk: imx: add clock driver for imx6sll")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/imx/clk-imx6sll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 3651c77fbabe..645d8a42007c 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -92,6 +92,7 @@ static void __init imx6sll_clocks_init(struct device_node=
 *ccm_node)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6sll-anatop");
 	base =3D of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!base);
=20
 	/* Do not bypass PLLs initially */
--=20
2.17.1
