Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeCXSvo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:51:44 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752626AbeCXSuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 1/8] efi: Fix IA32/X64 Processor Error Record definition
Date: Sat, 24 Mar 2018 13:49:33 -0500
Message-Id: <20180324184940.19762-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08b0cf0d-3a99-4a60-17f5-08d591b80ab6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:myxmBkmnTPwYKreUVnHndTNdbby41mloZKsQlglRKyizxbH2uGtZF6wG/48AEVuu5JIDp3RzCUuaVl8a4GxSofi6SattEt/OvJspdnW7KTljVxFPwsK3oydXCBGWuwqIOd0GAw4FoYD+pMtZwOfig3Sf0pidrKBd9oYrfDO5AOMvaOENl/Th5bVIDc1ix0iuFy5OfJkPDc2wvAOyv+4lJCDAIHGMe2pkSHnWvXAWjfpDrcqQ1eCaO++3NDD84G7/;25:3mfPugYK9tyij1gTv0ZSJP6h7eFc1SfRyDQGrThrSyU0CN4Nzpb2ABfyiatr46BoRj+Yle9pJZQE2lCPzQ7Tbdt/agi4VEmJIX2Juz9u31YtjsjtXYtZBH41Y7BjBh+e97/tz6Mk5/t2TF7dQf8q2JnHwifCBUFVJpey4Ppmvf6E6tYAJ14AInOX6CTq8caAvLKlWudQ5Cwvb/scpMBCsMCIpL1OOko87jKaI1SMKVwqA6tRz5+pgAyI2smxpq0K6WCUwAnGf1gWh6c0wTGb8u2IyFxRC7lCNRwBmIrhiz59NCpHcMAvFldk55gjEWkSZ7e1qqJ+rlSfpnQPOI95HQ==;31:SkN4sDTnXI/+LOEVcHYdmTYsN3GbpVG8BCnwUJ9AbURgBaqBFHEJuLZIfuzfP1NOW99U+gMFZOunPvbcCVwLaAcXH2ppWSgL6YzOV9bXX/Z75oAwFPOj3Vk68C1M9MCgS/Qqj2i91V7d+A0KELuL+3WwrHE+3aswfg+9y3XmcKvifWLqy0V8nQlox/n17DqI4uJItdeoN+/z4XLIyM7VaFIAbmNmmyVUmEb2O/R2+Cw=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:4StcjYyHtMJrW2nVNhqnE+RmYUOImEYdt7Ugw6KywrJ6153nlEkVEIVNwFxkevUfTlKfG3ePIa1zNVoiiKKsSEclWVA31EarAcVNqfnPwJlLSw9zDqPpm2tOAoQTEcYlEsoE/XUJwhd7fCtoovyseZhakc/qN/LtER0Sa/H//oWiQ0f33RIDC7jEEgAUgMvHqc4u4xmcJ7OiFrXbr+Yfu3Hr64QxcwXtmvnsjb4BvA9CqCOIJ1j2y18HniiVKPNSsLctHLJFogYTZuxasvezGlNNrgcW7Dbf+L9PMZzMhvWF5KIsAxQ/tcQBQglvKUHyrp9Muf5bVs8Oh/m/JutLqXSpwkkltd26MeZ434vrM3dK20c5DHOQ/bHA+WnQLZSqTqkFrZOIrqqa3dYs8IqvExszz0NagnJ+pIjnf2Wr+YPh7DYsRC+NUm6LktThS3wRjnG9heULEVcrpnwbnE1vwJ7JRta7Jo9ABqsJ36zodhHHh0Opx489hA5OPt8z0UIW;4:Dcz5ilMrgVrBgNzY0/GvLCvQZegfTVuCU2XUzRp/h09sNR0S8qsiXkpB3Gi9QHZ/OFgdhh4RT1WIT+lltXI3hy6IyGp5tmr4f0AwTQYIOLF956Ke5Mb1u8HbH5ijvzt/+duR4RNwqTUdPDXULxbsnTngZ6rCNR66KQnqUVXmcJLjtju6I3wIokKJyvr5KjlIb3aZRnNa+wrCik2OZ1W0/hQvl/r/7DACrz77bD0fYGUwpvTMdPomDEAGcAzrz0RZTestECdwzNmvOSTb6pJHEFF09clHjZVtwrHSm7NsHONlm2CQPkoSYc2Vgf2khZ4Vvagod9qrJetQX1w41EhT0VOXDSADj1pgWKhtSnBpuEk=
X-Microsoft-Antispam-PRVS: <MWHPR12MB191915D7D248B2165A759E7FF8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(59450400001)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:QSuc6iflRTxsevrK/6XP14ZpNEUXSMiUKxYsMBMIQ?=
 =?us-ascii?Q?C0xMT+Jtrr6k68ohHHaSfvpC+vHQC2jioRXyGYDNSwPzY2We4W6JsnzFX876?=
 =?us-ascii?Q?rKPqrWvtHKjKo3WTuXSRi94vBuyrKIjCiR0LX9YNGKVyNMMtdaZcy4WqqT0d?=
 =?us-ascii?Q?FOR/VhbUTp+RxTAXeHatv+uPrJd+FC+w3xOlbY6F0RXbhOVWfdnZdDviG2Wm?=
 =?us-ascii?Q?7QieeqDe+OFSaeM+zt1Vxsk8PzcHHuIEmXirmsUJMA/Li2hzrEIS8giMIglN?=
 =?us-ascii?Q?i7v327kXvtHgATIJlTac7G5ZY6biACwu4ywbyjzEYJnqQbzcEuiEMdeUJ65S?=
 =?us-ascii?Q?mwZFrgIWqX1jCYCzm5qyTuZsuqsdJFJ8W4p1a17WkAt89xWile5EaoeTAXcB?=
 =?us-ascii?Q?Mo4cwTkr79vsJw/+sk19IQfx+iL01WXDY3TRCnhNwFwMQORt+ga8SHNC9kts?=
 =?us-ascii?Q?uX2fBkmy12pLpAFRFZgqo0muH3Fejo9pJrlzDEDePNph4EnHBLZbNxpcMHMf?=
 =?us-ascii?Q?6l+vXNxFkj0yFBH2zo+KHdOaBq0ekH0jBly1M2bfZy/YSXrRkhCpHj+g2Vsr?=
 =?us-ascii?Q?W6Ag272Huk+ITh9eU3EuMjjHdjkkprRXle0MqYI4/dC/+okF/WsGfF8nHDZG?=
 =?us-ascii?Q?2DdMdeX7ORGC6HMTJjzJU68ne/xHHxrZrygsOHVQOtXHBhXMGrZemlFHSoYU?=
 =?us-ascii?Q?HMITIdi/32BsaPyU0U3UnJZJds8+28xDeX739NqzGZwGGiv4Ls2/vm1qEsy0?=
 =?us-ascii?Q?xIdCBqU09Bb8MztcjucAV4d7Ajrbfh5jVqlYKjEbFzuxBbPwfL+qXtmTn/SK?=
 =?us-ascii?Q?BIWzr940w2LqpH8oa6tQMwHtQ4THIZqfo3zguZgzwBUqUMDHKXcPwLqu7ixp?=
 =?us-ascii?Q?3tLSzGKh9M33BNfWPpnaF6hgYPYOrJuOum0a+Ddi59JjTBXYXYWUYfAS8JGE?=
 =?us-ascii?Q?t/s0Fd13SbGm3bwHzusaprmd4mvEe8Ogo0SkMmRKZ662xtltKxcpQjmAt6PR?=
 =?us-ascii?Q?7WrIvSUTfBXwSAHR21vLBTp35HkFgPYtfmkj9NhQwwTHlpWu6a6OCrOSrdKE?=
 =?us-ascii?Q?QD6UdwfAT9JQAjspiGWBorWX+q/g+FDCuUIpd4ODxiAKoWJk5vQkklCG6Ecx?=
 =?us-ascii?Q?13oALvUUAlOWBZkF410x/gq0wW+Qwc+BE0alvW5FkZQVY0GtpJEaS/yAnUls?=
 =?us-ascii?Q?/vsVOQpIis9BUo/Ed2GVStfHgevoTKn5Uwu1U/y1YHTqv5VOENUIC4w9y36R?=
 =?us-ascii?Q?aRS6RSm2ZPXY3sndr2ub1WxLUY/IYY/ZTxzjxe3X7nSryiZVO1V6al/v0T+q?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: JmIKJg0sAYjpU6xTDRxOReriwdbHpzD2vnvO3ckcOUgadZIGGAri8JR02zaoxq3MXpvo1fmDPI+FkDW7quC4rtJXUf51slOlqVZlYOPaRPwQjCWCCgDyo3bpHcF8OV0fb982K60PmO6yb+MhJx5ApZlZjaoPWwMrKdfo8f220TMB4Fx78KEgMBUaCWu9Gnm3
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:5v5ocu+1TLU3Gz2I+x74UT+yk9pLJrHT6a9DPMWaAW9KuR8bD3QGleO3T/6eY+TCZooDzoOtG633IumbvviODhVTFe4XtnPqkwr9NF0zer6iTY4xPE5QLeSHQKCeYBH52TcNoRuV9u1YPDruJzHRlwrW5sqtitgbXkcljwfCVQBTVCIdQUWjQueIem0LZEUMuGXpmpnjq5oWjVWJZpt03Sz167PkOfHRS+HwZVyiejekCW9E/aWde6LmiD0Q8czmX6CKRhhVLWXU7oAAoOUMcNmjrqKCji7/SWHUe+3Id4pNWZqa6ataU5UKYCrgh/LDvsq0e4PlVvy8+HxOn0OdWOPNzyJEuanqyqgp73bcOGph1Sww7khMKBXTeCm1C+45bH+WgWEf/YiID0g8EMK7uDPEhLI+0xwr+NmQETNT4OwsVANYfr0Hg1Sm5w343ZVFGYVsIjFn4/80Px+pPNHrTw==;5:nbu5CNAs7KH2XYGHTVF2OzWZyp0Sjo2AqFCi44Y8SUUtyRZqFVaUKM0pUfPI2SqHyjo7jbv8feM4ZOECKveczLuTclgGnnmrzB8ywd/nqtHgwzDxRUa3WEj1WEpL/Rg/ensgr2LJ3kXBsui9rn7ds9peg2gjmF54biOzYKE7X4s=;24:+Sp39k/zgbj/JtjRKHw8fm1ng1rUDepvBGKcCji8unGWrxk2JqPrJTIqpTvz+vbzxvVUklFniXckG6GUXF6v0on01wyUESosxaGRXv7dEOw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:C0j0K8Q88aQsIAr9iHa5e12exb2mV2e8jNsOacd/cnOqFm+imeupiqZImqJxwjYFAZNVl697p/OCJLS48c1Zkvvq1+ID+Enz9KR9HUQGeKvRtX1dNO3+s8jNStSDH2gSiDA7IPTDJx1jak3N0ZCgnd812S1uLnIScN4rrR94kdb1YdoB+LO8O3ZY1MOMgNNGsDkaJKe3WrnhlYgJNSbSmwMFoDUP8NDSvV+jk0q+4pGVn9scmTGFxJ3G6fGemLo3;20:2GJ2ruMqw/1T29PTZlPKHbaQX+bUrZVdseNCvaQKjgPnrsXGx9/XWd9cPFrqvPS8GjqiteN2jgAAGyY09SK21OaV5S8xJ3suMbE5pvYvslgPV1EXl/mSA//HMkp8Ym+CCwcDn7cxTD3eyTsBpzR/1NgYE8pyAbGxXs98ISDfafw/xiPVcHuNA1I+Rkg3i+5bJ+eKgJHZOw/O4fGgMMDnPv7o5REtStHNv6HgepYh4PuSAE6nrs1/619+f95dEWJH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:49:57.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b0cf0d-3a99-4a60-17f5-08d591b80ab6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Based on UEFI 2.7 Table 252. Processor Error Record, the "Local APIC_ID"
field is 8 bytes but Linux defines this field as 1 byte.

Fix this in the struct cper_sec_proc_ia definition.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-2-Yazen.Ghannam@amd.com

v2->v3:
* Fix table number in commit message.

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
