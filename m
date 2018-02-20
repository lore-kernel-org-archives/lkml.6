Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeBTLQ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:16:28 -0500
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:31776
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751509AbeBTLQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:16:25 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org,
        George Cherian <george.cherian@cavium.com>
Subject: [PATCH] ACPI / CPPC: Update all pr_(debug/err) messages to log the susbspace id
Date: Tue, 20 Feb 2018 11:16:03 +0000
Message-Id: <1519125363-23907-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR0101CA0032.INDPRD01.PROD.OUTLOOK.COM (10.174.221.18)
 To CY1PR07MB2331.namprd07.prod.outlook.com (10.166.194.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0dd4fab-97e0-40d3-01af-08d578535fa3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR07MB2331;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2331;3:nZvMrNJfTo+yQWGjxAnf/kXT+BeozBQk3rjSm28IjJx8evEUSsTqnaP1AzG32dXXU4U7iv/gvP8y2Tw/3bPrqYQGtPvadJaOL5YXg/+OCe4dnpkMyn46ktIV7Tm8UoZkCDfnOzVgEnacqvsb5XhU5Z+QJNhCqwK5Ty43JRNairuTHVnmXQNBB8qoS3bFLT5yg1G7Q7PS16PkPi/NW0bbG9+pKI+eF2JM8iEgx5c5WUYvZWdrue04S69hA+9cs3TT;25:u6VS1zcCWy5b+SLkroSmEO3PGIS8iJmbhGco2RKm1R2yYwD7WgwrBlNqs+SWao2PdXwFbC5Red/p0BVU5WHELFg29sGkE/WfvIwy+n6r+lBotwtmel2CsFtw9rJD3Ij2ljKh5+Asf7E7cfYdhefkwIIB6m1L2Mv6a6Zl4jafXSpSjt0X6S7XPz8gy0ljIxzVkOJsCGpJTR/OOx1N6XMvXlf4iFni8nAhf9d+UJf3+HH0kV+bNGvSdFiRiLCMTBcQo+pPSpczQ29g2tnF2A/vHHeNiKMOO3xnKmlE9KPzJzpf+exwWSVW6hh1KGM+8QVtFqFdGnpTlHFYthC1uXk09A==;31:qUihK9EZeHsSe0iVMx4vK/kbhaErgwIaWVfcMsGaIyvRUr0qf9P0SkZN2sVawwFrbtZjmurWbMBgCCCj1aVKQLiY6IbqAnbYX2FibZD/UcRXGLpWhtmKNJFmdep00s4b0CW0tucnstAjD9gj1/lZREPEU5mVkXkQpjNW0kWr2vIKfB90uiBm/tAba4B1WZLksOj2iV0oB9j0xmCNlmIFaRY0ii8ZqgsyOhAzNezXCWY=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2331:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2331;20:d0kIxI8fCjC5enT1oXQ9uSi4kj9x0cU9B6mqtj1e99PNxWjfC4MSItFp7Umi9P0zthmEgCWcEQSsDJvTYZwd/CX6S9Z8fQJYozSF6Idv+U7o8jPrrQfrNVDBWCbM4TX7CERcXJr+33t4u2iSRQXeWdgO4AKa9prtPvK5pC8RoVmahUmwyNq7EwkdjOJwi9QULcG5f7OyxZ3keb+ACvgwDMJw/gmpa8khfGf3F2MV4hwlXfgpi7Rqof9heqT3sBDa9zKFBx6psxiTO45lv6ptFRoWywg/81XlWlY1RLo59IrR01HC6d+xopJxcSXD97MnrwAEmQV7HQo2IDVTWRg8hMH6hPqih22D1NAH7NWbYiUkJ43wnGkj30gA1etQDQGjUehXZIpwtjVJ89fcOlBL3V+E3bK7ZAhgkr8O/85kz//h38xe711sNyBBjlEX7pje3ZkCoHHuo2ccYvYx4ZbigssfzcVhrRDQ21Nt7sf+5A53MgjtFeRZ0nTaC/CWT2SW;4:Ur+wo6IRL474RLDhYmCKgbM2weLIKLmn0+WmJau2bt5rjMuMJRixJ7h/wYV2ApeiYVKpGWAuNrr0Lmm1SNF7zL2fdq8Y8DveM30uiTNoxhqqJl+9jxq+FnWW218Cd2z/8Hmw8UW6M+uiwYDR7+xM0HSbQnwjfjavm+UtZ1Il2lx49FE/npnnHveL8VUHC9OHofbfIcRP7buEvEOF6cw1P6JPCrjGDbMzdNHqLzUKKdYLaMSAoyrV0nRIYrlIae9nzXlsY0MhYcLUz4gTO07LwQ==
X-Microsoft-Antispam-PRVS: <CY1PR07MB23315F8577278CEB64B03023F9CF0@CY1PR07MB2331.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR07MB2331;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2331;
X-Forefront-PRVS: 05891FB07F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(396003)(39850400004)(346002)(189003)(199004)(81166006)(51416003)(81156014)(3846002)(66066001)(59450400001)(5660300001)(8676002)(48376002)(4326008)(50466002)(47776003)(7736002)(68736007)(86362001)(50226002)(53416004)(6512007)(5009440100003)(15650500001)(6506007)(16586007)(106356001)(16526019)(72206003)(478600001)(6486002)(105586002)(107886003)(6116002)(2906002)(316002)(186003)(25786009)(52116002)(6666003)(8936002)(97736004)(386003)(69596002)(305945005)(53936002)(1857600001)(26005)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2331;H:ubuntu.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2331;23:6yuJ+KVAKgHD4enSDCFYtdhDMdNOVOGpGMFrjqkTo?=
 =?us-ascii?Q?DhFDfng/+705p2mlug5I7AmhuYyc6bIxvR+Un+pQS5G9MXoo6v6TRxmk/4Zw?=
 =?us-ascii?Q?9+jzHhUJaYokVzHP7oY5YYVu0AnKXZY1poA3hwT/czRzeAWHEk5mWTS7C6Uz?=
 =?us-ascii?Q?3Qdpciz3DGhqzrqTC8NIjbPQzm+DtuDP3dkr0j4Mh9vfHjjn4CxJtRcLTQEU?=
 =?us-ascii?Q?VFoBpT39KvNldk4fn4wNG+qIJTSG+wbqywslONuVf3aMp09BjajvO6f+u6nY?=
 =?us-ascii?Q?7U3MHtyxMQfVRzBxQTnJTllVWiVbq+41nTnQ5PbJLfxkcdvrNg8QaOUO1Vfz?=
 =?us-ascii?Q?3SjNYd3Up0n69boQat17znqcCb5jo2eqlYGGmnnHubqMSc+Bb2OeoEy0AYB+?=
 =?us-ascii?Q?nBCJNjne+X1HlI+U5sDhJ46E7wOaCBIkayYJ0Yytihooxm7HJixxS4V6XyX3?=
 =?us-ascii?Q?avac+dlXmP1BQFdBJ3e1/R5ITGLt4JV7c+dEADnp5t7VjzSHHFVxwTwH7AR8?=
 =?us-ascii?Q?Xm1+pI/3InyFFg1OSVhv10E/lby1gS51G3+d29IPeaZ8plozsLrmj/nmBrNl?=
 =?us-ascii?Q?iuLnNRwgWIeuf9Nltt5lujW75Su96KqzC2FTBhtOEOxJR3ZU5hzpc3TIjcf6?=
 =?us-ascii?Q?Zpfydv+uNGD2wNfZDdBKn0chfAXQNo+1VNy/fMrS9pawCOAF1xikaQEuq/yz?=
 =?us-ascii?Q?ynHBcWEbci76vAv6B/PsQzxGI6N73FwrznOA6gyBo0bqOwSteIMhG2J2kZ0C?=
 =?us-ascii?Q?V4/zY9C0tFvNm31Bul0kxn8/E/RPasWSoNfz7RXirYpDfF9Rp1Gy98VIAy85?=
 =?us-ascii?Q?BC7jMWGOFdez8UXal6Y7YDjvtbc8xN2COQEr9QCMbTPLRlao8ns3+cMF5um5?=
 =?us-ascii?Q?YAZlB3WSgQrSazz+qTbFh9hLqS6zy68WQIFJjxTfaQcIPtsCumqL8Owv4HEH?=
 =?us-ascii?Q?VzJlGMC18kfdAwAVK5PDNmVKbre5wZttj93TpBlvNFrc04w9DuVNn8IJAwKb?=
 =?us-ascii?Q?pVAFcBv1/IVo7ktWhyB0isJP7CWS3pcPbbbWtLUB2RQWu142J2f0HNwn45tV?=
 =?us-ascii?Q?SsXWT/xl7Tw+BeRXtujsBpVEY4eNQ5/47JGfwYZYf71LsMobqUPLs2yyQP6k?=
 =?us-ascii?Q?co1mEaLaLhGuAtgYw3KDwBhp8a4yAIFSZfefxTFZJgYJf8sgT+BrXO72jouq?=
 =?us-ascii?Q?ogeMlhmyO0fjW9e7TJ+rk1Lwcf+ukT0+lxqBzjYLIla0XBe3xdQg9xbNA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2331;6:nysl8FjvLfdiJRPLm7FycQPfJu2q5vOwljEngcCQGiYvH13qqyBklbiYI4qrXJ0bkW5NRUf3mCX5VizIFr61ZWevQd+BaEDP5utRLqyOqLFJTx+7LOF/wBTzYNyc430imrlGIWWZyHDpLJc6NPMWuxuazKHmVWUecBpjO0MvOMDIgIF4FXjajyRK0sw+MAC2uKsjyUE0AcOsoZGsNidYe/QTP7etYTIvxIZXnV2SeT87O8/HmVke5p/mtCpTNZn688h1jcr3+gDUbKMuo3xfk4pfFXy+T+ZDdiC688EIWohDEzxRvaZIo+ine5KOp5v7Sd+KsWdmFAizeBZyWjW3TpUvZlCHpE2Auq0nui5GSYE=;5:sOvB2WCO6+IYDjQcRg68phyM+AzmzYb7tDxvdNXiOKJtLF+BX1mjLdnadV2bNQu80kcP7XgiK3tCSUeU0tPhcEWza1BgAgcvDJPXP1FqS0hjNZW3eGjCBOGuY37VBaAWf5ORotEudC3tBP5ma2NJnb/4LC0PWQ1JDKlxj8OVSy4=;24:D9xmFINEtjXYQzvPtGRsdJTr+akARlyRpWozX5hWlDN6U6rSqRRJq5ogGjOUxA4HQNgn4Lj6bm7KaaJAU1g4e0yPzzvvzwPwYspjdrb1SLI=;7:TqMpbUtfLp80zxEmrdfG/iOgV/I0ZoLNc/071R+aXTea1kZIh0jbSHixo7XQBWDr05pOLIEFeBO1YIDV4CUM8mIwuSUbB0Sh7e2HRPe6L9ImeIfT1ByO8FG/8Ku5fP8mMuUHk5x/rGVrq1jGdPQDPXjQsjD7hex5t+zDGLpI721gPJhn9crWKptMAcg6Anmoc4e0oGfuHm+juuwEBORJE/Qv7UPKvgyu//YgJR/biD4Ywf3uJrOHoCJc4iR0rnbY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2018 11:16:20.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dd4fab-97e0-40d3-01af-08d578535fa3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPPC dirver is aware of multiple PCC subspace IDs. Enhance the debug
and error messages in the driver to print the subspace id. In case of
error it will be helpful to find which particular subspace is failing.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/acpi/cppc_acpi.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 06ea474..a4133d7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -227,7 +227,8 @@ static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
 	if (likely(!ret))
 		pcc_ss_data->platform_owns_pcc = false;
 	else
-		pr_err("PCC check channel failed. Status=%x\n", status);
+		pr_err("PCC check channel failed for ss: %d. Status=%x\n",
+		       pcc_ss_id, status);
 
 	return ret;
 }
@@ -291,7 +292,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 			time_delta = ktime_ms_delta(ktime_get(),
 						    pcc_ss_data->last_mpar_reset);
 			if ((time_delta < 60 * MSEC_PER_SEC) && pcc_ss_data->last_mpar_reset) {
-				pr_debug("PCC cmd not sent due to MPAR limit");
+				pr_debug("PCC cmd for subspace %d not sent due to MPAR limit",
+					 pcc_ss_id);
 				ret = -EIO;
 				goto end;
 			}
@@ -312,8 +314,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
 	/* Ring doorbell */
 	ret = mbox_send_message(pcc_ss_data->pcc_channel, &cmd);
 	if (ret < 0) {
-		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
-				cmd, ret);
+		pr_err("Err sending PCC mbox message. ss: %d cmd:%d, ret:%d\n",
+		       pcc_ss_id, cmd, ret);
 		goto end;
 	}
 
@@ -553,7 +555,8 @@ static int register_pcc_channel(int pcc_ss_idx)
 			pcc_mbox_request_channel(&cppc_mbox_cl,	pcc_ss_idx);
 
 		if (IS_ERR(pcc_data[pcc_ss_idx]->pcc_channel)) {
-			pr_err("Failed to find PCC communication channel\n");
+			pr_err("Failed to find PCC channel for subspace %d\n",
+			       pcc_ss_idx);
 			return -ENODEV;
 		}
 
@@ -566,7 +569,8 @@ static int register_pcc_channel(int pcc_ss_idx)
 		cppc_ss = (pcc_data[pcc_ss_idx]->pcc_channel)->con_priv;
 
 		if (!cppc_ss) {
-			pr_err("No PCC subspace found for CPPC\n");
+			pr_err("No PCC subspace found for %d CPPC\n",
+			       pcc_ss_idx);
 			return -ENODEV;
 		}
 
@@ -584,7 +588,8 @@ static int register_pcc_channel(int pcc_ss_idx)
 		pcc_data[pcc_ss_idx]->pcc_comm_addr =
 			acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
 		if (!pcc_data[pcc_ss_idx]->pcc_comm_addr) {
-			pr_err("Failed to ioremap PCC comm region mem\n");
+			pr_err("Failed to ioremap PCC comm region mem for %d\n",
+			       pcc_ss_idx);
 			return -ENOMEM;
 		}
 
@@ -973,8 +978,8 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 			*val = readq_relaxed(vaddr);
 			break;
 		default:
-			pr_debug("Error: Cannot read %u bit width from PCC\n",
-					reg->bit_width);
+			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
+				 reg->bit_width, pcc_ss_id);
 			ret_val = -EFAULT;
 	}
 
@@ -1012,8 +1017,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			writeq_relaxed(val, vaddr);
 			break;
 		default:
-			pr_debug("Error: Cannot write %u bit width to PCC\n",
-					reg->bit_width);
+			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
+				 reg->bit_width, pcc_ss_id);
 			ret_val = -EFAULT;
 			break;
 	}
-- 
2.1.4
