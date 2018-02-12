Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753741AbeBLTvy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:51:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbeBLTvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:51:49 -0500
Date: Mon, 12 Feb 2018 11:51:14 -0800
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
Subject: [PATCH 13/14] x86/crypto: aesni: Introduce scatter/gather asm
 function stubs
Message-ID: <20180212195114.GA61055@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: MWHPR20CA0019.namprd20.prod.outlook.com (10.171.151.157) To
 BN6PR15MB1748.namprd15.prod.outlook.com (10.174.238.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ea7ac3f-868b-454a-d32d-08d57251fbf3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1748;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1748;3:mpcqXpJrK2dxO1xsQTOUlQ7jU6seslvnPRCzRNY7qnblh4k/jZ5eowaut8icjU3hAou+NR+FidChv+mrDfnf++iEXsRxOiWHraL3XVwwXIys54Bwe+XIm5Rid9c3bQhH4K7u/Uxxs0Rly+WJRi9HJ2owCLoYwbOAXubZ3NGe4EqSGINIZ2sNFzH+qDMv/j3/qbjYXFkxlZ8jW4s6N4aXthGNLEF7PwWZaY821MX6RMjxuKoIAeRfhl0mxVL/KUhU;25:lJDrrj7zAuq3zCFS27z6SsDNDrzpcK1/Q20RQuMlbz7fJWXpe8VvE6V2cFoCKKBntn89p3DFP83x3UAIytkuWskI0Y/C+Bs9tWTY/K+40SLP54if0SpGFtEUjroiXmcEo61bhOZb0952hKTOc8Swaw8rCBSjJntgeGb2YCEvwOrtfN+m019WGrXsxxLfHotsGnU8N9EB0ta4zvke2pBo0ZxbzppFpLZisdQ8B6zOpofqzyVEFuibdZjihPKUk4MabKMlIQ2xuUtdci+xzZieaYz6tj2eOiMAimDg6gzA98ZoNvGxCnilOoURUqOY07i+zulH9lGtpTJ7ONIwBWlUGA==;31:eex3nvORr4++nURoRucSD7oAYr1VTGiCadWq9dPe8B+uWxFHoNROMpIx3xlfgd4DTcvF0w0W6U85s7VKmLDlpOjJpoWApzl5r8oGoViq8IJV+VAUgoTjann+WVn2jpm//semMvFt7hgGV2gNhh+5UCum4JTanKbQPBTBi8s4ngHyEXDWWPMlr7F6b6CAlLK15l+4AsH8/5DkdQzjgKylTfNxJkKg1xhBYf1rg2trb3U=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1748:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1748;20:+bKc3yY87AYCad7PMC0D+tvPt5xa32/88/2ASNE2hJfPgs67DZUJDLF01BQwXKpwj9rsVg0GmGlsaEUlY78wDYhQBheSjWMEabmfv9ARgL0sZdsmZ2xJKK9V//l3ULvkV8St9V7VaPlom86HTfDtqkjzWoR6d3fMFWE+SCcQ+ELOGai0nu9Mq97QwwkYmGaTetPy8ZFwJoHnSfZxFO2ycboKZzj6eZhh5iMTmzgNBQ1r/sHxKBCcV32EL15K9vTaUp/6k8dfD4MDypxd8kZe81td9AvTsJb0ZxVN1zIB47LYbzkN2AR05JoOI3IAnHZZOY1fAt9Se6oHsved8CHui+t/aL5XT4uK7z2unJxB4minGlPIghGG/NvKd43EFLKsOuGodDTIlmtnzAR2NNZCtLj37q3SBRCoHcY/hTewuoZIDnhSuqhiUhtrCcOdyteIHtXhyLElw6rou8vkne+MKurX6O1+oQIN8thmwvrwLdvENw2sJxv24ksPr/6ocI6c;4:4G3trgIrhHTHmPbO7NfZsby/WD7S7LKmkfPRncoCgM15sufUxjeoEPDGluiCwtvHRDFqVhvGdTgWuX2Uha1z7uJc7YGFVhAHogAelRErV6rmC1XuZLv5qDC6YLqezyqr1nBSd8Sj7qht+z5qmhpH4pQHb64QBaUw/0ny1rxbrd/irw40eksjXNsWyI54PZXQ6dcucA1Xvej03nuxEPJrR/gKK9jUyUKeaP+VluOyeMHiXccrDxo4/LfKPvC7ZaPZZtxkeIqlMXVSdGJn23kdo+puREr7j2BUu0lt+IMsLsA3knJ+o/ucCKNJNNVI08KMPVt9G4WwigSxw5FqFU10KC0KAL3Itw9Chd7rcsbvpVyx3jUOy/8Q+IDLFyQGyVPE
X-Microsoft-Antispam-PRVS: <BN6PR15MB17488E63850E746F8BC73621DDF70@BN6PR15MB1748.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(11241501184)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR15MB1748;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1748;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(366004)(376002)(39860400002)(39380400002)(199004)(189003)(59450400001)(386003)(58126008)(76506005)(86362001)(6496006)(52396003)(478600001)(33896004)(47776003)(50466002)(316002)(52116002)(16586007)(110136005)(83506002)(54906003)(53936002)(98436002)(76176011)(6116002)(25786009)(9686003)(6486002)(81156014)(7416002)(1076002)(97736004)(106356001)(4326008)(5660300001)(8676002)(8936002)(6666003)(33656002)(2906002)(105586002)(7736002)(305945005)(68736007)(186003)(16526019)(23726003)(2950100002)(81166006)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1748;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1748;23:6nM32tjCQcTRyJv3LljwKsfj+0jzzV6NgGI6OBP70?=
 =?us-ascii?Q?SnNda1zsvCA7LmBN7o9OmlZ4Nf9q8Rxec3PLoW8XYMwpwW0Yr5BdTLutrbXB?=
 =?us-ascii?Q?3HGA2lK1fE6daQZaGQCtFhcnY/L/HSZlQ8qwR7A+NadH0VXTKo/EH1w+GZno?=
 =?us-ascii?Q?kGqe06sNHZZUOB5Vcw0HSydLipw4AY0U473oT9ya41KTneE4JaQw5R2bRDGK?=
 =?us-ascii?Q?n7zJM7ERQ0B2LfvIfGyUjOAuQjC8mYJbKEWZTPeKbi00S3AcDPNNPPm8DrSo?=
 =?us-ascii?Q?y6lhAlUtfpuLFTfUI+0xPZN3tlVBww03XcPz4NaGhQxtbcw7dYV34z3hYQFq?=
 =?us-ascii?Q?TEBPbeGbdcTYFwAc9euZzV0DKGtbeZLuPZ+CPHq2fQQt0taaaafQC5+7zBE+?=
 =?us-ascii?Q?rbmJ6lthaRs/V7FzeYceddjwiEq+7q1dkZFBQJaj0SxriP7jWHCIwiKL3Ttl?=
 =?us-ascii?Q?EqdP2sJ8t/0l4qMkEz3nRZU/Pyh3sGCNjEULDu7Kkk5ci9mrQ1JaXWuMynvs?=
 =?us-ascii?Q?tg2SyY8UuCQ7XGbZV4TtGv31QVUgIAWaWMW7B88m63hJs1XIMjqYaIIbi2gJ?=
 =?us-ascii?Q?BbrPWZKJfgaphM7mnEICZ8rTpWh8MUtpckJNiYqX0RAVZSavKSQwjWTeyfbh?=
 =?us-ascii?Q?oHVJVHX9V3spKYUcs0rOKemwJ8ljrwo+yhlt0NQgFJOqcUP+EdLcuiyq9mzL?=
 =?us-ascii?Q?q3qAjKo8TbGvI+oWfWVyGO8xN/B4YaARywVFkZbSb0huZduj5tJ8a9Sr50YC?=
 =?us-ascii?Q?dPd4yug3IQIVnypIiAT/FeIGQ2ujkmpvDfDEyDxun5JdVm0bLClyuz1U2jop?=
 =?us-ascii?Q?d5tdt2Aol72TEvygaJWHLGthYpISS/hefHt0cYTOK4stJPEzqpPlcnETMRDr?=
 =?us-ascii?Q?9+bCSP/rvZUfQ1sj8GZe6L2G4/UxolCN9ra6v8/2f66RR+pcxziwpDY1Kf04?=
 =?us-ascii?Q?p5iTL+ZoIUKtLlJZp0kxrXa2kNU1R8e3ffBWQVVtoKeP28nv7DRao0HGufpk?=
 =?us-ascii?Q?7z4V0QCjHvzJz+kpL10dxMXDDHuSVwvs42AkgbQJRpvfYPO4Nn17L+szvtHG?=
 =?us-ascii?Q?AGGNLurFmpWLYjMReN338sBv8EPrC32JyFrYy5zqwlLTFss6bzKCcKz6xb6N?=
 =?us-ascii?Q?au8zkZXBAvuPALlbzkFdKl5+JsxCqBiFawt4rCYglALhx/zhRbUcBBdiXoqt?=
 =?us-ascii?Q?cQe6vCqU0Vn6I3amEJ22UdJTfcW4rxYdTAXLPe1sNq4BwyEyy2mtW/OG2nIN?=
 =?us-ascii?Q?OyKPJ3owqPCMWpoKQ/tu+lUolps5K3MFIYXYClS?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1748;6:iE44mTj/gaMADkCDxi70Z6JHvn6jJV3Icz+1UAonXEOvNU8nIgFu9fyNxX57lSGalWL4nFh7hMw0mBt1f2LnEFoPOS1rZSnkK/RXITBn+RBn5ZXGQ+k/p5IBbc72gbaXkqH9+saEvuOKjvEGkAHap3ENH/uQGI8IsdugR8jYL+V+4bgidqN1CHtwFR+JSoc+6yGCjRIMUk0hxmakQOp4JnJRLnFxewf9VtqZL2vMul40HgBumkpZwO8dTS+eSIk+mfw0fCauggv5/Qu0LhEDiA7epbiEi9WJMQqTJprRp5o0NGDN49w7F3GDsyRVo31N2Q4t1ILG7a8OVkxGO0vsbBSuw+/qy9alDYRx5fkfcqA=;5:web1ubeqwcQfl7m3TqCvs7wCSevGdyoFqxWgYyIcomHCL6oVxw2ZxK2gjLY+j090ud0f0FPM8OWGHfTtoK1t5XN5kq9pK7efdGx76Dsxxhtw4bnFfRJq04of+wjcNdB6GD/GjyuCqhHroA/Qw8aY5CIR2zuAnrT+TPhGiJsgCTk=;24:pUvoJHAbm1F0y+2nQ1XBUgErqqsJt7rG44XFNV9aRKxCyCPLbPiqGEUfXQ1g0CPAWyRgp9KMVEkiEQMzFvlZM1LiHGt88wicQBCBW/JOIxY=;7:klZwpCuhUelKrHuUXs75FWgLx5IKOkSia9rzTYa2nUyBVUV4lP5VhAJaDlp8jjHWwsVgLFulmIq66sl+85IFI/o1A8kLfmOEZHUIVZXozbHqvLXmmS0V7o7h9yWYJRCPPK9JdGyo/4TAPRowTEH7NgARaFkPQTjp1lQ0wIP+y9cAm/VC52N86UlGfeP4917j6Q/AtiITkchJbEJSXs220SNpdv9tLqILFpZ+D4L31qWUFGcM9OYHhtfBlE5SJn0/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1748;20:52IGB1G84dXmvMQrxt0Yty3VktRqITYsqji/WIXnKi232bpQTt6FG/duvq3JDTJ401MHSJ5bOlZod+a4dwCl8xEmDXniz4qGi+ekRxlf0AvJu2RAuDfwkK9b6CHm4B0rmpHwhJb9h16pq3S/P7F1PIXjI+4ybBlWq+SkqefYTsQ=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:51:18.5271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea7ac3f-868b-454a-d32d-08d57251fbf3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1748
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm macros are all set up now, introduce entry points.

GCM_INIT and GCM_COMPLETE have arguments supplied, so that
the new scatter/gather entry points don't have to take all the
arguments, and only the ones they need.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S  | 116 ++++++++++++++++++++++++++++---------
 arch/x86/crypto/aesni-intel_glue.c |  16 +++++
 2 files changed, 106 insertions(+), 26 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index b941952..311b2de 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -200,8 +200,8 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 # Output: HashKeys stored in gcm_context_data.  Only needs to be called
 # once per key.
 # clobbers r12, and tmp xmm registers.
-.macro PRECOMPUTE TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
-	mov	arg7, %r12
+.macro PRECOMPUTE SUBKEY TMP1 TMP2 TMP3 TMP4 TMP5 TMP6 TMP7
+	mov	\SUBKEY, %r12
 	movdqu	(%r12), \TMP3
 	movdqa	SHUF_MASK(%rip), \TMP2
 	PSHUFB_XMM \TMP2, \TMP3
@@ -254,14 +254,14 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 
 # GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
 # Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
-.macro GCM_INIT
-	mov arg9, %r11
+.macro GCM_INIT Iv SUBKEY AAD AADLEN
+	mov \AADLEN, %r11
 	mov %r11, AadLen(%arg2) # ctx_data.aad_length = aad_length
 	xor %r11, %r11
 	mov %r11, InLen(%arg2) # ctx_data.in_length = 0
 	mov %r11, PBlockLen(%arg2) # ctx_data.partial_block_length = 0
 	mov %r11, PBlockEncKey(%arg2) # ctx_data.partial_block_enc_key = 0
-	mov %arg6, %rax
+	mov \Iv, %rax
 	movdqu (%rax), %xmm0
 	movdqu %xmm0, OrigIV(%arg2) # ctx_data.orig_IV = iv
 
@@ -269,11 +269,11 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	PSHUFB_XMM %xmm2, %xmm0
 	movdqu %xmm0, CurCount(%arg2) # ctx_data.current_counter = iv
 
-	PRECOMPUTE %xmm1 %xmm2 %xmm3 %xmm4 %xmm5 %xmm6 %xmm7
+	PRECOMPUTE \SUBKEY, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5, %xmm6, %xmm7,
 	movdqa HashKey(%arg2), %xmm13
 
-	CALC_AAD_HASH %xmm13 %xmm0 %xmm1 %xmm2 %xmm3 %xmm4 \
-	%xmm5 %xmm6
+	CALC_AAD_HASH %xmm13, \AAD, \AADLEN, %xmm0, %xmm1, %xmm2, %xmm3, \
+	%xmm4, %xmm5, %xmm6
 .endm
 
 # GCM_ENC_DEC Encodes/Decodes given data. Assumes that the passed gcm_context
@@ -435,7 +435,7 @@ _multiple_of_16_bytes_\@:
 # GCM_COMPLETE Finishes update of tag of last partial block
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
-.macro GCM_COMPLETE
+.macro GCM_COMPLETE AUTHTAG AUTHTAGLEN
 	movdqu AadHash(%arg2), %xmm8
 	movdqu HashKey(%arg2), %xmm13
 
@@ -466,8 +466,8 @@ _partial_done\@:
 	ENCRYPT_SINGLE_BLOCK	%xmm0,  %xmm1	  # E(K, Y0)
 	pxor	%xmm8, %xmm0
 _return_T_\@:
-	mov	arg10, %r10                     # %r10 = authTag
-	mov	arg11, %r11                    # %r11 = auth_tag_len
+	mov	\AUTHTAG, %r10                     # %r10 = authTag
+	mov	\AUTHTAGLEN, %r11                    # %r11 = auth_tag_len
 	cmp	$16, %r11
 	je	_T_16_\@
 	cmp	$8, %r11
@@ -599,11 +599,11 @@ _done_read_partial_block_\@:
 
 # CALC_AAD_HASH: Calculates the hash of the data which will not be encrypted.
 # clobbers r10-11, xmm14
-.macro CALC_AAD_HASH HASHKEY TMP1 TMP2 TMP3 TMP4 TMP5 \
+.macro CALC_AAD_HASH HASHKEY AAD AADLEN TMP1 TMP2 TMP3 TMP4 TMP5 \
 	TMP6 TMP7
 	MOVADQ	   SHUF_MASK(%rip), %xmm14
-	mov	   arg8, %r10		# %r10 = AAD
-	mov	   arg9, %r11		# %r11 = aadLen
+	mov	   \AAD, %r10		# %r10 = AAD
+	mov	   \AADLEN, %r11		# %r11 = aadLen
 	pxor	   \TMP7, \TMP7
 	pxor	   \TMP6, \TMP6
 
@@ -1103,18 +1103,18 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	mov	  keysize,%eax
 	shr	  $2,%eax			# 128->4, 192->6, 256->8
 	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  aes_loop_par_enc_done
+	jz	  aes_loop_par_enc_done\@
 
-aes_loop_par_enc:
+aes_loop_par_enc\@:
 	MOVADQ	  (%r10),\TMP3
 .irpc	index, 1234
 	AESENC	  \TMP3, %xmm\index
 .endr
 	add	  $16,%r10
 	sub	  $1,%eax
-	jnz	  aes_loop_par_enc
+	jnz	  aes_loop_par_enc\@
 
-aes_loop_par_enc_done:
+aes_loop_par_enc_done\@:
 	MOVADQ	  (%r10), \TMP3
 	AESENCLAST \TMP3, \XMM1           # Round 10
 	AESENCLAST \TMP3, \XMM2
@@ -1311,18 +1311,18 @@ TMP6 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 operation
 	mov	  keysize,%eax
 	shr	  $2,%eax		        # 128->4, 192->6, 256->8
 	sub	  $4,%eax			# 128->0, 192->2, 256->4
-	jz	  aes_loop_par_dec_done
+	jz	  aes_loop_par_dec_done\@
 
-aes_loop_par_dec:
+aes_loop_par_dec\@:
 	MOVADQ	  (%r10),\TMP3
 .irpc	index, 1234
 	AESENC	  \TMP3, %xmm\index
 .endr
 	add	  $16,%r10
 	sub	  $1,%eax
-	jnz	  aes_loop_par_dec
+	jnz	  aes_loop_par_dec\@
 
-aes_loop_par_dec_done:
+aes_loop_par_dec_done\@:
 	MOVADQ	  (%r10), \TMP3
 	AESENCLAST \TMP3, \XMM1           # last round
 	AESENCLAST \TMP3, \XMM2
@@ -1598,9 +1598,9 @@ _esb_loop_\@:
 ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
 
-	GCM_INIT
+	GCM_INIT %arg6, arg7, arg8, arg9
 	GCM_ENC_DEC dec
-	GCM_COMPLETE
+	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec)
@@ -1686,13 +1686,77 @@ ENDPROC(aesni_gcm_dec)
 ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
 
-	GCM_INIT
+	GCM_INIT %arg6, arg7, arg8, arg9
 	GCM_ENC_DEC enc
-	GCM_COMPLETE
+
+	GCM_COMPLETE arg10, arg11
 	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc)
 
+/*****************************************************************************
+* void aesni_gcm_init(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                     struct gcm_context_data *data,
+*                                         // context data
+*                     u8 *iv,             // Pre-counter block j0: 4 byte salt (from Security Association)
+*                                         // concatenated with 8 byte Initialisation Vector (from IPSec ESP Payload)
+*                                         // concatenated with 0x00000001. 16-byte aligned pointer.
+*                     u8 *hash_subkey,    // H, the Hash sub key input. Data starts on a 16-byte boundary.
+*                     const u8 *aad,      // Additional Authentication Data (AAD)
+*                     u64 aad_len)        // Length of AAD in bytes.
+*/
+ENTRY(aesni_gcm_init)
+	FUNC_SAVE
+	GCM_INIT %arg3, %arg4,%arg5, %arg6
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_init)
+
+/*****************************************************************************
+* void aesni_gcm_enc_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
+*                    const u8 *in,       // Plaintext input
+*                    u64 plaintext_len,  // Length of data in bytes for encryption.
+*/
+ENTRY(aesni_gcm_enc_update)
+	FUNC_SAVE
+	GCM_ENC_DEC enc
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_enc_update)
+
+/*****************************************************************************
+* void aesni_gcm_dec_update(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *out,            // Ciphertext output. Encrypt in-place is allowed.
+*                    const u8 *in,       // Plaintext input
+*                    u64 plaintext_len,  // Length of data in bytes for encryption.
+*/
+ENTRY(aesni_gcm_dec_update)
+	FUNC_SAVE
+	GCM_ENC_DEC dec
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_dec_update)
+
+/*****************************************************************************
+* void aesni_gcm_finalize(void *aes_ctx,      // AES Key schedule. Starts on a 16 byte boundary.
+*                    struct gcm_context_data *data,
+*                                        // context data
+*                    u8 *auth_tag,       // Authenticated Tag output.
+*                    u64 auth_tag_len);  // Authenticated Tag Length in bytes. Valid values are 16 (most likely),
+*                                        // 12 or 8.
+*/
+ENTRY(aesni_gcm_finalize)
+	FUNC_SAVE
+	GCM_COMPLETE %arg3 %arg4
+	FUNC_RESTORE
+	ret
+ENDPROC(aesni_gcm_finalize)
+
 #endif
 
 
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 4dd5b9b..de986f9 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -161,6 +161,22 @@ asmlinkage void aesni_gcm_dec(void *ctx,
 			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
 
+/* Scatter / Gather routines, with args similar to above */
+asmlinkage void aesni_gcm_init(void *ctx,
+			       struct gcm_context_data *gdata,
+			       u8 *iv,
+			       u8 *hash_subkey, const u8 *aad,
+			       unsigned long aad_len);
+asmlinkage void aesni_gcm_enc_update(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in, unsigned long plaintext_len);
+asmlinkage void aesni_gcm_dec_update(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in,
+				     unsigned long ciphertext_len);
+asmlinkage void aesni_gcm_finalize(void *ctx,
+				   struct gcm_context_data *gdata,
+				   u8 *auth_tag, unsigned long auth_tag_len);
 
 #ifdef CONFIG_AS_AVX
 asmlinkage void aes_ctr_enc_128_avx_by8(const u8 *in, u8 *iv,
-- 
2.9.5
