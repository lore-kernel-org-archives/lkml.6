Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeBZTja (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:39:30 -0500
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:28397
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751521AbeBZTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:25 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 1/8] efi: Fix IA32/X64 Processor Error Record definition
Date: Mon, 26 Feb 2018 13:38:57 -0600
Message-Id: <20180226193904.20532-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ea258fa-00b3-45bb-2dc1-08d57d50a3d5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:wFgywaDRXVoqkvHHj29UAMtH6HU7rF7x8ipXQwAIrSaV21m0LY8m13CUltU2Wlcn29bi3/ybe+IIQc5aASQ3cf1QikniGZbT3X4Vam1PgjBAW0zkl4KkmhXfhFbOQElJuud233sSRaTcUkLnvVUB2YKA6eNtVbTUvDOGLZNIYTQcuhXSIa83zeiF7s24HMnhezcfA0gb6X0EWnqr4XF/310exjvatPGRv8T7wCu/7YPCBhXaEWSvx1Gj6gU+5cEl;25:2JhmIOpKwUAozPO4JFxTrLGGwLZi/ZIiTiIs3SqROugwM631PixALhlFKwmY3TM7idWGulMYz4tJ5klYYNbNr/lfcRKMQln2frQI3acu2dLfHuDyV0f5r3sii9DxN9sLw+NgH6lNnZyS3cmyVnVm1XAMvl9iK8jJ4u8UVkIl/7f8tptLi7u59KVXWGo2petnoM3rMYFFfFgPTtNd62DlOgNQdd5jQ3rM6hqmqk8K/0KNJ0Z+T8eSeIG1GZIaO5whi6I2HA9WbmTiIQYrLbpCDEmyOWorg/iOcX3D1yD6P9Q9CTMauY5ZgKMYIlm0TliLi8PpJmMGkSabhxQaPhUdKw==;31:Is4Gq6lSJ6uBm7H9sAe19yN/sjaUkPOBIf4Z0ItnEJcxACQszHgC78DODsYuqwbO85MQHkHQAhpvTU04rJe6/OGyZBWM6BQk0TSnTa+vYKjFwkk0va5calnrHT+c3ZjJDn2jOa8GBd6UqFrZgYh0F1oR7lDqUyDqk/11Pi/P2OzvSffqh43M/m2DCtYXjQEuTwn63O0AZtAeOsKSztMkQaoDpBJZmJDOGcIDDQFk1+0=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:WY2fek1gpWquoPImf6dKTNx7Pnh2Cd8hX2CrfNWJCf3iQsta/9kZzCLQAp3vcFLs/0j3FakJSMyBhntRTaW02h8XQnSbpnFoETta1YtyFEl0MXG1BF2zop3TdcjUizJFjCOLyBnUF5iG3A/X590RMSL36XYDg7tgp8Dr3v+u0SQAZhneEX1Ofs6y+beuLJkB4XjxazHAYvKtSQdaMkt8RfB+0HXzndWlYRWPzhg+/uYL6fANDpShCBBP7Muewyu6wlPsEa4J8gW3vPXfPBi/5Dp9j5keUXsjrnUy418vCGjybxcrBwIym82x18LQIxAApdwGqd5rKguwGMvom+xAF8b41XQX5e3Urq6kjVJqq2PpdSrEAHnFemO1qBkQzEvp7vy55+bHZgyuqLSA3nbyoGTILH+r5LuXJqgfpSMBXy5I4iDm/LqpiStxyTbiUkXBSCVBbroPtY5XPnCDYNLUF8rjwJpHeZXhf0E9EKMMbUJgBVql+u9Ta+/xvbBR8jRa;4:LszMETDmIqRQEXyt9PLp2hRjrdsBApX5NLSz5sgpPj0h3ZEBGJ0IxUh64jxNXIBHs5ISpsKI43eD+f9SftW3uRpJ9sC6z6jcgyhF5FIDAWD+n1eSntEpUvM4jTb+2M1XqICD+9CcHS8Y8NjNiixMEdKePY0Q/3yVfSYxAlde+Yq7YZeFmlUWzyTg5gZhcVF3D/zo9sc1UAdOAlcs+2ocvuRjqKvDidGZHFOtrRf+Wn7PBa4QnrL/BdS9BpMBjtKotl1PIq4H/3t/xg+IiCVzzxyrQrgmsTQHlodvwu17Q0k1IOz/L814OMY48C2J1jFZ/mF6mL5X54nKvXFOmXvV4Q==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917A9FADACFBD95041513FEF8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(86362001)(59450400001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:mMb+uer+cej2bkDU+taKeIcDVHf0GP436i8ZDu47b?=
 =?us-ascii?Q?E3y86VMM23u9lJZApIojoaleNIAI8dA8rXRzyRUvkitL7RoeAUGB4GBBv3js?=
 =?us-ascii?Q?V7qq/8ac40GSJrrsI5ATdbpZtQFP280FxpB/O2JW/U4FM9Yyai+uPQaJDc6b?=
 =?us-ascii?Q?n44ktk3M25F0RibuDKGQwtCtqwp9RR0TlDERngg2+FtmXyDJe2kMTxRECAES?=
 =?us-ascii?Q?IQub3Avq5aA41q87qfL62vFc47liExiOlccbQU3p6JfCEk9CuJfdXzxT5EyG?=
 =?us-ascii?Q?wgy58KdBf16j7UITgvBssQd4eRDgXLmA8y5077iEi/gk78Vc3kWftlFkt4O6?=
 =?us-ascii?Q?eWGcPVl+Rc9ULNYfa3tZq+wFVZCeVmhG2UCpVqQgn/5f+akKf5zxYXV2JkdJ?=
 =?us-ascii?Q?dTSdtmlGN7zXC2gcEsTtJnyiDQ4RzxXjoUH0zBSUKT4G+50BYK5OkWsn1jhG?=
 =?us-ascii?Q?nYgAgDxD5GD0C14tFjBAEo/2BhktBRqsNKwC7G4N9r/0tVoMzIBp4U3pt+PJ?=
 =?us-ascii?Q?caI5X5Q072obiJVu/HN0rzBnzsuiyCC7qupSqRqVKGAfjkFEFqPU1yKRskGU?=
 =?us-ascii?Q?iAysgL76ZT/0A/IhOq9qCiCcPcBP//fRLRDkZu7Rs4MArD40Euy0DjaKaIUx?=
 =?us-ascii?Q?7XQfBzzJeaEXNiVXwQCx3BlxFs76cHsv4RmZ2gIfmSQ5a0RwFncNTCog1AsZ?=
 =?us-ascii?Q?ElVhWGxVEo4sGNQWVv46kUswxL7/latTD1IBPZcFY6ZsBDHbX6ANvFhLMO4I?=
 =?us-ascii?Q?KTwqCoWYVcJX/jmoVELoT/fN1cGnCaWLkuFpQByV9xeSJBqEfC8wxgXP/ECF?=
 =?us-ascii?Q?3YFHZsKg3+J3T4XizPjCDdNFt0SM3F4bp0gPPqGoiU7xpgQfGpAD2oXTJqi6?=
 =?us-ascii?Q?bfqkVUrA+NgiBQzuScOiDdj4W5/5/RqTMDvLPkP2OvJi+PfV12Zj3QuQWJuG?=
 =?us-ascii?Q?3bCjZYn6ayhi0brg6dI9lAjc6m1zqPDv8A5RklXuAUhJgjSISE6ITLSXUCEO?=
 =?us-ascii?Q?2/WPKx7S26ePoqIxw/EqPF7ugDRExG2SVJzcU37fPG4pvCUhPsaenJR/fwFI?=
 =?us-ascii?Q?EME/JOBCjj1Sg5o1ib+5LUYivHvoGIuVoQ5gMTgi6HIwEPVPb4Mv7e7r2+Xk?=
 =?us-ascii?Q?D7xkZT8DWZdAQMdDT0oWQ5q1Wi/Iw1O8Vbj3TyeE3khZcbDgcl7x4voCbrkp?=
 =?us-ascii?Q?M1K5MjfUl+PmzNaVj1QHBN32t918UWPa1CsOycVpzXKvdLZxirHLkhfGFW7X?=
 =?us-ascii?Q?9GJO3JztBt2fPWJqSY=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:gBkw8y/pfr1vPunAHn4Tr7DBjYRCc3avTEp7AmZjYa7GudxxGiHLTrQuwH2s/zO+ybPAFN+mUijczrVpEBmxPYqwoHMulekyIxy95vPKqXFNkMYwxuNo2VLbCd8YBL4ArQbeg3/GHfWJrXU5H1I0fyzHNCkgoOdjmoHNqAqomFqx9dTUjS1FkGoO5keF9DtQyeoGaB3BIQ6b5ick3yoFkC9WLA+oBNrIWkS84nkyy5wS3VWYpt9H1EGyCA8elTcKnxuwjKwDGMTxpRF50Xw50cuBzGMzPgaaCk0Survk0bU/oWVHcCsdnrr+U5v24/Q8A3Sj579aYwJRPgQcGoDlcUOWpEKEPJOL/mbvCPBLYsc=;5:u9FIDHGIw6+gTZmql7YjYVvy9J+pFLYqUY3b19u4b2EPlygPymv8jT6J4UzEvpN3oLsSuqJ0yQXSZtDFA9P3R7/FkcQsVU+C4A/RB7tkd7jGqSDfSeGbic9qTXR4sMG1DrUau28LtLcKDbk8A+SDvY++HzTfaf7csNbULnAMyrs=;24:r51Gapg6hxQm+byb5Ji9sm7ZWcxqtgX1oQvfxGPMbsVVIY9X4QJS8cJ3M5UKbTCjuRxSuKm6G4s9xg7WDp3XydUV7tub11TdnF/qgAU8n2g=;7:eebjUTV/dnB7t6C9sjnwdqynBGKqBr9OCWH7mhJJ44JOLNDlvNoPoEewyY+ZRZCL57KjqufcCD0Lgl4OozO7Q3MSNRwLptfCkmwVmy2/6u0MW+TcFh5dva1Ir/jtO0PTlgK9duEBO4asVzRhFDnws1tXi2hx4vet9p5grFccTIF8GBnSAned6S+fUf8OgdptL2JjI3NvI4Pljl0Ryc+Vu2uHtbMY4dp0U+3ixTS0RxPFFUmAD0alnU/ye1kVWH4A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:3G0S26U5Rc1i1P+IIxpIVw0y3rnGu4WA73GRAgVHdyaYw7QwUR9pl/tvgmxsIaOFfCOIhj3yhMAlA9XUuTFyrKi+lcIgu8Zn8vab5fVkApgNqBhr7v5io40E9+oKqZM+2PxmwfMO9a11x45r1XiLQG1bIrl1KCMhH3tKut+69QOfeA/oayMYHtfDnCpeN2o18tdUdJCC8aT6RM0dkHkmeeOzejC2JL/ZVFblalL+7HHUobcD8rmA+5I7XXTAAM/Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:23.1837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea258fa-00b3-45bb-2dc1-08d57d50a3d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"
field is 8 bytes but Linux defines this field as 1 byte.

Fix this in the struct cper_sec_proc_ia definition.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180223200333.6410-2-Yazen.Ghannam@amd.com

v1->v2:
* No changes.

 include/linux/cper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index d14ef4e77c8a..4b5f8459b403 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -381,7 +381,7 @@ struct cper_sec_proc_generic {
 /* IA32/X64 Processor Error Section */
 struct cper_sec_proc_ia {
 	__u64	validation_bits;
-	__u8	lapic_id;
+	__u64	lapic_id;
 	__u8	cpuid[48];
 };
 
-- 
2.14.1
