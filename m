Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeDZWcw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:32:52 -0400
Received: from mail-he1eur01on0126.outbound.protection.outlook.com ([104.47.0.126]:11971
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757127AbeDZWcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/24] drm/bridge: sii8620: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:28 +0200
Message-Id: <20180426223139.16740-14-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:6YivJ7DTauK/KBX7oaFQ6uxNi4vPBLVAI5RYKJ7RJQB+jC6V2PXMsA7o0iB17ZZgKSNtHj1iQfoiriZPqZLESuPThRxodG21a6BIZEYh6y+9jrnuJpkDYz/498WvfhekYZ2PxEFPYUJkkDhVocK7lFqU8yb349BPjVXhrDlKXHJCEQEPzLfOH/62uz3w0+4icgmVNUA/AlNf+nLnrF6BbvgLTmEPrEBz6pNNd9Mcz2MnEs28t39aZDiq8kSihIfs;25:oudeuFE4BOCehhN8LkzJi6KxyxQmPwvimROiCiSOd1RYnJr+4Ii/HmgvyudTlO8GMUhDtbAXslOnmaPPhTyNkBztDpIrY6Tq+dfZ9Y8XIMiZw11bhuhF0x3nKmSabK7y2sduZkvjMxE36pmow8Ics2APzOxK80BdZwYsgLeP8OsSOf70m1C1UImkRajn7eO9HG92B75FUkhNGrxPdVtOy0PiKs7i0YyAchRJUEA8GGz4haf3+xyzAJEZRBQioXJ8wljVKAYrxo881dxAi38PUiAYtIfxU9258sL4TDv9nPgjafuhQMDQbDFGUIZ90mNwyRsBUifIJWlHpYiPUTBBkg==;31:jxPUZpasqkanpYy0HpALcT+vXYQs8BVV+fLJ2KzNQz8X2j0VwhHDwrgPlb6URWC0nP1vKWvG2+ubrs9MSceq66STgVpAzBW1KM4d4jKGjPo/OcR8I++VaWO6hlt4N3gzt5f6YbrYPhcRzfG2FSKkZqXzKhXyoZNYNdf9MO+E0Oz3RK+msTV/NXwBtMHW6jxJFgeQcXw1oNw9+h+OJCldEGrz+tRhblEMPe8Twt31xoQ=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27823A627EBE8E2B27F70B5FBC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:g/eFQGYJ+WgfYvi3n7b6mdnL0cBFI0lxqtmji/JIlp9vjWr22ReEp5zabgd+HROZpj8KkMvUt9qt8ZuH5i3nCG1zvL/S77DqM8B9QXfGo75t1bApYAxYmCYJ5he+0kIqADdYam7GWUotoLLpS8w9zfI6gtWrpqQT05rqdXGNpA1bAYc9mP76iLtTpTJ02/7LsFmdVPI/ONrGq6roV8vi08/Ont0+qajre0S1XaFrkSC0UiL+K4pI8ZHhTYaQotfeWDbdtAtLZDUqu11kIrAAOg==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(59450400001)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:tO+7FlMLVs9WdG1B0xNZRTHa6L3xPFXhTp1f50d?=
 =?us-ascii?Q?CR0tmFseua0f8+yMVV8PEgypiAaVpa4NUguB4n+isxhsmQoJ0h4xtrvaG25M?=
 =?us-ascii?Q?dl33GZUqQLgEp7amPFJUkgGCkI6KQvOQidLwHDUG/Q4dscngKI9GdutpEIhR?=
 =?us-ascii?Q?di6jwQYyvxBsWu+LBULm2q/5qAcY8KCB9bUAIrsAlHRjWvQQkAaHmrNcS5c6?=
 =?us-ascii?Q?pH3A11GJzfNHL9hh8wO0rEbaHjAMecmnEkM/f1oK9mcPCZicDHDRTejCk5m6?=
 =?us-ascii?Q?7IqLEc54Q6WIBpviJh42oOMSXnM9fMxzNWG84rUSzcp8Yye7tLUK+fva4Wr0?=
 =?us-ascii?Q?xDJVA+MEdZ16EHFL3NMx1s12irrPhlsH/6NwRArP09UuF5QgdcJ+FmYFm+PF?=
 =?us-ascii?Q?d9fpI6ql7HQazkn1m/EmgdUpaBI+j3Ox7Xhy8FP2EQYUGy/Wg6Yu27oBQdMX?=
 =?us-ascii?Q?qqJQnbK351KUheOyzqx0I5YN+FVOBs6YaNJaX28aeiRYM0d0u4WkI2h3KAa6?=
 =?us-ascii?Q?V/raUhttghA5rNItOLghJPveLUAyC72uN/yuhOBBI8aC41Yb40uJ6KKEqX+U?=
 =?us-ascii?Q?dV6T+1Zo6sMq8rCtLE2Hev8kW7QSKykRAmCoTYEZureLGttFdx/ueLUCAjE4?=
 =?us-ascii?Q?elKETPXYAT3FnhfxLM+Lq9G2pnaUXdrkJTTB3/lKeseAfh4fF5mkBd2+Yfxf?=
 =?us-ascii?Q?zVPsXu3JpL/SGwdRwhW8BVu/qxB2oXf1WV0HdC+0sldo4PbroFRhQM2K1otT?=
 =?us-ascii?Q?7jBNrrUW/sMwT/DlsPFjONRm7q0ZNKZNfeAabWpge39IfXnyoTFdDq92d1h4?=
 =?us-ascii?Q?kRHVCMv/fKj9RrZskfqFiEmqESSi8rC8DeKHtOhze8Oyb2UzMEaUeet08SV+?=
 =?us-ascii?Q?K8qFDYMC8MSwenVgBwjUbaav3kt/qiyUCrj8kSb4rsk6AUBq85eq0SHnQUYd?=
 =?us-ascii?Q?Udvnk6b/1apM74kkq7sAHEOZ74WTTDy80DFgdlwXa2OHH9HrZ6+O3+06+kF+?=
 =?us-ascii?Q?CiFq+aVZY/eruWB+S5qilT839frc4K94ik+aGse6A09yOcoTJioHbDHUt5i7?=
 =?us-ascii?Q?Fbh4+tDLMoIKxXtCePpFy0BvbnJ0G8q/tAcvZYCJ0JR/OKXodo2wrBvmfSR1?=
 =?us-ascii?Q?1GBbaHfC4CLJbsIVIs57ALWjKVnOlp8KnSqOL3neqKZEIJn0z/lJ030F1rfd?=
 =?us-ascii?Q?tr9ro9osWrifv1F2lla89Aq03QUtHj454PhVa/KU+HCejjGav1gdmEWdPo7j?=
 =?us-ascii?Q?4Sm4peOnYjhrqjsqOJslWCkL2CermwkrONDsOz/ZYXXO+KNylgpeCsxOl3YY?=
 =?us-ascii?Q?bO3BHbpq9VuwkQi1AHM1GQlGJor8UdXVv9ro4A1nae9OdajTW+JuXUco3Jm3?=
 =?us-ascii?Q?VsRYDnA=3D=3D?=
X-Microsoft-Antispam-Message-Info: c0tlOB9NW7yZ+uFKxrIOUtE0hM9luMzMotte1drzGeYxTBvW4OBQ+aXWZHqzoS7v7tk8PkHWm8nkYIhA1QnRI1wiBorHRxJMKGfVp8qvFq2/udlBY6oWXMSueE/jslx9cXuWjpRpAIkkdoB91gZOLGX7OyAW0hKQzR2PwsIBEuqrZ7jfsb62C6CYd58YZbMF
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:SenTMttYkpUhZRfd3NgkTF0HZNjc1KuUNk3BXtlsd75Ck9B1f0mBLltKbvWWpyDWVJXH2gyvSC7Qcckfk1uBN6XNhv0anv8T/Vyl70vEOBG2Aw8hqEjd6Fqm4WJXjQm8Z0GvGnmKvjFHkKtu9ehdiPq14vn88USoai8AMPl1sNVlkXCv/F0Tj2krBovcyMztZcJJyy5h2yOxHX2LSGYvxO/6/5hDLagZTcpUS6o4nDwNF7w4xeo1HmEx4BkUIZ31dzgCym1JXNCFw4htS0gG6cKsHKRmEdE1JGDYiLxpcsa/DHcbelF8rWwG4EaiyozeusiR2FB8rulsFlT3kDBVA2MAzrxj5BOwjr6n20D0d7n+PhokjLwxAFCmddv9ddbkwc6MABI88B8pMw0ow8gvU8U3cGDyyaZ7KEbhkB+8ow/BON1x01tDUmxehdcm4SqaAk9etJOVR/t1Oiy7EtOeEw==;5:Hc9FJsP5UprhfZTKshiedmC1PWV/r8qek25LsjtXp40SCWQMZ6k+UF8FvxcTCR3GJ4euCbUuAVCS5sejRnBFxJ/CoC2JCiWVjDXG+1xWB1VhBOpEiLXvppBmM0faoYqphoGmv7YMvhDeda2zU0WQ1aOmBy4fHWjIdQ/VVWR4ccI=;24:7mp18z8WUrKGJTKCqMwYlN/mxolJijqHOnLquvy48nS/Eq9fJvHi0U+T8BxSXDlPUIi939m6YoXCV0XfmYNwJ9H0K2qrmYun5mqzLRqHKb8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:1UiaLWMRHl3+oa7PGomv3XrvuNAEtvTKIj1/6UGk2u+uKXFt5H5jcqrsCnLIsFg/NuAsUpGfXeJONZr8gDR4+YMlPCqqh7+OrWbS1AVhEdRDFn48B8upS4vvDHTo4ZyioLNhWHF6329eU8O/g6WfPAdtefGWCLR2/3qJLhRXmszGDZj2MVaezUMQNvdFj44ippwDid/XvlmASgDg9ymf8fCxDRhoLQqoSHGkLH4rULUYfEzzKS4CwyWxz6LI2hMC
X-MS-Office365-Filtering-Correlation-Id: d6701300-7ae0-4858-b700-08d5abc59e0a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:38.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6701300-7ae0-4858-b700-08d5abc59e0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 7ab36042a822..650f71003e45 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2387,8 +2387,8 @@ static int sii8620_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ctx);
 
+	ctx->bridge.owner = dev;
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
-	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
 	if (!ctx->extcon)
-- 
2.11.0
