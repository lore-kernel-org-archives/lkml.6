Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937924AbeBUOmP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:42:15 -0500
Received: from mail-sn1nam02on0074.outbound.protection.outlook.com ([104.47.36.74]:11072
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936290AbeBUOmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:42:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-crypto@vger.kernel.org
Cc: Paulian Bogdan Marinca <paulian@marinca.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] crypto: ccp: add check to get PSP master only when PSP is detected
Date: Wed, 21 Feb 2018 08:41:39 -0600
Message-Id: <20180221144139.4989-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:404:121::11) To SN1PR12MB0158.namprd12.prod.outlook.com
 (2a01:111:e400:5144::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f7d758a-2c7c-49ee-af7e-08d5793947d8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0158;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;3:lpYqvdkuKc39ik0ZEoijAeBFRK2hdgMqSLaUnrY2O9Ne/Tl/LBbZTcZfzMHKNkdU9KnrigOnrRvuX29nkGVr7cm+YIC6b7s0UKBVnxFQMFWW+R2d7k9dXx3ktryI2iKeP5byNAe1W9VlsC7yiAzMjXNBf0QijPO5qgwESABNSH+3lsC6MO/G47WO1LqlJUCNgichADCHAOJj0h7AJDuPgeuJVrxF91Bf/xkF2jah14KkhdD7MEzI+wVl/u4S59pD;25:QBe5DYzHDD8ZpONEtzx4OcyGiyuPmq3qeS39E0nDKV3xpSiC4o45ERmDhG0iiUg78W2Ute/fEDCZ7aAbetgZ4lirookMknL9JVpMXUkbe/Oct9x9cDJmfdWIFgBzNvmVJ6UxBq7qoceNs5Plwc7VxO/U+us2FJP8NzHdQJ4xyUU+uJdR16S7wtWqn1zlCWcDFK1vadxp1i1cplXB1fhWVCbmjvJSMNXd5Zb7pQr4E44g8SbtLJGH7gPCTWyfwoDC5EtFARKYMcdm84PTJAsShCR7vhkpeXIU7/f2dnOaV6+WXVUQQ5Q9LYAXHwoNHQFoM3eewwvDCZgPy1LfZIV6LQ==;31:9LsezUcBQNWX9ddZp3vOs5Y9xzbepO7RucQbN7obCKNqoIuv+RnRL26IEmqyYGbAlHB0HdWGzB1KD5hjawVuiVULCsh6XHiRpuT+8DlRfXZk/zTOXcMr3stLLJ6qESZCaJ4VNEOOc77xa1/sbvlM3x4JZvENxsaCRMiz2+Bxgq6u8o11Zs05TUpMRIOH4M2aepJiakD4s17livxF3cEiMI/nZ2Zl+K50Zep7WglOhJM=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0158:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;20:cCoaXCOZCpeiD74lfefIBAiMpUl8QPCHjbt3QwwIUso9OHG3Ej/bl4FdO1IsZsqK15qvt9K4UziFjISBcOAsc56Iq67ZIjEXuHcfPdrXhkTNyfEXoEU6ijLUOM0pFtDvOCYITTwo0Uf8Q227u/U2JPj0wSxgzdZVutdcFgq/3kVVRZiAeIxqgMUBA76hUCpWLe03gmQR0aYwWsVI7lIdMJ4xCqpU/LjnZJUuPCw1GnvsrNNxyX6p2ABF5gsmrrN28nNkwpGasG22d8kAUNE76qtXHVDHWbvZ2MW5lsjybrzJVDOoVulZ5XhzLh1AJDYEOC6kDWHHg+CNY+nagdB6uVCyjKlYb1ab4BfnrGp9z+gyuEMWwNMXucqOpl2XwbZBG+SY++VVCjPLSPLi2gxxgBPowHFtA/e+jzmkXocIOuevk+Hn3dU8Hxm43G2uic1nXfFgqEtt1wk5dOCIQztm40it2SC5kOoSVWLNsr/yapJ0zxBBGkD38fizkedBdUE/;4:xrkzQ6ofpQM0lC2UmooiYzj473VJov/Lk6ANceHffm8T2zYPlX5j8Y9pqRYAzdR0Odyi7TK3bmqS46xGXEzTBhm/XdD0CkMi7aP72ChNlS5kIF7HVs009AEtX0U6ie7gc0/5wxMH8qYP4xaQwmEJWGc6BjMtbLL1CU13MtvblG+7MlgAxZSGkEHk/C+ibSKv8ASkQS9x++SbfdY8zrDEjrk5Yflu5zfvAWmBtoJX8vTXfUugyQ6d1I1pY2g4Lk03ARt7j8b1Y98FeqXewyDLm3WK1R7tbCLGpISpL5JoC1mTTwYGUhMq/tdJqen2/kOI13rC5hjhS1Hhh58cq/38bA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB01588702A8279D169B11206FE5CE0@SN1PR12MB0158.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB0158;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0158;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39380400002)(39860400002)(346002)(396003)(189003)(199004)(47776003)(2361001)(8936002)(50226002)(66066001)(106356001)(2351001)(6486002)(6916009)(6666003)(48376002)(50466002)(478600001)(86362001)(97736004)(575784001)(53936002)(59450400001)(5660300001)(386003)(3846002)(6116002)(186003)(36756003)(26005)(2906002)(105586002)(7736002)(53416004)(1076002)(51416003)(52116002)(7696005)(8676002)(16526019)(4326008)(25786009)(81156014)(81166006)(68736007)(316002)(16586007)(305945005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0158;H:wsp141597wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0158;23:nC5RLwqlTstteFwISd0C+i6D3oy1KNrdcushVzUFT?=
 =?us-ascii?Q?x+KX1N0QhE7v/ZfZBQrxoSiowFTtLYfcHZEjT9vpxGtX4GOgxQa+kBHBIIyO?=
 =?us-ascii?Q?KKs04m53j5V7lJ6lnMgUq82zyCz2L+kYi5zG97Ky1kaS/W1vX1sYJVejEW30?=
 =?us-ascii?Q?ICC0Hgiinh044O+8cynp1OpkthhNgTTOyh4LajRU7LaeWiW0fbGjV12Mwumw?=
 =?us-ascii?Q?RXhNXXRbM5yWM9TdiJs6pVrb8vE/NmQywjQXxOgYy30Tztd6XbdT/fNFBINr?=
 =?us-ascii?Q?TlnV+hB1iJjUxgVsPH/DrYgvAIUOpxCfRgNMkOtuCZJVOwaxCv0y6ODt4l7z?=
 =?us-ascii?Q?xbQhvqDhYEOv6SBneeu32BSLJuQnxRujwU9TkZZoCQuWqjLgyFh1bWyTOJ6N?=
 =?us-ascii?Q?lXrvEDm1PbaVHfcLSKoGldK1HHzjRgnpE6iazk5vqxqPBN+xuwxqyzAype+g?=
 =?us-ascii?Q?dRZovFSQLdvb3rSV07Ja1Q2FYPSLL4/Vqghtd/AUNO0NvxetWu+bwVqLAG64?=
 =?us-ascii?Q?67qeMJEotDWDFLu+0itQkPpiDelAw69zKxuBiUGf9QfzMl3r+dU3ykn4FSQn?=
 =?us-ascii?Q?NPaoyuEvK/PCBhMhVumkl9yUDwKd7w4k5ZcqR+gghjs7BimYQj1oB1ggQIlY?=
 =?us-ascii?Q?wrGp2UBGv2g1WKJ4WkrYrsU77n2xUKqGlmqpqoAx83W7wnejBJJ/d+glavpo?=
 =?us-ascii?Q?ftTwruT/agdWQXM/BuyIGF/xM6AYApRp5sK86eEYKYxdIk/pgaRK1W2rnbxM?=
 =?us-ascii?Q?uSxKUyVOdSethnna2lqoDVGHS4ItUibBscSAbCtcHEaAi19qZnWaaJwfnZ4x?=
 =?us-ascii?Q?Asj4zFl9oVq5Mpr8Pyrj5O9SmcHxOuUBQDj5lnCU63e+qed9nJb7WPNvt5ni?=
 =?us-ascii?Q?MqWUGUByl2JymCNiBoAnlr+aUS5qfN10DXp1jU5a52LIVfSg4hCk84XEAPfS?=
 =?us-ascii?Q?+RxVW5r4ETeljH0iDzP+GXKoujAd8H+87BwDkVfs8M9+wSF075aGH+tWD+Gi?=
 =?us-ascii?Q?SIVg3JCHu19APxoYO9eggnv+yFfOvEay4ftAToF+EhiuladLaOtfWWSI2o+b?=
 =?us-ascii?Q?uaZY1xm72f4hrA/tKaITQUaKrNsAtkI610Y7Xfq0rUZxbK3uwpiAGL6Y1cko?=
 =?us-ascii?Q?fziC4XtVawM2njZWNXLRrNtIeav1f1t58XT+sU1zAeInF895JQ1w3UhatbkF?=
 =?us-ascii?Q?cfex4z3vbIQotU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;6:F1Xy6vKoC4EGEwZS96vaSn8W15LoTPMbg/p1Pd0rXiq+5VfKQwyCRy/0NYHQcICr8oL1deFOu15TRMtnhu3mtEgtmyzZCHWkKwIRZRLkZlxsUXvMv3pS6hDY++UBTAEN05YYr9ykvbl1jv2Q2zd9DuIU9CMeTsB1vWaFvBwaIuPSEnUpYvo+szzYAreVJG5XFstjhqlnsYX4/pEi502EvIALTu6G5vtInGiGUj90tbM3dFZH5Ef1uywrGvM5B22RAQYlYuC0k/I5QoWZdLcEz8Y8sIe/B/AkvpbQ4jO6VP3EhgRHpKSrbMC5LQAmVFqBUdcv+HEB3ZwuA7hVLsQteyoDO8Sj3pil/z97rvVDVQY=;5:o85YysUU0Z7zPlov8KhW/2eAt9GyTLhHL7+eph8yGEG/Jp2udVbjOuU1m4msUbq6yQ54kLau5wtaeHQTbrDiZvMml0moxjQWTIYJ00zCoVPSIucyBzrQaNN3RAK2JAAsGCBUaX5nG5WJA+pDurZLExC/4pElbN/CkN65H2qFHNY=;24:CoKMXvs9xdwcl1mPg99EfnKIVMumfWOAUG+0rzuUWOw2dzAZxCRbsBNVGEAuFiiImI8TFqlcLLZUWWYXAzN2IDVpqgcejU2hDlqFXVqwuM0=;7:w7BiCg7jp9KP7EvqSl5d9stvznVTimv2gycUYDEg3sN72M6hUZHjgOaFKDP4cOhgZ/zaQPcHdDxZYikQYX2LGtSCliCuDPwR4ueR/Xc0XDkqdDchl61GXcLunVfYTI38kqOGdGdOz3PYKgo3yBvE6rydeLNKVcskOYScTfZboVbCrgTB528Bp23ghnZX5w/7E6f03sacGO0EuL8CW8ANUQ5dfC2eD+suQKGKiz/H3v9KiBx7feJL5DUvDoAo7xZh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0158;20:s+FY/1TK9k4usuYEMhtPwyfO4E5Et4SibVgxDOHy7lRZN33+TU3fGvO3bHc5aKUel4br0bU3Qxj5lSNbzDb107nsMfD3+Hfqtz9Awq9gNzCvX+mZjCWjliDi41w6Haeg3kHZHxOuu9vh+pL5mD1G6rEo9ke5kDEmUQuzy+aEbilMGoxXfJ2aHYkk+E9cRWd4N8h3nfp8ME/qxC2laUL5nLTrJ9AY5a3G8q+arnDqpstMgeHdmncPmFvkfoKsWxRz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:42:06.2023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7d758a-2c7c-49ee-af7e-08d5793947d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paulian reported the below kernel crash on Ryzen 5 system:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000073
RIP: 0010:.LC0+0x41f/0xa00
RSP: 0018:ffffa9968003bdd0 EFLAGS: 00010002
RAX: ffffffffb113b130 RBX: 0000000000000000 RCX: 00000000000005a7
RDX: 00000000000000ff RSI: ffff8b46dee651a0 RDI: ffffffffb1bd617c
RBP: 0000000000000246 R08: 00000000000251a0 R09: 0000000000000000
R10: ffffd81f11a38200 R11: ffff8b52e8e0a161 R12: ffffffffb19db220
R13: 0000000000000007 R14: ffffffffb17e4888 R15: 5dccd7affc30a31e
FS:  0000000000000000(0000) GS:ffff8b46dee40000(0000) knlGS:0000000000000000
CR2: 0000000000000073 CR3: 000080128120a000 CR4: 00000000003406e0
Call Trace:
 ? sp_get_psp_master_device+0x56/0x80
 ? map_properties+0x540/0x540
 ? psp_pci_init+0x20/0xe0
 ? map_properties+0x540/0x540
 ? sp_mod_init+0x16/0x1a
 ? do_one_initcall+0x4b/0x190
 ? kernel_init_freeable+0x19b/0x23c
 ? rest_init+0xb0/0xb0
 ? kernel_init+0xa/0x100
 ? ret_from_fork+0x22/0x40

Since Ryzen does not support PSP/SEV firmware hence i->psp_data will
NULL in all sp instances. In those cases, 'i' will point to the
list head after list_for_each_entry(). Dereferencing the head will
cause kernel crash.

Add check to call get master device only when PSP/SEV is detected.

Reported-by: Paulian Bogdan Marinca <paulian@marinca.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
CC: Gary R Hook <gary.hook@amd.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---

Changes since v1:

v1 contained a local change I used for triggering the crash on EPYC system.
we do not need those changes in final patch.

 drivers/crypto/ccp/sp-dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index eb0da6572720..e0459002eb71 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -252,12 +252,12 @@ struct sp_device *sp_get_psp_master_device(void)
 		goto unlock;
 
 	list_for_each_entry(i, &sp_units, entry) {
-		if (i->psp_data)
+		if (i->psp_data && i->get_psp_master_device) {
+			ret = i->get_psp_master_device();
 			break;
+		}
 	}
 
-	if (i->get_psp_master_device)
-		ret = i->get_psp_master_device();
 unlock:
 	write_unlock_irqrestore(&sp_unit_lock, flags);
 	return ret;
-- 
2.14.3
