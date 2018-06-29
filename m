Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44445C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB08427AAA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WalW0nW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB08427AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935919AbeF2Bj6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 21:39:58 -0400
Received: from mail-ve1eur01on0070.outbound.protection.outlook.com ([104.47.1.70]:63024
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934863AbeF2Bj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 21:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykmM22HTqMiVN/dFKn9w9aYBG5K8t6s2P0iGHvO/LFM=;
 b=WalW0nW3mrC19PgFpvZVkX9qcVTX4t1FiiX/pdCRpNLcgwFiNVmCnqHu51JjHYvBS/hvEqksSupH1OJ+zhC3OTvDaLu4CpI/4LvZ++9FQ/TFIRs/D0TV28yTRoYKvVRBNMLqJqQkH/R/pxU8lHyv8UD1qjS9v4zguQmT7MoxjqU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Fri, 29 Jun
 2018 01:39:48 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        yamada.masahiro@socionext.com, evgreen@chromium.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] mmc: core: cd_label must be last entry of mmc_gpio struct
Date:   Fri, 29 Jun 2018 09:35:32 +0800
Message-Id: <1530236132-7968-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:203:2f::31) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa06cccc-2fff-418c-c5cb-08d5dd61350a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652037)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:42J9dSywdNNuZNOyrtvAxQwB4EbTao0aAJGymRWWIauPSxaBZMLcwfyMwk74v9YEjSDRDF0G53AsFigeuyQJKdLUi9Av5iD9d3c27KVZRcHdj/TTtI14jKirQRPJLc8RQNcjvOyJMzOiy7yuGY/RMduR6wpo25TPvoNnT96XnP1FjS8XIqj4e+HQ89c3rD82PqRPnD8AQkglhOP/EoOmo5s3e5W2JEo40SqTnSM/GlvYg/hMmwEzaXjP+JMjdaIp;25:eDIzjktGYFZbi3N8KatJ/I8ELOFI1zldSnwXaibGla5NdVHI/QJfowHrH3b/6YyLPJ/vZWfVv9tGISTJbaVcH78JGsDyeULsAfGHSKhq2qqSrs3kWccNvJa04iNaHqaCenMJAkov/vB4F8KqoPfsq6ERJFM+S3U5vD6C90cvndGipp+0odwSpNx1+08lKx5wFDoMDM3zQl+ArxW6avFf0cJe9Q0AtsViFjVJ0j12UZ85D9s6QNKTboySY0fp4vZNGXNGrWAwX4LSFFTq1V4JBqWBibk0qEeZB0KlOJ3fba0KS1wIzoZX5HjiHrLz1FrWN2HklajAYV3cvVRQgchkBw==;31:8Fkp1DbPUj2QXZRiBzUHcsRrlcIqzOSVqYBBmfaUXX9k1bU6Np+XzqnkS/TARwhMLHglfnj9wW1YXpxFGBTp5lwWVRHQEZECmEyVBZ/sVMzOqpL8Ag5A/+TZwWEcEYM7Hs6gv+z0l5vRy+VClWc1sX3+3xAbMyLzrpK//TDaT9mF7abPPJU5hqb9cIgRIc16S8/RwdryMzOTQh35z3yKW3KR5DtALVSymoxdWIiCA6g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:DSyXx1IqLtKBj3BmcG6V1a+b0GR2FcVaxb7nZSlZQbku+lkGil2ZVsbYB0AD+n/XXUeY8laVA9poxqVb2ByhYhkLr9PWEKJNT0Im3W3wNDOvBd1wwCaZiYkkdHEX6Xqu1t0BfE9xU/xaF13S/Z+PHQGn+ytlQjGqHoPm57ddFclaSyK1MuIHEz9voOQwCxKCu3MMM6pXIcBHfQnTI+VFRhP158Q42EKs/dlzxOAWlwAl+u3cE9b3MBxkcmDukzi52OynkvHkZLyQb7rltqgD12SlvGOahQFNahxQW2LXI7jscvFhIduy6tIOnyR9pidtmGiCovEiugTRLCFzmYOdEcK09iQE93zsI1LRV2o7LcAIhrLzOrvo4tqAXmg8dJ+TsF5ZU0FR9Khz6TM83O3vkzo83LmTtJT11Q9LPolrahUKwJFCmHY8XLnZiNeDaIbhhoqjm4/jF9lqZOa0Na/aWQw/oIG51dCan1jwObAdWgHH10C+vvs64UU+ODPFKriS;4:Wm3C5TiIRSvXDTCmwsVNLocMKxfsGqjSV7zcJ76xwIlY6eA3s8QhKAFgdEabmMPt84x/284HKc81ZkjM2/wItT2wy1AwBLxgOPazwsEvik4AgJsolSlv+60nig/jQOpMWWQMMTQbFLDYxzPLjjefSmIHRuDG5oHhC+dnYV9PWjHhBhMZCDdB8DYukfOj1k7TzlPBxxJBlViKshqQ3oeOdyky4ijpkG57JQ8VN9F7teIIheoeQMqdD9ENuvJF5iLbAY7UFl1WVsAkfNuQTm1Q4wSjeSh7paixknEa0dSezksiERuNOd0IKyOlXNGR93t9
X-Microsoft-Antispam-PRVS: <AM3PR04MB13158A273042EF55CA7EEC88F54E0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(106356001)(81166006)(105586002)(186003)(16526019)(4326008)(47776003)(86362001)(25786009)(66066001)(53936002)(26005)(478600001)(2870700001)(36756003)(316002)(50466002)(8936002)(3846002)(8676002)(2906002)(476003)(81156014)(6116002)(7736002)(486006)(305945005)(2616005)(956004)(1857600001)(6512007)(97736004)(14444005)(52116002)(6486002)(23676004)(6666003)(5660300001)(50226002)(68736007)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTNQUjA0TUIxMzE1OzIzOlVTTFo5MERRTmZUU3R6eTdEU1k0QmJzWm40?=
 =?utf-8?B?bGtMY1VBNjZDZ2tRYWhNVTk1RG0vMkxRcWQzRmlzalRZeGh3clVPdnh4Qlhy?=
 =?utf-8?B?aUdnOHNvSERNWk5OMUdaRE9ISUhXOGJqeUV5eG1BQ1crTHRLL3Z4YWYxZ0Vs?=
 =?utf-8?B?eW9oZTA2bXZ0aSsxa29QcWtxb2ZleTFBWG9vLzRWRjYzQ1JrdXVHTndDcXVY?=
 =?utf-8?B?aFZUVkVHREptM3puS0xrTHRQNiswNlQ3d0xuVjlUdk5HZlVRV0IvSTAwVUt5?=
 =?utf-8?B?M0N5RkhDR0h6V0dTUHB1RG5HVXp2eGRoN1d4MTZRVUl3MXJMcXAyUFYzUklB?=
 =?utf-8?B?OExPcFVPK3JRWkxDRkRWRHFjeDVub1ppM243bFJvWHRETTNVMDFRTGVkYnhL?=
 =?utf-8?B?T1hXUVVUZ2VJNEdGWi9uOXc0MVltSk5HVnRhY2ZocUZGUERKbEZwVnhNSmdF?=
 =?utf-8?B?UzhwSDJMbXl2NG4yc3YwVUNOVlJpeCs0WDFSTkFnOGJod3ZqS0lxditDL2Mv?=
 =?utf-8?B?MUZRaUQ2ZG93Qk56V3gvTWdveXppRGRRZEF6U2Y5RkJMa0NRbmVCWUFYQXZm?=
 =?utf-8?B?TEZRdDdtRkZrbEtxemRaLzBMNUlET0tYTFVSTmxUSUhMWkpsZGhsUlJ4Q044?=
 =?utf-8?B?ZmxkcEFjYnVmbmgvcFpKcmtWcGxNekhxVGI3THNXWFlrdFZudWJUMVVUR0tH?=
 =?utf-8?B?YXlnYzErelZzYjFJSXpKNDdEdWRtdi80aFRJeGoxM0NReE4zVENpUVJBMVFx?=
 =?utf-8?B?UHVUSjJOK2dyNHB6VjRLNmtJbXhoWFBMVGREZVBGNzQza3NYZTdpVHNmclBS?=
 =?utf-8?B?N2ZleVVNZFppQXVlbXU4Q1ZsQWdrRTRhYkJ4UVcrY0JsYmZNMnhuR0tCU2dV?=
 =?utf-8?B?eVdMYlQ0RlZEMHI1MThCSFp3NzlSLzA5eGFPVFcwSEV6c0ZxU0NyeGR6VEl6?=
 =?utf-8?B?ekIwRFA4SWtVaGM2ZXM0RnNVZDNIZFBTZldhbHVMdFN0Tk1rem14S3RlRUZ6?=
 =?utf-8?B?cUNvRFVhQzVRbkFMaGRRbUlhK2phM0ovTEF6ZW9LR3B1UUNRTHNBbkI4UktT?=
 =?utf-8?B?eVFyUU11TUxwSGJud1laV296UGhGZVNqRWdkQmpzZVVySkZJakh4eVF2cmpW?=
 =?utf-8?B?eGVxcjJJSzdWczkyVjhZWmJ5OExmdUtQc09yelliWitmNnhBcVRyd0ZveXhT?=
 =?utf-8?B?Q1U3aWE3dVo3SjFWN0hhc2RhZ1o1WGhlSDVLQjYreGpyNzQ3a2hlQW1kTjNL?=
 =?utf-8?B?OENxc2plTUpMRHZiWGgwazV1ZnNHVmdLUitiYVFiODRDaXE0THRxVXFSMEI1?=
 =?utf-8?B?WXRLekJSWXhuOEFGSnZHVzFjc3JCQVN4eE1HQWNhYjFBRlJXZW8vd2h0c09B?=
 =?utf-8?B?cnA1bmVsMkFIMGNJWURsK01sL1hVQ3pnRVE2SnBOSmdDelRBK2JabzEvb2hm?=
 =?utf-8?B?ZGRRbkRpMEN6cFFrdVVGbUN4c254QXlYMmQybVFqMzNoZEhySE1xL1VIakF3?=
 =?utf-8?Q?yWMYo1TeMok8MUU19cjVtAkGs=3D?=
X-Microsoft-Antispam-Message-Info: 4bkBOiReFEF4W5WkpZUft56dPKZREnkCaCB2z1blW2jQhlWZ4JlAOCOn1/XC0O4JfRuXVmdGjE2M7kS6bPZ7H4O14qUFhGAOR2qHO+YEzeFeV15Mjge4ixj56zXmntC+dHKQg8lKh/wmE0PPkuDLBXT7e9Wf9JsQrjGvpdGyqhb4/o+2mCx8pbTZWUIqDGIPzMxCHXO1mndrthe87eamgy+OCC0gw5FX1gzjxMgOJDPBUTljJsEiL+K4xumS6i9Urp+qCu8QaigiGWHpjSUoT5aFBF9iKbOQfBvSFlygTXWlB9kPePRjY/rbIY+RE3U6c77UC4RYBh/TbKb4flr5WbfAn6WfmuCgt5qQqeBb/0Q=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:8LwC8plurzoI3i+JpfuEfNjb6MbJX1fxKol7QfJMpOyrZeIzq0kyTy4hKeTqbc0XOcHy0DDYA2cNYjebJvLWHWgWFwwmPzD1gg2IKeCh/mJP3uDd233oYsVI0XbnhcXX/+5luMZTMLHjw71G8QBi/txlc9zg1TVXYeI1POFZLzHMZ88hF/g5XGkzOOfKwVa3HfkrsUQEJgYM34qnF23h9F8AX/tsAeOLFqnSbAfyP9JqUJJnCiwIy4q6oCe0zJRjHLWg2c7xfAXeIvve+q8HxE2b0DUW6zI9SnoCXOhFU4iEj8pFl58UVJvg54GpqfqJksNK7JUKqo2L2eJgfmVGuzujAxMEUQGHVc46wAIKhdylmtYU7LzEfFvRnevhKQwhv3DPTQlCMwKB6dzzoi8TCqX68eH6IUFRrkY2vFK10/AzqHdRzHWhB82oglCCr64cYYkJHNCxCsfkXkb2V9zEkw==;5:0o5B8ul6VoLK7cDEGvjDaafvLckVbnh/2RmVOoHu+E/blR6cG/G56nkFJxltiF84/sx0t12RA3sGvogccNhu5xX8JR3xUHWM/dG9V99Fc6MaLR487j26axJKUtdnb0cvjCaIuFEP2f5odEufnFjSmLQWcBjOSPaarr6oqy7LyEU=;24:fe4LDM/AnX1Ts9W/igQcw9V7JbyE5C1XyN7PFZjs1IBtLQo3YJzhM/glH9Qa+i8n6Gb38rqW/xVzOkSWb+eHdvmmDlVW3TTVdj0/AV9TXIg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:7PMbRnX19r9RxAeCKVO1aY8HUJ31u+gKiWdSwxJZfWmJIRViHOrspQwfmAZakSB7dK4y67/WQ5JyUyLPjJCjyjzFAid0x7n7f72nGXwERwKM2ArzxTIwP/J4y3qS/s4TgqXz9AQBHO/yT4eFJKX1tHg8Z4jqJl3X/++Ic7p9QX7TArKZwKDP2kWFdm+2UHVGz4Mu1TKtS8drAVz7NYEjbtQQg8qWl2SjafOp0RTHb3PXwRf5fjfOOyNrQ4twMOxt
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 01:39:48.9007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa06cccc-2fff-418c-c5cb-08d5dd61350a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bfd694d5e21c ("mmc: core: Add tunable delay
before detecting card after card is inserted") adds
"u32 cd_debounce_delay_ms" to the last of mmc_gpio
struct and cause "char cd_label[0]" NOT work as string
pointer of card detect label, when "cat /proc/interrupts",
the devname for card detect gpio is incorrect as below:

144:          0  gpio-mxc  22 Edge      ▒
161:          0  gpio-mxc   7 Edge      ▒

Making "char cd_label[0]" the last entry of mmc_gpio struct,
the result is correct as below:

144:          0  gpio-mxc  22 Edge      2198000.mmc cd
161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e00..1ccf9dc 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[0];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.7.4

