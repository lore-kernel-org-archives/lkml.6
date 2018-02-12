Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeBLTua (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:50:30 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751806AbeBLTuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:50:24 -0500
Date: Mon, 12 Feb 2018 11:49:58 -0800
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
Subject: [PATCH 08/14] x86/crypto: aesni: Fill in new context data structures
Message-ID: <20180212194958.GA60868@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: SN4PR0501CA0102.namprd05.prod.outlook.com (10.167.128.19)
 To DM5PR15MB1755.namprd15.prod.outlook.com (10.174.246.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f22d27be-095e-49c9-61cb-08d57251cffc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1755;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;3:e6eNCVrIeURQTLkCbmuwdFGLKS7aID2cCr3VHWvsb8cA2ykJlbDc1lw6IwIAEpOUDHLMj7X8eCqyiL6ylop1db4URhLJRDBrUXk3l0NEnVRUGzJOOZTy/lWVRkJClPlH4Otx83HvcL23iD6v78Mvxh7tG7JFWaG+RzFwycGUyWjL0QJLzYyv/Lu7q3t9KnaS7pS4V3Aw9tCHu7Y6IBV117oyjkngjDn+1qc4OFlCy1QslGyTdwcnoKYibibCooro;25:ytj2JszLIqz7Phgn4PIjOYCk33jqn6FYwOtSoSFEIudbqg8MHm5lXmHNaOcakBMVwj2aUALPgDI3UasMx5oWLSm9Olei7VmUF8Jgf920JyP0fDMAu3SpYrdNfdZYd/hqXtfpfmZmyI9pVWe78ASkTaqZvovNjkIL/4PbzVwtijckizhuP6U21moTizA3boUKMXhO2mnRjXp5Ed846/dlIPsRZc/Sk8HG0C/aujVojsIkzUtoMH+uDbgwFub5KlC8tukC5UwwAEgTt/jb2I4n5rXrFoTwDZUuhLbSxvrDkrA5vhmAhqheD9m+a+vIpq7PsEWYm666Q9/u8Mlg5FKhmw==;31:oYwBOWNs9X5Z+nWr8U55Q5Gxl9cXsn4fQCc57kkBCYvzvyfguzT+Exff3n6Qs0j/6/9DYTzB7In9Fv32e6QLrqI1Tx6yyZpzM77wJAC6LmvvjYW9mo0etqRADqb2uPQmAEzWIYQCjhXcnFXA5gQrVDvmw7ALh5MtxvD0gf3Ii3wRH2TxhoP2XxBSNYdntjkkDDDgiBk9za63oRgy11GEJL8fWmaoEkVAY7VLFiBpKKY=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1755:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:z1rNg3gIjWVfLvKty69CykCjulWidV5Lx502z5+QQ/K7LQPBWriluzOJZwDWt5mZJ24x/k2Ee6xKGbfBISuOhdDsWOBILVKKBZzIddUZCi0p1bclhaWJE46CKu6Lv3L9BChpKgP+EUsXbZ0TM0BTh/NEJiRl44oxM3aOMmnrePyuFEiMN2P2Tw+x6P8RkvTM0d/bgz9Eeyqx8x8slI9UucS9p7wNODy4A8E5gL/R4T8VA8qXN0g8ABI4TT3Xv0B74J00SEpmeNcfCK7fLQIuRBgaqOiKddwOxf2w6US2bnFO8XXOhwA2I7m9yx7n8ElEtWcGVTdXXOJBTZTqOHYH/j3ii7D8W7i0ghnF7Drwx6JCjK5c4eC6cNFSul37GnVdAhcRjNcfZhnX9IkMyTUCwrh7D5zLHFAVj7Pr+dA7YN9agAsID52xYlAomYwYJrbK8+qye98OgAqoMnjBNgNUy9Vdrz4EXEz3GoYx2cp75ZDE7B2PUYNRo7hxbA5thqQR;4:5Rgsw2wl7H/+voCaHVXigY+rQ0v2KzuQcHl0l+A/A6bx76RaeA4pD4gNZW1PTMGQBgl74XbBjy+VG9J/8HvL2+9r1MpT1RVEFgdx8Vuja8jCGLyfCK3yg6S7EZ0KEIbplhsXQtAjWdfkZrGsP217pdLPe7LFj+tMNQ2NSuk1gTVgWhaov8Bk69n8Rgti3KAYSlbcX+dOMk1e5AqX/82Jc9ZIs10iTME5TvZUVOg6t76IruFLRLPGFUSWJf+seRp0AZVIP9F8VbQiNWCMHzV/LbVDqglA2oDHOI+FJ8QlS6NEwAwVwiJy/oDAazj3qMhlOnYupci1OXR+2hsCzhvdwOqQo5j2FkGf50v1aQOyAMA=
X-Microsoft-Antispam-PRVS: <DM5PR15MB175528841AF26A93466C3A72DDF70@DM5PR15MB1755.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR15MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1755;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(39860400002)(366004)(39380400002)(346002)(199004)(189003)(23726003)(6116002)(1076002)(8936002)(9686003)(50466002)(81156014)(81166006)(8676002)(186003)(16526019)(86362001)(2906002)(98436002)(33656002)(478600001)(33896004)(97736004)(52396003)(6496006)(106356001)(386003)(68736007)(105586002)(5660300001)(76176011)(47776003)(6486002)(58126008)(110136005)(6666003)(7736002)(316002)(16586007)(54906003)(52116002)(76506005)(4326008)(25786009)(305945005)(2950100002)(7416002)(83506002)(53936002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1755;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1755;23:2+B6pmzz2YDQC86o7W3qIZVXdvxHO2EZNAvaoLZNd?=
 =?us-ascii?Q?EoewKGZ5CjoAi7K2bU1r2ijhfKoj014bYW0JHlV4lpNRhQSxeb2smp0X1YCF?=
 =?us-ascii?Q?+8oo6jllAerIk+Ft8RPCtzjJg6J84zO6FsqXIPCfrDT0hlVeAXqfecCkGKof?=
 =?us-ascii?Q?vT3zP+CvWW70A7IfOH4+XZkKQAcBSsUbkk5U+rg4/x8RoC5rwZTV7Bntu4z5?=
 =?us-ascii?Q?v0FP09ZV3LnFHgbWoA4hrqnIGBvySQ7o+3aYfeGeq3sX1XDg2AUPjwtRc/iC?=
 =?us-ascii?Q?JbET3jKjj3SmRx9UeZ9Wvtn8UCAr4813kRkHiZ94DJ6DGZZ+oCo0AK3VrjIe?=
 =?us-ascii?Q?aqm+sCQjmMiizN3RaDUuh7Iy0gfD8HXr1OeMkCbUi2DB58HwP+u6HWLo/4Qf?=
 =?us-ascii?Q?BUHmhBn5pcJRh3nibjzEWLKQmSimhApAFS/Lnh94dUY//7PWjQnyHO0TdMKS?=
 =?us-ascii?Q?qihIm5hzgQ16JAyfFc6DkAAyYa0a4zr4Cc61tdvX7CoJuBsgSCXTThWjJolB?=
 =?us-ascii?Q?82Yy+jSGWunrK62vjKZ74NtZRZks645MHpAYrlS37k5lWbe4QLveJ93rsBgT?=
 =?us-ascii?Q?6Em6VSYu53/zPMFhxpEHar2pjSC83jaDUm4YjzunH7KfqO3PMDjSlS26kVnG?=
 =?us-ascii?Q?4aFeKXOx15SzTS+3o1Gx3Fnk/RprBhZrP30gEaiYK6IrTOB3TUXj4u1bPZeG?=
 =?us-ascii?Q?uR/6iEPjEPc3DCXhkBjRztFcDUGlqulAj7PFqK+kGRCt7GJUW2eJEr1xW4tD?=
 =?us-ascii?Q?tTK5CweuAIRZjZw9SnUv5g2GgMBV9k/Id2IgohnU4lyD93g++BIFqh17T3+B?=
 =?us-ascii?Q?clmlw2OLruGzimNz9J+3sIUzXko2QRfdvSVXPNbE+VwiXhtwlj0LPqwI98sX?=
 =?us-ascii?Q?lDO4q/Wo5myztCxgZ6AluR+rNy3KogS4ckUavmwx7haV34qEq0QN8+VWMHoi?=
 =?us-ascii?Q?+NGEisxfn+9yDqN/YVI8o2D1o5lzd6JdxO4d04VtKwwH4TCRdV/4BZlCrmBk?=
 =?us-ascii?Q?DBKB+Y8jYj6YiDOrpgAi/7FYj00J77ypNmVqbZbWL/ipN3Rhe09HHlubL8tm?=
 =?us-ascii?Q?eoYSoh5U3LqgeSGQQzh7nzmr6m71KhRcOJeUvoHKVirVCQIz8hIrVozJ/GHV?=
 =?us-ascii?Q?a5ZBXFYOD5cO7HZ8uJdSlSmn7Li20GdFeTzhXyrMhqgpo7H71oJAFEYTpWM+?=
 =?us-ascii?Q?9GuNLHdDf732fv+xeA0wKkc+4mO6iJHMk0FAmjRO8bQH+Va7Hem2UZrtI8u8?=
 =?us-ascii?Q?Nw4mFCvzjsQmmkcB/c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;6:w9DfSwO38CoDLgR7787n2VO87AhQhD9CK+S4OVVoK7c/9v5yyoTczFp/28O8fI7le0AzAZ42V815hSZBLGxLRzo1rI2i2cPjogLJAqlvA/ynfxLpFMNlMJVAPmnIeM3YDx48fHKkCHLZPqXybsy9rFyieHyisDXPYKbBkRVCZRsmo1PJ4xByLT9GfDs5s45VgqYUZ4HY3xp3LTw41JW4GDojy49s3ojuwgCz2wTwttJ+S2MknX0acoro0eQWp8l09HVXJxH6BdDfnb/qY5OuKD7hChjmAe5fs4+37S/sou1Q4l3fFx6F9S6U/ul7gmBe4yyDXQFaJXrEKUlIOlYchwEI8cleSMFztZMwN6PE43s=;5:y4Lfarup8x2QGlPQHaHqWYFWoUL/kiTqztjJdAiAx0+rxEuCdr2/cRMnw47UwBG0IkhKredHZv5CMHaf1q8wqQWJxsJf3NZiiFc26k1iDv6w+t6fK5t/GJFzkv3V3EVG25aALnTxOqxdh6Iluw08jvDevtxQPQSslraDIBA6H0Q=;24:bs23JPETZklNKp0jEmx7YsV+rY7EB7u4RUHEoFAEIl/yxXqm/FhOp84lM91ihYXoaPf7WYbeV6Hb8iUZpV0zsg0Y0nsmfzTOd6tdpS7j1YU=;7:6NXNlS9qfO6SyXGTMyjFr82kvDWUAmfNGXL3hgS/eNkOXACfQ/je4KoEKIJlUZnFdf3SAgQbuqcQFFyfF14Tc8YaMmR4wTNfJrV3LPt1SInz6JOEFylcR0Egs2TnInn5X8daY3iDa0zG6ulA7f+BvlseSmXl7bZ1Yps1ERgoR+9ACQ0IkBwrqCtxSncdrcB8fQZPbMEG3zXU7noF4TevBTXFjlVzgTXmRXnMvLTeQN86MMATGUAzIvvZvL0rP+tb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:7crO5YuTOAytJsfodscybZWbKAi2l1oRitminmTdZGazNkINGVKGcy+CDiIcgOBNQ1Htp84nhhHDmh2EOJAG2gpyK6rnppbp7ql8Igfx//17ZdrRrf3cTU/3MCvBReKlxUF56wuM1g6y4mCXBSPYNdBvdXTyFPsypaOvVrQpOCQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:50:04.7946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f22d27be-095e-49c9-61cb-08d57251cffc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1755
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill in aadhash, aadlen, pblocklen, curcount with appropriate values.
pblocklen, aadhash, and pblockenckey are also updated at the end
of each scatter/gather operation, to be carried over to the next
operation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 51 ++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 58bbfac..aa82493 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -204,6 +204,21 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
 # Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
 .macro GCM_INIT
+
+	mov arg9, %r11
+	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
+	xor %r11, %r11
+	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
+	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
+	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
+	mov %arg6, %rax
+	movdqu (%rax), %xmm0
+	movdqu %xmm0, OrigIV(%arg2) # ctx_data.orig_IV = iv
+
+	movdqa  SHUF_MASK(%rip), %xmm2
+	PSHUFB_XMM %xmm2, %xmm0
+	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
+
 	mov	arg7, %r12
 	movdqu	(%r12), %xmm13
 	movdqa	SHUF_MASK(%rip), %xmm2
@@ -226,13 +241,9 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	pand	POLY(%rip), %xmm2
 	pxor	%xmm2, %xmm13
 	movdqa	%xmm13, HashKey(%rsp)
-	mov	%arg5, %r13		# %xmm13 holds HashKey<<1 (mod poly)
-	and	$-16, %r13
-	mov	%r13, %r12
 
 	CALC_AAD_HASH %xmm13 %xmm0 %xmm1 %xmm2 %xmm3 %xmm4 \
 	%xmm5 %xmm6
-	mov %r13, %r12
 .endm
 
 # GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
@@ -240,6 +251,12 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # Requires the input data be at least 1 byte long because of READ_PARTIAL_BLOCK
 # Clobbers rax, r10-r13, and xmm0-xmm15
 .macro GCM_ENC_DEC operation
+	movdqu AadHash(%arg2), %xmm8
+	movdqu HashKey(%rsp), %xmm13
+	add %arg5, InLen(%arg2)
+	mov %arg5, %r13		# save the number of bytes
+	and $-16, %r13		# %r13 = %r13 - (%r13 mod 16)
+	mov %r13, %r12
 	# Encrypt/Decrypt first few blocks
 
 	and	$(3<<4), %r12
@@ -284,16 +301,23 @@ _four_cipher_left_\@:
 	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
 %xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
 _zero_cipher_left_\@:
+	movdqu %xmm8, AadHash(%arg2)
+	movdqu %xmm0, CurCount(%arg2)
+
 	mov	%arg5, %r13
 	and	$15, %r13			# %r13 = arg5 (mod 16)
 	je	_multiple_of_16_bytes_\@
 
+	mov %r13, PBlockLen(%arg2)
+
 	# Handle the last <16 Byte block separately
 	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
+	movdqu %xmm0, CurCount(%arg2)
 	movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm0
 
 	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
+	movdqu %xmm0, PBlockEncKey(%arg2)
 
 	lea (%arg4,%r11,1), %r10
 	mov %r13, %r12
@@ -322,6 +346,7 @@ _zero_cipher_left_\@:
 .endif
 
 	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
+	movdqu %xmm8, AadHash(%arg2)
 .ifc \operation, enc
 	# GHASH computation for the last <16 byte block
 	movdqa SHUF_MASK(%rip), %xmm10
@@ -351,11 +376,15 @@ _multiple_of_16_bytes_\@:
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
 .macro GCM_COMPLETE
-	mov	arg9, %r12		  # %r13 = aadLen (number of bytes)
+	movdqu AadHash(%arg2), %xmm8
+	movdqu HashKey(%rsp), %xmm13
+	mov AadLen(%arg2), %r12  # %r13 = aadLen (number of bytes)
 	shl	$3, %r12		  # convert into number of bits
 	movd	%r12d, %xmm15		  # len(A) in %xmm15
-	shl	$3, %arg5		  # len(C) in bits (*128)
-	MOVQ_R64_XMM	%arg5, %xmm1
+	mov InLen(%arg2), %r12
+	shl     $3, %r12                  # len(C) in bits (*128)
+	MOVQ_R64_XMM    %r12, %xmm1
+
 	pslldq	$8, %xmm15		  # %xmm15 = len(A)||0x0000000000000000
 	pxor	%xmm1, %xmm15		  # %xmm15 = len(A)||len(C)
 	pxor	%xmm15, %xmm8
@@ -364,8 +393,7 @@ _multiple_of_16_bytes_\@:
 	movdqa SHUF_MASK(%rip), %xmm10
 	PSHUFB_XMM %xmm10, %xmm8
 
-	mov	%arg6, %rax		  # %rax = *Y0
-	movdqu	(%rax), %xmm0		  # %xmm0 = Y0
+	movdqu OrigIV(%arg2), %xmm0       # %xmm0 = Y0
 	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
 	pxor	%xmm8, %xmm0
 _return_T_\@:
@@ -553,15 +581,14 @@ _get_AAD_done\@:
 
 .macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
 	XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
+	MOVADQ		SHUF_MASK(%rip), %xmm14
 
 	movdqu AadHash(%arg2), %xmm\i		    # XMM0 = Y0
 
 	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
-	mov	   %arg6, %rax                      # %rax = *Y0
-	movdqu	   (%rax), \XMM0                    # XMM0 = Y0
-	PSHUFB_XMM   %xmm14, \XMM0
+	movdqu CurCount(%arg2), \XMM0                # XMM0 = Y0
 
 .if (\i == 5) || (\i == 6) || (\i == 7)
 
-- 
2.9.5
