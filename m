Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeBLTst (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:48:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752320AbeBLTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:48:43 -0500
Date: Mon, 12 Feb 2018 11:48:15 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH 02/14] x86/crypto: aesni: Macro-ify func save/restore
Message-ID: <20180212194815.GA60401@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: SN4PR0501CA0130.namprd05.prod.outlook.com (10.167.128.47)
 To MWHPR15MB1759.namprd15.prod.outlook.com (10.174.255.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a152a7-abdc-4423-140d-08d572519207
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1759;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;3:erWwjhYsS37qVaeKMpMbHlROj8bpiS7bOPNvVJOSBIUDyRj+ucZlnGj3EEJLLtmZgs2fyUrHI6VQ4cUyGDoofXpgaVvAYgok26CwEMfkHshugX6pDj82xHY80xpedggGvI/Y8WVO0pCXC0wvABbglPPBWjLfGv6/fq4JlRkoXu8FQ5Nwm9SyTA66QfLXQzyZW/Uvl5obFKIOJ7GBGYmTTA07SOlicr/rWr/CCDS6wV82Rx7tZDhlOvctwJIjX+S5;25:z4YVXMTY/3eRBMT6gzaZN0zwhT5pmicRnr8e9loGjS/mVQAAkp2HQdf/zQdBHmjiArcZosPO/gWLHUNj7Mx6786nFzdPckAsMb9AqTShX9zFPKRialD3YJtpXbJ9pzFHipeyakA+1p72UDvrezsg+2U9ul77EXIJF7bG87jBqJ2uT3TDalz8XJ99u9pXGzC/0JcFSdzZkegrag+u0hAFYW3WsOJ/o9GTAzEpE/+I3pxgRsETJ20+8huN9QG0qnaYaFn6i7xPK3ndBg9w32HeLxrNmLe5HJguhgmkGcir4f9x1MFIj9yOi1p/7zejge+YCjN8wYtR6QHAq+b+btL/qQ==;31:cIGMWnlJ9xFV5/PVpPsyq4qXJ+E4An2BPiAQaHuYHwvjG+mVAIJ1vS9vgmiXxJs60KZp4oHoi/MKmkYzOn6BvhqzLZi71opS2Tz/PZ0SOjEQq1cAJCUWou7Zt5k27lNOrIYH2oIiyxTqdQ0YBfwkJuHbNFnjz7btJxOLli21V4L96eBFE5buuyfEQIkpbMGuRtTbZfwO+73wv4mZe/KCKMsyTheZTohNS3IUyrY8gRY=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1759:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:TYQyC9GTXaQx8bZtelsVSI7g4tjp3RIIGogAtL9aifAuSFeMMqbmcTMscyn3yKRqwjqhRBfrVzqc8yLbWTeUTpfYJGZ3DftxsUmyXk7lcePMT22oneoHsbLqxFHHZ8+bqPyi2W36OwqPHkkQX2kRFCo3CYWVYMt9iuxIWO4hW+ufwXXQEIfR+oplvEKpL5had3/dcJdgC33XuJ1d/jHHDIMRsFt7p9t2JgQtG7DQekde/8eNd5hkhyISWrymgwzaOLJvPq1DupKCEzrCtczs5phTfqJuxErpz/0tFnW62ZmiyM22HPA2NaUerFCqJ8lSQhbU0GTr2q/0YZt1qeyNnfPQ/H1pEjZwGj7uqv63Stn2GJCX2Goh9n5PPz80+g2sck8ESVv253neGkdUhvQqb0CtzO2MkrAjOMWF7xTKdNL99b7A89B4a2mtkBRAy4qkEeVlVOvssearQdss02msUD4SaVWtuOSDPRycdsPcAo1/Nm8mYly7Mv1abpaS7ULW;4:aSDSVn1jRDAxUKGm+PbW39xTF0P5nlvHcToqlSxFd7sITipSxZ5ylEl3YtWx6Zo4uUtwer875lzkb803zOvEUKEgj0eJkoJxhpR6z8ZJDCa6iTMphkIEFiw8Bk8m9mdK630dr1nzvue002M+ZaDM2dUGq3cUsCjHj+LNGMR02chxfVrrVRwg+CbU5b5ER614+AmShbQTSDfZvrAeyh/C5ZIq+QRBdntoUkLMR0z2o0b5Gc2uguicdCV5+LTMgR/E/g1uDSbwwFpc3nZci7aswSGX6L1GLcpulOc9zVBiksIyTO1qooZJNxr2uih/sjkyDuUvhIL1Tc++4OLFcYUsvqDrLUpjZtWTFTKepREmnlo=
X-Microsoft-Antispam-PRVS: <MWHPR15MB17597E5E04720848211F90ACDDF70@MWHPR15MB1759.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231101)(11241501184)(2400082)(944501161)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR15MB1759;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1759;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(6496006)(25786009)(4326008)(59450400001)(50466002)(1076002)(7416002)(52116002)(52396003)(8936002)(76506005)(98436002)(83506002)(316002)(33656002)(386003)(68736007)(2906002)(6666003)(86362001)(16586007)(105586002)(2950100002)(76176011)(110136005)(47776003)(58126008)(53936002)(33896004)(106356001)(7736002)(81166006)(478600001)(8676002)(6116002)(16526019)(186003)(81156014)(305945005)(23726003)(97736004)(5660300001)(54906003)(6346003)(9686003)(6486002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1759;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1759;23:65+BQRCG8bYWl8Jhu4PlWZrs8bZaPI+1TLzAdxN8O?=
 =?us-ascii?Q?ItoBcrTjHgS49OCNi86H/5wE2CwgtGzYulmSlXBAdRbofrhaFrBHPmyZjHtM?=
 =?us-ascii?Q?AXiuDDGBiIbWiYBIETdTN1f9+gDdAT69PX5djDUxMhuSM2Iw0Ep2pUbYMGmU?=
 =?us-ascii?Q?jD5C8P13TeOZnjXd2lJAn+biGsGN088I4IWbts7r1K5XVbIeidz48lX/7UIg?=
 =?us-ascii?Q?/Mvkmyet+RMeVzQ4LMYvNwpYg/b0t12j0mVVYMpXaI/fLk8QxxOUU8YOOFEp?=
 =?us-ascii?Q?rZlH6U0UmZ0t4UGN7v7qIgvE3dK87bli5S4SOJCASXcspceoJV/qmNJfa06L?=
 =?us-ascii?Q?FnXSWfl2JvN3DLHJ1/LQHCoIGDhWNLWy3zFzjVpr1c1yqdbiE5qCid3XXUMs?=
 =?us-ascii?Q?qIwFmz085VUaLJbe5zU4M7+LD6izP6w+cLaC+QPWbjT5mKd5br6lG0i+UXLw?=
 =?us-ascii?Q?EIrxzbAQcvcQGQoWUZC+Nk/c+PlVBLTiOqKg2RiMu95ap7PEPUFDjqOgEJ3p?=
 =?us-ascii?Q?upcpyn/YWBgqVHXE3DjEsnvD2ZXY3zOOHkGyv9zyLCsmbRDdSIxihM3roICg?=
 =?us-ascii?Q?a02/uHKFxgaa6YCF1KjxttAkQEo52XfeNgoBVx/BwEO7JyadrwMPiHQh6wM2?=
 =?us-ascii?Q?g4Opjq3WTAPD0VJPw/bh17oSXSbYAZnic607SUzc5Y1ff8lY5sdChL+IZD1M?=
 =?us-ascii?Q?PQLDUmwVfC2SSzGJkq3TW5VIE17X3F7uc4HXjKTxivKJIt2Gq789CFwJr349?=
 =?us-ascii?Q?JVPia27V5hFPX1CWPjYXExEXji7N3ZRqmLOskk/6CEBqHTYEjqlJq3hyOElg?=
 =?us-ascii?Q?rUwB4oMhZZ6DbigPGc8K5tEMF6ll9RnO1dHQvVocvJulZjNiZd+VbuGNlBce?=
 =?us-ascii?Q?2U8AaScAW+Gk+iGnEmy7RVN7+DlhMg8931mShoCyqqJO9CKzhyPoC8yVOI38?=
 =?us-ascii?Q?j7in/CWmCBfm8P0mvlfFueNyantHavTkBfVBpMGjhWbXH2goB7nch/Se/hP1?=
 =?us-ascii?Q?VJ5eEZw70E8It/sB9JPeE8ejK7+fVaoAffMj+j0SoZ5v5i9M15x4NSsksGcE?=
 =?us-ascii?Q?A7UfNcvu19r9mWDuJ2YlbPlVyfAhoHcuPOVMjFIUsBDqPMPA6AtU1TS/himP?=
 =?us-ascii?Q?85nkDUIk5i7T9kLdUAZltC+zdQGvZH6GyrIUY+qqxmW6Hnxn2bTpC5JjyBmb?=
 =?us-ascii?Q?bPkdtx6TKwNpqhrDjuhXi6oDL0lfwBB1LSmfVM8h+Ixs3CG2ZrfNKAx3aJlY?=
 =?us-ascii?Q?obZfXzujuQlWuTP9r2nAuea2nV6wg91WZBbN/anBkzIMic2KHl8ghGScGC7g?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;6:hjCyq7HPwioImqoNcSn6bkFgudf6dckU9shT9zLBQznus9p1n9g9htj5vU6TKOLtU0Sv6pG//7C85ZmLCx+ZuHlYUzosOybIAGMiBoBnyp9sxCPoGSyjHIK8c3IXjZbnqQqLpPzNrTFOMHQgI/Ls2IsEEx653bcB+0FQTsfur8eUqG+zWDxvQZWJGWSB0VxCfeP+FFdWG4NtLxBqSWfAt7B5Dv0hBMoOVoMzzXElevbjhRwLh5UY8V4UQDw8kiY8JZktKNtcf77SCFIBdgV654HELDDv6TbfpApm4D61mCFMbO47jt+JsN6JTS1a47EvYtckNwUtZ31zvxr/ati2PiGv7Ti9R81awx/aEFAA8Yk=;5:E21/yQJBFiq4oj6xMqdokw2d8VOIDee56bn0TysdNBUlibtScSSOgUninbIrgRxfdfzKprbkCAduK3cZ/DXmnG7KHjHTr2pJOHf2PWm11dqO4gVNFQdBJCuYk6EqQu4OAGz6Lk2V4dlXTjn12XeYdiUbY1A5i/ojskt36KCr5WA=;24:HJhq+vzJGhZ7xzmhMj770SrgXDKherSq7vYpktLcBar6kQIZPVtTy2iQuR5eiFcy7qcY35FAdlG1m3c87NSBETLWUpqAW80zmtku1NeeaK8=;7:qugr4gJTVmi0LztahVxfKkAE/mezc7fSPTuOtYWB8h8SYJ7pgrHfTVnT2fiyEbJQLk6sJP+LR12FXMuGoHc6FlKBqgC7HBffcTNcrUHS6tI85Z8hqpKwdnP6tCSMQIQQ1npbMwqB5yPwzPak4shCGjbft1AnHU1nM5NmZ1MY5KuSZYTX3UVAoZc6dUOvpcBEUrGnr539ilJgEb9b57SX0jI6N3pgS8n6Yoar+1+cynfMLGYzjOe77FtgXCIskczs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1759;20:LSkWByKuBFrpOcHW9MzLP7Xhls4b8Db8+yoK+zUuQ4L0tHSEaAOguEHOdwOjvUiY5DMDbmgfA14K5MK8KiGJPo9JI1bosxlCu0D+kIh3zPp2SWBYYu13z65RlEu1jh6YxRgCS3DNMyV1YjKvbuUl7/fojVljQOtXZR52y9BGYxc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:48:20.8304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a152a7-abdc-4423-140d-08d572519207
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1759
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro-ify function save and restore.  These will be used in new functions
added for scatter/gather update operations.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 53 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 48911fe..39b42b1 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -170,6 +170,26 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define TKEYP	T1
 #endif
 
+.macro FUNC_SAVE
+	push	%r12
+	push	%r13
+	push	%r14
+	mov	%rsp, %r14
+#
+# states of %xmm registers %xmm6:%xmm15 not saved
+# all %xmm registers are clobbered
+#
+	sub	$VARIABLE_OFFSET, %rsp
+	and	$~63, %rsp
+.endm
+
+
+.macro FUNC_RESTORE
+	mov	%r14, %rsp
+	pop	%r14
+	pop	%r13
+	pop	%r12
+.endm
 
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -1130,16 +1150,7 @@ _esb_loop_\@:
 *
 *****************************************************************************/
 ENTRY(aesni_gcm_dec)
-	push	%r12
-	push	%r13
-	push	%r14
-	mov	%rsp, %r14
-/*
-* states of %xmm registers %xmm6:%xmm15 not saved
-* all %xmm registers are clobbered
-*/
-	sub	$VARIABLE_OFFSET, %rsp
-	and	$~63, %rsp                        # align rsp to 64 bytes
+	FUNC_SAVE
 	mov	%arg6, %r12
 	movdqu	(%r12), %xmm13			  # %xmm13 = HashKey
         movdqa  SHUF_MASK(%rip), %xmm2
@@ -1309,10 +1320,7 @@ _T_1_decrypt:
 _T_16_decrypt:
 	movdqu	%xmm0, (%r10)
 _return_T_done_decrypt:
-	mov	%r14, %rsp
-	pop	%r14
-	pop	%r13
-	pop	%r12
+	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec)
 
@@ -1393,22 +1401,12 @@ ENDPROC(aesni_gcm_dec)
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 ***************************************************************************/
 ENTRY(aesni_gcm_enc)
-	push	%r12
-	push	%r13
-	push	%r14
-	mov	%rsp, %r14
-#
-# states of %xmm registers %xmm6:%xmm15 not saved
-# all %xmm registers are clobbered
-#
-	sub	$VARIABLE_OFFSET, %rsp
-	and	$~63, %rsp
+	FUNC_SAVE
 	mov	%arg6, %r12
 	movdqu	(%r12), %xmm13
         movdqa  SHUF_MASK(%rip), %xmm2
 	PSHUFB_XMM %xmm2, %xmm13
 
-
 # precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
 
 	movdqa	%xmm13, %xmm2
@@ -1576,10 +1574,7 @@ _T_1_encrypt:
 _T_16_encrypt:
 	movdqu	%xmm0, (%r10)
 _return_T_done_encrypt:
-	mov	%r14, %rsp
-	pop	%r14
-	pop	%r13
-	pop	%r12
+	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc)
 
-- 
2.9.5
