Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52650C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B572083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EaBK9HYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B572083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeIGFTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:43 -0400
Received: from mail-cys01nam02on0119.outbound.protection.outlook.com ([104.47.37.119]:49833
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbeIGFTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy4VBkABTYqDaEWYxg+mPIgCcuZhjJ1IKoxBvHMcq10=;
 b=EaBK9HYkUhMUd20GxhWEbJZDMYQwEkzZHNgJ8zEmXlUh7hJ0hNi2zKlA7KHamTmLU42h+ZKu0uZ407j0qrS0GP0sSWiCuzxzxeYxDK3UGMdIX6OkZt7XbayziBngIkUUG05k0OGg2DZL8JWEchvxle02k2Dt58x2VrxXashfwxU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0853.namprd21.prod.outlook.com (10.173.192.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 07/30] clk: imx6ul: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.4 07/30] clk: imx6ul: fix missing of_node_put()
Thread-Index: AQHURkMru/n7vUNW6kGSubpDshTqcw==
Date:   Fri, 7 Sep 2018 00:39:00 +0000
Message-ID: <20180907003853.57942-7-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0853;6:FtWxREiiL+pkmwnWGsN9jvNzRGw/r3CfANZGnf+R7BaADN07En7rKR6Lt4pAqu6280paZF2mWWu9LC0XPAOheOJawopbynVm9VbcFl8gsvvZxOY9sGxeuQo2XYxBl117s8+cGr5Ef1SM3KtYj3wvFZF7UcUp0xNnqtWr1PBfG6JTdy6kwqfgyjwNG40+HjWGUTD8sIISCz0lIwJc4ADn7f9JivJclDEFbX+qJY4umBjIiTzRFjeQ+UmzB5MNb2HbERvPK6tMdbezWlYGkuzBAVqsCmZU/YrdRVN6iNu0k/hbBznygwvMNhuffIYz+A9pEXEepH+JJyDBM6tkIrJ6jjhw+eo0UExBqauINjx3d3AOBByWh+Re+3V0uoKVAePSLxZo9bpGBzbOuSgE3AsRkUtvrCAmM2DXoyBEHqegiUJlibmwbhD+sCGdVZP22w1mH84V4/EnhxjMgkTWVSjeHw==;5:qq6swUAqV4PiTncIeSWt7XYxZNxRQ7xeL1ncVH1bUJzq3vxaoRr6GH/cayUTK2ThuF3Pu4Ha4jGoe4PjFNb4GuJjTANSrG/j5QZoD5Ppyk540uhdV+E9DBOkSCmGQ9SRwPWpqDa+wfNxkSFwmfJbhAaW5z7bI/fE0AXk0/pfSiY=;7:q/ZjOagoGPx3GB/zVwlo34qZaw+hbYEnplEP0sbEqtYpg8lu1bL3r1DgwY1x3uD1DBRmrERh/qxIGK+qRnOsX8rVhaDCCd9cai1WSC/8SyTRRUeJSYbqmNyD+5eMUkw2awOrPFmSCh8Cms9QjFQFS+e5dBRdh4rVFcdbHcq/yH7tI1OIKxUpUwVahk3XpUfS2zbnQkkU23V4/j5SVyOCejcHp8ZXF9K3WfaVLD8WjyjB+MsC9O7s89oqp+/37jy4
x-ms-office365-filtering-correlation-id: eab3245e-6e7c-42b0-925c-08d6145aa5a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0853;
x-ms-traffictypediagnostic: CY4PR21MB0853:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0853EC7087A6C9FC9BAA9C83FB000@CY4PR21MB0853.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0853;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0853;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39860400002)(136003)(199004)(189003)(217873002)(105586002)(106356001)(256004)(1076002)(66066001)(3846002)(6116002)(4326008)(25786009)(107886003)(486006)(6436002)(6512007)(6666003)(53936002)(5660300001)(68736007)(102836004)(10290500003)(186003)(2906002)(2616005)(11346002)(476003)(2501003)(5250100002)(6506007)(446003)(110136005)(8936002)(36756003)(54906003)(76176011)(99286004)(26005)(2900100001)(81166006)(7736002)(81156014)(8676002)(14454004)(305945005)(6486002)(97736004)(72206003)(478600001)(86362001)(10090500001)(316002)(22452003)(575784001)(86612001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0853;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o2R3umSn2k+luNEKO93cgCWAFYU0oEo2Q9vgfIYj211oxKJV893uaTx9pYW/VLPRjsL6dKRiyuwJVA0PNJliiurwK/TLwIn8xU16t6e8TrKnKGvHG+vhc+gf8M0IGjV79/YlXmxqonUB5OQaaZeMtQMJnrHrCY7Kvks63+RsujpffxRaBxEp+AueFlCJDTMj/uNEAkXU1x3nvr0mTl9Rrn/ui6wZMvo0Kwy06A9OB6hFUWjSCHr674OwVX/BZ31HjqLXCPRKEHmaVyGW47jPmV6dQgMQ5QrEZMPXKrVnGj4N0Zn9n/KkbMYzWwX0wOBJQ8f6XRmd70oWYEgMFPiNVynVM6mLqJEv4OCM+9Ex7o4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab3245e-6e7c-42b0-925c-08d6145aa5a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:00.9316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 11177e7a7aaef95935592072985526ebf0a3df43 ]

of_find_compatible_node() is returning a device node with refcount
incremented and must be explicitly decremented after the last use
which is right after the us in of_iomap() here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 787b4271a6a0 ("clk: imx: add imx6ul clk tree support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/imx/clk-imx6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 01718d05e952..9e8f0e255de2 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -120,6 +120,7 @@ static void __init imx6ul_clocks_init(struct device_nod=
e *ccm_node)
=20
 	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6ul-anatop");
 	base =3D of_iomap(np, 0);
+	of_node_put(np);
 	WARN_ON(!base);
=20
 	clks[IMX6UL_PLL1_BYPASS_SRC] =3D imx_clk_mux("pll1_bypass_src", base + 0x=
00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
--=20
2.17.1
