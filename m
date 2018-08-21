Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B55CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8D521502
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XMjmTZdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8D521502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHUKMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:12:16 -0400
Received: from mail-dm3nam03on0066.outbound.protection.outlook.com ([104.47.41.66]:40153
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726381AbeHUKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRaC4i2DUCnvD1LfFPueemXT8+FA89j/MgVYz2WHKk0=;
 b=XMjmTZdkEKn2flmj2/a/OQTruNeBpoYliEYjEQPB6vsx6M5k2Up4ho41uIk2atzBfSm1yJuz70gsaAfkEtci7sRsqKmtzeEI9pJHH7er9gYGlueJFf0tXViPaLhKEqMNYQldgumMIMZjC0S3D6Q1j3TjUA9YsmzcQnz46RGq+t8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from akshu-HP-EliteBook-745-G2.amd.com (202.56.249.162) by
 SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 06:53:12 +0000
From:   Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] clk: x86: Set default parent to 48Mhz
Date:   Tue, 21 Aug 2018 12:21:57 +0530
Message-Id: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR0101CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::34) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e014b018-5ab6-434e-d710-08d60732c7e1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:cFMC1+cWvyFDx6PL2BW6366sMTeqyxNl5oeriQj+ge94wguVBrJ9pvuHhjmDgSt0yJb4gmX2L/4cqxh9R3FsjdZbYS2D4PGovriAvaZZFmir8QdMFq8Cc964HSp3Hj3DUo/fJWd1HMtGt7GTAbc4ieCVi39PhVQpX3b4lJa9KN4meeP+UcsvS1/+q5wbxLyvQ+BjZy8/qEDuUNy0Xx0BnZDSsC1m2dUnPQwo3lmAwbptKOgvRkZ14XxBgqxQoXon;25:sQMrVvE2ZHOwZvyN+drzswOVQ5TSWMuw01aAbvq1Y8xwayaqOMWpy+pWKKMXfnKeBBVfIwWd0AfwC7usxO2xHKG/8C7xpJFzlh040Q05pUiVlAMNb6e/YnFQz5ityyEBOo9FTXIacJRCnKSq9m1vhfDGkhBe9QjJ+SV8/ZJWprMi6+88gI+D9UFHgaJhakKoJX12IFU6EN6byT0Iu7a/FY0ERjNDCXb9EeVgJcOTmKLz9M6XXAXeag8LU0Gxc+bjhdWOacQz/zwy7OhhTb7vCV91THrUzF+9GP9xbFDhEdA3ETlBdZB7XWzLrpABArfgRyigQuQNMJqXESVm2eFddQ==;31:qktwRXaf0PxWgjG7PxeWky22O79uyYj4oXVisHIxeQI26DjRV6Fq7WoJT9tbJxnGhwz8W0n8yieowh7cnHyUCiCSuK78BkuZu5luDsQ41njqoa5ZICn+eKgOfwVsNF15rwMVG8BiMoDD9vWMX8KRMWl7kC+qhGbUQ5HXRTDTUAvgSEDQdbsXQlvbashiSOB7gBimLLa2yU8geSuGMcUH45694jv2nI3F96jWcE0/SJI=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:K1x8epcIP7YnTjniYqLi01nRWuYbb+XbwX4ccET4JjGZUgyTS2fCFsBa0tcC3fUf9YtRkb+gMSy13Wcg8d1bZa/sPALYl0sDKzLaxo3CpacbWfx7u00B6I0lphCqixYxVJVuJfmsjn3UdRoVDV5hlQE06jG9rtO8qxmBIXSXns4SLm/kb0vcFvz2p6arq/fpgg0cKszuow9HPnSnR1wvbO9uugk5XBVW8mrcK7pMWqtZY9GWb0dJYy8CKiGJEApC8DFQqyr6U07lFN0tmr0PejhFqXhRfB5jejDFtF58S5xSK3lLF5Xn62x6BBXPszC3KzQhY7vOx4YVgh8mF1oagG5kQWKVEYi/eTgiOTolf++7fw1kIvi1zM1pxjlw/RSjcrIHNmZuVvAFHMTz51ebia29txkLVFQAiZ0tFxIBjz6nMjL7YxRIpDztwUeD1G0aWvzcYh0/y6JNJ8/qANGIHXselfOiLsJvlSyxv8QHPAK6i/YHoMwqbL5X16l3fqdd;4:1tl0YvepgBZCGiozNk50RPfNVMIEWywzFoDwaplvwJ1dUUjcUMUPkxnNok7NK8WB4NH74w2tx7S9/oivN8cLaFcc3YjvnAWBicbvAND9t+XE+arHpKEV84KEOLIdf15vJlHemaiNS8N/waOX09UyEsGrQJJkMWfi0innmaIIXZYOIxMAk9KgT5Uu/ExwqqE4blWCYW0i6kpXo5viGI3VFaQeOzYcOjhmxd+ns1oKfKj3k3PuTiQQHM9lsJaabkyr12O4akEwR92w81NsO9Pc/qsZMhjjmvS22lSkBjAMGTKSkEwBoC35HuB/oAvcHTBA
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366E7C0C592BCFE5768C4E0F8310@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(5660300001)(97736004)(105586002)(53416004)(106356001)(316002)(1671002)(16526019)(54906003)(16586007)(6486002)(72206003)(186003)(50466002)(48376002)(68736007)(47776003)(66066001)(86362001)(478600001)(476003)(1857600001)(36756003)(53936002)(486006)(25786009)(26005)(81166006)(8936002)(81156014)(109986005)(14444005)(386003)(7736002)(2616005)(44832011)(305945005)(50226002)(4326008)(6116002)(6666003)(2906002)(51416003)(3846002)(7696005)(956004)(52116002)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:jceF81jArUCRudkq7f6kxipncR57WKTcfaH0SOkFR?=
 =?us-ascii?Q?FW6QPmBpABVPk9tyMbP0hIJ0HMmHTTsiyyLqn8rnrl6CyKnDhIxXKhlkxoE8?=
 =?us-ascii?Q?mjPCm7bw3JObanK7eGXGlzxa64ZDr5cYwuzbCl49XJK+DPnJKFZMbvJ2xcgH?=
 =?us-ascii?Q?5mBbM3XnbM99VukkCJMg81RpssHdSCMwBpVG7/b9Z1P9vgKRv+mSpHckSe3E?=
 =?us-ascii?Q?PFfZWkvyipEpsup00AW9LJzGZHfib5IY12upRbY9pSx4Rrnwpbg5yjsHRlQT?=
 =?us-ascii?Q?6DCNvwfPhcKlARZ5qHDywlsMaS2AI2gxhrCOeq/AV4ShRtcS2lNi70N/97cp?=
 =?us-ascii?Q?k3jTWjnR9CbcI1V2NKD742mDa1MslQupZplMlPifdpp4uF2AoyPRYMjSiQtu?=
 =?us-ascii?Q?LaRWW3xol+mThM4l1Q9+dGsz2wxgMd+hKFC+ERngOb/UHihSk3WJl/++wmrk?=
 =?us-ascii?Q?9hFOz5v4gb/44zH/z2wQWD65iVKLzFu+h7WSD9jSvPW8PTr8uHdV5f0PhHNr?=
 =?us-ascii?Q?ED1UbdUtJzD4ClcurTkQyWdwSbg4OxoD95JXOnla4WUMy8/4lHD56zA05UQV?=
 =?us-ascii?Q?P1Dv9B1Fx8RUmcgRBGAt2q1mLG+kCnWRimg0cYHukNJnilSPFzvx1vj+519i?=
 =?us-ascii?Q?mZd/MCIlDbNJzzNG+m1Q10gDFVmKw6BRhuEib9MiiaaHC0Mupk0haQ0agYna?=
 =?us-ascii?Q?6SGI/HULe2rD29DKPwBDL/5FGoakznosELJXS2/GsYQ8yfNw+UWddOga8rNb?=
 =?us-ascii?Q?+/eqdWXBBwXV7tsE57lWOglrI6zVMstFMBYzTB6Z6jz9Hohu6Ji/H4D57T59?=
 =?us-ascii?Q?FCzptubHagY3mU1MlnJ6u1SoiaiYny3h8lZsH1dOGUpYyeDatTkfZoJiXdOo?=
 =?us-ascii?Q?hOZs5tE30g+YamIOuo9yleOYnV98AGmaBahgjOqPSJBKLYCQBzyKdYG2tzcn?=
 =?us-ascii?Q?O+QBG4i7U8Wed24/YE7TDLw6gfBWkGTA+T0IfqK2JB5zwEYAMLVLPtQqiWG7?=
 =?us-ascii?Q?hoIzyF/CQ2FLXttxewemD4FM/ixoWie+yum0SATD/UmMk6sJqKopyeJwDbwg?=
 =?us-ascii?Q?o5ely5kCU8n5KOtW9S+vT5aP8aIqAX+5Rd+nbFyJZmQ+EK/uZMtOiQgl6HDc?=
 =?us-ascii?Q?GLA0Mew7lPbBs23C3OBhrey/pIG9Pf3QV8+fR+AVjAMSocPEcxfEBILEfo88?=
 =?us-ascii?Q?t/AtpPoHVe5wXD1x/SvibEzsM2ee0sqZGL08IXcy64LkcbPFXCV3hbqYtz4v?=
 =?us-ascii?Q?J66pRfLW2fZtsqm5g4=3D?=
X-Microsoft-Antispam-Message-Info: v0W2gdRRiG938UB09Z8BDQFwOfDu5c19Geh9WDXpTT5BLHsC6emJdVHErpUMMdOSXHyzKFT3WsUUQufOyPF0otL8BP0Gy7JPU6lsrApZpVrlj704UJ+peAi4rsqQdBFnWAkZCWzQtERaxTYKL46iYRvP/7rWTuyAATZqYNaUg/qqLu6pR2rAxyuUTjGpM/4jnlhpoi1XHkWdTj0l6HabUAJVqitQ7AKSOHdcVq/OSoqNH++R31qh+p6bgIpepp2Ze8lARcvPkuU2CRbM1/rOVQp4LOfp/sAVtINVgGcko7X3QFdEpKFUlKj7/w4qhYZFNEWm2BhlYKCIhK4JRdYZMhP7aqSLtjoguRXrO26JGdM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:UJ5V+q3SYI6KEUxysDhbKZ3i0+cLeqLZgdnIFakZ9au2SiNhvUXgnPln8th9OO2EHsYUWevwdRjn3Ljja46yCHBjdIlWCsTwaVQi7Ir2PY6CkhMNhV8UAOt4SSDjI7tC92zoFUqvUrRP4zFUMK6H6l1tvXaKbO1mcwTNvHItOZIlSOCDj94BIZghjYvW8Na/JfoI79aOiSknJJb8phG+YWeb9j9oFT8Krd/G/5fNUaKqQ/Jqzx/cY0UKDTw49q8OCD+HR61kOPgRkQKwekPGHLpqrZLzzVHUCXKpu2E9rVUfVys5MyFKJwvBfS6WGX52THgEYui5I1FTXD2C/efYvzHHF2Nj8/5agBpM6fYX7MxeBWFXevC11QxHth0d1pZvQWbHyCOQ1NcXOkgXqglx1rqjBNeSeYiIq0JLfOxHz7r4C6cTPYbXmGRWBWudANIxDo2Xcn+zndS1e/pDhUM5Uw==;5:aZP2rgbQtq6nZXVnq+u5401VZwBcFNTLBnZTcvxRxw59Y+eKbCH0dmnlVi4xMNZmKF7g0lC3ty4zveYHEw8Q/HIQgjRswC3VgM6PBAEYlhikr8jxhonOwyJ0VwO1QMLpktaiOuB+AbdtWm7y77PPsLNUQcSglWIIX38YsGr90c8=;7:Z6AgDesYYsXE+UXjLr9riZIfWnxjqrLwNWQBLky9mnhMvDjoivwH2HBKJ7eTTUkPWmrsT5DN97oRMWQ/WPli3yJiFyvhU9Nrw1UTreiTELVuTTwq4GK5zjJmdI+y2emZS4LxzmzetlGcIBGfsM4b82J05uQPzUBlmWiko+1VKuX69b9aVD4+6cve1GmxuRUj/ci0ZFhiquZ1h6fIT4LeENrvWbGOujWf6JD+YNDrzBDiFatR4mwUG9cXU8+FoK0x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:BVANQsIMTOjHax7zMm4udrM88aZjbZ0jMAZTi9ubYwQxPHn0MuS9G9pTKtX0iGznD46QqvR8TWp56b2HkNQUZXoe6+fTQPoQ/ImCKiUTdd1WRzLoN020CyHp+wVU47cjhRmze6/xkxT997c/r0y0jDhve2rU++hskUuKqZ3ayzps9BtBXJii8V3GeJBjVTZloTK1VqX4elXrUVzpuhzF8xazOHU9dql594UC8OYOHipz6nq6TZ2f0RJmqvp/lmUm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 06:53:12.1591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e014b018-5ab6-434e-d710-08d60732c7e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System clk provided in ST soc can be set to:
48Mhz, non-spread
25Mhz, spread
To get accurate rate, we need it to set it at non-spread
option which is 48Mhz.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 drivers/clk/x86/clk-st.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index fb62f39..3a0996f 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -46,7 +46,7 @@ static int st_clk_probe(struct platform_device *pdev)
 		clk_oscout1_parents, ARRAY_SIZE(clk_oscout1_parents),
 		0, st_data->base + CLKDRVSTR2, OSCOUT1CLK25MHZ, 3, 0, NULL);
 
-	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_25M]->clk);
+	clk_set_parent(hws[ST_CLK_MUX]->clk, hws[ST_CLK_48M]->clk);
 
 	hws[ST_CLK_GATE] = clk_hw_register_gate(NULL, "oscout1", "oscout1_mux",
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
-- 
1.9.1

