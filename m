Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933512AbeBWUD6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:03:58 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933271AbeBWUDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:52 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 1/8] efi: Fix IA32/X64 Processor Error Record definition
Date: Fri, 23 Feb 2018 14:03:26 -0600
Message-Id: <20180223200333.6410-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bfaeb3b-10ad-4c66-c6b8-08d57af88e2f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:ePWis/GqoBnL2SKrvFaCx3odDhqZduDLJfewmWBq57iXu/iarMpCJEbmgWfqdcTICoyINsX8MWkSOrsmj5faHNAZrtmkAHQ+5r+vy3++JkuCwaVvtAyuBbUp/x+tscGavll9Vxx+bKTg+B/OP9+E4/GZhkGj/G+m3Moey7KRe7g4WNz5wED4HNbufttVRLVbOtQRgkJHM09aZ6/VZyJWDCM2FpgvaQRGtPbPccGUKzUWltd1NoWPdocIuYgibdZ0;25:+bCB271MU0AXooW6Cu/baPi1vk/Hz6q5IoNgL0kfZZZs67Lpco7UNcZglwwfqgemDChHzOUnz/xLGrVeY0r5MtIaX9RVe6SdPEKMXHe7RcNomXC5KnT+Z6mPI8w4q0GzRfnpTjQOu1h34iXSF8+6In7Khq6ZiH+CcC12HtcTVzoyGuqbp3yt4z6asPYy2i45Sn4ba7bVHOWL/rDqvfbhPYdWd3K+7zQ9LbAFAYp3InfxFyC0qsPl/Z3Evb9JKgI5hMSj+yVYfI8Hc2cc8B47WkijIPOlkY7964C2KfQ65n27EsFvtUs0FIy1JVYOl7QHkmF1IX6KSbArzPnrfbcDzQ==;31:NjK45ltZF6mk6Uc3DxBINobUtQe0fXn1sXE768YRqFjcwre6Vs2F+6mDcn9u28CriksmOQcQ4ECjePUucrveOj37msYCLSf0TpXFABep3Pxbjj4Z4D2Cl1FwEFEGnjsjJEXgDR0mgPaY3N49VJf+3O/6gU5BNnKHcnMMt2WOokNisqLVa9wN1A7pFCkknQW1MCwEJYhWu5pQsTO+FAZFZMGatagu1j09l+ku7MQxP2Y=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:s8S3BtT7R78Y8Q/AG4BbxwA9htvUw4kxe6YOw/d7DvjKTs7mB8vwVqudvgNqGs7GoAuviefAzGsnOR7rv1PK4chHo/4TQ89BkD1XWNcgp4BTnO6/xBDGsDTon/1htPbFJsl3h4rvgchleHDIfNTl8vvXKVh4XJhNNxdBN0vxyccKqCUvw4Or7O6LlkoCkFCqDeYNCGETgAP94WAKWVWn2T2R0q6T6lKAyigjH73DE3pxlkxyr3PsdVgweUlt1s2dyMSpwvMgB97ZYxNFwjqr3sYUGh91oUpw4RA0/QSqLgf7DBgGYjPSbSLyXJlMPdUL8ZBdfirr70DqxMqNjkTmilvGjWeNAR3B9v01Q9UGLYjP+lykVXigr/vJhs1UG06f1I9p+0lDbymvXXwDE7IYBV2f9Tzr0+MYUSfvCm4sQN9GNujNLvpR94cxcA5kCgVgbYHvtBSuaAfwMoXtM6F4W+DRsIvSV66ogbv/LQtS98zH4SnHX2Pnajw15R89OHmq;4:9ri3QFUWJRLd7MS/qnhxheR5neojDGvlBP61VCk1IIDbgDO/jDDAhsuesPd7/+jdLEbAa7lxbg2WNBpdbWJPUROQfsZG1s3GS5bN9anpBLB3+RnEJJzX4HhuM6xoSZfC2IQ01pgYBeObPK0oY6GEdjyMG54srZLap+24A4rgmYzEnnJIuyGrdkcPtIXP1maa5ouUevctiAh6qg0DEVvTXrrtNp+WxHanui65AY+gVYphB84sA4dCBNRVuktO6dnAed48SXuEb8AEy5XHPxiBIPq5fJvQQog3iFcj7u+ZkeVolSmpdwuMe6o1m8kB6f6cEgTT6HIQin/7GUO5WWkuPg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1906FF27CE20E079644BB1DFF8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(59450400001)(50466002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:Fsc7JhUnSnFrkNrmDQk3mJHxlZT+3dBUwGAH1hctL?=
 =?us-ascii?Q?5tLwlLpFXu1ZJJ2k2W+7otsPefgh+7Nx8qwGPXNzg0BrIj/IKstmRExgzJrL?=
 =?us-ascii?Q?o4+7aTeqVtdtpacHQRp+vVQB6jsMPM1XcAtZhCu8806flIk2Ux0ffHnL/7Ex?=
 =?us-ascii?Q?mhYBuTjuMpJPSWyFLNkqyfmw6KhPnwpfh0irZlUA9XRdw1lhMmx9J6ycvwpt?=
 =?us-ascii?Q?juE03D1aJ6s/ekUGzp1T7pQ/ZTciI+S4DOBURTL31f8fhaNI2iEYUwYEkAU/?=
 =?us-ascii?Q?yoTHrrxdTn0FGPefQG3UkfoOLFqEcjgksk1ttDSC3JPXs+Ak9iqQXKW54g3e?=
 =?us-ascii?Q?nELoUPVasly3+agtVFO30Y4uUnV2ZQFO6m9xMN6XDgVCeIdlTePEWeQ90z1n?=
 =?us-ascii?Q?1/t0snH8utkuFwYwFKGF9hk/bsaF+5LwnMj4mIyzd8DwiCnawc3tPnOUfGy6?=
 =?us-ascii?Q?9j1XHRdy99P3ZUWwpWRY9navtsYS6HFhCwl6iyggWZtlRoXXukBJPQpFTvT0?=
 =?us-ascii?Q?gTQLoxaSV5RtoTIdsAwoEpceCXmeUxjv2mpU6dsPGJaoHBSlGBrWMYvNTcN0?=
 =?us-ascii?Q?H9Dd7HUIhbNQmUMSJX/S/z7KGPrZU2OwH21hCzwUQ8Tlees3QphjlwFBTZJJ?=
 =?us-ascii?Q?ejnOr7H5jiw3QUnUF7ly3UCtRJLe0h/x3PZ/UrAIair0fBTJkzL5i8aZkvj7?=
 =?us-ascii?Q?TnR4vMQO3JxK9eq8WoLECGgLy/0FCDpRQgkPIDfgU855RUP0WfpWFdV2EzeP?=
 =?us-ascii?Q?yCN8BguC0qb0ZG60GOoVTChGFGhsND+wbwsBCvN9h5cMt96CGEjaY2Pu0aw3?=
 =?us-ascii?Q?7SZHAfdZSmUbTzm7eg4C5wvEL7BFbxOoEUWJaHzGqaZ+X3fKjCqPsKyH8axG?=
 =?us-ascii?Q?Z7IUE6CXwJksOtFFhhrACiTZi6WphxpKJXr5URNxeMqzyHXsn9x4I3oxHugi?=
 =?us-ascii?Q?WB9FulMnUzf2GmWCQHl81DGLMOCg/kjbUj6AIx/kcAsj1rcNyjRJ4gPCDJ1H?=
 =?us-ascii?Q?1gH90KCyCb1n0aKAqTmyVjuWdM8srZv6fA4Ebrw3eTCyFRUxW4Ah/JDPaikv?=
 =?us-ascii?Q?EVdsMT/YgUmawSQrWgjyh/VkSrU4adszC7GDD+UOHe/DsXZsmuykwfMbNKG0?=
 =?us-ascii?Q?q4N9U6bucvQzTe9747fsoKn+VKslulVQdxnG9WU2R/k0eu2JcfoTq2avh4xG?=
 =?us-ascii?Q?KTevZwXXs4pP210Qltm9YxSnhrHnZLgfNja?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:1ec+yAkUAvAeMz+ecXIIKCxazkdchpgJnFhYYdBpoZDOiJm9INjmUO2b2kSIKAPKHP33sMogL26PAuPtKNE2Q2bcD9/D9k7HZ1i9S/whQKS6iCn0Hn7DkZQboq2jM6cXgD8/r0O4dS7OJ2iQD5sXKdN4dZ0SK/Mq2jFodkwD3Yn+A46vtYYQ7v6TPmxoMJwaH06JrOMjyEDCzhhxT7oDuUfv3Fx7mIgIHZZKeQP6wHttGGxkhRYRNkwefnc+U3wypOY5g1gthuHLMh4ewc+NeqqlRSmiKc8ylKqsB6AlCE9ABC6xdUhm65k48fdyb3lE9j2r0hg06WOTl6abzsPeE3PhbtRb0FeZQY6g8SyhXos=;5:Ih4plJcIyjstMMCNjTkMPVHOIQOn6YmUbwXG0LUNcq4yXdA0q4fqpgVPdBPYMbQyIYtoZh/kQIw/LwMnO+Mz26gKlUS8+TnhYdY28OzFkCz0Zg6CqTrYqRXXBlJ6vCrEvLPAQLP/N4QC3G8KxEmPExxzMSWqonNcsNtdCJ/aW+8=;24:cQCZsvSG9Kl4jB3qMYhszYv4mcuPXqbyMuzg6TfAS/DfR1GECl41f61hznVpXH+UC8nDoKSAQ+0Gs1eDI+ydjxp0VGpYdU+eYj1FuyM/zrs=;7:imh4Z/qXwfvEC50oaGfl6DhCPmA0as5LyWbcnODFVkXYkWgt7iqmCrlAw2zK50EFDYo04+WzFSowf1Am5rUWUuRukFbo+CO/UaS4QQZmREO81vVkfmuOC/xbjEG2WGrp+EYHNosxjZJA552IIb8T1PplTvGOJQYEFDuFuNNx6CM+RZVQ1AqEswoOtQYUHywrdSnNhXuTL1dbB90ZvVMKP2N+1KW2nRI2vlF9iNq7m5vqqnBh/sLfX5iV5O11MGm0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:0EOZRechmZDUXhR32NU63U3REYRndafXOwPF2fsuQgZDBntgF7pFb+au9IG5Lx7h8vGGhlVjxNhVoKMv//87Vl7RY2aAPmKlN4uhigL19WBj5bFy5goGKkPmd0nK6/e4/MV6RbMakK8L52FJRem2+G7poA0lB24u0J72CLtgl03aAjs6SUPd6VRrRPUlZZpcVlrQE+8meoktv+LCkOIGq3QuGRwpxR+HaNyzSAMODgygQE4EBSk45DMi64YVi7Kc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:48.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfaeb3b-10ad-4c66-c6b8-08d57af88e2f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"
field is 8 bytes but Linux defines this field as 1 byte.

Fix this in the struct cper_sec_proc_ia definition.

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
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
