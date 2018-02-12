Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeBLTtU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:49:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60844 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932252AbeBLTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:49:15 -0500
Date: Mon, 12 Feb 2018 11:48:48 -0800
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
Subject: [PATCH 04/14] x86/crypto: aesni: Add GCM_COMPLETE macro
Message-ID: <20180212194848.GA60699@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: BN6PR22CA0041.namprd22.prod.outlook.com (10.173.23.27) To
 DM5PR15MB1754.namprd15.prod.outlook.com (10.174.246.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dfdd164-45fd-4e26-4dc3-08d57251a53b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1754;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1754;3:6daNKHPtl3JPExh/upsdE1BumUJ2+jiL57PH72+7vfs6nvLxR6F5DiDp3ylgYjnDTl8SN46zqtYE87AFy5UF0hmrwVjMmJUlZwqpdhFzhCQfKS3nmmKe4QlmAwCtnvB+25qYpR5QOvA97xccjaNFvqJwXH0q+YJIsp6svnLlD/aVTpaTHkcIa7wSxJsTB+Gfh/A/XyzMDd3TEl9WzMobz/BYTEHjxjWHtehp1boTeFHLXzzKCwVjjLuauosQYnTm;25:g+qB1rZF6TuXyOBk/yp2abzlL+AVt3irM8rm0D998YK0NqxAoYYhGUEBE4wyhIABtXjFVuIQmxBTtyJXC2b6wu591RUroyBMgN6pBy1jKuHHeoqXJD4Jx2x/2qq2SRIQZz0+8jJD83iYcuFhXYlDCTuRHlyn7CyddqBDl07lVSHP38JQbFpR9MzbxsyYP/mt3s35765GP/zQWe/6ux3IOYAduVyen7aQLnA/n6gBXElar7C8j9/rXWjxVGAQIs+HE5SBQKMch7kpHOur7xq3BP2UcUf+YPqkOqS8lGA/xvtbcSHwCKBnFu2op4NcZzMAcIIeGB0A4xmKIPIclco5dg==;31:FhmsUkf7fBitbs2/nJfQigyHKa3THCUgkv4xr25NtX3Vo2y27TR3RejQn+/CuBm2+HGSxPJQ7wpmXbC3xsec7eIFIEGsCZ77sIQvIR+Tk9qu9hmCuMQYINUjkORwXwLM8CocUhHX5Qc+j40sobSYKIuS1QFOpuGdLxVPfWSskR2kMTRsWsSbcCQTH8mEj+NGpCC/dki8Uxk/v/JZxOesrFdSdc2dqZ6kvCCs/HiuFHo=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1754:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1754;20:kxHaFs6WlmDXXXjEXRwPdxoYlDKRHennPTpP2KVjzS9EBkaoR0cefE4FWdYo+aHBF8w5ablDYqszHOZ7+np6l2BR/UfXqa+34QuyrXVp0+waJ/78rZadj+5MXlNEEa8piTlU3ewmruCwKKCw4+B/NhejMFhcQ9XKA7WF6469qcFQ+IFrVPBJcfl/xTimKpdOdNltx/mS/dtgyMkQeOxWYaLJ5yKH7qbWrtw1ME5RLQJY3FntqwSfYSahESBgsQ5uRWWPT/NpYIaJbFYX6aFcc2myTAL+0fMPVd5kVjk7POiG0cCq9SFrP+I3TR7v5vYrrD8EqrX3DUQv6eIun7dCLrcK5fK7npbsLSTkld3JKsElNLiVEBts6CZcOxPF2WsE0j1DP/cIP9EaeVHyVMzHb3Hg0V1sh9tDEO2K74pWgd2pkS5fDhyCt5UzAr0ronzY1OM869815l31y6iEXBem+iLD8h698seuns1OebQQ7fC8N80oSu8x/I/6wgkAd5o/;4:1weczQPXugTkzC12JdaK0NLY3zePTVt1aBvuJ36+mBwSFSYQ2VQfbFQqRu6HCTCgr+6y6DINEJQTbGS+9fyiPzBw5uWqOvCIn2wNvzntGtQyzdPY1oqgsboeEoVM4HuUSZBCcuA1cMQdB3ib0CKha9Uy1Mm6YvgnWAW8WgOjSCP3982BlyX0qb0kGDILNiovWbSIwWP0xsy/7MlQpy3V5TzFR2LS+ESswjYgNAz0pZ4HRlWBNCRF97Hbm9scFLEaA69tS/jWWVVbi+ypu6bLHDCHRa4mJh/z0027m+MPQt517Jmd6mxXiGz5zF1I1v/ErAAhHRHqFmT3JlFFAeg1NdtTLCS4qLaCWcKSfuWxOtw=
X-Microsoft-Antispam-PRVS: <DM5PR15MB17543034C542E8B724D08FEADDF70@DM5PR15MB1754.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231101)(11241501184)(2400082)(944501161)(3002001)(6041288)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR15MB1754;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1754;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(376002)(39860400002)(366004)(39380400002)(189003)(199004)(16586007)(76506005)(68736007)(50466002)(6666003)(83506002)(86362001)(2950100002)(316002)(47776003)(8936002)(58126008)(81156014)(97736004)(54906003)(110136005)(81166006)(386003)(6486002)(186003)(16526019)(8676002)(7416002)(2906002)(33896004)(33656002)(9686003)(23726003)(53936002)(1076002)(59450400001)(6116002)(305945005)(4326008)(25786009)(76176011)(6496006)(7736002)(105586002)(5660300001)(52396003)(106356001)(98436002)(478600001)(52116002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1754;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1754;23:jUPOUC8vX7LagVcNVS8K+JR8UhEizLm5z608d0FwA?=
 =?us-ascii?Q?hzchflpbEFYPDGMIsk+5acbLuPmPKiucpdodWdWCZwetc5ibjM3D8OK4o9Ua?=
 =?us-ascii?Q?Xd49R33pVK8lu80Oe2FOyC1XwnXarmZawMc6Avczqr1awoV99C/VMBXB3A/A?=
 =?us-ascii?Q?HOmmc1plDVwokJ4qqW38xHnnRG6qZhEIWDVLuKmJqGe1gaP7a8cj0FahNs2d?=
 =?us-ascii?Q?b3Taqlyfp/rsgi/MEqubR45kl2NszR+cTZg7wGZg7qUKaZQ014/XbUnYBAql?=
 =?us-ascii?Q?eFRXRk42jO/kxVkO/jD41ePLjGqghEqVtwB/w2ObCGyPAM8K1oRXq90zSySh?=
 =?us-ascii?Q?glJOnRYOyv/AayvpjAVuVqiBbRBomtlqY0as5+d+enkK4HOdIwQa1YNI5YH6?=
 =?us-ascii?Q?ZtWK8Bc5CMSXCii3+7rhhsWsc2WDTDa2wJq/pvIiBs6yS7PbJgt4gdsJ8ECP?=
 =?us-ascii?Q?gIZluA3aFcobmVtjWClqO/wLtoUKEZYNGs69LRq4evRVB/+zk6HQG39B8BkY?=
 =?us-ascii?Q?52vTGdh/A4x9OEuYJRzh1tynHPbsUxYQAv9a0q4dCr29XO+GQC9x1StnWNoD?=
 =?us-ascii?Q?gArz2Jc7npcQAfWdLDTya3+GhTxzpDogJ5bRp4XzkLyGpT78ojvHRRVoVtjf?=
 =?us-ascii?Q?349tASd8QbvdPjoFiWuH4rZG2DMRkrwnkLKM2zTrUVSN5xBs81OS3VaNzmxj?=
 =?us-ascii?Q?rhkKZ2ZLsQBuiCyZnZh1FG1ax+5WxWAG+u1oxDjtL19TMD2B0rTTEf3SZFSy?=
 =?us-ascii?Q?W2WIm8CawLdBEdEMIlg+t5vm4/0nBPEQCx/oKFe0Cayp6GaZ3JCUGsAOucGV?=
 =?us-ascii?Q?Z1RBlLFDTI9z8Q4VWI8yauKCai6Lu1GjJfwuNOeYXXdjQ+KTHN+HUsFNetia?=
 =?us-ascii?Q?WflqPgMK/REH+ELr0qHzChKRLw0pXcfAdY9o7iz6ZQtDlmT592QJchpge2Yy?=
 =?us-ascii?Q?2NxT+E2mV0Xic4MhXAyPuijvzeIZFzWCOnhHnPO0+DlCT6on+fE35iAlNyXz?=
 =?us-ascii?Q?G1Yk1Zf4fRfY+OEjpUHONo/b7wip/5L9WPzR53AV6+9B2SzQGChA+1J6gjjE?=
 =?us-ascii?Q?d90GlUK2LWLlG6roT/Kr5X4YqiVnfwZ1SjM5cQ8CoXPsUCEa6i+Dz3qYJevK?=
 =?us-ascii?Q?FMvZGhFp2nR+SxGcnAC2zpBGQWnj+Hz1y0KNMWDlX6h2LJF1Jor/f6GHGGxC?=
 =?us-ascii?Q?XRPKMp655SI7IXbpKHEy8WegETiEySCTGZs5ERS36wGZwoIG5DnFK000MlTL?=
 =?us-ascii?Q?PXiWvXw23OhnoylBnW5k4OylvzqVN0np8qTwTZB?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1754;6:K+n9MdiCr4kmxXT023HZQ15o2AGrj5wMAnI3xP0nn3xu0gWnJGXVCzjTVLAO74LQZ8QwpYjCe5tFY8UYEDB6rhGkxW2+7nxO+LxAtm2Pg65TJXPvQoBwC1f4xFJgQ+dfpYdw2isci3FFTFjCudVxVWtitPy/3GH6cFI00xTcxna9jP5+K3GioFUJSnCB8Fckrfy3oFjaS+BQBgDy9niULwNcOkOH09pMv9cLvM1oaYKFBw4rfmMN7izpJXcxQ4qc9UaKrfICrjON5zu8Qejol+P54QMG4g9otKlnb/NaEAkF06KmkOFJg0tI7Uduh5T4OpBAl4ebmUur8TXKZa7VqGWfXsTca+2RBrgmIKTiSh8=;5:R+B664VcDx6V05vWHWNETFTC4NbOb0vSuhWBeVqSC6H5MRTL2krqJp+cQf0+cU5LBW1A2JnEZdkylYdpuC17MnrfiDWY9sT9RCQfwrvXkql4tcu1SjmJGQuELgEwEYSjDYDN3RMc3c2r3IqPgvcMje/lrbt2nzOIxH42NQ73/j4=;24:N8MuhEB+KYK9bBIZfWdxeQtoTsitgmrzaQzQvUW1XfIKY2kUn00sS6wiHlKtPu07qM5tVPCXL5w2e5/Gu2PSzsybe9PEtyoPxxPGkmfs4Q8=;7:WbYyy3WDwSjhCaDOhCiYX3epW9lYScImlOOn3vfHwaCqiiRh+OwlC/xhWig2LCdeN5EvtTcpbUoH7QGKXuQWNYeCBfyeB3oBCC1ZrXuCI1DGspv1XQgXRxUbwRluboUDb765CqyWHmfwcTUWrwQoQiA2ZJ937nZ4nt+A789LNOFIXjSadB+xWyUSmutX1u705fbooMk4alNPfPdWDPeYShCZzr4qGIziJWoylS0Vzngd+s9GiRlYwhnBZTiLa6Cp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1754;20:gQ+1r5EidMrWcLfnEQ4oucJ17NoNW+0uglLfJLrzSj0k/Up2CtoVLdSGJphH6aTa256A1iBAxPmBKdNkNlgSYGfjwzQ5b9yhtS/ehqfjLgMZHvrP/Uebf63XLGXYOil4qD93tigRcWsLb5BqdJpsu6ZPGpCosS9uerhk7dkwh3A=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:48:53.0337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfdd164-45fd-4e26-4dc3-08d57251a53b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1754
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge encode and decode tag calculations in GCM_COMPLETE macro.
Scatter/gather routines will call this once at the end of encryption
or decryption.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 172 ++++++++++++++------------------------
 1 file changed, 63 insertions(+), 109 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index b9fe2ab..529c542 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -222,6 +222,67 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	mov	%r13, %r12
 .endm
 
+# GCM_COMPLETE Finishes update of tag of last partial block
+# Output: Authorization Tag (AUTH_TAG)
+# Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
+.macro GCM_COMPLETE
+	mov	arg8, %r12		  # %r13 = aadLen (number of bytes)
+	shl	$3, %r12		  # convert into number of bits
+	movd	%r12d, %xmm15		  # len(A) in %xmm15
+	shl	$3, %arg4		  # len(C) in bits (*128)
+	MOVQ_R64_XMM	%arg4, %xmm1
+	pslldq	$8, %xmm15		  # %xmm15 = len(A)||0x0000000000000000
+	pxor	%xmm1, %xmm15		  # %xmm15 = len(A)||len(C)
+	pxor	%xmm15, %xmm8
+	GHASH_MUL	%xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
+	# final GHASH computation
+	movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10, %xmm8
+
+	mov	%arg5, %rax		  # %rax = *Y0
+	movdqu	(%rax), %xmm0		  # %xmm0 = Y0
+	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
+	pxor	%xmm8, %xmm0
+_return_T_\@:
+	mov	arg9, %r10                     # %r10 = authTag
+	mov	arg10, %r11                    # %r11 = auth_tag_len
+	cmp	$16, %r11
+	je	_T_16_\@
+	cmp	$8, %r11
+	jl	_T_4_\@
+_T_8_\@:
+	MOVQ_R64_XMM	%xmm0, %rax
+	mov	%rax, (%r10)
+	add	$8, %r10
+	sub	$8, %r11
+	psrldq	$8, %xmm0
+	cmp	$0, %r11
+	je	_return_T_done_\@
+_T_4_\@:
+	movd	%xmm0, %eax
+	mov	%eax, (%r10)
+	add	$4, %r10
+	sub	$4, %r11
+	psrldq	$4, %xmm0
+	cmp	$0, %r11
+	je	_return_T_done_\@
+_T_123_\@:
+	movd	%xmm0, %eax
+	cmp	$2, %r11
+	jl	_T_1_\@
+	mov	%ax, (%r10)
+	cmp	$2, %r11
+	je	_return_T_done_\@
+	add	$2, %r10
+	sar	$16, %eax
+_T_1_\@:
+	mov	%al, (%r10)
+	jmp	_return_T_done_\@
+_T_16_\@:
+	movdqu	%xmm0, (%r10)
+_return_T_done_\@:
+.endm
+
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
 *
@@ -1271,61 +1332,7 @@ _less_than_8_bytes_left_decrypt:
 	sub	$1, %r13
 	jne	_less_than_8_bytes_left_decrypt
 _multiple_of_16_bytes_decrypt:
-	mov	arg8, %r12		  # %r13 = aadLen (number of bytes)
-	shl	$3, %r12		  # convert into number of bits
-	movd	%r12d, %xmm15		  # len(A) in %xmm15
-	shl	$3, %arg4		  # len(C) in bits (*128)
-	MOVQ_R64_XMM	%arg4, %xmm1
-	pslldq	$8, %xmm15		  # %xmm15 = len(A)||0x0000000000000000
-	pxor	%xmm1, %xmm15		  # %xmm15 = len(A)||len(C)
-	pxor	%xmm15, %xmm8
-	GHASH_MUL	%xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	         # final GHASH computation
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm8
-
-	mov	%arg5, %rax		  # %rax = *Y0
-	movdqu	(%rax), %xmm0		  # %xmm0 = Y0
-	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
-	pxor	%xmm8, %xmm0
-_return_T_decrypt:
-	mov	arg9, %r10                # %r10 = authTag
-	mov	arg10, %r11               # %r11 = auth_tag_len
-	cmp	$16, %r11
-	je	_T_16_decrypt
-	cmp	$8, %r11
-	jl	_T_4_decrypt
-_T_8_decrypt:
-	MOVQ_R64_XMM	%xmm0, %rax
-	mov	%rax, (%r10)
-	add	$8, %r10
-	sub	$8, %r11
-	psrldq	$8, %xmm0
-	cmp	$0, %r11
-	je	_return_T_done_decrypt
-_T_4_decrypt:
-	movd	%xmm0, %eax
-	mov	%eax, (%r10)
-	add	$4, %r10
-	sub	$4, %r11
-	psrldq	$4, %xmm0
-	cmp	$0, %r11
-	je	_return_T_done_decrypt
-_T_123_decrypt:
-	movd	%xmm0, %eax
-	cmp	$2, %r11
-	jl	_T_1_decrypt
-	mov	%ax, (%r10)
-	cmp	$2, %r11
-	je	_return_T_done_decrypt
-	add	$2, %r10
-	sar	$16, %eax
-_T_1_decrypt:
-	mov	%al, (%r10)
-	jmp	_return_T_done_decrypt
-_T_16_decrypt:
-	movdqu	%xmm0, (%r10)
-_return_T_done_decrypt:
+	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec)
@@ -1501,61 +1508,8 @@ _less_than_8_bytes_left_encrypt:
 	sub $1, %r13
 	jne _less_than_8_bytes_left_encrypt
 _multiple_of_16_bytes_encrypt:
-	mov	arg8, %r12    # %r12 = addLen (number of bytes)
-	shl	$3, %r12
-	movd	%r12d, %xmm15       # len(A) in %xmm15
-	shl	$3, %arg4               # len(C) in bits (*128)
-	MOVQ_R64_XMM	%arg4, %xmm1
-	pslldq	$8, %xmm15          # %xmm15 = len(A)||0x0000000000000000
-	pxor	%xmm1, %xmm15       # %xmm15 = len(A)||len(C)
-	pxor	%xmm15, %xmm8
-	GHASH_MUL	%xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	# final GHASH computation
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm8         # perform a 16 byte swap
-
-	mov	%arg5, %rax		       # %rax  = *Y0
-	movdqu	(%rax), %xmm0		       # %xmm0 = Y0
-	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm15         # Encrypt(K, Y0)
-	pxor	%xmm8, %xmm0
 _return_T_encrypt:
-	mov	arg9, %r10                     # %r10 = authTag
-	mov	arg10, %r11                    # %r11 = auth_tag_len
-	cmp	$16, %r11
-	je	_T_16_encrypt
-	cmp	$8, %r11
-	jl	_T_4_encrypt
-_T_8_encrypt:
-	MOVQ_R64_XMM	%xmm0, %rax
-	mov	%rax, (%r10)
-	add	$8, %r10
-	sub	$8, %r11
-	psrldq	$8, %xmm0
-	cmp	$0, %r11
-	je	_return_T_done_encrypt
-_T_4_encrypt:
-	movd	%xmm0, %eax
-	mov	%eax, (%r10)
-	add	$4, %r10
-	sub	$4, %r11
-	psrldq	$4, %xmm0
-	cmp	$0, %r11
-	je	_return_T_done_encrypt
-_T_123_encrypt:
-	movd	%xmm0, %eax
-	cmp	$2, %r11
-	jl	_T_1_encrypt
-	mov	%ax, (%r10)
-	cmp	$2, %r11
-	je	_return_T_done_encrypt
-	add	$2, %r10
-	sar	$16, %eax
-_T_1_encrypt:
-	mov	%al, (%r10)
-	jmp	_return_T_done_encrypt
-_T_16_encrypt:
-	movdqu	%xmm0, (%r10)
-_return_T_done_encrypt:
+	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc)
-- 
2.9.5
