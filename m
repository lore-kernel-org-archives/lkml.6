Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161379AbeBNRkC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:40:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161343AbeBNRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:39:39 -0500
Date: Wed, 14 Feb 2018 09:38:57 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Sabrina Dubroca" <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH v2 04/14] x86/crypto: aesni: Add GCM_COMPLETE macro
Message-ID: <20180214173857.GA61900@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: CY4PR20CA0006.namprd20.prod.outlook.com (10.173.116.144) To
 DM5PR15MB1756.namprd15.prod.outlook.com (10.174.246.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527e5cbd-9223-4601-d54c-08d573d1d761
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1756;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;3:1QaLt6/8bNZDTDzDfTtbJBmHfp0RAaXY1f6abjhU1B/fWf2i0LaRFj8YyGxbjkIJeyw2eNi8MKk6wclltizWc1kYXPH6iQ3YVzsPAbsqT3Ui9sSDdk3Lq93GI+BGPZeI2CHOYJ/Nv40p9NRaVIOeHFdmmM3RyR2R4volqKeBuhlmPyrPRacPIWC2t9FzVAX28NulSw+ijtKdunuCknlWB0oo3j0dwKy2jFTEQnSDsN9EBoKxT1O0tt4QRWAha2Rp;25:sz9MzglbgF9nVuv/5JU/4fRqzKit8a/KmrZodVqpGCPOOwmORycSl0QvGZeFwqMYu+CZ5yOa8p3ApcY9r2Oodz5F1igc0+UvMIHh4p3oQWUwS6YYbWj8QgL4sViaHCIMR5yc0cLCWCvjDh/kI17ShEI65/6QqsWWvVoY7Cz/0ZIuhntH5F4oymTY5XxRkGKox63lisYFGXgGV3XloOoUv8sCr7r6J5QwesvGAcSKu1j0OkHuMBvxtsMMTMRmZynrsI5b+lOvAIieOzFOSZHI4ZR+332kM6RjJcUBiJHgJ6nVM9TCO9Xb31oeUFtI/apIupRai8jYycIylNlOV3ppmA==;31:e7DD4JQXkooi7sSFh06ypubUjxdC8E7a5JvF75EkwLg28pl0h+1HcoyB02Tx4zU9629ude5pV7HZ319LsG4JlM37XqDfNn1nS3gwG3/FJsi+kq8o7NgHCEeeq1WKW3rj17qyTI1cIs2wVDJIMVg1bU7QiKUGRR2KgABbpfqp6OfG6waesroe3q03TgQHG5FdoPrSZqxl6Y5g77Nu1KOMOa/veTLND1VuqLfOI8C9ex0=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1756:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:Z0vnxfyKyjTKhoneUL5fSZGj7pJWrgvVjv3UFZDv3jCxBX+reVWPFsydZe4BSbmWLTU7kiWRrM/zuUU9qleYMrClkb+Q/+of64BHBz2E9C+1iuUdLZt/85h3fYCrRu2wKhehV7EYoVRLS7NeAtO4TVDI6Z4TdKzd5bcqIV9nFzE7W1VkvBQEJqvV6ZCatRBRbWEDjBNGsNWnGjj7MwNX41LgzTjFdOpqBj8EP/hBpCASVp5UhQYwFwLJGYUKv63a4UtZ1v43h9Q5L51xsGeBE6HSWnpE/GHOJ3w6WITfHfwTfoYAlxmfOxNrsAI5oXmTbxGit+XhQwTku+e+E4U5rTlNp/GNHYDOM5gUUKN/Da1C7+ZHbK0ep0pc7lEvWgSfhkGQZLCJJCEJo6sTn12Zql41lcRV8wKVScMpnVl8cshC4nLIp1g7GckyucIXMu/THvOKulh2oirPjx1Y8jbNdbZXkrAz3ySUwXqlT1mhDIE/0YHkSvVoO3CKp6Mi1RYM;4:d490DTrZVz8fsee0CyMbEs4ZgHqiNdCDKQEwS2sqQ8JqJHWu8md+Taeu7rJl6/Ttz+BSIbUqILwqp2JeEhaBRNhh92g7jKzjMo6eBa+CpiFvA1R2oGSaxzCO+AHMNUR+dlvNw1ihYWPvHO3dxO/1fQKemQ5CSInBZD/pt1exNGSUuEw41UkZiLV9MWQwpk+S1QLVAQu5bI+vbtncPcvz8KyX94Mcgr6M0HQoX5CeIS2XCNRgwJLMcsM2WdTISmsexQV35RWgZTeKT/9iG2mOWIoqzKlQlHqBPrwQ/3Mhq6Et20PC9i0YNBrN6HL8mae5r7foLw8JcRJMmGuhu0l/HNLoXseDoa73CZhpf4ZJD7Q=
X-Microsoft-Antispam-PRVS: <DM5PR15MB17566FA0F1D0AD5DFC61F157DDF50@DM5PR15MB1756.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(11241501184)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR15MB1756;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1756;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39380400002)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(68736007)(4326008)(305945005)(7736002)(25786009)(33656002)(478600001)(8936002)(6346003)(2950100002)(6666003)(7416002)(81156014)(106356001)(59450400001)(76506005)(33896004)(52116002)(386003)(81166006)(52396003)(8676002)(76176011)(5660300001)(16586007)(6496006)(50466002)(54906003)(58126008)(110136005)(186003)(105586002)(97736004)(53936002)(316002)(16526019)(9686003)(33716001)(2906002)(47776003)(86362001)(23726003)(6116002)(6486002)(83506002)(1076002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1756;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1756;23:1ntzAvIYGfuW4TnAGYODWeQCtK/Nw6qWM1maMrosv?=
 =?us-ascii?Q?2s4RK3xspue2stApDMYnDxLYEmw8dsbDnAJ/drkIGf/Fifp0XzuTnZBIjwkr?=
 =?us-ascii?Q?fs+gdbuMNNZZ5LItEsTCqDm6wPV7uvKuTT+tHAL+9toqH7gpWLIVQwXdh81C?=
 =?us-ascii?Q?BMVR43mRF1WPvsAKb8rPrnkWcVhwmCM0X7Nzzzb7m+UotKl4vLBo2pDnf3dR?=
 =?us-ascii?Q?NN/M66o6rTnTVz2BVNt1J7oxZtmdxRJE6D5yM735fH8QH3YKd5mje3SxVfhx?=
 =?us-ascii?Q?JwuYReMNRhqyhd5hz4OrrtmUS8dm7L310lxYUSQdnisikULPGOmzwuH33mTP?=
 =?us-ascii?Q?uUlbxeosLAWwGl780WKIVHOrcE2cxI18HKceev3Z56v2ol3w+RhLOydaeQo1?=
 =?us-ascii?Q?82GLhxTgWhwrXHs7Xr+5hxZm5TVpUwlWw1juixHHInfdFMkEx0E56fNb67E/?=
 =?us-ascii?Q?4z/LzPwJBg2NW+3vJ4zhfDcoEbba5RKp8a1EBIzT3v+1HSkbP4SCcKPCCK1i?=
 =?us-ascii?Q?0gYTSNWB3PXsvD1nUNQelMacq/OjHD2UEMfo76I6A4VONMv993BjH2fR5Alt?=
 =?us-ascii?Q?3Gi8Zd8UpAmoCUKplnGHX1cuy4ytBQHCbjEmtGFW8J7fkUHvA1Rhexq8IYlb?=
 =?us-ascii?Q?LOG3scrLQtKuDsP2VQ4wbimMCr7GpYOmJ+kW6bbDX+meWHLmSH2gmszlojFy?=
 =?us-ascii?Q?lNHluTVXw7DcWDxO5YXHSZ8yYUm7xbf8lGuesE4XI2Y9BucphrR898hXzdJ6?=
 =?us-ascii?Q?t584KRN6Hks+8Fn7N4Nu7aQlKuFSwxHegV5O3ZkXAw1xRtJmC7cAUBRgvyqt?=
 =?us-ascii?Q?/iO4dKhQoofclTGZClz19LRQTx1/NeT7Pd55Fa3cuOsZ5tdY5Zu7sr6OcTOI?=
 =?us-ascii?Q?i6RIicAiCauFlZ/X9bmbPmzvFz40H/wiTiCM+d+38JE3YF0wspkeFLHkxDOf?=
 =?us-ascii?Q?zW604v3oVvF0Co9vVVG1Ft9qqmLtu7iL4W8qKELp0BI/I8AIFwZkGN9wPV13?=
 =?us-ascii?Q?UknWMQZkFqehI9XOGRc/lWEClxcdM0UUv/loZjgrVzJ1P5mq8cFpWzVrj347?=
 =?us-ascii?Q?tAKpnyGnZCv5KAM5Az4wwW843hFYDwegaEB+33wEvYfGKGr2xkjOQ4zS+yWk?=
 =?us-ascii?Q?fRMpATAwn2mN+ybwkkiWXB4Xk5aAflShQT4dzKQtbiPLduE1b5CeEWD95YZh?=
 =?us-ascii?Q?Ps+URD7S1SahXgYJrkRHjzpTwLq6c37XnKh+CtZkJo3fg5uijN7gZ9w0wgvr?=
 =?us-ascii?Q?ys5mgVS+PxiEUMgOBDf8QLA5GXnBz8H5pt2cD60KO1l7rqYkkWoXXRhW80uj?=
 =?us-ascii?Q?CQwWhzblRzqrhMa8EGrJQs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;6:IpZU1CUDIgFpBPKOxe3gQtKwjotANhf79TuqNDIujOaxBfKRpYsFY5Sqb/dinZCdAOZGE3P9N01ohuROydsCsfKpkMRdvzaU4fDGgUrewMhGaMkesMJrGa5QiFdA28iktIoevmGZVhdPa2oaOAWJ+LWpqGSzRILn2Kkm7KztEyygl9SvhObVunf+tZLg3LgMdk5Ko/ay5WttB6QnirwejA/jlv/qay4wnlOaZjq7qiu/o76e9zWCEfM0l979R+drgWfwBOP1RehB/DYbvkbNl5/YTQCCvHGs5Ra1eYIXfW2r70Lc+iahHU0n9nI9kmgyJT7C48fhfq5SZUL91wHUnvz2M8zWQN72ZstE6ZJnxKQ=;5:6dSTATTeAVUdy50pT87W/3Iaqs9V9nDlyx2tdYoAjlkTlG/megTvv3PO2k9RswCGPeCx3I2afCeteo9uO/psqhT5zPSgz+BbP4XIcDcSxUAMk9QGmHo7JGnogpFtj+Wuopu9k2omoZbEPykultMzMco1uuRIGNTJdpbWiYtSPrg=;24:Zras1cR/sRZzWl1VIxa6+cV3/QVGAZa7hFJSxKMN7OMuj5QuP3NvqhEU4T13uqdXRb53gnYOvD5IOUpY6GPQ8t9L2z4FCa1f2WQeBgLdxHU=;7:0O8tv4g8y/CAEpZ/lDEi3shTgrQTMg0rWmKsGU9aHRsOfk/oyTaZkpq8Yw89tqdgMPF/lIrllUEbsAZ1YqrU/Srdc1NtRWhbRF64eLhpe3+1E8H7ue5nXHxUYdpW983lpScAKKjDnw5NAnmK69UXgqVbA/MSqSUoDMbiXHspUKAkL5VswAdFgaoeqW2z/s7ow4GbyRddVRDDOPEuxCNgeHk0CvXa/szQGPhl3ngq0xUlbUxqI5G5+LDieyWsWF11
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1756;20:rWntOtBAGo1qrg77gy2rsZf1YSQSm+dt0CUVgSe2fu0ZzxY9wqVJ8YZw1wAMWKncGMJJO4qZcGUelLwAtOajuHw8OyCiMVUwDGFhpSQ1qFB7bIx57JLr/coWvG9DkS8lRP1RjcjYGLAcBUkaT46ev1UC45PL+9wHdQid7e4ybnw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:39:03.9634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527e5cbd-9223-4601-d54c-08d573d1d761
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1756
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
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
