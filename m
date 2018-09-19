Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDAECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC07021508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n24ZZltl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC07021508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeISLqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:14 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:6887
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730325AbeISLqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnaeAOk+ua72nj7gW5La8Nz8mISGcc6S34yOkxQVaTs=;
 b=n24ZZltliSAZhj/RPq/bZ736ozytD9ozdP85Nd0IwXm2LFm22IiIcGkupRNgAObj9oJ3VqGFAA2dQY753Ui5QrFglDcdyP/U56vM4NBsPbY9Zicpr9+P/gJJzntxJy2+0JkZbXSFOXIMRzV8Py08UbTwNGhP80ZfkvFi6zj7V6Y=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 06:09:41 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 0/4] Add i.MX6ULZ SoC support
Date:   Wed, 19 Sep 2018 14:04:44 +0800
Message-Id: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To VI1PR0402MB3919.eurprd04.prod.outlook.com
 (2603:10a6:803:22::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a4c12c-c0f5-4dee-9e96-08d61df67fb1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3919;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;3:YZbQXwOx6ZpOvEEWf0RMUDxgPaca25LL8tCJZDgZlVBtGwZAF7EXAQNghsCkjosoZOTaP6D/V/RqHyD9aBkLXmfJM2FPFDCVJhiQfS7a2Ha3LEthyu2zTLo+LE7QNr4PAAFIu4NslW31vQkLvCly+X5TCSy4b5573lIOIahSLgMzAU3prrk9QiMPq9XgnnxFLzosNt5vuklKGyHqEnWgpmgfP2HQRjLje4koM6z3sV0yb1SDf54vpgIMaCgHdek5;25:EdVBygfN+kGaCsPufyNZYmoLOgiPsZQ+SQt8YsWjghHLa1dDfVicF/Pwe5Cspta6VNgpsgC3hGB1Y/CF8S4OY6ZU/qYSCXKbBzr7Bci2l7ssOaQmWFh2T8H8IFEATSFQouiuB6s8GFOrps54pWWTuuhBz8n8zq1b7AXXg8iPkZgVkC9fqExJL1OUjeJ6RyN5iDu+8VMzqLMztrPUtwEPvd8MgHiaNnwC9r7CSglC+IMD5pI5QwZmUF6quh/FX1Ka88UaL/c5lgYJPm1kLBOgRtg+QOTz/hWH2LjryY21sMfN16Xx7I9XevTtWnat3O8ul7MGNdRMURhhxiwF+8LTjA==;31:8zsqu57kq/7vu189bET0pKj1ldIwCGgQComA82dsuZrpzcfiGnKAgExWNmzPuQQ9HR9d9rtbHR4M88A5rLqCdjQwbMaLtSDXY2o1XOw2auiP6WEQ6jNn9JRJXxaWbuXiSw9ppXMC/pACRNnBUiFos5MeSUfAtBGlWMpitJnaaxAZnNGMs2u0xD5NR5t4UfSBT7190z0dnEJCgVE3n2CeTo2Pi+7j60xXAackMWh+CNU=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;20:veSZSpG/LYIiWaXIhvgyz0m0aadrAPCurR4aSsdaMQ8oL5j8329EoPd7pcDoI4ScZAP70Z5wE+DTeGAH39P2r8WQ6YNPsfQD61f9s3eBrsu2veucWjO0olI6Me28He8dCAmmSipw1AphPsDcX+bBeg6KON8attcBZGr3vt15189eYo7ttgCfGmAiiMafha2jUybnNeeFS23EhFPJr8efCGhhD1+LxMTxWqvO/5OFmcdi1uE92n5CIyKsIgGGZN4YUEAGt24T5iKrwvol/z86KkvrQa3fJfcc8SgRsbXcS/3vtHQBkbv82FPNSHxLbCFQDnDfPL/jZ5RkvIDOswwoXnxYdNS8ackREHte2ulk3p2uAmc8/KeCH8egGeRDDOGxVVwsPoWpGnwcCxFqXfaUqzC8v6pdaUCr33/FwbeEW3/x5BYlChQUSMRvP/v9ubvYx8W0mQjKu/hJ8ZMScuP/C9T7FQVLhejPbUV7QEMiAv3KFWSrfKEFnHuXr81/dU7V;4:Cuw2jTpzCYngfkDbUnwbycIVBS2TSlRHHvVlYF2tLWhiL63ZJBAapTKGQJCFSNzG4P3bMj41s0l6HHKog4Hy9BdbCNgQ2e1GOigT8/D4lKkmGgdzdtnVVPxD4WNAb0SKA/8P23pN0vfFp8RjSrJ5SOEmvldq3m6Tpzp4NkOFeO5/FhZrvYwHQuhS5XwhMU0bPiYSFGwpgF5jqO4IfZLjR7larxPZe4RTuAondiQjYv+bgj4PPtqWv16sejQPS8oQnhb6IhuweaQBG0foEQD1Qg==
X-Microsoft-Antispam-PRVS: <VI1PR0402MB39193AC46831B61C3B9AD9ADF51C0@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:VI1PR0402MB3919;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3919;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(6506007)(26005)(23676004)(486006)(4326008)(16526019)(36756003)(52116002)(476003)(956004)(105586002)(25786009)(6512007)(386003)(53936002)(2616005)(47776003)(6346003)(186003)(68736007)(81166006)(81156014)(8936002)(50226002)(66066001)(106356001)(6486002)(5660300001)(86362001)(305945005)(7416002)(7736002)(478600001)(2906002)(6116002)(3846002)(2870700001)(316002)(50466002)(97736004)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3919;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM5MTk7MjM6TEw3cE5YbmpDdlg5alRyeTNIOFMwS2lP?=
 =?utf-8?B?Y0lzR3hadHdoR1R4ckhTSW9FWFNQakZ5UDdCeFROd3FUQ29laTZXeEExR2Jk?=
 =?utf-8?B?MUdMVFlseVNNeXBZM0RjZXRRczdzSlF2aHVGcTkwd3RkN0loVHdJbVpCakQz?=
 =?utf-8?B?NmMrVXh0aUQvVVZmWjIveGlXT01BdjRjenN4MUdMSVZWYlBjVWhZdmhidk9O?=
 =?utf-8?B?eFlNWHZtZ042M3VxS1hzVDdqOTl0VjdGeXFENHY5dkZRQXpoWVU3SStMRjBT?=
 =?utf-8?B?Tk5Oci91OXN3SFkzdHZ0czlqWXF4TytSRXBEd0ozVUNDcGRtRWIxTDBoZWIw?=
 =?utf-8?B?WW8xWnN1d3cxZkN6ZUgvU2RYVFUyMzB5SEY2ak1xUjkrVUZLUWZBOGV2OWRF?=
 =?utf-8?B?UmhweTZEcUZ0aFl3WjF4LzJsdml0dHo2MXZRdTBMZlZoaW1RTjNtQ1d6ejhy?=
 =?utf-8?B?Q1U1QlBhWGdveXhmU09mbmJHa2RWRkJRVzFPaGI2MS9IdzRmNDlrNTl5akRu?=
 =?utf-8?B?OHU1ME1nQ3FqVUlxY0U1aWxPeVNPMjBmRFBJWFFwSDVNeVpjVCszSGNWSko4?=
 =?utf-8?B?RldkNWU3ak8wVnYya0NVRVBjT1ZpbVJZQXJ1d3N5SHBNZFRVcVd1anIyU1la?=
 =?utf-8?B?WHNqQmFWZkdSMGplVnV1WUttQmpXaWN4K3czWnBqbDQwLzJyVWZjZEp4UmhG?=
 =?utf-8?B?MU9SbWV4a0swMWk3R0NRREJYZ2tER01rSTdEVVg1SnNnVytJUXhBSE8zZDZq?=
 =?utf-8?B?SUdrbmFRU2h3SGlxcXF5RS9qQ3p2cHp3cWRoRnNEUGxmK1FPU2lveUFXekcr?=
 =?utf-8?B?alphb3VpUTBDOVN6SGJ0SXNtSUxvWXNIY3FCYWNOUU5aN2dCZ0htanFPMVcx?=
 =?utf-8?B?K2ZyUHh2aTBWUXVEb01uNk0zU1NPNUFoS21rSGszSGVIeW85YUNnLzdkMEpF?=
 =?utf-8?B?QXdlU3BKZFV1UUwxOHZ4Y1VPQXlrMmE1OTFPVEQzNk1WMHVGcGhRcDFxMHRt?=
 =?utf-8?B?R0d4S0JPTW1GNUlPOVovSmpEZEkwUTBaQzF5Y1RwcjlQWGJqTElXZ1JNdE5E?=
 =?utf-8?B?TTBDVnY0NlRVaTdvNXVBWmc1SVdLUkkxejZ5T1NXdjZ0U3VKZWQ1VEhZZzR1?=
 =?utf-8?B?Z0xYZWhoQ1JHWGF4ZHkwMStaM2FBSm9XUUNGTlZEVHRuKzl5bFBmbVIzdkhU?=
 =?utf-8?B?a1lGSWJxdG5SNXlsQmVCL3dJSHlFTDNMbHYrRlNpVVp0em9sSmpHY2dSL3dx?=
 =?utf-8?B?SDJrSnV1eElMa3BKQURNcjFGYTN4cjVIUVhaS3UwSnZBMzFKV1cwa3gwMkZ3?=
 =?utf-8?B?TlVLR1pzdUxFYk1PbmpuYUNUMHNXVXdHbVF0SktqT3A0VFZBT3dTdVI0VWdy?=
 =?utf-8?B?emxRbHV6M0h5UFhzbTFJZTMxelhOT0RiWkg5NVNSUENzbFpGVCs5dEw4R203?=
 =?utf-8?B?RW9yNDlnNDhtbGUrNDZ4M1dnRmlzc2NJZncxYzQrYjNhYTBXaENVcFdzRmY5?=
 =?utf-8?Q?Q0vJBNA4qZ2ASgMEdKkSVE/q14c=3D?=
X-Microsoft-Antispam-Message-Info: phSRNb2JUhXDlinrER45G89wgtFJnDD7v6maIN7PephpWJ9s6zRA3cbFvGsG9CtiuUt3Xs4b8mSczO4UHJrLe5PrHsMFLT1z01msLYLLBQEKt1ffGjlr4QZNBr14a+NXEVEQ9XNAvGmUZzRCtdcLftm1NDmuzOIuRWck3PSl1DV7Wuol6I1l0ThgIQcwyMOXR5eh2+OqoBL5lgMXkljmT5Dg4T5mvsV/ZMnr0ewYQ0YybOreyyq8S9WkdgE5tAI0EQ1ScnufPYH029D799S4sBpoBwlCgZEuSqwCr5Bb1hkMZi1i4fujnsocfN0n9rSUgs2XUh9hEuxSksuWX13TpzsZorXUskKOaTh36IShqEc=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;6:ugsuqJ5sI89zFV6xkhbrt6O0VnLSp9DBPyidGTl1izyCzhhMMG/y26j15elr56mp3k3vQyZN7mBZJ7jttpvXoVcbr+ZNFcapiBZoPeCPibh3z0gBuA0O2qRCmHpXUwRMiYu/J8BkXEx7WF6yb+DNKsv4JvdTvrCu1zVSv+iZSLGZPk++9LHVopIlmZdAmW0OUCdVhI55HlGRbv/v0CsQfS02w5UIs+7LKL07IYFzFF9m0OqdBY2JFtoGgiyppqMM0n+MkL3TmqA5QD8IkM876oQRUqOc54NuKUZvW1N1ezJxCyRgfpkorW04sZIUBnvzmMVk8+9iz2dMHD+AoQ7bp0CC6CnV/8MXgqdsIygdCPNhhhvWzkts/1bfMDejto6mafN0ph8CRA1azZ2A58qMB1cDr+E4635DoaoWCGV5UlDbisN2OK6kumdXt4klUsNxuHLK9KFeqEBqj6jG+v4Nmg==;5:qGDeNFhp5BiDI+PayAVIu9iVUCJ6oSL+9119ngJ/rYONkkRESDUi2zrx4sIUxPQS5tqh4YZgv2RB5DWYw1y855HBur7IJbpSOXnf14l73AhMlj78f3t/4zl+P1UPEIwwWz0Anshx2lsrX/qWxvpZkUUsMwP419VpwoJ4Zs2V7bQ=;7:11eZxp7dtNbfcg0CmgA/m7NxZzFTqu33kE2RqFLyx1cTbLz6stGsW/oqnp+v2tEdv0nByhBnzzoo5i2ahs6GNlUY1LXVsXPz/F1rHdzKLnzjywZmOFECbEII0Z0NpIToO+r1FQyDhbFSePj1ps/7vBbf7oskMMi94oeAs8UX61MvzIG5CL1mDWJC7o7ySqS25YkEL7Wi9hPNdaGTQEfVlo3yIix77r8k3Ovciwpzvdi7crQSO6ZFkSkMeJtkmIE7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:09:41.0625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a4c12c-c0f5-4dee-9e96-08d61df67fb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
i.MX6 family, compared to i.MX6ULL, it removes below modules:

    - UART5/UART6/UART7/UART8;
    - PWM5/PWM6/PWM7/PWM8;
    - eCSPI3/eCSPI4;
    - CAN1/CAN2;
    - FEC1/FEC2;
    - I2C3/I2C4;
    - EPIT2;
    - LCDIF;
    - GPT2;
    - TSC;

And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
just add the new CPU type and remove those non-exist modules from dtb.

Anson Huang (4):
  ARM: imx: add i.mx6ulz msl support
  clk: imx6ul: add i.mx6ulz support
  dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
  ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +++
 arch/arm/boot/dts/Makefile                    |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts       | 20 ++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi                | 38 +++++++++++++++++++++++++++
 arch/arm/mach-imx/anatop.c                    | 20 ++++++++++++++
 arch/arm/mach-imx/cpu.c                       |  3 +++
 arch/arm/mach-imx/mach-imx6ul.c               |  1 +
 arch/arm/mach-imx/mxc.h                       |  7 +++++
 arch/arm/mach-imx/pm-imx6.c                   |  4 +--
 drivers/clk/imx/clk-imx6ul.c                  |  3 ++-
 10 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

-- 
2.7.4

