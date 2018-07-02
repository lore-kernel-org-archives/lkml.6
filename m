Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866CBC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A94255F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qa6t8CgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A94255F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeGBBcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:32:15 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:12572
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752879AbeGBBcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWgsXorxPI0OJfb+sFs+czxSrl9etcWdfPKZfZewGtk=;
 b=Qa6t8CgOxAOFEbchaXnLenhi9+WzL86fFDcb7RcOai5p+qLanIa9PS85qWu0j8HR0fertuYkDjbnPYAeE64aDCXbGRPSo1Li7k/wFVda2xS4U45m/sIn5TZXJT8j22Gy07HhrC5h9opC7NZiUhvBv2rf5fiZsJigKerjaP0hoWw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1318.eurprd04.prod.outlook.com (2a01:111:e400:51cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 01:32:06 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, yamada.masahiro@socionext.com,
        adrian.hunter@intel.com, linus.walleij@linaro.org,
        evgreen@chromium.org, shawn.lin@rock-chips.com,
        fabio.estevam@nxp.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
Date:   Mon,  2 Jul 2018 09:27:47 +0800
Message-Id: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::15) To DB5PR04MB1318.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c3edcc-ecde-4c0f-2a0e-08d5dfbba0e6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1318;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;3:mySBKS4STz+tzZlpSQlO/Vy35Njk3sABQT5PnWSNhJtrgYfUY1yKth9K0u4Nv+WiFhgn5qvAu2TsZRkmNiUCd0+0i0ep028SboGE8Wx6ppPbAk52zJTyifcAVLYcgv+7PXfrHxUgbXbXaTPl1asd4iUGk8Bp1bxt5jJqKH/ALMIGlhWlqZnNtiAakPQR2x+A1Pd+yMJFA1KlukdP8otqShx1Np8O0bX5ujus0yUBIFB0o8U8hDQqJVBgm4Bd4E9C;25:1EgV9fAmh0ag39SXsw4435Q93eEa70VxiZL3GcB7dr/zdgq6EKRGn2WE5o8BEUrWu0gMAW3aY+icEwdhhdOCI4jWDagnPS67EaZmCcKg6c1II1LeiUYuxje5fKHLF6infTHHxavV65m/zrFiJWNtRKFf0R3eS9NDKwbi/MkaV3l2C+fdRfFYlAhnL/uNzj8mckGsh9gVqgySM/XJ+yOkM8LDJQWGG7ee1NrPe23g8IDfxlEhaItefZhQFEeC+w0XJGzMUU64bBIZmchh+/JgQTTKAYMbvb1hcRffrgB6DPCaU/2018ewDNEi+VQgzJ5uNxP035qs7juNTjFbA8p6Hw==;31:Y7SSnda1NNSvb7uU6OZTzlQvqBfgwRj1OCGc3yWvigiEXBykJkFYcygITdytQZFps3Bp3iHeewm0rbW1S1tTIiRNNhGJlEvNjW9vxBcRnRE2JcTkAuEAGE3pu4eaHUstsug+ddth1H/BU2nCSJ9C4jhXS39tapMo1IJ8hZWafbcLLmH01cQ39f8BbCahc7T1Y/GkZcK5ajsBwQk6Nyjcs2wzV42KPBl4ZKndd8U6ULk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1318:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;20:NGlqAp/r/e7yQFyHT8cD6SAaC4YWJJFLdFQozmGSVdJQLlma4K4AQkTgqRCjZqi6okbZRhVRqqxKK0XV3qc9e1h+XrI7btopVNRUZsBZNScgQeet+qYXBZGFVwZiRe1cBi0Xgv2zhSSdxJDNejXblKv8yu7w89ia4w2qdKCtE70xzSZAoKsqOnWUJFalpQS+WDxtud8yPmTxqEtdcjIE/8kMWdTnxNjVFZ6dQzmPc4IKptNiCQQdrMK5N8mhBD6NoyY03V1SeVbaHlmG+k9/Dm63Ro/YWnqsgrj9P6Z/D5jTArK/HP3IycdkrK3lEgPtB6ybIsIqGTVzqHYWxpNuA14FvA2JFV358Iag2AY2hJPSFpYjI/WiJHC0iUuTR5iMgeCAB9M5Jta5GNRVPYA+ML414RhEBvNB/fJVLA7POgmzLoOkVyVgw1eEVXnPRDBQDAZjuAYp3J9fVgGoKTExNhYl6jIU9qVfgo3qBJscyxwtYaeSlz6QAE58YxMrg+KK;4:Q8XEJQ3qw8vhLZ+gFsi4M1QhVTMcjfLniUZ487TTQBLEErP1prRvOGOzMFTQMh+OM0MLMB8VpSIU1BiH2Anqd3cLsZ3WrOWgRujs7R3/bedmdI7EzOPaECaK+JnP8KpMncQIlNIHWuxE5qObmCKhquvhcf+CCNOLXqfQEvSyLLp30mm5h/XzK1xaf2J/i/o68OBIof91pyomwbjY3r90DYMW0mBvglbUi+J2PzuKuPx4ZNhzuSZjHuwhIjOgY1cOapb7IyEK6TrtbQxDqjRDuQAajWX0JHuWarkkGi2u3MLaLwMAF/1qQDZ2zOhH0YuU
X-Microsoft-Antispam-PRVS: <DB5PR04MB1318F15F3AED586F26395434F5430@DB5PR04MB1318.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1318;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1318;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(199004)(189003)(6512007)(2870700001)(4326008)(14444005)(486006)(476003)(386003)(23676004)(52116002)(97736004)(6506007)(6486002)(956004)(2616005)(25786009)(2906002)(50466002)(6116002)(305945005)(53936002)(105586002)(8676002)(8936002)(3846002)(7736002)(106356001)(68736007)(66066001)(47776003)(26005)(86362001)(478600001)(50226002)(316002)(81166006)(186003)(16526019)(36756003)(5660300001)(6666003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1318;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjVQUjA0TUIxMzE4OzIzOm5pZ3VKL2RwNnJtWWdYNGlCVTczd1AxTVRT?=
 =?utf-8?B?L2xVMUtjYzNvU1lSVUtMa1dFN2tCNTY4blN1a1NLYzBXOHRXeUExWnVSWXNS?=
 =?utf-8?B?NTlLcVBscEdhZ21kY09UUEtScHJaSk9LVDFKZUpkaXRYY25mV3QxTm5Jc3d6?=
 =?utf-8?B?akl3a08waFVaMU5uS1hNdWFIM3VSZE9KMEVzMkpHQkNJbzVQQ3VRMU9zL2lS?=
 =?utf-8?B?TjVqbmFUQlBydExsOTJ2dlladUNRanNCR1VhK05DREZ2c1hENGFOaGQ5TVp0?=
 =?utf-8?B?djdtWkhORE1sbWhFMGJ6NTRHbEhZWmlFbkJxQUJ2QVNLSG5YZ1hoWUJOMzBz?=
 =?utf-8?B?d2xhNnRtcDdaYURCQjdxcEUvd1FZdTZwVjhzb2NXb1VHOEJhZnFJOE9NKzZ2?=
 =?utf-8?B?ci9OS3lEbVRtbEMyc3B1WFlvSkhuTm96N2hhY0dJczVWM1RYZTZ1QXVhb3d2?=
 =?utf-8?B?d205S2xiYjhJWWo0OWZYT0JKZkRBYVdsb2RlbzgyVTk5bEdGdXQzQVNIbENw?=
 =?utf-8?B?dDFSbGJtUTd0UXd6UURjUFRsbzB4QjBRZngxZ2NIcFRaWG1ZZmNvOENSUWtE?=
 =?utf-8?B?M2RzV0tUZ2JXSWdHdk91NHN4Wkg2dEhXdTJCQUpZaUovNm01NXZ3N050RWQ4?=
 =?utf-8?B?aDF6RGlmQWFnTjlDK3JNQzgyMW9wckk3MmxLay9BN1BSNkJ5MWVGUWRITEZs?=
 =?utf-8?B?K2xTWUo3ZHpVc0RHR0l0cXJIYkFYSWprRVNrM3VkbXdsKy85ajZrblZUdjBF?=
 =?utf-8?B?bzVoUnl3aGQ4Q0llS3JrK2c3UEIzRmt0eWZIa05uT05MQkJwdjl3b0VyYlBi?=
 =?utf-8?B?bnhXL0w4R1M3dzdTSUFCTkZCaXZZdFNzUjhkajcwd2JXeGI2dythdVkrYjNz?=
 =?utf-8?B?TlZJR1UreDM5dHplTm00SGU5THRmTXNVQTRyTDlkYjR4UnZHbW9EdmNkUkRK?=
 =?utf-8?B?U29BZ08xN0hOSGEyZkVLTm8remVMczNHaEhXRWs0bko0Um10Y252a1VQbWha?=
 =?utf-8?B?OGFpL21lRFU1Q0RHOWV3cS9ra2hPdGJQMUNJY1Frd2J5cXpabFIxRjBQRVAy?=
 =?utf-8?B?c0xMeTkvS3o0SXFqRDcwQUFtOVBpRjI4dGFJV2tHTVZvTDNKRlgvMjNWYXVG?=
 =?utf-8?B?QVJJVmhaNVlEN0pmeTVUVlZ5eGdOUjhKU1RnOG5HNEFnNUhtTUdXakM0ejFp?=
 =?utf-8?B?aUxyL0FhOHBhUFBYODkrNlYvTWpoN1VOUkE3SEVEQlNOTXlsVElLR041VmMy?=
 =?utf-8?B?bDdISGNkWFBqdTJvRkp5SWluaGExVVFVYndPZ1BsNkxQK1ZTQkxTeHBzdzZH?=
 =?utf-8?B?bnQwOXpyNE9vVnRhSzZvRDM5OGFlQ0ZmaFh5QlNKV3F5TUMxNVlJN01aZUh1?=
 =?utf-8?B?ckQ5Z2JtbXJwTXZZdGllT01NTkFzVDNETmtYcDlDMmxkMnN6UmxXVUxQMUh2?=
 =?utf-8?B?SU1oM1lzQUNrdmtsM1FYYUw0c0tpMFFSM2pGTkFFb1psUUFTY0o2Y0lscDhR?=
 =?utf-8?B?OU1DQT09?=
X-Microsoft-Antispam-Message-Info: UIkfP3dgfElwXSsysRx1cXBSxkOniCapsrCl/5rQabaoCaxUXeLIsb3HBMUW/18U727PsMpsh1iO92nxxKP0Bp/NbfjvSGimwgcnxk7HjKGDJ1kKidWG0Tf0anpGzBQzsqn+uWe+m7TkLa9EF+OHwprGL8bzyt/e8Eb3VA+Mz7Jd+fq7O0+Uyr7kRLveiVroU6+50YwqA5AihKQCwwe/8QgkzQ7EfQ5X31+N+lw7THyRyUp7wrjMIizHoPrgh+hyF/6/D/06fzyPNojNnrhBmPRvPqC1ZlqJoEdSfnFpSVOy8G6p6M8GCGIOxo3uwvQZEyor72VV31mSPQhoE74c0ctHNcBKThySEoG+MfuV+ag=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;6:4iayCQcvY1Mls4jjB1d0QTOoqhJ5PN8hcWMdh7bGkKW+ahS9r3+eQnqZ6NLebJGf/tP55hu1iRtME6ny/hUhtMukSpNJCk6z79UXxeyq/3Fa/8Fby3oNdJ2BlZ5ua6RlK0LL014XK0G5i5BS3MzgZzIbdkZ1ERh7ukAxazvnng9pHCija6qfOtYwCkVQ56ue/ygGWlRsQaeZX9qn1NVDS22LIiBagLW9Gz8XrlODoSwpuK7k8w1KgyFRl7R5DzlPyt2c6tPb5vxRnU0Su9KLRHj/dmTQvKz077QDTwafIsQ/tlZggeqeM3IZBWwPZpKbtgX0O0RNrMN46yHccuJGaUgcwQO0MAEksKgndvUNilL76v2pS8GJ5E/fqiccgk8QGmTq172Uvm7UkUu5lASSypdY5CYPorCtxXSphxU/u3Uk1CuKKFjyvcY/H2QBgfb4RNlfYMHrzU2KYuYflip+6w==;5:7ZAQe+8VbeygcojnrmXdybmSAp/wrYcbbI+ytcL+owJV9zT4P/qkNUyo+D/r9XgtZ1LbrkqY37zHHslBy8FbOGDKKFnLxpz8CdGVvKW34is9QzJl2yidogp1QJeU66jTMhsO2TVdOOPU3aybAQqJr9Fax1pF1lr+eq5hgm+cSmk=;24:THscKUw9LIjIQOwrb6tQV7bhexPp1BGgDL3fz3debRKHbJrcGyXZ0DwEnMyX8dlYZa8pNJQDG38q0jSAL1zErRcBNBcAsopb5nUoPrr/P2E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1318;7:b+5dJHTmoIvdH1ND3DrPM4oWVyoYuB5X+rPXNT7AaYYYRwYkiB0SWGicMtJJK+fOq6R2BjoJhXpxoSGp4WOmCHphohv5xwNNmEqvvipTgVaSysG7LEU+m07RlldBgDYbcfkPHmILzE43tiT2obvrHVETWBXspc3hqV5YteGdApqxKQbAQwhUDhHFBZzplSXDunTWrCqLsVpMdpGRNegzenu5rqImexT7zL1lCTw82yiaNRyhlH9xnIi1O3Trp/To
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 01:32:06.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c3edcc-ecde-4c0f-2a0e-08d5dfbba0e6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1318
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

Move the cd_label field down to fix this, and drop the
zero from the array size to prevent future similar bugs,
the result is correct as below:

144:          0  gpio-mxc  22 Edge      2198000.mmc cd
161:          0  gpio-mxc   7 Edge      2190000.mmc cd

Fixes: bfd694d5e21c ("mmc: core: Add tunable delay before detecting card after card is inserted")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V1:
	- Add fix tag;
	- Drop the zero from the array size, then gcc will have compiling error for such kind of issue next time.
 drivers/mmc/core/slot-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index ef05e00..2a83368 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -27,8 +27,8 @@ struct mmc_gpio {
 	bool override_cd_active_level;
 	irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
 	char *ro_label;
-	char cd_label[0];
 	u32 cd_debounce_delay_ms;
+	char cd_label[];
 };
 
 static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
-- 
2.7.4

