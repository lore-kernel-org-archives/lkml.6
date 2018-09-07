Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512A8C2BC8C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6C820857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KfYgO5cK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6C820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeIGFO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:27 -0400
Received: from mail-eopbgr690126.outbound.protection.outlook.com ([40.107.69.126]:51988
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbeIGFO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwtNuS6TstVOuukAGbqeV792rdq/RBPkboKdtt+8QtE=;
 b=KfYgO5cKIRL1LGz2sl4e1WEk89+ozcGZUG/uAdypWgJsLZjROKcc6icXbQg6qBMDbir3QWPF6nBl/wv8ad7JVHzRvj6l1GyZyTJQLA0vQ6P4gCQABXzl3IISAEjyYvX51NGJnMof085Qzs7Q2kkVXx9uDfFfu6JFDEaI3HLPcrQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:36:04 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:04 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 16/88] clk: imx6ul: fix missing of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.18 16/88] clk: imx6ul: fix missing
 of_node_put()
Thread-Index: AQHURkLCEGfPg5Mt6ECxlxfbWT9Hfw==
Date:   Fri, 7 Sep 2018 00:36:04 +0000
Message-ID: <20180907003547.57567-16-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0773;6:z7qvQFrYvVpeXGzpSm6faKWBmWXylY06x2WHkNp21q7KV+2aJVRu+6oDMhWfA9+60QWKFuHMe1N4fogR9bapyhFFiu+mwl4b+UaMpN8Ibct7g8BC5b1cfkAgGoodb5Yy2oljCOOl9yqN6kwdbt2Y6aRYKUAjAuWEyGH0demvBBtOoj8PJv6+pOuBLX8gX6CSK0Eq7Ap26oBZI0lXrqmVOaOzPhTrCHN4Hmndzjl3t5o5/NXJo6rWtRS7HVpxEpdIgKf5yzHj1cXsEsdx4+CbTTdZU1/YAk/IJW92wxmNdQN1/vvRnrqlL3R0l81QFVTTHCm++zv9T6xe6gFXxRkz5H7OwcZ/H3EDvrd15hFr1m7GG+F/yTh3DcFlqBYEWrt3iqNNUy/vl1k+yXKYDOinaJZdOYZlBZrv0xdI8MMFR2u+9H+ql40oDzaLmEFevpyu3wna8gJAbh5U9buZSX/gIg==;5:Xwzls8IFuJoO9Wo0MHEFrm3td+tHuidUSYyqEhiXx2xiOFU4bj1GqYuglE5o45MxdvxmIDne+u+iIeHEbpKoQGY6VBuZHnOnSN8CM67BmWgVi6Grf2Y+jYOBVM74fAV0lXhwMSdjV5TsF8UDku8UljrGbGq0n7Sa28/GEBsxwcY=;7:cG9g4uF/FfGmPqnXHS+bj+xgA2CD41BKFigULt59Fx8eufuccCbDKoqyrj7AAApkC8GAIy3EhdYqRiUCko1iOHJhMHblKiX86vesulSdWhTI63k/EDur7upZmLeEaw+mXbZJXSyhuoquPhyLJyRa8V31CV+lR17Oqfqgjco3M8h+P/MFCXGvmr3/0BT/Sybxs7rTQuaydGkqHcjaeu38ACKj+2tRvqexOnuZTDkNRKiUG4anOK4+sCgyvIzOr+kT
x-ms-office365-filtering-correlation-id: 8fbfc6de-ea2b-4e58-b2c3-08d61459e4d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0773;
x-ms-traffictypediagnostic: CY4PR21MB0773:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0773AE945E1F042FF110E320FB000@CY4PR21MB0773.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0773;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0773;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(8676002)(5660300001)(106356001)(6436002)(25786009)(110136005)(54906003)(6506007)(105586002)(2906002)(486006)(53936002)(446003)(2616005)(476003)(4326008)(11346002)(5250100002)(107886003)(2501003)(86612001)(97736004)(6512007)(478600001)(3846002)(72206003)(6116002)(10290500003)(76176011)(68736007)(14454004)(1076002)(66066001)(26005)(575784001)(6486002)(99286004)(8936002)(36756003)(81166006)(86362001)(256004)(102836004)(81156014)(305945005)(186003)(22452003)(2900100001)(7736002)(10090500001)(316002)(217873002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0773;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n2R8Z86/kp4d+WOl5q5mb10JqXrtP7qUJ90EWYosf9WlxXhE5eTADmmqzwGKKNPj3kRNTCZqtLU8wSXmSlgsrXy4gfzxXrfijAyvpEE3TJrTXL1lWRRNr3RrVBxvS4UydwCUe9dtkKq6tbTnskb6q8wnXgkxpeXNSWbvloAoIjdwJFWT2v+A3SgZK8Cug11gdhAzpr2gaGWXOCln9iF2yG4Ye15w3rT7ncL47+I35adaZ9VoScycuUH7c5Cy6KgwR8BJCJCbJJvfH1EjQo4kG78ePJ1AF8BZ6WCGFS1GpE24OQ2k5WmNNPoc2s/k1vTcGEE8hIjsVCZtXCV7VOuJS5SXatKVimRQPJu7G/JjW0I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbfc6de-ea2b-4e58-b2c3-08d61459e4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:04.1805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0773
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
index ba563ba50b40..9f1a40498642 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -142,6 +142,7 @@ static void __init imx6ul_clocks_init(struct device_nod=
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
