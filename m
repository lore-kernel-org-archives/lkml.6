Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161364AbeBNRjm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:39:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161296AbeBNRjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:39:35 -0500
Date: Wed, 14 Feb 2018 09:39:10 -0800
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
Subject: [PATCH v2 05/14] x86/crypto: aesni: Merge encode and decode to
 GCM_ENC_DEC macro
Message-ID: <20180214173910.GA61943@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR14CA0032.namprd14.prod.outlook.com (10.171.142.146) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb2dfca-e7ca-4526-1484-08d573d1dec4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:TNBhti3dMJCOiQgBOo+fanvM8eoda+RAkTPHGFUhl92zQTYILxp1lKmtsSobDiyUeL4NrnBYV+DPckOn0mmSDfWQX61LGfHex2Jcl3EptSkCRESiPRfeTKZTHq5JbW5pHXGozlWdcXGJ7m+yRpO10fz84eWuCq0Hv0Ug4wtmGDk8KQJTQTT3hnLFlmqG/nkurFldGIj8DRofyxwabuV9IAonOtLYJjj/gp98SItAbcwU4KPmCyuKI8sEdeqF9YAT;25:EE5ZjjRjz3nfgZ7McOTN/N8fFgITZWCUVrDUL92+Ev41CMQg/Rk9E5/xf1NwstLuYwdDRXBxg9IfyEfPyfdmjCyvNoIxwGJanxWK7TZLjZaU+Y+B+DfvapYWS6y8s6GvCjXPQs76kduE4kvmsyPJXruSpgggX3fO/6INXa2tPDPqYuQs082FYiNM0k3+0SF0tm6otUycu/p3oxZi0InVwv5E7FliFwMOagIiAYRu8sT9yCQx6pgVgismV85xLOEnWNyDh518qomjOzo32+uG6dgchtRdPTjPDCUVVVJ0pydZaUT9RuhjYbOyLdpCbTTXoIzpM/ssBvVlmTuXpy7k6Q==;31:6oEkAAElrWxmG/26bfkHjMOaJcIjpar9jy6NSUwtNQIEI71tB5nXCnSrQSsjlq6c+WxpTC71Ym9VC3wsA4QSmhjv3GFStl50NHeCMpPQvzZClNYQRR8JlRGiTs2pt+/TnwKFScfnofpVwP3iAcyIdhpjEOaD2WnIG9bbLdbosh+rq/HMzhVQvxtDV4itg45IZJxl7LZRIuoorP4QM0P9wBAkG1MBrGKWUODdRJtw5yM=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:F3XTdVAe7lemneok81Xka9c6PDxHof7FnnDPaGcmsw3U+Q3aL58kDorPtR2GK2wRXIyp8/tG0R6JTe9pdfr/Dyc+laJjznTPfYG09nb29VtxrT+BpYSq5KEs8WM8evReeExvruaCsSv5UnyhEWzdAJq5ToXvMjDHM9EW2ypm2Lx7MSnN07EISXuq0qwS2ayAPGOMuRftpcMWJaBQpuRioSgcXamxlEqm4Qm14hHzDBzNaq4ZeE5QpU21Y+9AEkAxwTyj17cfSymS3nJch2RDmtR5okHJj6c6MeVUuACPWYNak1ZUNul076ZzBqYEYf6tJpojN1+XhMtPtr4x6jk5iMSD4R3mmQLG9pAroVXbEyUHy7pcCRQU3CBOSTu1xLQi8aA3hn/RHPLGNvMw0c8HKpB/Dluq1qLi9WYq1drWxr2yqaToXpEwQPog0sBOcNLRZQ7AGzqtMiek+Oj9/ZQG/MKUTcXG52zH6RRcs6i7UkmgUZteCy7BurQWTZnmq7EN;4:hTaHQ8Ty09GBEoomNbGoUPMriZ5IBpl6wOIz+DBj93SSyA59CbeRc5fOBHm8AoyGGey8Zzk9rnByoz+kVnOdeeFWRDwLY5O8W9rTDPkMIg4hvSodYk0d124op2HLYF5s0OMHIxTH+N3s9Q1E9CUaoQQvh8P8MFmgfzAW9LRviH35bltmqUV0+6TJz1pzBCv5o6U/BIp4guH5bXu+0P8OSTUuD9WZC516+jwFH3heGoV5WUNRgEjL/BPw6as+lP3nY1UTACiuuaIVZbb4IONNeD1Trc71QqNj5ql6p4jwRET2yspWAZlmBf9nCPuXhWqDLc7WPw2XGAUI72Dwux8ZVJIZHWclfJPAbSIDO6tkE+g=
X-Microsoft-Antispam-PRVS: <CY4PR15MB1752D9F2B34A65DCFC5A22FDDDF50@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(305945005)(59450400001)(6496006)(52116002)(9686003)(52396003)(83506002)(54906003)(16586007)(58126008)(76176011)(386003)(33896004)(86362001)(16526019)(6486002)(8936002)(316002)(50466002)(97736004)(76506005)(7416002)(110136005)(81166006)(105586002)(53936002)(186003)(68736007)(4326008)(47776003)(1076002)(2950100002)(8676002)(33716001)(6666003)(81156014)(106356001)(2906002)(25786009)(23726003)(33656002)(5660300001)(6116002)(478600001)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:pb4PFi2ykp5ln3ph//lwjJ6IaRFxyVDOR3iWh3xjh?=
 =?us-ascii?Q?VN9iUqBDt5thdIrSuaCJm0sm407vMUSvntz27+xYnl2ox0HyLmis9Iv3myrr?=
 =?us-ascii?Q?VA7UUT8ehNr1VVwMvTR7vWTcU64qiLuuZChn4zzNegEqZFiuIPS2A3WlyxDc?=
 =?us-ascii?Q?Er6LushEQCV7TzAt2nM5tCZEbWdvKUzlHzPnBaeA0UKuF685UFEi9sbMsJQp?=
 =?us-ascii?Q?n9yeTlNXVIa0apOPKjf8813qtybsc36k+XKYukc6im+dmGFUIx2MVFQJhWCZ?=
 =?us-ascii?Q?QZANzxKmRbZk7DNd6vZ1ggHB3mTT7oMd9BbMz1f6q8Dw9P/y77UZ4fg24roj?=
 =?us-ascii?Q?6gXryzf6HtEnLn1Gw0DnFvShLCiEmFZiKqpm30T4k2OkAE2dYu4SVsAiiN3J?=
 =?us-ascii?Q?PmIYX/hxp1pmhPqPBHDHHrqgFwq6BZPVR39pDmMJdLrquLE6RrHVkyHZpYaa?=
 =?us-ascii?Q?dRaxIq/ao0gP9TTgn0tAl5z2m+FO/BljyvZLYpIt+mFFEFhR8rRSqUlVnuHC?=
 =?us-ascii?Q?3IfjMIWfLAFGjRuWRP6NK5kEi4uMNfF3ABEPSUwmmH2GmP03m26yqhnl3HyH?=
 =?us-ascii?Q?EYk7Y9VkhVvPoqg7CrGirnmhfy1gouwZMBQVX/Hncu1YhYY1bBWUpVBgpG3t?=
 =?us-ascii?Q?FXi9XSd9nJJpUVWwpW6sMmrUxmL1WgdvLDcROJUFmPdxEgBGK/ACiEPtJT4J?=
 =?us-ascii?Q?MXNEvDSXFSXU9PKzJGRZZ7FgPZGZ9z4tjWH+91+z74NNaW7bQQiI/7HTUGWs?=
 =?us-ascii?Q?0h365LJX6y3MX/Y+fzi0Z7AXliSqXawEyCFcVruv9+EXoABblR2Z1yRrvjJ0?=
 =?us-ascii?Q?+VlH09UhdshlKCPe0XaZKgoqxETruMIpdOlrQpygCiIaFYQjKy+KbGr7GIzB?=
 =?us-ascii?Q?xSfMQq62Nml6+2B7Wo9YH757xhRZO7rUDp7dxpYPCiwmArjyF/mUASXnGeg+?=
 =?us-ascii?Q?1dmm5moMzudNGiRUVS4fUVcKY7v+LeFKpuO8yfgF8Eyn4dywci4y2jz88Vn/?=
 =?us-ascii?Q?vovfs6gY13Psq1LYj+fLs+Giyk69Hr0w5AnjqZUTi5lHtj8wCmznbJqgtH+G?=
 =?us-ascii?Q?ccDfls3EBvpfrNNhVq4E5Gf6bu+UDkfVfldolv1OW00hBPT41lDVglkeq907?=
 =?us-ascii?Q?E3PeGa0nnBe2xhjWsDzVLzXssTtWHopPQfMkcgEEm2uh6B19Rn8I/xyASpmZ?=
 =?us-ascii?Q?nOuUALDJvNtsU1bTcaYOmtSZ3S+6xhxNyZFnVZdT0u4aTMp2dM0DZ0Yl2ol7?=
 =?us-ascii?Q?IwruG7vhTZxc1VaPSdg/xIAoEzkX06koDkhRoNQK1p/Ej58Zc+MFVrxvcDyj?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:Nxr9HMUNyl9aEJDG7HjahygwKxJmdpP1ayTaZH+2a8lLbq02zURSXTCHFIDaSrNrlci228k3UgGGBaKIDPh11OcTVNOCZjE1aI5jHwiY9EEFjXGqaugVFAxnePeERbHSnvL1L9O/jlQ4fv+aHmhlGQfst3OiUrPu8AE/Fz/ERtSuKmQlM7Cly3S6MtYgdgYNl2Lhx6ulLECe/pmiH9akzpy9PPwrIMLruh6JUP9bgJfWvbcOa2+OYKahPx6Mp+9ARWvXGsMxz+HvLfCzw17gaC7FJ9W+dRFR1mLsBUDzMFimHgIQlGctM8W50xvTG8KkSIWaVXfZvmlWReBhT8dY4RrRT8S1fNla4g/zBhAOY3A=;5:zjXPnMwNiMWiAZMubezIa5YPKUjkzRHjVIoFpeCve0wpHrFAATTMuophu2ztQYOv5p/BNrVrKHNPH5vtn3Ww+SpmR7RcDJe8FfShSsshT7WXmIWrkjs0ZJMH4TiyOGWzNwvR8exZwoUhPnOdPDqXopTx2zLpjqLMJuXTAb0Il3I=;24:aIS33v8s0lUMewCJJhUy5PKLeZ29lT2crgmRg9qFFWbZWgbfJZGRv2EVZr01QdeCuAriVveO3s420+y66XDVU4kM9e+md32DoqQFy0UUW8A=;7:76wXmZK1jL8xRXJvffiX4u9RTksXsX48SVb8Ve7ISMQICEHyN0I8jHc6J/Q3Jt/lHAWJosjNN/MRjfWJcGqA0B2auqS9KDj/MvfXbH9pY5hAoYjap12t/vJqneRaajnWzoxqgzD2ZpYO3PP49lgbqLip9MWFnN0t0Ai1RQAwRCigpnKAdnJRneQ6EGOFosJmccpnLDvFX/MOEzcdwpN+rmt/45+qG9WsqlDbR057SMknweyw9l7OnzNCeKNksQ4M
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:s9HDqxeVezPVpHKnw8YSVp/fj4LD9cdZkSmwS6wlZ3PREBbwm1IrFvv3fTOUszO1ABsOb+WasqZpq0651D3FlP/fZfxH4HP4/EBqMftPVUi24ASygUkXqVXVbV/qqxaH01IBsE84xdNx1R6pwwH3yrdp1KVLjHTSIKWqSTZ5m2I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:39:16.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb2dfca-e7ca-4526-1484-08d573d1dec4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a macro for the main encode/decode routine.  Only a small handful
of lines differ for enc and dec.   This will also become the main
scatter/gather update routine.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 293 +++++++++++++++-----------------------
 1 file changed, 114 insertions(+), 179 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 529c542..8021fd1 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -222,6 +222,118 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	mov	%r13, %r12
 .endm
 
+# GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
+# struct has been initialized by GCM_INIT.
+# Requires the input data be at least 1 byte long because of READ_PARTIAL_BLOCK
+# Clobbers rax, r10-r13, and xmm0-xmm15
+.macro GCM_ENC_DEC operation
+	# Encrypt/Decrypt first few blocks
+
+	and	$(3<<4), %r12
+	jz	_initial_num_blocks_is_0_\@
+	cmp	$(2<<4), %r12
+	jb	_initial_num_blocks_is_1_\@
+	je	_initial_num_blocks_is_2_\@
+_initial_num_blocks_is_3_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, \operation
+	sub	$48, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_2_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, \operation
+	sub	$32, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_1_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, \operation
+	sub	$16, %r13
+	jmp	_initial_blocks_\@
+_initial_num_blocks_is_0_\@:
+	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
+%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, \operation
+_initial_blocks_\@:
+
+	# Main loop - Encrypt/Decrypt remaining blocks
+
+	cmp	$0, %r13
+	je	_zero_cipher_left_\@
+	sub	$64, %r13
+	je	_four_cipher_left_\@
+_crypt_by_4_\@:
+	GHASH_4_ENCRYPT_4_PARALLEL_\operation	%xmm9, %xmm10, %xmm11, %xmm12, \
+	%xmm13, %xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, \
+	%xmm7, %xmm8, enc
+	add	$64, %r11
+	sub	$64, %r13
+	jne	_crypt_by_4_\@
+_four_cipher_left_\@:
+	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
+%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
+_zero_cipher_left_\@:
+	mov	%arg4, %r13
+	and	$15, %r13			# %r13 = arg4 (mod 16)
+	je	_multiple_of_16_bytes_\@
+
+	# Handle the last <16 Byte block separately
+	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
+        movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10, %xmm0
+
+	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
+
+	lea (%arg3,%r11,1), %r10
+	mov %r13, %r12
+	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
+
+	lea ALL_F+16(%rip), %r12
+	sub %r13, %r12
+.ifc \operation, dec
+	movdqa  %xmm1, %xmm2
+.endif
+	pxor	%xmm1, %xmm0            # XOR Encrypt(K, Yn)
+	movdqu	(%r12), %xmm1
+	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
+	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
+.ifc \operation, dec
+	pand    %xmm1, %xmm2
+	movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10 ,%xmm2
+
+	pxor %xmm2, %xmm8
+.else
+	movdqa SHUF_MASK(%rip), %xmm10
+	PSHUFB_XMM %xmm10,%xmm0
+
+	pxor	%xmm0, %xmm8
+.endif
+
+	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
+.ifc \operation, enc
+	# GHASH computation for the last <16 byte block
+	movdqa SHUF_MASK(%rip), %xmm10
+	# shuffle xmm0 back to output as ciphertext
+	PSHUFB_XMM %xmm10, %xmm0
+.endif
+
+	# Output %r13 bytes
+	MOVQ_R64_XMM %xmm0, %rax
+	cmp $8, %r13
+	jle _less_than_8_bytes_left_\@
+	mov %rax, (%arg2 , %r11, 1)
+	add $8, %r11
+	psrldq $8, %xmm0
+	MOVQ_R64_XMM %xmm0, %rax
+	sub $8, %r13
+_less_than_8_bytes_left_\@:
+	mov %al,  (%arg2, %r11, 1)
+	add $1, %r11
+	shr $8, %rax
+	sub $1, %r13
+	jne _less_than_8_bytes_left_\@
+_multiple_of_16_bytes_\@:
+.endm
+
 # GCM_COMPLETE Finishes update of tag of last partial block
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
@@ -1245,93 +1357,7 @@ ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
 
 	GCM_INIT
-
-        # Decrypt first few blocks
-
-	and $(3<<4), %r12
-	jz _initial_num_blocks_is_0_decrypt
-	cmp $(2<<4), %r12
-	jb _initial_num_blocks_is_1_decrypt
-	je _initial_num_blocks_is_2_decrypt
-_initial_num_blocks_is_3_decrypt:
-	INITIAL_BLOCKS_ENC_DEC %xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, dec
-	sub	$48, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_2_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, dec
-	sub	$32, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_1_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, dec
-	sub	$16, %r13
-	jmp	_initial_blocks_decrypted
-_initial_num_blocks_is_0_decrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, dec
-_initial_blocks_decrypted:
-	cmp	$0, %r13
-	je	_zero_cipher_left_decrypt
-	sub	$64, %r13
-	je	_four_cipher_left_decrypt
-_decrypt_by_4:
-	GHASH_4_ENCRYPT_4_PARALLEL_DEC	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, \
-%xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, dec
-	add	$64, %r11
-	sub	$64, %r13
-	jne	_decrypt_by_4
-_four_cipher_left_decrypt:
-	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
-%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
-_zero_cipher_left_decrypt:
-	mov	%arg4, %r13
-	and	$15, %r13				# %r13 = arg4 (mod 16)
-	je	_multiple_of_16_bytes_decrypt
-
-        # Handle the last <16 byte block separately
-
-	paddd ONE(%rip), %xmm0         # increment CNT to get Yn
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	ENCRYPT_SINGLE_BLOCK  %xmm0, %xmm1    # E(K, Yn)
-
-	lea (%arg3,%r11,1), %r10
-	mov %r13, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
-
-	lea ALL_F+16(%rip), %r12
-	sub %r13, %r12
-	movdqa  %xmm1, %xmm2
-	pxor %xmm1, %xmm0            # Ciphertext XOR E(K, Yn)
-	movdqu (%r12), %xmm1
-	# get the appropriate mask to mask out top 16-%r13 bytes of %xmm0
-	pand %xmm1, %xmm0            # mask out top 16-%r13 bytes of %xmm0
-	pand    %xmm1, %xmm2
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10 ,%xmm2
-
-	pxor %xmm2, %xmm8
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-
-        # output %r13 bytes
-	MOVQ_R64_XMM	%xmm0, %rax
-	cmp	$8, %r13
-	jle	_less_than_8_bytes_left_decrypt
-	mov	%rax, (%arg2 , %r11, 1)
-	add	$8, %r11
-	psrldq	$8, %xmm0
-	MOVQ_R64_XMM	%xmm0, %rax
-	sub	$8, %r13
-_less_than_8_bytes_left_decrypt:
-	mov	%al,  (%arg2, %r11, 1)
-	add	$1, %r11
-	shr	$8, %rax
-	sub	$1, %r13
-	jne	_less_than_8_bytes_left_decrypt
-_multiple_of_16_bytes_decrypt:
+	GCM_ENC_DEC dec
 	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
@@ -1417,98 +1443,7 @@ ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
 
 	GCM_INIT
-        # Encrypt first few blocks
-
-	and	$(3<<4), %r12
-	jz	_initial_num_blocks_is_0_encrypt
-	cmp	$(2<<4), %r12
-	jb	_initial_num_blocks_is_1_encrypt
-	je	_initial_num_blocks_is_2_encrypt
-_initial_num_blocks_is_3_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 5, 678, enc
-	sub	$48, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_2_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 6, 78, enc
-	sub	$32, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_1_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 7, 8, enc
-	sub	$16, %r13
-	jmp	_initial_blocks_encrypted
-_initial_num_blocks_is_0_encrypt:
-	INITIAL_BLOCKS_ENC_DEC	%xmm9, %xmm10, %xmm13, %xmm11, %xmm12, %xmm0, \
-%xmm1, %xmm2, %xmm3, %xmm4, %xmm8, %xmm5, %xmm6, 8, 0, enc
-_initial_blocks_encrypted:
-
-        # Main loop - Encrypt remaining blocks
-
-	cmp	$0, %r13
-	je	_zero_cipher_left_encrypt
-	sub	$64, %r13
-	je	_four_cipher_left_encrypt
-_encrypt_by_4_encrypt:
-	GHASH_4_ENCRYPT_4_PARALLEL_ENC	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, \
-%xmm14, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7, %xmm8, enc
-	add	$64, %r11
-	sub	$64, %r13
-	jne	_encrypt_by_4_encrypt
-_four_cipher_left_encrypt:
-	GHASH_LAST_4	%xmm9, %xmm10, %xmm11, %xmm12, %xmm13, %xmm14, \
-%xmm15, %xmm1, %xmm2, %xmm3, %xmm4, %xmm8
-_zero_cipher_left_encrypt:
-	mov	%arg4, %r13
-	and	$15, %r13			# %r13 = arg4 (mod 16)
-	je	_multiple_of_16_bytes_encrypt
-
-         # Handle the last <16 Byte block separately
-	paddd ONE(%rip), %xmm0                # INCR CNT to get Yn
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	ENCRYPT_SINGLE_BLOCK	%xmm0, %xmm1        # Encrypt(K, Yn)
-
-	lea (%arg3,%r11,1), %r10
-	mov %r13, %r12
-	READ_PARTIAL_BLOCK %r10 %r12 %xmm2 %xmm1
-
-	lea ALL_F+16(%rip), %r12
-	sub %r13, %r12
-	pxor	%xmm1, %xmm0            # Plaintext XOR Encrypt(K, Yn)
-	movdqu	(%r12), %xmm1
-	# get the appropriate mask to mask out top 16-r13 bytes of xmm0
-	pand	%xmm1, %xmm0            # mask out top 16-r13 bytes of xmm0
-        movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10,%xmm0
-
-	pxor	%xmm0, %xmm8
-	GHASH_MUL %xmm8, %xmm13, %xmm9, %xmm10, %xmm11, %xmm5, %xmm6
-	# GHASH computation for the last <16 byte block
-	movdqa SHUF_MASK(%rip), %xmm10
-	PSHUFB_XMM %xmm10, %xmm0
-
-	# shuffle xmm0 back to output as ciphertext
-
-        # Output %r13 bytes
-	MOVQ_R64_XMM %xmm0, %rax
-	cmp $8, %r13
-	jle _less_than_8_bytes_left_encrypt
-	mov %rax, (%arg2 , %r11, 1)
-	add $8, %r11
-	psrldq $8, %xmm0
-	MOVQ_R64_XMM %xmm0, %rax
-	sub $8, %r13
-_less_than_8_bytes_left_encrypt:
-	mov %al,  (%arg2, %r11, 1)
-	add $1, %r11
-	shr $8, %rax
-	sub $1, %r13
-	jne _less_than_8_bytes_left_encrypt
-_multiple_of_16_bytes_encrypt:
-_return_T_encrypt:
+	GCM_ENC_DEC enc
 	GCM_COMPLETE
 	FUNC_RESTORE
 	ret
-- 
2.9.5
