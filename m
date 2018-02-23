Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751814AbeBWRAJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:00:09 -0500
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:59334
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751702AbeBWRAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:00:05 -0500
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Steven Miao <realmz6@gmail.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <jhogan@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, adi-buildroot-devel@lists.sourceforge.net,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 0/3] ARM: Implement MODULE_PLT support in FTRACE
Date: Fri, 23 Feb 2018 17:58:46 +0100
Message-Id: <20180223165849.16388-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To AM4PR07MB1316.eurprd07.prod.outlook.com
 (2a01:111:e400:59ec::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3da3906-0733-4566-f56e-08d57adedf88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7193020);SRVR:AM4PR07MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;3:lCJRsqKdmUOkUNYbiQKHHfAoRh7d9omI+NIg6E9ddSX/ZbPqhTYt4az69nIswRBF2BeiOqgfwSeQZjkKtSlYhYtLOgINr7J5sD9f9XrOzgmVeyFwa+Ww2U2j4rTZGkkvWd6SA4F7eF2N/+Mqz3NiJ9Xq7caUqA5wl3e1WbdZbxc8xOBM5lsJd6d1qOJRbEdpcAIx7ghU2EIfaRX+eB+iUU3/fK88qJkZpykNt45EwmsC+Q8DyqiciWz4ZR4LfolL;25:aoqxQiiBBb0b+WDvDuPcWFZ1CRsy2Wuz6ZriZvGaiB+c9FxC6t+DMm4wOfJkbOREFCscVAoqFNS+Y2T3jEBZ+pO17BXoEAFnkOChyGkupYSjNjehf5mExSb+9g4mYK7GPU/qtFcelhexK4xe4Ve6YMi6RB7MSuO1t1ymOgmBWWivgiSiV9vWJJI4NF40DRgLF9sccwEHzasBFU9rRochqJD9n+jUlzFD5zaQn3w6IB7+fKnGQdVlTkF4yEvmLrJik/J8iSGn1jt/MyMp2K3aEEdBOOnr9Wny79Xs9tKpMPusc2pN5CJQbLe8xH2VDso/atifrhxulp2dxC5JFd1Ogg==;31:6pU54gqoy7y1sxP9PI3zzUIAxMUw/TRHZP1I6MPD3C+dAwFviMpUt18LXNVqxx/rL39fhvuuCIPkYiUoqp8DLRy+ro29k/xEngKNVh3aNPMjItvlijX2S0nLpTo04Z31T/uJlBEHKjW8QVNgAlvDCfqE5CCWhilyJ+ZS6/HzjRyNhs2/xi2/sREeKGDzLqbM3j/JZAPaokjxibql4tQthZ1Zn2ubMK4MKvUhIoUoGr4=
X-MS-TrafficTypeDiagnostic: AM4PR07MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;20:s7NBOGJtnqtheNf/AfSpyzCj9pauB6FlZ2wdRI0kuxb6bvQBRhnMME4XYp5B9Md3GRx7TwAEijaKI04vn7kiKxxzHyPr4e4oErZx7B1d/09bdxfqb7bUh3mEwzwh2Tly2kZ/Gv6TV6S00lOQP2YUc1HWPrlw1oxXY6ScfDAyeCLOSxJV0IFjNnMkJtppHVUvHQqpNDLVVg9N926P/3Ocv/RCGMHByq5SqzRIcy4PnFzS7+UVXXSSHu5KwB70Bo5VFc9obGsJUZBfmSuR1u1NqJQ02fcVo/r5PSv/bmFYXA+yT4OY0+S4Y2CynG7b+xk3l+TVd/kbvpLxONZZX3Nv2qyhwK6FHNnwOqdMCgRDCc/RRR6cvfeKS/mssem21ECwPu524OTMG74NehIK2x9gHbaREbTg/mCJTXBnBpgDR2IqMrwNGqSC2pTEOeqHk/ZGYOetu21swH5BrHblVtuJFQh5wN0eFCFlocfeMWsfaEiZg/uhEE0rCPMkN2QnaWc0iHfGUOkp2M1ckLWIrxbAoYn5r5M1GKVd7H17ruwJaMnLTFNLk7SNwV8hZmfCZI6JQXe+Bq9tm5alEy58tMgzxcDU2cPJA654W0CWXcrL7Fk=;4:0hva2lJrlAx+FkH+LGXmPZ7CnhpCYM1MxQ9QnnGdYt5gBMYxKW0S59gi/4RHoWHj1WLqdWXVc2HKhPcHWft0/tAn2Xy5Kjtlad0OFXnWcpVO+zBYxspwxfKcr61imhv3zp2kh/2HNQNWANBo8fQGpCMLJO6w6fnIxghaoL+7iEXJAXkJWdBaWttRJDMQ6eJGRLCjhtt7SZPcdkGAAjQu779t6M06jNnSBr3fpWUSKze2bU9dPvlsSr7hf67P0u+JoikmDcKqJFAfoWlUSz1Bng==
X-Microsoft-Antispam-PRVS: <AM4PR07MB13160AE3D76DC4DB99568BF488CC0@AM4PR07MB1316.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231192)(11241501184)(806099)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR07MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM4PR07MB1316;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(52116002)(6506007)(386003)(7736002)(305945005)(1076002)(7406005)(7416002)(97736004)(5660300001)(6666003)(6116002)(59450400001)(39060400002)(3846002)(16526019)(186003)(50226002)(105586002)(478600001)(106356001)(81166006)(81156014)(66066001)(6346003)(8936002)(47776003)(68736007)(26005)(8676002)(86362001)(50466002)(4326008)(53936002)(51416003)(25786009)(6486002)(48376002)(54906003)(110136005)(16586007)(6512007)(316002)(2906002)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR07MB1316;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR07MB1316;23:05ee31kxdzWZC8FYuHejF2q+ZA4D2uGqTdqBNq8yK?=
 =?us-ascii?Q?/kTu6xhZWyu5H2QMMdxCGcE9SD/CHxm6tjvAP2hmvwpX2Q3yaZo/4wJq4+yZ?=
 =?us-ascii?Q?laHrAVsw6hXOohjmsCQyle9dJddB0AS79fj2InGAoSoCvG35p/BAGkRLuE8/?=
 =?us-ascii?Q?jeylji3WugqShnRhNmdrUSwgLeVc5PLzlOXvKRttgjiyZ00EW/Ya/Z+eMrRG?=
 =?us-ascii?Q?clr0R7KSNPiGNF9Deh/HioQLGaIthpPGwpLnKFSKeSveyWbNe4zIN7byGsKn?=
 =?us-ascii?Q?P2Rk++7RtYp37HtT1qLexjJQRb4xfbBcyj4CulJE75H6HTk9UxHZ8SKyv5I+?=
 =?us-ascii?Q?qbPKN4Muts1u1TEYQ3SeYvElkirQbnVsxKnGXrrmnjINGqmuB6wYBJCbnW8A?=
 =?us-ascii?Q?6wYu3U2S5VXSc5i1CHhlsYDzZWbpU6Zt+GMS8NsP1rLG4deIvn9G54OFZNgw?=
 =?us-ascii?Q?NbcPcp5BMQPnTMTPr8Af+BdJnY8mjb+8JwIUulGregF/WXStj3XDQmajEWE1?=
 =?us-ascii?Q?RoFrLG4a+93L5xAqmtgjqZtn24R9tOCPaVZkXAgPAPwvjw1BO2AO06rkXtyM?=
 =?us-ascii?Q?lvSfA+fBo0Tcj1YuEUtuFcTIRe68QrWj/ydoD3Y2WHvDEdEHt7eMYdxHhUK7?=
 =?us-ascii?Q?SBn06aco6FqwcbC8y03A5gd0m7PWEdO/mqFprJOEDseSdu9cq2XyiqOmKKr8?=
 =?us-ascii?Q?ZyiUDJDvHsW3J7NJpQZg8ig5l+JZYAnJdgU1opR1qendMPBZUXgdLH2xLJCd?=
 =?us-ascii?Q?YTxYZjIoDFFOyZyt2UkxvApM8uhVdRlvGpgmExiOK56oMtqfzq/HI0NUaMFZ?=
 =?us-ascii?Q?VYjvycPKbx+zQjI+YhzfQEG422nQAIm7gWyD4LF3SbVJobn+Qv64zJh84XSP?=
 =?us-ascii?Q?0e0azePNFD44KjOILFMDqyAenHTVg+fssORGkuM6YPvdjbJIbZ52onhGyyYr?=
 =?us-ascii?Q?4+Fqq9N6eUs/gsU7w3nDuhRoHNk2BLxzGr9/KyBhlh3XB6i/TGtj4J/6Bv3w?=
 =?us-ascii?Q?CNB8WbjusVuahNUhmI2GH6YvUQBE1nbLlIcT3ijEJn3j4WaWZ4BwnWZhfEwP?=
 =?us-ascii?Q?qNNBsIAwaov50KzvMNRw3ydnTlZhFEtyJ2tGU5hh+Wn+/3ndMAWRBe4PnKkn?=
 =?us-ascii?Q?3+Rq/GqmhjJCWA+YiDGm/6EdlCmN8jeVpPePHRHxL8Sz2F2ThImpk40DTC7X?=
 =?us-ascii?Q?UGuIsCUsYiQQTUSNNGAQdMGdqo5T6NYoXqy?=
X-Microsoft-Antispam-Message-Info: HTEuVGXeHpptlvc+X9pW8RB6pIgpOZGhNhvZDP4olQeIzw01rzDe0K8ef4bvg2n9pFBdDeNn1PUhKF/LnPwkmA==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR07MB1316;6:4BMfKODXSKG3vIeZHEevsTgA05tU0APq+Q6K59C96TAiS9GKwH2FVy4cjxWHxPP+K6WICb767XSYv8m8QukbU45yaUUYnyT7wY61aWzwkDaoa/vpdim2cyxUwThyo3F18yJLrUFUh+8oPeTzYt9jFV8jWsaZ9GoiNWbeeVMxIieMOzt2Yryb3ux1YRFDytDTBPImBFA3Vr5JNNenArs9qgA2YRuxRoLvENf/ibOtmFd/ElQ5J6IhUHWfipihNUJfR3NnDBUybwy4BfEIPYrCD/a/yulakqhz8/XWdqr1O83V1HN8qjJDpLy1Ci2E7I+7yJw7FskbwK2NSRoMXHZNSO052VRmoEZIHUOS/yR8Wjw=;5:tlr9cwmYoTj6t0zg8friIQRNN+CJl9O5n0L4+LYzjfPNEWj2m22T1uIFwgqWUjM4N8iy6wutvGFV05mgLBuNoGanAe+lewPfUW1AXZZTr7soB0vXS5svJbwR4I98ahlHnT2kbfdjpEikMKTFmIGY0ONSUdDqpp/dRhWz1eOVulY=;24:chXpVOtkaXKwe/0y3IkPlUaE8ZPhwRwYnE3XTevfyFTrCIrCSGr8QuQKkI7GnvfTTsyrFZfZQV73rdLgw2XvAO/uxbU89eFcTy6Ue3Rymf0=;7:8WFigYwJk07JZ7ASCQN6sFa2pRE1NyG3/rUyq5dNEZau9C2Wn2+2/UaEe8kK/FOPz/HH5NpSuih6FFCElJwoZ8Of8xwa5UG5fQoqvxZR+m5pw01VUJVqCxqNWwSDJL1dYtwWdCb3ecRbZT0YHyWoSN3r1j7QapF8Au7C5N7/JgPflLej1Zjxd0kkGZauUKmXdjj59SmT+A5v6sOePdb7y4wP/wPTHpFXkfnrZmQP0B3G1OgMPOcFuhvHRp49rpYF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 16:59:55.9257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3da3906-0733-4566-f56e-08d57adedf88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB1316
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Alexander Sverdlin (3):
  ftrace: Add module to ftrace_make_call() parameters
  ARM: PLT: Move struct plt_entries definition to header
  ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/module.h      | 10 ++++++
 arch/arm/kernel/ftrace.c           | 73 ++++++++++++++++++++++++++++++++------
 arch/arm/kernel/module-plts.c      | 58 +++++++++++++++++++-----------
 arch/arm64/kernel/ftrace.c         |  3 +-
 arch/blackfin/kernel/ftrace.c      |  3 +-
 arch/ia64/kernel/ftrace.c          |  3 +-
 arch/metag/kernel/ftrace.c         |  3 +-
 arch/microblaze/kernel/ftrace.c    |  3 +-
 arch/mips/kernel/ftrace.c          |  3 +-
 arch/powerpc/kernel/trace/ftrace.c |  3 +-
 arch/s390/kernel/ftrace.c          |  3 +-
 arch/sh/kernel/ftrace.c            |  3 +-
 arch/sparc/kernel/ftrace.c         |  3 +-
 arch/tile/kernel/ftrace.c          |  3 +-
 arch/x86/kernel/ftrace.c           |  3 +-
 include/linux/ftrace.h             |  4 ++-
 kernel/trace/ftrace.c              |  6 ++--
 17 files changed, 140 insertions(+), 47 deletions(-)

-- 
2.4.6
