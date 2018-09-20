Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19A7ECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02A21521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KrngBud9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F02A21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbeITIdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:33:17 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:3328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388214AbeITIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnZ8ffG8yGJTASN1Qt5Lej5F4zboeU+rS/VGE+A+bG0=;
 b=KrngBud9dBn03xvGA5GtSXKpn6BQsgRa/H7h6i/FE89mZKPv4k9f0fcYD3+P92ydJ1AZbJaH0t9wyF2ZwkY2Mg0KLOnbIL+YL65wOoUUKI/zpswK5Bi7KN14aNIvHVH07rLN73Ik71TtjqGIcVvkuy8dNCXK0a8ctxcSdryIa0Q=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0119.namprd21.prod.outlook.com (10.173.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Thu, 20 Sep 2018 02:48:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:48:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 55/56] clk: x86: Set default parent to 48Mhz
Thread-Topic: [PATCH AUTOSEL 4.18 55/56] clk: x86: Set default parent to 48Mhz
Thread-Index: AQHUUIxb9885TnyMpkKbg7SUjv+8uQ==
Date:   Thu, 20 Sep 2018 02:48:06 +0000
Message-ID: <20180920024716.58490-55-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0119;6:d+OrZmghOx0ZZREcLWqIe+NatiiYL1uyXcohAdvO2Zvwjt1RYf5ord9LiYm7CzWlnneph0kqqs6cFs2VUvYp/1FCzO4x3PuZ1XBwrjl+Nw2989DRc1frnGg79kJs856g+ALaxnNWeZkbRpU94V6qB6bm+eeDdTclaoxxsiXne29YgebOPh4mhq8aYgFR3wCtmrOA1Fs66+Ore2hpnVTMhTDRIMai3+Ad5yNm/OO4cRhA4ugZVz3doCYpcFw9V8oJgUKyrvyeX+9ThbDRqQYb50910tA0NWsxFcFWhwLT6bGpOaDwNSrinzxJH0lKMfqVosUV9MWIAorOPaosfcHrf7n0gcw3ChMSveMPltgPP7BhlItG+TgZ5Td+taWueQrtQ71l6vu7arvhs/yWhYEaN9wKBVtPecg7wQscoyza4m4lSpQwy263cIYefSvRRALAmPXQBUeTUpH9cWZX5lkdoA==;5:CV8SgLXYJkKBRkYwT8IevTetRz/eBySAjgKr7pEdjEijhTh5x57pfA7Q1w5x8/4G7oVlVGklrLnHW1h7WOxqDIZ0LoOIIs/3M+Gm5hUkJMoUx82nyLbgw3uXwaTUfLYsJXRP0nWS718WmUdB4afi11gIEnyvdDeWm09PlrlVxsA=;7:FBN3K+PKJRPekB72BewxAi9xE6jPeg2hlRZs7Io2RcHt8KqCszcSNOkcZKjw5cBenHfJfUi1BfWZIDaKxtLo6J6ThqkSYuNLjLnyYzUhDhOeZGG4DPNt63h3bCtm+Lgc9HQcM9cEOO1suJOnrulVFYCfOcbFFWx03b8Br6R5NL+wIqoy3qiy72C5RZjRSL3KKbTRABLG5EuWWzj4aXAQIVnvGG3OMpfQ1ORNKNzullHvxJBIZn67NyiUO5QobbxU
x-ms-office365-filtering-correlation-id: 8ab234fd-4b36-46f7-5792-08d61ea38f50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0119;
x-ms-traffictypediagnostic: CY4PR21MB0119:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01190F293C0AA9667FB375F7FB130@CY4PR21MB0119.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0119;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0119;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(189003)(199004)(5660300001)(54906003)(1076002)(478600001)(10090500001)(72206003)(22452003)(107886003)(110136005)(316002)(68736007)(4326008)(76176011)(3846002)(6116002)(25786009)(14454004)(106356001)(99286004)(6666003)(105586002)(102836004)(6506007)(5250100002)(186003)(2501003)(26005)(6486002)(6436002)(53936002)(6512007)(66066001)(486006)(476003)(2616005)(10290500003)(11346002)(446003)(97736004)(36756003)(2900100001)(2906002)(8936002)(305945005)(217873002)(7736002)(86362001)(8676002)(86612001)(256004)(71200400001)(14444005)(71190400001)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0119;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YZHiWyITD1E7WJ6I3nDYpBgYSEcxDAvdCwa57gx9+pu6975brvkQjgysgrWYkdUgL9b9HKjxECofiEEha6+g/YAoZ2JKzM0fe9UkuX8DZnk52vjObsLgt4kVh2Isal4F9/bQyXHBu7Jwb3TL4SVPe/mvGw6OLtdunGN4lJsj5newDftDu9Sr06cuQhZvSvhXVf/+7AgATd/v5cCLD7vhsCneHDENwC+JCBa+a1E7JaKrxSUEBXDSBMgnAaNe0cWuyU+1xvb0YcnRDcLqGhIJbxn4L6Q0VgOClOCK3t0XwIIKA5TtwEbfqvjnx8mgqdbrVE9Qr17lQBbjj/9GzTpIEKD47e3q/7aG9vyyDyqAi74=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab234fd-4b36-46f7-5792-08d61ea38f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:48:06.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit bded6c03e398dc6e862dc8301fb9a60175740653 ]

System clk provided in ST soc can be set to:
48Mhz, non-spread
25Mhz, spread
To get accurate rate, we need it to set it at non-spread
option which is 48Mhz.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Fixes: 421bf6a1f061 ("clk: x86: Add ST oscout platform clock")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/x86/clk-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index fb62f3938008..3a0996f2d556 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -46,7 +46,7 @@ static int st_clk_probe(struct platform_device *pdev)
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
 		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
=20
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
+	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
=20
 	hws[ST_CLK_GATE] =3D clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
--=20
2.17.1
