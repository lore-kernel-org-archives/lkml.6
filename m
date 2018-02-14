Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161331AbeBNRj3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:39:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55750 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161296AbeBNRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:39:19 -0500
Date: Wed, 14 Feb 2018 09:38:45 -0800
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
Subject: [PATCH v2 03/14] x86/crypto: aesni: Add GCM_INIT macro
Message-ID: <20180214173845.GA61871@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: CO2PR06CA0054.namprd06.prod.outlook.com (10.165.93.12) To
 MWHPR15MB1758.namprd15.prod.outlook.com (10.174.255.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fa9f206-f091-47fe-4bea-08d573d1d004
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1758;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;3:HUcdx/rxjTiLW5uz/0gdd4HCy7GLfARriV7zbbCh8lm+MvAp5M4sXYr49Drsm10BSYeTee4Ofi8t7YAnwnj4k/v9YAVJS5iPtTcpZ/3l1cDHdu2fiXlkQu83w9z1XkL7EopEPIdvGGNnw9OSfXI4TuL/SSWjvHft1GY3UoBgI8tMGyzmqEP9Z8c+BFsXIg4FlIJv7evRYaWWUbGWHSDM9ec59so9Zx8X7L4ju0jU5BCeTqWzlUzUVBk76H227f/y;25:XcxWfJtL0ehy/jjgSOgWqDyTVxPWJOPnwPbDIeCw45Nb4ih4b3k2IYqJ27mVvRh35uAauSQdeL8TzSeujRNOusavd5NRknEZVRcY4VC+8eXySXThQzB0+Toz3oCumI+L9IRpnq13jUw+C4cK9qB+jO2ORKLL/u3/RLwgoRQywLxnYiBeDHF4FnAKClvMMbr/77S/dXEJrinRWyYRiq5gxoyOQ7g4Dof9bLE76XqF+0TCMx8PPv3p3I25ShA82driIo9iV5YDfoI4l21cz7wMIq0oLf+Nyfg7VLTnxNlcMpn+S+hW5kbO38QDwvsYVaxgPdVrZ2j9lDLEGqph+dxkxg==;31:AvFOx5rVo3ZiNUm5ge6ir/LJi3nxYGR/vDf+5rsDPJzC13hahy7nWB0bb+i8tjEOIEtIz3YR17MudH5x4n19WZPHCgAnYQVLEK1u+M6AyrjqZrqne7q+sVZS6GTxqBNmnDCRBtypDvTZt7t4nvjxodQQQhVnDEKoFepCLytZGa1mx4YOQSNCEqDeVtw4wuK1MqXcgT+PN8PyDz6esSqashZnEwOsElXNkwfO3zhor90=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1758:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;20:A9ql/9p0078CJeCUNChCI6SBPmiiOftlBcxdn7ZEl7v6kMY3fXxc7LZCQNLfxmBPuLYVwdwGTYKFPwDKdI34U9g3t76BNwhYw6hW9x8Qr+4SGMVWlRjBfJcr48t3dXldN5ZIyFN6wZxbtK/Ac0MeyKAdDN9pP9L97LzJVS0bZF8SWF8bt0k6AqmvycL9wDMAYTKD8jIDxULn+qzNmmMwfVjWWRfi29W5hT0bs2rsGiiiDHMUsq85ZZBvhFLdhld7sp3GrWSBIR00BSHV283tAqrcpM/Dywh9m5+R9X1f2mvDZzk+PYBZRVO25pU/IG8bPTf7rw+kWtyeq6U9pWM0tmZ6SaJHLN9lM1+j7B4DMah1aoswWg2aDB2q0u8gDJbH+dtYChZdgxO8OSl4v/joTHeekuSimfNXTPdBUztSwRXLF0i7/MpSgDDGUfwYCPkm9DFDif5ajGwGE6b6090wMHBCkDqA4lzct7f+Ss+jICSZm1P2jT5ZUGNijtkr2ZfS;4:ZwSj9atpXDy0g8dKhMlb7hzxdED6shj+Z67RNuZYxmtv06393bqeyIzhSSPXApXWnV3nTIcMo/gEsE9OXIDTR9uWiHwFRU0bkWxxWTrBY98J2kJzh5atrBt9PyWhSa6E8I0qfZrWs4PsHvixD8rXLp4rEC8PqUS9expC45NE/GuvoG6zvp1L2/dFfJ9n/zjhLcCgCEF4OmKPCne8IHKbuE1jKWPElUdFtpuBUTSSgZBGt1GyeS2NZCmPUvKMt34/5X3/kapBOdkXVyRd/P1/X29Ef3uQMsQH88EzVdvxvGLRrklJv84JZuySb3/414D00PzP5jJ6q9A6SdktzxR2uj6XQoiFhqc00VjxPIN5L5Q=
X-Microsoft-Antispam-PRVS: <MWHPR15MB17588C7D4E5A1FC8D1929CFFDDF50@MWHPR15MB1758.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR15MB1758;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1758;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(199004)(189003)(305945005)(52396003)(47776003)(81156014)(16526019)(8676002)(50466002)(6496006)(52116002)(9686003)(6116002)(53936002)(106356001)(83506002)(54906003)(105586002)(7416002)(316002)(478600001)(33656002)(16586007)(110136005)(58126008)(76176011)(33896004)(81166006)(7736002)(1076002)(8936002)(386003)(186003)(33716001)(86362001)(6486002)(2906002)(97736004)(25786009)(5660300001)(6666003)(76506005)(4326008)(23726003)(2950100002)(68736007)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1758;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1758;23:Jzgy6pCdndFuCAlFM36J+XReemtvWsFbPQe4XQDpl?=
 =?us-ascii?Q?+1pib8tDpwGXiNWfqYPGUUwnCVygDqK9ubUKVzxNQ/CA78l1fNdPUk0mFi2K?=
 =?us-ascii?Q?jtEcRlgcLTVyLh9wT5apVWh8irH+n0GcuCrxin/YEw3vV0VrWIdIxEC57Zdx?=
 =?us-ascii?Q?ewEyFzlq2w0NF2CyZ+443XgkjkfeH/gaJXTPajduAzaSctgOcf2/TODGm2AC?=
 =?us-ascii?Q?0Bu90dMID55m4KCgpDFGEZcwfqS35EKrqsPG6NbNDCI+rEWRWLaan+Z6sVbQ?=
 =?us-ascii?Q?a5HZblvinK1gqJkPq9jSlTaeq8TdiI2GIcCdXn028EsIiY8JEtnD4wiOxe9O?=
 =?us-ascii?Q?UNKOPD1cL5T5231aJ+osP/qlyR6weM/u1IZtXgWw94jehVwBwWm1DtLFMKjh?=
 =?us-ascii?Q?8qU7DpMeI7WzUb3sAS1isUdNWGR+WQAKVVvbkrfCQUtAOGq+9MlPAIKoDZxa?=
 =?us-ascii?Q?B9GWMAJ9PV2xgZJJnul34p2ZXvE4elMFXRrLJbKerqZqRN7R4nn6DiC0PvOw?=
 =?us-ascii?Q?Uvy+2DA2QiH8jZHJyybTv2ZIZkBr1kKZ/KxsgwIsV9eOQYrbt9kXqirbxwu6?=
 =?us-ascii?Q?Hs2y9S06eLOGYpbUjHarmsyYk1P2aFyKTdi4dT1WTLmz/BU/eIaj8Fn9o1Cr?=
 =?us-ascii?Q?y/c8iVRyGTUjXQlNig8FKkU0BKC+EOqu0hgVZqWWuU569jAW/I+aIm/Nwz9o?=
 =?us-ascii?Q?4c3NeqVF8hLEGIKukCMYipR7wMb5XendNUlj8AdVJdhtpM6MihcDMK9WdZ/9?=
 =?us-ascii?Q?3any6ZnA+tAwsndovpidhzZrDs5K+yesjNEm2tamGI7pEIftg6vRzesytnHx?=
 =?us-ascii?Q?48+kqUGR3kflwEvkKxW/Cq7vYJlzyvytsCqPssV5f58frv8wz2Cdj+KCsAup?=
 =?us-ascii?Q?SmBRNw8Ys9graRGDpDPxTGO+UJF5wlkodwBgUFH62RW31Lte9gbkn/5ll6d+?=
 =?us-ascii?Q?BbkxsJ9WDUOjR4wKtKt2cmC3ZdwbpMHGfqWErnvFPdx6AqMgkG54Sy/nCrX7?=
 =?us-ascii?Q?P0du8W6zKvYwsInIf5qAeqiDmTfBJglYhuVTxvnZt9JPBerHRAmtya4oQ8/5?=
 =?us-ascii?Q?ktiGeNB4gB4Lml3WtJ4S3i1ewyU2wO5nK4oXW8WJlZ1dZj3mz14uRCQrPPKk?=
 =?us-ascii?Q?5Ivp5WAwY4Jru0VLvbA3+fziNQO8oUqICbl4huCd8uge6vc9Lqc7WY+Q2pAh?=
 =?us-ascii?Q?UDjw3ZwAhXgeJJGJNm2UPTDTs/hHnhLOTmizmdo5pqTf2cIUztN8whl4+pMR?=
 =?us-ascii?Q?9L9K31/Vq63c9CTIsQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;6:RZpaMno8IkAJVtIao1aKCgmkXJZyMo7Zws5EUJthh2n03Yr1Yvp8OF35peSN1/DtQCLPw2djNejx7pHXhe1/5IqINWMCuwABBGFjMMppr9CJPolnwmQBwPXbZKAOpqPT1Oio6/DcfnRxfIBlHFLCCFpz3WSEvTsBRDjljnC4PaYDb5pPEH+TFHr5NVrUeHTKAEKTH0Zlgn86FAkZ5lG1Ag1CQvV/kc49XrbBe1Q4O+ZxlrzxKeFIJfCBwc9G8eZZs4X6fPloCa0F51Fiv+svyAgbct+n5+LEmnwVavNWd2X5Yp7MSYMXLUzwtZq9Hl/P6PT/QoN84XjYb7ULuJmEguTMDu4OTixxxNXXs1cBkAo=;5:8QDHtniD2HIPmYW502aIyMr+ZF2h0ah+tgDGhVeNS3/F7ALVZORsB1QHMq/c2Q540jCiheV/UxSXI0IREdj5AoV3iLov3e3+EIih+n/kR195Jwsf73G+8bazmNwiO7mBT0xcdPv2OTfD0SqS/z2N2Cn53rd1JJmo7Hq4B1XD4sk=;24:JlzwIQXwIc++EKlBBLLy9R998wV+dcukOX9y43cZXNSAWRDM+GUG19jEEgEkRmLkps47+SurgiQGUjYqwPuU+/2v2dW2R8W/jXcNd8G53RI=;7:ukkRloHZPv0/aMyHqwhb9hWz+AGlDJ3+sCXr0UohKumo+D7/GJ69YCe8nVOwZWkL2HuAzQWCcCPyc27322E10TZKcE9X+xtGlKjZKCr4AL75YTy46Sqsl9YT8871xL/Vl8nNRmqsWyxdabLz9mIfca+DdJbXEPQwE4r/2M0AnYWkEAIJk681qnWy0l3JR19YK18CeOYmJ3YeB10my/cLqHoL+Kgmx5FmT9U9CflSqtbJT4nvOW51/F2ehozPbHip
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;20:OYppi0640TVCLqrDjdTcijnfCQujPVkP+ZVAt+8i0w78VVXC06V3cAfgjF1n+SI5Wq564tFr1jIaRlnKERPEN3Vx/LudXyni9sJk5YSKAojrkwsOmO7RXhZVP+WnQFKpbymU7MyBRjHrsa0d9KqbMl6DFgyeWEPcFcTas3AbU6I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:38:51.7157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa9f206-f091-47fe-4bea-08d573d1d004
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication by introducting GCM_INIT macro.  This macro
will also be exposed as a function for implementing scatter/gather
support, since INIT only needs to be called once for the full
operation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 84 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 39b42b1..b9fe2ab 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -191,6 +191,37 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	pop	%r12
 .endm
 
+
+# GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
+# Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
+.macro GCM_INIT
+	mov	%arg6, %r12
+	movdqu	(%r12), %xmm13
+	movdqa  SHUF_MASK(%rip), %xmm2
+	PSHUFB_XMM %xmm2, %xmm13
+
+	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
+
+	movdqa	%xmm13, %xmm2
+	psllq	$1, %xmm13
+	psrlq	$63, %xmm2
+	movdqa	%xmm2, %xmm1
+	pslldq	$8, %xmm2
+	psrldq	$8, %xmm1
+	por	%xmm2, %xmm13
+
+	# reduce HashKey<<1
+
+	pshufd	$0x24, %xmm1, %xmm2
+	pcmpeqd TWOONE(%rip), %xmm2
+	pand	POLY(%rip), %xmm2
+	pxor	%xmm2, %xmm13
+	movdqa	%xmm13, HashKey(%rsp)
+	mov	%arg4, %r13			# %xmm13 holds HashKey<<1 (mod poly)
+	and	$-16, %r13
+	mov	%r13, %r12
+.endm
+
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
 *
@@ -1151,36 +1182,11 @@ _esb_loop_\@:
 *****************************************************************************/
 ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
-	mov	%arg6, %r12
-	movdqu	(%r12), %xmm13			  # %xmm13 = HashKey
-        movdqa  SHUF_MASK(%rip), %xmm2
-	PSHUFB_XMM %xmm2, %xmm13
-
-
-# Precompute HashKey<<1 (mod poly) from the hash key (required for GHASH)
-
-	movdqa	%xmm13, %xmm2
-	psllq	$1, %xmm13
-	psrlq	$63, %xmm2
-	movdqa	%xmm2, %xmm1
-	pslldq	$8, %xmm2
-	psrldq	$8, %xmm1
-	por	%xmm2, %xmm13
-
-        # Reduction
-
-	pshufd	$0x24, %xmm1, %xmm2
-	pcmpeqd TWOONE(%rip), %xmm2
-	pand	POLY(%rip), %xmm2
-	pxor	%xmm2, %xmm13     # %xmm13 holds the HashKey<<1 (mod poly)
 
+	GCM_INIT
 
         # Decrypt first few blocks
 
-	movdqa %xmm13, HashKey(%rsp)           # store HashKey<<1 (mod poly)
-	mov %arg4, %r13    # save the number of bytes of plaintext/ciphertext
-	and $-16, %r13                      # %r13 = %r13 - (%r13 mod 16)
-	mov %r13, %r12
 	and $(3<<4), %r12
 	jz _initial_num_blocks_is_0_decrypt
 	cmp $(2<<4), %r12
@@ -1402,32 +1408,8 @@ ENDPROC(aesni_gcm_dec)
 ***************************************************************************/
 ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
-	mov	%arg6, %r12
-	movdqu	(%r12), %xmm13
-        movdqa  SHUF_MASK(%rip), %xmm2
-	PSHUFB_XMM %xmm2, %xmm13
-
-# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
-
-	movdqa	%xmm13, %xmm2
-	psllq	$1, %xmm13
-	psrlq	$63, %xmm2
-	movdqa	%xmm2, %xmm1
-	pslldq	$8, %xmm2
-	psrldq	$8, %xmm1
-	por	%xmm2, %xmm13
-
-        # reduce HashKey<<1
-
-	pshufd	$0x24, %xmm1, %xmm2
-	pcmpeqd TWOONE(%rip), %xmm2
-	pand	POLY(%rip), %xmm2
-	pxor	%xmm2, %xmm13
-	movdqa	%xmm13, HashKey(%rsp)
-	mov	%arg4, %r13            # %xmm13 holds HashKey<<1 (mod poly)
-	and	$-16, %r13
-	mov	%r13, %r12
 
+	GCM_INIT
         # Encrypt first few blocks
 
 	and	$(3<<4), %r12
-- 
2.9.5
