Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F0BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Vx5H1VC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35D62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeIGFSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:49 -0400
Received: from mail-sn1nam01on0098.outbound.protection.outlook.com ([104.47.32.98]:26944
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728153AbeIGFSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeorMlTqazLwhAxvJH38J29+OrgRu9A6jzn2hQN/noU=;
 b=Vx5H1VC4+FLQTfyoujKlHE7G4/FCjFs5Q3bC2u+gnRD3TvehCSSP6agi3uue+MHA/KSR0FR/SVEYmAaWzp8EdmcBwsM0yaU346AQQ/mO6aAeTVdzkzDo6ktNHURsj6htFrn7ZMPnfBK0y8rmd4wMAvL/xXod37xcjGX+pY8tS98=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 07/43] clk: imx6ul: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.9 07/43] clk: imx6ul: fix missing of_node_put()
Thread-Index: AQHURkMVoxpDtywAeUGOd75uwCCspw==
Date:   Fri, 7 Sep 2018 00:38:23 +0000
Message-ID: <20180907003816.57852-7-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:A8d37drWkxQZfqIIriofHmxF3c9j643QIDwgfemHaWhQH4S190DmBoRqS5WmNlhC8+Tl+YjqjryXAE0p/s2Ho7Dm1kB+aM8/lPN6qwTLvyC7lm3ArKDkgtQMnBpUmxB1bYJCunpKqsnFt/tYyVmoOgBaK4+Pcw0nvPbucPnWUYxvguTVpRxETHm2iGj6mYNjmXlV5H3d7XuVSI/NikEWJ08nymnBot/0MiRN7U8I9v0IoH1uRa1ljxKMjrwcNUUb/jI5WcDJND/ukWUQxvrdWyMHbsGVEvL14b8bW82olgIN81qbgpd2DGyVBpuKkQ/cYCWheedtgpiQSTaWm56xXEX2u0IbGCEFDOQqVtO+tyB2sIXE9nKDzwvWKtbx6U9rVug5qL7GH5Da12mquSKK4QPfiFDXElm7kzlZzL7FISxJJ3dr8P+Ll7/G93M7VxexuVbMrg1dqfkSA25b1FK2hA==;5:f5Zpg6GKlBrqh2nlOgRSt1+0dtnSwOjH53eGYZEJcgZTmwdEhzlAzwl2n9YnXLi3sdfdYuNe+ezU53QEmz8P2RYYtAPd2GI2KU0FL3DNfarudalxOHP2XojqtialcVpsBk4PhP5lQ9/VnHZNB3jfV/zhKW4WatuNrBgM1WJocLQ=;7:4oyN1BHmzSRLWaaSibmLd9QHFN1O95B1pDppAKTYh9YyQP43QVZaqhhrAOPQov9/aK5AcUg2XgCZt9KrWyKUGzVTkQKF/BTLBhyUXKRZ3jPAUXmN5CXYFy6zEIdJiJouVV5jJSFEbq/RDZcCy3bswl7Nsp6M5bWf/ikyB3IeVrBaY8aCpSB0xfk2sDaaPrCNqd3qmaZXp27R4ax8DkUPHa/tz+U5163iJ3M6exR/BJvVTDNejN0cRz6Q+0d88tie
x-ms-office365-filtering-correlation-id: 5187c4c0-8cef-45f4-00b8-08d6145a88bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01493230007CE850ABC59C7AFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(575784001)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(6116002)(11346002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: C+qrfYUnwI/HJy/X4Fz1B3S97JbR1itZW9ioqQ+OJuDocB/r1GRQClZ30nlPPgg2iBRcI2GVFxos1MSjW4X+M/PpYl47FdKMED1iCrlbUxikUrtOunIihr8EQD36pgCS2m+OBXE0hX/Ph7eqFu40WtDGwSGYEPiqdm/Pt5Vfcdqsycs73GJE2T96mOJCDfTKe2B/l6UZ0FjHIwPQFxKuULQ/xD0MVrkDC2lR7neEFilI+dbzJzAf0xboacTx91DB9eRyUp1B8Y4tgMMyNWZPisaujOxdgz+ezsxI3T+3ovtOk2myvV0NhGkaeMADSJUqVX86sLgZ0mnWi/CLSg8sf72IUDdA+hzQUSu6teKBFrI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5187c4c0-8cef-45f4-00b8-08d6145a88bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:23.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
index d1d7787ce211..db2901646403 100644
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
