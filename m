Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeBLTsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:48:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751058AbeBLTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:48:32 -0500
Date: Mon, 12 Feb 2018 11:47:59 -0800
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
Subject: [PATCH 01/14] x86/crypto: aesni: Merge INITIAL_BLOCKS_ENC/DEC
Message-ID: <20180212194759.GA60319@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: DM5PR19CA0045.namprd19.prod.outlook.com (10.173.167.159) To
 MWHPR15MB1758.namprd15.prod.outlook.com (10.174.255.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faee7a26-ff2e-4ba1-86b7-08d572518783
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1758;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;3:3WetgMsGmVRXYoyaLoOlfkDq7U9+rXnB3klHW+zfraWUM7h1kZtrVKE5laMBCt3HBfQOV9Jhobr0ixsshsNHK+Wb4u59EyqA4caLVSOKjOmXCAaKJdHYcGxbbL0pSNwtDecnAMRWtXhPVgPqzW2clyapOevHWw2V172UBH1l6yxgRdjUlCK2bMAPlRKrfoSZ9Qc2G8EPzPe0ymhHphubKezvsY1+8s5VN1V6N87/O0p+e+/Kpi+xC8J/MPseK8MY;25:FHJbbO2Yoc+lP4WkzDFoigRzpfgSYJQhYQvWNizC1uKg+ZwsNSuVDFxGrjhV4Eiqw/I4RGuniM+227vcgU+wpig3egkvThd7YnXdWimOgg8EKWdlX215ZfEgycMVzLWt0ZhPP97PBUkHk8oc31qEtuQ3U0FZI5orFvRYaXEAUvj3iCBfv73zM4lO0N7rMC5BeeJKXM86MMPf/IoazydQRwnQ5HL9hVrinMeeHuKJYINea6vUZJAS8LS+FsqVQUiqGcD/ndq3gm9jGa1oLummwncmFAXBE7V3LNOc0A8X3yE97psVfGbE1C1TP2mkrebJ7gJV3KWWYOUHBaAGsksETQ==;31:4XHnzy+SUKrbv+rTjJm8L0cS5OWt7YaHd6UuWzi6Kn4w6wHSwfPxwWcOs0msZHLx1gArv5qboJDYBxu11VKP+QhXeD4d3UzZ8Vqkl541gT5jGTPz+CDe76h1xOQ+ZdjwrEiXmzNSsXmP771coIao3qCPGj2OgJAYcKXo3F3g7696R72FRuBS/3hXuIk+zy4xKTT/GfRXB87p0Uf0FnEEnsxQ0D/gDlpzqITcgzxCl6I=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1758:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;20:lMcBqrllI7sDuh4tTemA4zsNzBinplL13NkWaih+VYB3zd+eE/XpPfohl3r1LdMm4U/aST2C3zMFX/MMuxJgoDkVqU1CsIQrBt0zstxABMmb/FA1jEWJztFgwQI7cmWQ18m9HYm6bdGcWklUUlDPtMUArCK9o8RFOu5tJQzfRqe7pbNPaHSYVZ9Ed/zswS7Sq5J+y1au47eEoMbSsXH78rDwHt1mgEKza1NFUa6VyAtVWb+p+zOZXzupADFddr61vtfWzSawFzhARXpW2RfGAtgFnZhbLCcBhfCG5VLIUZoma3dWQKPa2s24J9/fAvgjzLRwocHVyUZ4UTjm9T2hn3Gj/FhYP9RCN/d+5pi0geeFUCecnj6JLwJu0lG1WqOJXbHTJefvHvafQIiLlzQDfIbEoRNkDa2yOX0zl8NRx/nxhXAoowsA8dbjvQvQaEMXI/3KTUc0C/OfckuVLzkJIAImoJ7zkL3UxDw7KrdtijGiMqSMZHcsXwhTjt8KWRnN;4:PRxfclRKnN3XOv7KMhPMH3zaS+Pa+WeCEKxyjidvHHgKR2ZmS6pXgppQzYPBE8Nn2wmtIRo5XW+q75cNvwCUtiHlbur1hLchPQDU1KHqR+kP4AlLvOjgPIcKvf8o3WoABEGZUexH0WCwMncrQm4nMSIHXoKJR82EERGUccc3mR4tY2Dl6LOQ4B2sJGvBs0wPHrlSgxZdd0x2AATJvlLmuwFyG8A08GlKClBwpng16l16Mmq/TYRBy25wl4XJMHh0QCN50doCrPlJhHSgJNQZVWwVRVtLq0KK1Ht3fihEoifsNlid+b0sZ3Zr69CeeU1Ap5v2wVNazcb6ilRnQsGlcGFX4JCjnmo9sC56Bnq8jeE=
X-Microsoft-Antispam-PRVS: <MWHPR15MB175870BC42B2BE06BAC1B1A8DDF70@MWHPR15MB1758.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231101)(11241501184)(2400082)(944501161)(6041288)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR15MB1758;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1758;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(346002)(39860400002)(39380400002)(376002)(199004)(189003)(6116002)(16586007)(86362001)(386003)(98436002)(33656002)(7416002)(9686003)(6486002)(7736002)(305945005)(478600001)(33896004)(76176011)(47776003)(53936002)(97736004)(4326008)(106356001)(83506002)(6496006)(52396003)(76506005)(52116002)(25786009)(105586002)(68736007)(58126008)(5660300001)(110136005)(316002)(2950100002)(6666003)(54906003)(23726003)(8676002)(8936002)(50466002)(81156014)(81166006)(2906002)(186003)(16526019)(1076002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1758;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1758;23:brlp4Fwt/QeXrVqQtjFHfDYTXk0ySvUSYlG/OlziS?=
 =?us-ascii?Q?EUKOgNh3KSAj26/pFxupjtXoMHYYzzUYi6WRqMZYW85XGFZbd1K/OeniAHRV?=
 =?us-ascii?Q?VRimFYJBCDcI9kLU+vR6vxwjMb0yjoshw9LQ/CwCQXTFbykuSCRkm08ojlxN?=
 =?us-ascii?Q?sQxCPcoS8fW/8IFckKmAIR/j4uTRNEnvSWbkWOnGXED+glb5L2N+gv1gCMyW?=
 =?us-ascii?Q?AiUL4sco13hXqHthz5l6idT14sMW680QxAHC7jshdX2i9nS2z6sXcFA8nf0E?=
 =?us-ascii?Q?h0dS0iCnkrJHESyUoBJ36oq1Krz/abzAY0OFHMibrPRZCUGjRrCpIhibVZal?=
 =?us-ascii?Q?KlvrmQwPdx92zFOgBVRE8517/wN/r5ogb/bQ1DXBGK1LATUVhwGZN+KAKOnS?=
 =?us-ascii?Q?qcXFo47w4A5QJXnAtX5m9EkoS/YSW7oaP9K9kOR+oe733pLCRSHD7OuPDN+P?=
 =?us-ascii?Q?gGU5oS1VZRqMot9Pj8E1w/JODWWWY/IQRhfjDm7Gvh9cr8rKhTCYsTuSi1fR?=
 =?us-ascii?Q?/bRb+5k0M5ige7m7gYB9w6xkXX+TypRXs3w78oD8rLsmnzYw9M5xJjEdhuc1?=
 =?us-ascii?Q?RmBEeomK05LHPdHH55QpXi6IMGgYLziUs98/f46jzZRJQJLb/6tlBCORVGc6?=
 =?us-ascii?Q?K5ktimnGddzTdyDWXmtaIqp1Qkr7F0bmpYZp+S7L7yeJHcIput+gYDWM87Bb?=
 =?us-ascii?Q?kpfuDTfTSwFbEmAPrQG4/6hHg4sE07FifOYDnyEyxq2y4PRWNEpvqoyLkNf0?=
 =?us-ascii?Q?3jqX2ERXpHazGk9cn5Jy/ylvvNKZCCC/lK5a8Ji/O3rwNL4404Ua+YKXF2xP?=
 =?us-ascii?Q?Nz5M4g33LXAosUjUPyCjO/TbUj0PAh606OQHeXX4X4J20McgXIlCwLpNibBo?=
 =?us-ascii?Q?gg8FmkOvCUnmH3GTShnkFqHIo6DPkdqKFvQGCT6+pdBWMUEnFkVk04BNvsFI?=
 =?us-ascii?Q?tqix6enl7cuIUESAH6HcPUC8ihGM8VwuwNaWkxhcy3OfhrqO2p1SbV7chIO+?=
 =?us-ascii?Q?claa2NxKk263TNsHr/Sd0KPX0cJ9Awuh6bSE3X1v3yH2CqHRez92UOZ0d4OT?=
 =?us-ascii?Q?Uz7r7CsDYawMum3ibuIL5imsSBWUnApcVgToQkt24wLSKdrRxrmuKsoi/PK6?=
 =?us-ascii?Q?mDPvgIHN7scZx7HrBDD/hK9J3toCozIk+wrJSjcRxZ/JL/c2Y57/oFd6l6xP?=
 =?us-ascii?Q?3aj5FmDta91yXzaYB2xRBlT/XBUhxOu6UbXsSduQmm1smnVip4PDqkPHIG+L?=
 =?us-ascii?Q?LOZy65Hk+3H1q69aKw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;6:bf9TS99UiQAuJj2gPiv2hkzgt4kaHtzMg2u+qiVmeuMKrK5yr0lkV6uOFzKFVZ7Q2r0MUNbvBDka8G+28zG8RzaY9i1WAwJtX8X56VRGwtERkAUznaBeUyQgixYDWurdxG3tCqht6vuH4j1fGF0F3VxZi1zMSBMjeekH6c6GgDIfOoQyiByUTIB5LVam/r7yfDX0e3kSFjjsi/R1O67euB+246azDTBBr6NnqG4R0dBKxRIbgO7Z09FnylXPJHH87pFQnD4x97FR5suHoKOgr0J0PoF7dL9Vhx/1MK0lHf2Ah8RVQjiehMmpWevKJAS+q+XrTe+zdJyKsGOm1I9FEQPgx0pp/DxNON+sKtTZGXY=;5:01Hz5gU7YtwF6Kezi6iR+FM7Np1rLmL4gDv0kcJM3LNA//CVDA107ymM5a9Ly06JnbZYmXhT7m2B2vUjbRP/uiPjQ0gZmPbI4golJmVwLw0yt69wSgKiG1UXvYdh+Zpd77xXadGICoMQXcq0VwsY/busZLpdMZ29R6YJklBySA0=;24:bersUAW3hP12Wc7kzUEn5ZPMRlVe3kEFC9jewmsspci3U2k2u5PtNtrb5SVffJrso0uNRVdVMNlnFPW8D1GY+zATVStBMIEeRYIHDK/TXsg=;7:+xnzM5mT2u7dhp5Be3Y6VVrDwlJVFliv7z9vEl9L9iNlovtwoirvFHOi4SVkERU5A4xMW18tBMkpmtRfSEBdaHcqgZpgZG4r/1hyzKWZ09/c5ijOeK5388yGP5UXEoQdtHuANS8tdDY1VaDAUmhE4KvSh7ONvkBauoaDLokvEl5RYdbeusm5XU22ptO2cxPAuOUKRZF2FYK2S+6ScOX9VWPwydNbC5YbsCZtqpLZBuyptI8i5PRPx3o6llIBifyc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1758;20:b3Xr84Ma7xD9cy0nDbyh32KbEGDxG3IPJ5voTlb3uUsBswMPa4tXTcNTofPld4kD4zCVZhQMNXH94dSg5bb8NBiBd7Hwy4LyPwcGuEc/o72RrDy6HF4O0S8tg9s6wm2V+H/LAkqbyOxs/LCFuWhXmwfoLIbshJlslpD1EJtaEf4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:48:03.2067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faee7a26-ff2e-4ba1-86b7-08d572518783
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro operations to merge implemetations of INITIAL_BLOCKS,
since they differ by only a small handful of lines.

Use macro counter \@ to simplify implementation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 298 ++++++--------------------------------
 1 file changed, 48 insertions(+), 250 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 76d8cd4..48911fe 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -275,234 +275,7 @@ _done_read_partial_block_\@:
 */
 
 
-.macro INITIAL_BLOCKS_DEC num_initial_blocks TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
-XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
-        MOVADQ     SHUF_MASK(%rip), %xmm14
-	mov	   arg7, %r10           # %r10 = AAD
-	mov	   arg8, %r11           # %r11 = aadLen
-	pxor	   %xmm\i, %xmm\i
-	pxor       \XMM2, \XMM2
-
-	cmp	   $16, %r11
-	jl	   _get_AAD_rest\num_initial_blocks\operation
-_get_AAD_blocks\num_initial_blocks\operation:
-	movdqu	   (%r10), %xmm\i
-	PSHUFB_XMM %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   %xmm\i, \XMM2
-	GHASH_MUL  \XMM2, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-	add	   $16, %r10
-	sub	   $16, %r11
-	cmp	   $16, %r11
-	jge	   _get_AAD_blocks\num_initial_blocks\operation
-
-	movdqu	   \XMM2, %xmm\i
-
-	/* read the last <16B of AAD */
-_get_AAD_rest\num_initial_blocks\operation:
-	cmp	   $0, %r11
-	je	   _get_AAD_done\num_initial_blocks\operation
-
-	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
-	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
-	pxor	   \XMM2, %xmm\i
-	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-
-_get_AAD_done\num_initial_blocks\operation:
-	xor	   %r11, %r11 # initialise the data pointer offset as zero
-	# start AES for num_initial_blocks blocks
-
-	mov	   %arg5, %rax                      # %rax = *Y0
-	movdqu	   (%rax), \XMM0                    # XMM0 = Y0
-	PSHUFB_XMM   %xmm14, \XMM0
-
-.if (\i == 5) || (\i == 6) || (\i == 7)
-	MOVADQ		ONE(%RIP),\TMP1
-	MOVADQ		(%arg1),\TMP2
-.irpc index, \i_seq
-	paddd	   \TMP1, \XMM0                 # INCR Y0
-	movdqa	   \XMM0, %xmm\index
-	PSHUFB_XMM   %xmm14, %xmm\index      # perform a 16 byte swap
-	pxor	   \TMP2, %xmm\index
-.endr
-	lea	0x10(%arg1),%r10
-	mov	keysize,%eax
-	shr	$2,%eax				# 128->4, 192->6, 256->8
-	add	$5,%eax			      # 128->9, 192->11, 256->13
-
-aes_loop_initial_dec\num_initial_blocks:
-	MOVADQ	(%r10),\TMP1
-.irpc	index, \i_seq
-	AESENC	\TMP1, %xmm\index
-.endr
-	add	$16,%r10
-	sub	$1,%eax
-	jnz	aes_loop_initial_dec\num_initial_blocks
-
-	MOVADQ	(%r10), \TMP1
-.irpc index, \i_seq
-	AESENCLAST \TMP1, %xmm\index         # Last Round
-.endr
-.irpc index, \i_seq
-	movdqu	   (%arg3 , %r11, 1), \TMP1
-	pxor	   \TMP1, %xmm\index
-	movdqu	   %xmm\index, (%arg2 , %r11, 1)
-	# write back plaintext/ciphertext for num_initial_blocks
-	add	   $16, %r11
-
-	movdqa     \TMP1, %xmm\index
-	PSHUFB_XMM	   %xmm14, %xmm\index
-                # prepare plaintext/ciphertext for GHASH computation
-.endr
-.endif
-
-        # apply GHASH on num_initial_blocks blocks
-
-.if \i == 5
-        pxor       %xmm5, %xmm6
-	GHASH_MUL  %xmm6, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 6
-        pxor       %xmm6, %xmm7
-	GHASH_MUL  %xmm7, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.elseif \i == 7
-        pxor       %xmm7, %xmm8
-	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
-.endif
-	cmp	   $64, %r13
-	jl	_initial_blocks_done\num_initial_blocks\operation
-	# no need for precomputed values
-/*
-*
-* Precomputations for HashKey parallel with encryption of first 4 blocks.
-* Haskey_i_k holds XORed values of the low and high parts of the Haskey_i
-*/
-	MOVADQ	   ONE(%rip), \TMP1
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM1
-	PSHUFB_XMM  %xmm14, \XMM1        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM2
-	PSHUFB_XMM  %xmm14, \XMM2        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM3
-	PSHUFB_XMM %xmm14, \XMM3        # perform a 16 byte swap
-
-	paddd	   \TMP1, \XMM0              # INCR Y0
-	MOVADQ	   \XMM0, \XMM4
-	PSHUFB_XMM %xmm14, \XMM4        # perform a 16 byte swap
-
-	MOVADQ	   0(%arg1),\TMP1
-	pxor	   \TMP1, \XMM1
-	pxor	   \TMP1, \XMM2
-	pxor	   \TMP1, \XMM3
-	pxor	   \TMP1, \XMM4
-	movdqa	   \TMP3, \TMP5
-	pshufd	   $78, \TMP3, \TMP1
-	pxor	   \TMP3, \TMP1
-	movdqa	   \TMP1, HashKey_k(%rsp)
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^2<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_2(%rsp)
-# HashKey_2 = HashKey^2<<1 (mod poly)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_2_k(%rsp)
-.irpc index, 1234 # do 4 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	AESENC	   \TMP1, \XMM1
-	AESENC	   \TMP1, \XMM2
-	AESENC	   \TMP1, \XMM3
-	AESENC	   \TMP1, \XMM4
-.endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_3(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_3_k(%rsp)
-.irpc index, 56789 # do next 5 rounds
-	movaps 0x10*\index(%arg1), \TMP1
-	AESENC	   \TMP1, \XMM1
-	AESENC	   \TMP1, \XMM2
-	AESENC	   \TMP1, \XMM3
-	AESENC	   \TMP1, \XMM4
-.endr
-	GHASH_MUL  \TMP5, \TMP3, \TMP1, \TMP2, \TMP4, \TMP6, \TMP7
-# TMP5 = HashKey^3<<1 (mod poly)
-	movdqa	   \TMP5, HashKey_4(%rsp)
-	pshufd	   $78, \TMP5, \TMP1
-	pxor	   \TMP5, \TMP1
-	movdqa	   \TMP1, HashKey_4_k(%rsp)
-	lea	   0xa0(%arg1),%r10
-	mov	   keysize,%eax
-	shr	   $2,%eax			# 128->4, 192->6, 256->8
-	sub	   $4,%eax			# 128->0, 192->2, 256->4
-	jz	   aes_loop_pre_dec_done\num_initial_blocks
-
-aes_loop_pre_dec\num_initial_blocks:
-	MOVADQ	   (%r10),\TMP2
-.irpc	index, 1234
-	AESENC	   \TMP2, %xmm\index
-.endr
-	add	   $16,%r10
-	sub	   $1,%eax
-	jnz	   aes_loop_pre_dec\num_initial_blocks
-
-aes_loop_pre_dec_done\num_initial_blocks:
-	MOVADQ	   (%r10), \TMP2
-	AESENCLAST \TMP2, \XMM1
-	AESENCLAST \TMP2, \XMM2
-	AESENCLAST \TMP2, \XMM3
-	AESENCLAST \TMP2, \XMM4
-	movdqu	   16*0(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM1
-	movdqu	   \XMM1, 16*0(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM1
-	movdqu	   16*1(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM2
-	movdqu	   \XMM2, 16*1(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM2
-	movdqu	   16*2(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM3
-	movdqu	   \XMM3, 16*2(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM3
-	movdqu	   16*3(%arg3 , %r11 , 1), \TMP1
-	pxor	   \TMP1, \XMM4
-	movdqu	   \XMM4, 16*3(%arg2 , %r11 , 1)
-	movdqa     \TMP1, \XMM4
-	add	   $64, %r11
-	PSHUFB_XMM %xmm14, \XMM1 # perform a 16 byte swap
-	pxor	   \XMMDst, \XMM1
-# combine GHASHed value with the corresponding ciphertext
-	PSHUFB_XMM %xmm14, \XMM2 # perform a 16 byte swap
-	PSHUFB_XMM %xmm14, \XMM3 # perform a 16 byte swap
-	PSHUFB_XMM %xmm14, \XMM4 # perform a 16 byte swap
-
-_initial_blocks_done\num_initial_blocks\operation:
-
-.endm
-
-
-/*
-* if a = number of total plaintext bytes
-* b = floor(a/16)
-* num_initial_blocks = b mod 4
-* encrypt the initial num_initial_blocks blocks and apply ghash on
-* the ciphertext
-* %r10, %r11, %r12, %rax, %xmm5, %xmm6, %xmm7, %xmm8, %xmm9 registers
-* are clobbered
-* arg1, %arg2, %arg3, %r14 are used as a pointer only, not modified
-*/
-
-
-.macro INITIAL_BLOCKS_ENC num_initial_blocks TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
+.macro INITIAL_BLOCKS_ENC_DEC TMP1 TMP2 TMP3 TMP4 TMP5 XMM0 XMM1 \
 XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
         MOVADQ     SHUF_MASK(%rip), %xmm14
 	mov	   arg7, %r10           # %r10 = AAD
@@ -511,8 +284,8 @@ XMM2 XMM3 XMM4 XMMDst TMP6 TMP7 i i_seq operation
 	pxor	   \XMM2, \XMM2
 
 	cmp	   $16, %r11
-	jl	   _get_AAD_rest\num_initial_blocks\operation
-_get_AAD_blocks\num_initial_blocks\operation:
+	jl	   _get_AAD_rest\@
+_get_AAD_blocks\@:
 	movdqu	   (%r10), %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   %xmm\i, \XMM2
@@ -520,21 +293,21 @@ _get_AAD_blocks\num_initial_blocks\operation:
 	add	   $16, %r10
 	sub	   $16, %r11
 	cmp	   $16, %r11
-	jge	   _get_AAD_blocks\num_initial_blocks\operation
+	jge	   _get_AAD_blocks\@
 
 	movdqu	   \XMM2, %xmm\i
 
 	/* read the last <16B of AAD */
-_get_AAD_rest\num_initial_blocks\operation:
+_get_AAD_rest\@:
 	cmp	   $0, %r11
-	je	   _get_AAD_done\num_initial_blocks\operation
+	je	   _get_AAD_done\@
 
 	READ_PARTIAL_BLOCK %r10, %r11, \TMP1, %xmm\i
 	PSHUFB_XMM   %xmm14, %xmm\i # byte-reflect the AAD data
 	pxor	   \XMM2, %xmm\i
 	GHASH_MUL  %xmm\i, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 
-_get_AAD_done\num_initial_blocks\operation:
+_get_AAD_done\@:
 	xor	   %r11, %r11 # initialise the data pointer offset as zero
 	# start AES for num_initial_blocks blocks
 
@@ -548,7 +321,11 @@ _get_AAD_done\num_initial_blocks\operation:
 	MOVADQ		0(%arg1),\TMP2
 .irpc index, \i_seq
 	paddd		\TMP1, \XMM0                 # INCR Y0
+.ifc \operation, dec
+        movdqa     \XMM0, %xmm\index
+.else
 	MOVADQ		\XMM0, %xmm\index
+.endif
 	PSHUFB_XMM	%xmm14, %xmm\index      # perform a 16 byte swap
 	pxor		\TMP2, %xmm\index
 .endr
@@ -557,14 +334,14 @@ _get_AAD_done\num_initial_blocks\operation:
 	shr	$2,%eax				# 128->4, 192->6, 256->8
 	add	$5,%eax			      # 128->9, 192->11, 256->13
 
-aes_loop_initial_enc\num_initial_blocks:
+aes_loop_initial_\@:
 	MOVADQ	(%r10),\TMP1
 .irpc	index, \i_seq
 	AESENC	\TMP1, %xmm\index
 .endr
 	add	$16,%r10
 	sub	$1,%eax
-	jnz	aes_loop_initial_enc\num_initial_blocks
+	jnz	aes_loop_initial_\@
 
 	MOVADQ	(%r10), \TMP1
 .irpc index, \i_seq
@@ -576,6 +353,10 @@ aes_loop_initial_enc\num_initial_blocks:
 	movdqu	   %xmm\index, (%arg2 , %r11, 1)
 	# write back plaintext/ciphertext for num_initial_blocks
 	add	   $16, %r11
+
+.ifc \operation, dec
+	movdqa     \TMP1, %xmm\index
+.endif
 	PSHUFB_XMM	   %xmm14, %xmm\index
 
 		# prepare plaintext/ciphertext for GHASH computation
@@ -601,7 +382,7 @@ aes_loop_initial_enc\num_initial_blocks:
 	GHASH_MUL  %xmm8, \TMP3, \TMP1, \TMP2, \TMP4, \TMP5, \XMM1
 .endif
 	cmp	   $64, %r13
-	jl	_initial_blocks_done\num_initial_blocks\operation
+	jl	_initial_blocks_done\@
 	# no need for precomputed values
 /*
 *
@@ -671,18 +452,18 @@ aes_loop_initial_enc\num_initial_blocks:
 	mov	   keysize,%eax
 	shr	   $2,%eax			# 128->4, 192->6, 256->8
 	sub	   $4,%eax			# 128->0, 192->2, 256->4
-	jz	   aes_loop_pre_enc_done\num_initial_blocks
+	jz	   aes_loop_pre_done\@
 
-aes_loop_pre_enc\num_initial_blocks:
+aes_loop_pre_\@:
 	MOVADQ	   (%r10),\TMP2
 .irpc	index, 1234
 	AESENC	   \TMP2, %xmm\index
 .endr
 	add	   $16,%r10
 	sub	   $1,%eax
-	jnz	   aes_loop_pre_enc\num_initial_blocks
+	jnz	   aes_loop_pre_\@
 
-aes_loop_pre_enc_done\num_initial_blocks:
+aes_loop_pre_done\@:
 	MOVADQ	   (%r10), \TMP2
 	AESENCLAST \TMP2, \XMM1
 	AESENCLAST \TMP2, \XMM2
@@ -690,16 +471,33 @@ aes_loop_pre_enc_done\num_initial_blocks:
 	AESENCLAST \TMP2, \XMM4
 	movdqu	   16*0(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM1
+.ifc \operation, dec
+	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM1
+.endif
 	movdqu	   16*1(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM2
+.ifc \operation, dec
+	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM2
+.endif
 	movdqu	   16*2(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM3
+.ifc \operation, dec
+	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM3
+.endif
 	movdqu	   16*3(%arg3 , %r11 , 1), \TMP1
 	pxor	   \TMP1, \XMM4
+.ifc \operation, dec
+	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+	movdqa     \TMP1, \XMM4
+.else
 	movdqu     \XMM1, 16*0(%arg2 , %r11 , 1)
 	movdqu     \XMM2, 16*1(%arg2 , %r11 , 1)
 	movdqu     \XMM3, 16*2(%arg2 , %r11 , 1)
 	movdqu     \XMM4, 16*3(%arg2 , %r11 , 1)
+.endif
 
 	add	   $64, %r11
 	PSHUFB_XMM %xmm14, \XMM1 # perform a 16 byte swap
@@ -709,7 +507,7 @@ aes_loop_pre_enc_done\num_initial_blocks:
 	PSHUFB_XMM %xmm14, \XMM3 # perform a 16 byte swap
 	PSHUFB_XMM %xmm14, \XMM4 # perform a 16 byte swap
 
-_initial_blocks_done\num_initial_blocks\operation:
+_initial_blocks_done\@:
 
 .endm
 
@@ -1378,22 +1176,22 @@ ENTRY(aesni_gcm_dec)
 	jb _initial_num_blocks_is_1_decrypt
 	je _initial_num_blocks_is_2_decrypt
 _initial_num_blocks_is_3_decrypt:
-	INITIAL_BLOCKS_DEC 3, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, dec
 	sub	$48, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_2_decrypt:
-	INITIAL_BLOCKS_DEC	2, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, dec
 	sub	$32, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_1_decrypt:
-	INITIAL_BLOCKS_DEC	1, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, dec
 	sub	$16, %r13
 	jmp	_initial_blocks_decrypted
 _initial_num_blocks_is_0_decrypt:
-	INITIAL_BLOCKS_DEC	0, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, dec
 _initial_blocks_decrypted:
 	cmp	$0, %r13
@@ -1640,22 +1438,22 @@ ENTRY(aesni_gcm_enc)
 	jb	_initial_num_blocks_is_1_encrypt
 	je	_initial_num_blocks_is_2_encrypt
 _initial_num_blocks_is_3_encrypt:
-	INITIAL_BLOCKS_ENC	3, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, enc
 	sub	$48, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_2_encrypt:
-	INITIAL_BLOCKS_ENC	2, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, enc
 	sub	$32, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_1_encrypt:
-	INITIAL_BLOCKS_ENC	1, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, enc
 	sub	$16, %r13
 	jmp	_initial_blocks_encrypted
 _initial_num_blocks_is_0_encrypt:
-	INITIAL_BLOCKS_ENC	0, %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
 %xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, enc
 _initial_blocks_encrypted:
 
-- 
2.9.5
