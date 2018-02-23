Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933489AbeBWUDz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:03:55 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933270AbeBWUDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:50 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 0/8] Decode IA32/X64 CPER
Date: Fri, 23 Feb 2018 14:03:25 -0600
Message-Id: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e80076b-e636-4397-ac08-08d57af88d11
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:N/5K6P11sppg2QAweE2LiRneqEcYon4Y7w1rPxOoYDBX4dBKLVPwNQLatLEIxQZlyRoGQ9NCklfF/TgoPxOKAUmpqReJJQRa8h4sPX7EunUIiprHYPlkfRhlxmSWVHf8Nn7sZfrUatC+WCUKu+fMfKL2ZHpJGkXbC1TwK/EGc/mBZQ8CTW1/097Opx7/OxyPa3kdv/pWzF0r6t+hGaO7m2gNN/hTsyF2qHkUyzrNWHpHo6IlxsE5rD90rJ11u2t0;25:l2y+xd/zJ37xPixYwPzidhx+0jI1M+6XIy4mvrErFAI/tP9oaCvTpSN65Tx++I/zUIsT4BoTCOPb8QdZ41cDGf2QWKPQb4PHr4JKWOtKakutnzMe563KI+WSHSWkbIqNBwYOPDfbRSJoY2gYNde89QNQ6YNMzZEdWjUOETtU91EK3pY1CX2Gy3c7Hpig+o29uqruwID/a+qC9mv7RaAfNflL5JA4TTKDmlUIS+eQrPb4pPcUj9E3Fpiy1KrE2vNC3zmxQ9g7Pd7uvex5WFTQJsvx4m+z2X5V+YW3VGPwraF/dc/mH+x/G9ySEq1IRYW5ZUKZq8lDl2jjHGpmpJUGuw==;31:Zy3WDZccWxZmD3k2hzlp85hfRpMyyYxfmitwX8Xqq0+16iTl99FJbD2VkBbK2UBhdbJpPHNojBH6EM9tWM1H0XfrNFz/5M9gUAl1ka7ddKEus1hxByt7LZbg1mzQZpxz2vU3vlpvdpSHzy7fOsawrIybcfo606kiVnnIham0AX9gBdgMbGi9lOxnaQWvizDlx28cyJUV4kCNh2/ofZCAeXzl4r2gmHj23EvqQ5/ZSdI=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:K26m0e1659/S3c50crixs89dDRPdogb+g6/G4V0gQrxddkX4xyqcBMoKWZFcLaq9RIulXXTOO8o3KDeYSus0pTacVddGYzI6/kpsxy8t5R0fB7oGBUYYx7PfwK/T2Lh2BSEVPgwmXMs1erHf3A5uacZrQnfMcjFP2rRqkhcXnQXGONk0HvJ3/Lg/JaEcoA4zljGIXODiL09IDnsHIIiMQ/0PLhtNAo06CZQJ13+2jxSL4mGNHU95w8KciGBlF4DlRJpC1ebqO1Dqfb5kR/kAuuOSB6Hb//jb4KtVHim6RvjWl6GROmrAyo/5KRYSJe/q9dQeGiEylOVESYmKshUFT2BQeOBc7/wCvORiyQMu0LaZOZvg0i89Y/EMB7Fyg9bTGc1QOQSBVp9yxTIHxSHCS6x/MSNaQQnakOJkn+ROMt8SPFw3pPJ5ZSHPIPv+I4BcWGHMUhakSDexfNb9cZy4BP98vFHyIA4PQHr7ojLlzMkbvNmhIR2xrU3Whc98j7oZ;4:MWjkVgvWlIKiGZwZc+LZb851fqm8+ZqGgyqveYAbCybC46i7l8VjqiW5+bSKwpqQwFwK7Cu5eLKw9MJYHy8Zryfzvuzn/79teQYK+p9OJ9QaZazodas6PPsK74biKl+HvzVK+xLsGMZXr9hCBHvWCpHcECW0OOvmwyYSSDlP3IIG9cMCnLZ4RnOFGSZekruQfD2ok/9BJ+PjcsuuBF3wkikx8uMl22CbLUkq/ajk6t0TQ7CWHZiNIxDEgSPRU1SLT1oXHxmSNOPnj+yESkujTluHHxq9uzOPHLg3nfZ+JhIm8A0/U12EiWVv3Xrvzuz4
X-Microsoft-Antispam-PRVS: <BN6PR12MB19065CAFABC205B3F235AEC3F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(59450400001)(50466002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:rulQ1MJVXBCjvFNWLUNJbeJMX/eneu2pOC/176Rj5?=
 =?us-ascii?Q?IWJ2hhQUnOm7a7FzRuGCSqJ3Zrw8xQYRnMiA/N+pN5rqM3XSWJ+eGX4hnSWC?=
 =?us-ascii?Q?35o9vEycwcELNygkYVEjIgR4tTwZdgsFrkd1S3AjarcBXeEpR4I0J6JimFah?=
 =?us-ascii?Q?qV+3Li+vDbVcf5+IuaIFWtTHtRFkJvKiPT7gXQP9sPeaHIpzuSA4+4dDh1Y8?=
 =?us-ascii?Q?WtCtiQ/kmrT8i9d0NsxTVhHbil9ef4b+91g7cj+ZpT9CHrN2O9Ws6fiHQ4v9?=
 =?us-ascii?Q?oJjdOW2g3iDxZBdic/W2YPJ1v12QLYbvGvGV+k0a/K6adSnMyW9D1l3zNZZs?=
 =?us-ascii?Q?ONhNMaMVlXTFlDQcYqSKvoPd4VftTatxAiDsfJbMhB2tcTeT4AVZAFn1chhY?=
 =?us-ascii?Q?O8YYBnaray1Hridfhb+xphZiZwGgNJMPZEQ2jJedlTgXkAPJuxjyibon1Aif?=
 =?us-ascii?Q?CwuiFZu2C+gXUr6mXRn9iGGTu5b+r5M8mgp+qWa9xvtfSD0Yt6z/+3sfNmR3?=
 =?us-ascii?Q?ip5trINILc34fAVcA1vwcG41hYc5I79upaHsKbnNUsbKZ9PjgCuB+4bonHpE?=
 =?us-ascii?Q?050nI0vDUxkKxD20F40y37/CUqfop2obiG/tTyF9KQjHZppneOQGb/tsfWZb?=
 =?us-ascii?Q?QzxZfA1LEtQfh49PMTrYMzlSPHqZVFernKL9zRYQFzDgUHbq5/pxIqrTyzP+?=
 =?us-ascii?Q?wwqGedTqXzlkvSpggbPY6RL39v0t7szu26uZ6FHQ0hd01WqOFtZ7wj0hMLVP?=
 =?us-ascii?Q?UP5ff6ddTiBEk0I1RP7LwEcg2ggyvRwbQhwc/7Nw1mTiZsOesxkoEcXHm9l4?=
 =?us-ascii?Q?r0XIDXrMbM9fNh8KDUn9KUMbCD1mFa7xS6q+8zi2IQz0AfhFmmAKZmqbFbvw?=
 =?us-ascii?Q?IopHDgA6x38e7aiM+TGA4fpUrGNV/vP56aqzotEMsfdI+4uJjk0a/ufHdcf8?=
 =?us-ascii?Q?pJ/t60lEPDnRQzvG+RIDGBgZPFNSlTlIOels9MMOKbKN/S7QaStMmOrWXAAz?=
 =?us-ascii?Q?JfNH/fVndisMvE4F6g2m3mpGRSn/RRSf/89FDZt+bkoxj6USrwaOkk9j7Ibg?=
 =?us-ascii?Q?Ds0HZN/q7me4GILLwi/IxPJNL5o+A8flLucEdHErBdN/380ifV5kVzZ64+ap?=
 =?us-ascii?Q?T/XbepwXuwSD74CBBObCyEMAsOb99l4rJCnpbNmytbHOu/u/aXdEQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:zJQZRpKCdznZ2cYayBtah4SRxNFUlvLJw1IGpZaIvpSIZunWI5MLoZNd2Vroy3HumbV8q4Qah7Ko9gN7SqI/+jicYkMVKjUhoVeFMVlwJkeuXxJkgls5+G27Gpr+/bub1OkGY5cdf++jqrxB3r02nOnzHpxYiwCt5X3lTzpsCqP4LgW8f1wRs2GrRur3zuiNfdSZKxHeqlzbFp7jhwQ2uPgvl+8fx0MZS9yvtXFzhsV3ugGyH9iKdxJDZ91VYTDevTezrmX1dDW/bURIaIPgka40kMxJbd1J0WdNO5pvpDfHfnR0pHcPOoJmr3Qd9ixn6n8HKGLzWZHWj83nMy2TdMYE1HBTVKnAYX84l3Nn/qw=;5:Mo0s379yaWz7uO2ans85leSyIxmakpfQNWem4X49lV9tuw8Upps6PstIHggY4dQAPOh9xTwwN65A/T/24bVGVgn07O/cxykYkEwzvGblItclna9G0yQDAZiiuoLnHqKI3Z2dNQqf/CAR7WeiTU+HohclHbogDN14mf9//Xpbzj8=;24:GLzP4+X65v45oFnlTH9IhyHetftz3/0z+8o560cHenXIWIlJJozZAU8szNHmIwtQJXJA2ktB+/TNYtthDtEUmdsvGefQHhp9KXJkhKEt5Tw=;7:GbBtTQZfUf3EVkMMl5TMZWFX7Nyu5pn/7PEMeRDs4aenNrjtgFqKJcZ6wQWHCrKbod9Qikqi3IXu2ooQ01xrY57TnfaSC3+/3Gr/UnHwim/aoh4OBGR5WmeKTmQvepHFe5SQgl7rYI0020f2pZAPTQ7w2hmNRcq9LYy8gJrNUo8Z7nj+bYfd1y6FrepcYLphFqJ8u7r1KhwqkXC+AgC0f9pOZoEMjrM0w3RwqeiR4UJsupvn86dGhLd4bgVUOY7v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:TXAwozJHp+fr+J2R3yy6QMdFPH772Fd6CS5Po/cl3xUkGQwyJC+7BG1JT9lQwiZwCSExERz8gHRfftD4hQny4uWQKqS5DMk/1XvbAhN9c7l+obaXv7Anivz6kvifAYiymiUN5EgD8HEoxr+kGhIBKVZqJo6wne+P0r3IxgtHr6DzK0rpsJSv9thz3Elm9Cr5JOGbcXFMvgEn6DFrTm0EjDlKHbW14YFMH7lNnrOzfii5b0cMmtaStdREcev0OMq7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:46.6735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e80076b-e636-4397-ac08-08d57af88d11
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This series adds decoding for the IA32/X64 Common Platform Error Record.

Patch 1 fixes the IA32/X64 Processor Error Section definition to match
the UEFI spec.

Patches 2-8 add the new decoding. The patches incrementally add the
decoding starting from the top-level "Error Section". Hopefully, this
will make reviewing a bit easier compared to one large patch.

The formatting of the field names and options is taken from the UEFI
spec. I tried to keep everything the same to make searching easier.

The patches were written to the UEFI 2.7 spec though the definition of
the IA32/X64 CPER seems to be the same as when it was introduced in
the UEFI 2.1 spec.

Without basic decoding, users will be confused about what these
"Hardware Errors" mean. So I'm requesting this set to be applied to the
stable branches. This set applies to the v4.16. However, patch 2 will
have a conflict on older branches, so I'll send this set again with the
conflict fixed.

Thanks,
Yazen

Yazen Ghannam (8):
  efi: Fix IA32/X64 Processor Error Record definition
  efi: Decode IA32/X64 Processor Error Section
  efi: Decode IA32/X64 Processor Error Info Structure
  efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
  efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
  efi: Decode additional IA32/X64 Bus Check fields
  efi: Decode IA32/X64 MS Check structure
  efi: Decode IA32/X64 Context Info structure

 drivers/firmware/efi/Kconfig    |   5 +
 drivers/firmware/efi/Makefile   |   2 +
 drivers/firmware/efi/cper-x86.c | 371 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     |  10 ++
 include/linux/cper.h            |   4 +-
 5 files changed, 391 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper-x86.c

-- 
2.14.1
