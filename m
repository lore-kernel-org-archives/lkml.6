Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161406AbeBNRkS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161237AbeBNRkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:40:11 -0500
Date: Wed, 14 Feb 2018 09:39:45 -0800
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
Subject: [PATCH v2 08/14] x86/crypto: aesni: Fill in new context data
 structures
Message-ID: <20180214173945.GA62068@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR20CA0003.namprd20.prod.outlook.com (10.171.151.141) To
 DM5PR15MB1755.namprd15.prod.outlook.com (10.174.246.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc32246-e178-4127-2d0d-08d573d1f283
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1755;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;3:+AiI+Sfu6EUFha2tQxAssNZSogE+49ZUeXq4sFur8mKfHUxHb/7FopXhAyLuF9ytK9xMqfFC/yQoDeosvxLDBG2AZVxDZKO9Am3a25zfer3q6ijl4vmX1nQY970UiAX7EkUOta5AfXluSa5BraLJ+RB0+kVR24GrXPLWRI/UOpd8MGX66TIPpxciRSbDqjNO/H6HIY6yt3ymiwJ7EIzsKsS8+VIJrHz7f7obJ0hkFjhAoD8MnzDYdBk0nF8/RAO0;25:ZBz96VV4XlZu1g0XQQOBbCbgAIjEgewqOebeqXu67CLzl9LLGWtO73MCqLqUhoVDHksN/y2bgH6L9nIg4M75uXa8yMGs5TrPpmB/PBwzaX4wr8L3uTGXXa9IvLhaGF+zlM+U7/07IYSuKsJkBCU204lDjwaBQRhgo7SimM7bJvjEtqh9FxgPhiDaBH+tAzCk8LenCjQSjY2KOfod6xjHdAfTrI5CAuHQCPQ0rzDytkZnsUoFDdOLYILoCjsecQ67FOnm7jzBmu5eN0207zJ8HKz0mYHBUoD2YUOTAZjvjhl6qfMH9keQRh6x/9eiWcvw80u/Lk8VLO+CIkHwl3c1pA==;31:NOXXRsW01fmQBcEIo9PWg180qsuBYv7LxF71uQcBv7l3G8cZ8uT3ZMY4sA9nJNlLVb0zy3iN6fdGKQBFF3/fh9p5+1ZlySVi4vVTT2CCAQBPkOfWdYL5Dj8N7vpFTDw5WmTspVtDJ3bvvzadVN653GpBgFHobyshFLbVxOchGZ4kZ8t+PKbAk04PqJFA8PrsVu+gBCsb8oRQRxS+tp6xzMK0nPjkD9BcSFFAOGP731o=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1755:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:kUH6eH6bBvGh3z73KK6e7UMog51LCVNNWIHUhdrxQ+khf/60DBIoTVtl78iJNqbwG2L4giGfRx8DANCCdsDNvfQ18NjuNmTiYKv9EUEXg2ZQJ45jZUlq0X4+JUGDah7nftvIvrKfQmuwyk+3fm3iCxeSl3k/hYNaexfzsdjbHjXtAag4QOaSODGhviWeW3ukLSSQipA25RcDSfV71QjfksqGUsyApekvhMDP7ewPEfKRrbK0cwVgi7h9QpFOBQh54obHQi3gjzMF8X/IuPAHE3OlaF4cTEq8Edygvm3qwxTJX4uJSa0rj4Cu8dIw1nUDrdHMirowAWOp5GH9jli7ZYkeXCJQTqW1lAKL8/k/Yuxda75CXzSCGBrTLFW2ZuGI9ODTr9KofLvxAgzU5Mh0F500rSDAx99MLQUB5FYyN7qr9rtIfKn/Ca+EZPvRLvxEYmxqpgNkJQ/5llw32nR9dZrg26Z+uW4yGmYXEkaVNuJ9UBsS0wq2TmML/xhu6UDf;4:FjLB5EMU3aCPNzcfV37SH5I0rZpra/q/v7793prlCNNa+djjudUF4v6Lc9nfox2wlJRjYxVxS/5Tu8I/aDgFIIGnzE/ZuXYgJx0gZmKYiWPTXmfbeSrnvg2IVabLo6+FoKI17z4srdn+lsS1Sf8BpwNxPM1Bz1/gsA1u0L+mUUMzfl/CTnRSGtNrN95Mn4tEq8tm6x+b4OeF+TmgROLNkovnXVEC3EVEYnstzk/bb8vd9FeQM3mGozSsT+mFFtzWOJ8ZH+lKDC2X7xt1xrwjColDl8yKq9uaVTJBLhxeN2a7y1ge37YhZcZXZeWNSLZmt5JADHgS6gnC96Ltpclh2xucrppI/5DEG4Vu+DxoQcc=
X-Microsoft-Antispam-PRVS: <DM5PR15MB175504FB61A8769B88157A50DDF50@DM5PR15MB1755.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(10201501046)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1755;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(199004)(189003)(9686003)(53936002)(6486002)(6666003)(2950100002)(4326008)(52396003)(52116002)(6496006)(16526019)(76176011)(33896004)(186003)(105586002)(478600001)(5660300001)(316002)(58126008)(386003)(16586007)(25786009)(50466002)(106356001)(33716001)(76506005)(8936002)(83506002)(110136005)(54906003)(97736004)(86362001)(8676002)(47776003)(1076002)(6116002)(7736002)(33656002)(305945005)(23726003)(81166006)(81156014)(7416002)(68736007)(2906002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1755;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1755;23:2+EykhxYQl/vDqvabGQzNPF3nOoNVhRSlkjh860vO?=
 =?us-ascii?Q?PnQykcsbPEt0Jw+Xw0V/rEXwTrCzjHO8SBp+eilO4DaHmXFIPDDQVtDFpZ3f?=
 =?us-ascii?Q?ZosTPct5ZmlVjveTHvvxcJeExpD/3+J5MYPmnetjcG5ng7OF7ds61Uv7tDlO?=
 =?us-ascii?Q?pnvWRRGLzKUUYDAw1wIa/Ay2U755YoTkwKUBxEP136fXIE0NdZbZ2SQsADm+?=
 =?us-ascii?Q?j1Kefed2aTIvlLTVKk/avB16+l6lKzNqd6lVdkR376d/baSmSBqBYlzuyxOG?=
 =?us-ascii?Q?yOoTE7uZX27ohQUrUGGim6oCwUrBHuVDyc6Q+PojGhbuNAb0IRt3wVmPByhf?=
 =?us-ascii?Q?ddggHByRshvSsf8RUD/JD7EYvnl4Cg/RspQ/jEqlnsoLaGncPdrnAGH2S03X?=
 =?us-ascii?Q?bFmay0Efr5PIRlw03IhtK9WPBYTYaUC5kOF7+fO3/U+6iql3hJKF34GpSqIH?=
 =?us-ascii?Q?0lXBwlwvSnKGIceTSa/Kq08qqgD81ZV2SNN4zQsq4HFcnd5sulOpWjuKdfGK?=
 =?us-ascii?Q?kwjk6vyGGwMUqjMOZrHUIsIL1fZPCPJrZ06B+l1ELhLg2ch7M8Qd5pIWXSET?=
 =?us-ascii?Q?MQmN6doaEHYefPO3fU06/h/yJ33iNJ2MGhilmzp+hrYzvqgtwYfQ4JuyHC0Y?=
 =?us-ascii?Q?AIkfa40BwFALhDP47xVZSaxBAkZG2UwwDp8DmvOpqFgZAWBEo3FgqyFNLB8N?=
 =?us-ascii?Q?rlDHePzS/4f3mWT/P4OWMd8Axx7XRTSKPoZzs5nyr+POrRNC9sOFxTaOjyxM?=
 =?us-ascii?Q?ZMoN+IBtf9RFXMnepeIOJLX3uAQVzX5dorgVnP8pbavo1I2jYIH6WFkCT2ss?=
 =?us-ascii?Q?mQl92u8KJdE752AeCeg7JHMTRodUSs26SXkOVVfmkwgXm2KI4l3f2rdO9ldT?=
 =?us-ascii?Q?MNzCIXUrhnlqhG+7meEiAiIm+Kxq65c3zooF+0hbcsdlyr+krPUbGSwBEm34?=
 =?us-ascii?Q?PYlOobLONypJv10si1LOm8vD0bwhdgtUjUh+DfahHHqNw/JSLROZMwKR3Lx9?=
 =?us-ascii?Q?02BKwiHdMFLJVkgJcxoiF+6WDy/G8XkguUfhT1jxY55tkeVhL38hNW8wApCh?=
 =?us-ascii?Q?43VvQLl1rDBO6/EEQwNQnhUTdUCKcktyX1FtCjxtGSJhB1TUTLque/uITvat?=
 =?us-ascii?Q?PIg/ZPw695ipQEFkdCfbMXVvexo6CtiD4xa0yMuf55LO+SWrwIZTbA6K6XSH?=
 =?us-ascii?Q?hWk6WetkynLDZG5K7j/y80RGrJDQxti+pIlfgilrv5pzwjCFxjZ8f/mbjTpl?=
 =?us-ascii?Q?aFYh+ZZBs0jm0yz/vc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;6:xBbyM7mD+KFw2I+hHuM9z1fFkIQpZjZPlMqUXxKosUEtSokBjkGoDkBo6jyUg7K2c3mAfDs5QV1aXIVT+WE9Kr3hwiyiSIonCJCHI+piQZ4VOeY4Vqk63R+cwMjBia3q0uhQjwX4dAqPpWzhtpDSbVS5tMdBkhpdMXodAC8jcEg//gtD0vAen97LgmjCrP6A0LZ0TWaz0b+amwe2k9Hs9hY77qxrXCn5yY8ziKTijZ/pf++HirmyJ/HsaQxcErWcxOCDf/Nwv9Pynmr+v7mkUixt0BwZdR+V/u/m2dQp44s00swaUw3oMRQINMydnXI0pJVcP/GRMt65ihGf1rDWmpMUrotodb8Rh+jKF75MpoY=;5:4zz1KydzCpK0YGdc2pFIILtyk/W3SOFUhnJ3GekXICfvonXJNq0WTb9jIY0HwOJ2SZHS19xq7Y+1/NAhF9MxRdduN968wGb5k62QSKPIlYG9ek0tlzrnaaxjM7iFQCizChgpck1vikBXWKMUIPOLa3j71rrq1JO8lr3Af3tO3WM=;24:QIO53avNPpnFDd3uWzu59fE7t9Rv4Ku11g8jU6Ir11NdSPD1wnLF3oV9yNIsuIboRBvrsnQsGr1MiToFEZCvqpHYSmGyaltQgj9Z7x2hseE=;7:MsP/mNhhQgkQ7V3cv6dM6n1zwyo/iAFmPWmdWRdOv0o81ADyGq6l3+ikGedAjgGJXc6ThKXySOQwoQewuhzWG4NUqW0+5r2gR8mtMa9h+qiyn4i/nP/NO56EAMqSX2MkPyqOtNV4nvjietzvNG4DBakiTNJnxR1XJVByMfdc0YDj2KiUlWbYw+laLReKWPG4czrDNweweJDo3lgX2TDP7MTSkSCzXDZxCCTAQRzBIzV9dAogsd1SKoyJIGfv0Mjk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:CViD4wIFy/I5AgVWQ6zNoT8j3fR+g3UAMzeGsiXPuV2tN7Yki7LDZQOQR/DNK/45NF5eAJiPmw+urs9sZ1mOYlK4oL1kAFZB3JoeAy6C4x7WP9PW3a0HmGyd4MOk4mC8Xn4kulMePrbM6VkTwJ+OVQNdn+A2dlja7tD0k0AA+OY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:39:49.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc32246-e178-4127-2d0d-08d573d1f283
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1755
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
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
