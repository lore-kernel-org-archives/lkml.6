Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E3520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rIjx17mC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PSEcoxAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E3520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbeLJUAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:24 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbeLJUAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJtDW2028783;
        Mon, 10 Dec 2018 12:00:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=naE1dV7ato/SilweVs0L8CWrcmUGSHFDcV2O7mh5O74=;
 b=rIjx17mCo4Y9pyAJaBvrILXVSeWOzX32kwPtErM7f61cNHW/THumMzy1/PxmVC/uULoL
 Rib9Bx1QZVQJnfzhPwQcdbZIAKd/2F60JMV84rTpquFMixgMYl1H/YL4WOghzxTOR8ZL
 ojYoDBoleoUXxNzKKuxe2zTsKO8i/pIyo2E= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2p9w53reg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 12:00:04 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 12:00:02 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 12:00:01 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 12:00:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naE1dV7ato/SilweVs0L8CWrcmUGSHFDcV2O7mh5O74=;
 b=PSEcoxAZsSHFX1f5wzL1L+Z28a3yGSIsabcPXA6IrphiKYV0Zx3YR2hffEna/DHS70P5X13cYdshXQRuK6h/MR9J79QfegaDRirkGOmETUaVGqdQsJDIkmOs8jzNldoc6+DfqSbvLnFvuYWHnVnbOB8IF12vFCl7QyUIYwK2PR0=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:59:59 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:59:59 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 12/12] x86/crypto: aesni: Add scatter/gather avx stubs, and
 use them in C
Thread-Topic: [PATCH 12/12] x86/crypto: aesni: Add scatter/gather avx stubs,
 and use them in C
Thread-Index: AQHUkMLuGF2rGoFkpEq8txxphznUqA==
Date:   Mon, 10 Dec 2018 19:59:59 +0000
Message-ID: <bac26594582d4addf284e3b87bd1fb4e2d24827d.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR0201CA0018.namprd02.prod.outlook.com
 (2603:10b6:301:74::31) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:P4W64RogJu2v5JjQaDYpf1qwvKtZQlhC/C2wjJ5nXdpVylVntIS5e2PkTSdT5RXSd+pZf16kmD4D5kN2nNG/clbQIfMYCFgo+RmRLTXjhpcCqKyakLUidQ0XuDYBH3gc8SUutk77Tc5PoNsfUthZHkEZ4Lsy3TMA1bJgkR+91b0=
x-ms-office365-filtering-correlation-id: 367f8721-0c01-4084-eaee-08d65eda102e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB116656BA068F0B26E3E12E7FDDA50@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(7736002)(256004)(8936002)(14444005)(486006)(386003)(76176011)(316002)(54906003)(58126008)(110136005)(99286004)(4326008)(2616005)(446003)(11346002)(52116002)(102836004)(305945005)(6506007)(46003)(476003)(186003)(4744004)(5660300001)(36756003)(71190400001)(71200400001)(106356001)(105586002)(97736004)(118296001)(2501003)(53936002)(8676002)(68736007)(81166006)(81156014)(478600001)(14454004)(2906002)(25786009)(86362001)(6486002)(6512007)(6116002)(6436002)(53946003)(559001)(579004)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qdtu5VJ/AMwpvLPjtvHK7Z9n57F4JV/cNNBywm8KeNnvYR9Kl31HocnAXvvBdahPZXesYvCK10/Fy+lqiVCxMGNejRkDwdbMzksiv2hWtY1YcJTxirzLiHH0HcDnuoMtB6ADjY7b1GI2FPVo4RqzG1PPzNhpidqCNoUKnbgDPfqV8XddDFpAFPesIofi5WWjKcKzWqejhy3Z51kU7y1TdHRVT8m4WGBQhTXntY8Or3BlJRjfKgpUujFrlA6EdTPQttiFR3T009Ij0nbe6tUEvbHauGfqKR/pLhaCWDnYJk3tydcuba++sbjX9FMlOPHo
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <316F4137FFB29245A156F6BACBFC8D8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 367f8721-0c01-4084-eaee-08d65eda102e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:59:59.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1166
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate scatter/gather stubs to the avx asm.
In the C code, we can now always use crypt_by_sg, since both
sse and asm code now support scatter/gather.

Introduce a new struct, aesni_gcm_tfm, that is initialized on
startup to point to either the SSE, AVX, or AVX2 versions of the
four necessary encryption/decryption routines.

GENX_OPTSIZE is still checked at the start of crypt_by_sg.  The
total size of the data is checked, since the additional overhead
is in the init function, calculating additional HashKeys.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 181 ++++++------
 arch/x86/crypto/aesni-intel_glue.c       | 349 +++++++----------------
 2 files changed, 198 insertions(+), 332 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index af45fc57db90..91c039ab5699 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -518,14 +518,13 @@ _less_than_8_bytes_left\@:
         #############################
=20
 _multiple_of_16_bytes\@:
-        GCM_COMPLETE \GHASH_MUL \REP
 .endm
=20
=20
 # GCM_COMPLETE Finishes update of tag of last partial block
 # Output: Authorization Tag (AUTH_TAG)
 # Clobbers rax, r10-r12, and xmm0, xmm1, xmm5-xmm15
-.macro GCM_COMPLETE GHASH_MUL REP
+.macro GCM_COMPLETE GHASH_MUL REP AUTH_TAG AUTH_TAG_LEN
         vmovdqu AadHash(arg2), %xmm14
         vmovdqu HashKey(arg2), %xmm13
=20
@@ -560,8 +559,8 @@ _partial_done\@:
=20
=20
 _return_T\@:
-        mov     arg9, %r10              # r10 =3D authTag
-        mov     arg10, %r11              # r11 =3D auth_tag_len
+        mov     \AUTH_TAG, %r10              # r10 =3D authTag
+        mov     \AUTH_TAG_LEN, %r11              # r11 =3D auth_tag_len
=20
         cmp     $16, %r11
         je      _T_16\@
@@ -680,14 +679,14 @@ _get_AAD_done\@:
=20
         mov %r11, PBlockLen(arg2) # ctx_data.partial_block_length =3D 0
         mov %r11, PBlockEncKey(arg2) # ctx_data.partial_block_enc_key =3D =
0
-        mov arg4, %rax
+        mov arg3, %rax
         movdqu (%rax), %xmm0
         movdqu %xmm0, OrigIV(arg2) # ctx_data.orig_IV =3D iv
=20
         vpshufb SHUF_MASK(%rip), %xmm0, %xmm0
         movdqu %xmm0, CurCount(arg2) # ctx_data.current_counter =3D iv
=20
-        vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
+        vmovdqu  (arg4), %xmm6              # xmm6 =3D HashKey
=20
         vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
         ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
@@ -1776,88 +1775,100 @@ _initial_blocks_done\@:
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
 #############################################################
-ENTRY(aesni_gcm_precomp_avx_gen2)
+ENTRY(aesni_gcm_init_avx_gen2)
         FUNC_SAVE
         INIT GHASH_MUL_AVX, PRECOMPUTE_AVX
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_precomp_avx_gen2)
+ENDPROC(aesni_gcm_init_avx_gen2)
=20
 ##########################################################################=
#####
-#void   aesni_gcm_enc_avx_gen2(
+#void   aesni_gcm_enc_update_avx_gen2(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
 #        gcm_context_data *data,
 #        u8      *out, /* Ciphertext output. Encrypt in-place is allowed. =
 */
 #        const   u8 *in, /* Plaintext input */
-#        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			Initialisation Vector (from IPSec ESP Payload)
-#			concatenated with 0x00000001. 16-byte aligned pointer. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len, /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#				Valid values are 16 (most likely), 12 or 8. */
+#        u64     plaintext_len) /* Length of data in Bytes for encryption.=
 */
 ##########################################################################=
#####
-ENTRY(aesni_gcm_enc_avx_gen2)
+ENTRY(aesni_gcm_enc_update_avx_gen2)
         FUNC_SAVE
         mov     keysize, %eax
         cmp     $32, %eax
-        je      key_256_enc
+        je      key_256_enc_update
         cmp     $16, %eax
-        je      key_128_enc
+        je      key_128_enc_update
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 11
         FUNC_RESTORE
         ret
-key_128_enc:
+key_128_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 9
         FUNC_RESTORE
         ret
-key_256_enc:
+key_256_enc_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, ENC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_enc_avx_gen2)
+ENDPROC(aesni_gcm_enc_update_avx_gen2)
=20
 ##########################################################################=
#####
-#void   aesni_gcm_dec_avx_gen2(
+#void   aesni_gcm_dec_update_avx_gen2(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
 #        gcm_context_data *data,
 #        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  =
*/
 #        const   u8 *in, /* Ciphertext input */
-#        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			Initialisation Vector (from IPSec ESP Payload)
-#			concatenated with 0x00000001. 16-byte aligned pointer. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len, /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#				Valid values are 16 (most likely), 12 or 8. */
+#        u64     plaintext_len) /* Length of data in Bytes for encryption.=
 */
 ##########################################################################=
#####
-ENTRY(aesni_gcm_dec_avx_gen2)
+ENTRY(aesni_gcm_dec_update_avx_gen2)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
-        je      key_256_dec
+        je      key_256_dec_update
         cmp     $16, %eax
-        je      key_128_dec
+        je      key_128_dec_update
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 11
         FUNC_RESTORE
         ret
-key_128_dec:
+key_128_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 9
         FUNC_RESTORE
         ret
-key_256_dec:
+key_256_dec_update:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX, GHASH_8_ENCRYPT_8_PARALLEL_AVX, GH=
ASH_LAST_8_AVX, GHASH_MUL_AVX, DEC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_dec_avx_gen2)
+ENDPROC(aesni_gcm_dec_update_avx_gen2)
+
+##########################################################################=
#####
+#void   aesni_gcm_finalize_avx_gen2(
+#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
+#        u8      *auth_tag, /* Authenticated Tag output. */
+#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
+#				Valid values are 16 (most likely), 12 or 8. */
+##########################################################################=
#####
+ENTRY(aesni_gcm_finalize_avx_gen2)
+        FUNC_SAVE
+        mov	keysize,%eax
+        cmp     $32, %eax
+        je      key_256_finalize
+        cmp     $16, %eax
+        je      key_128_finalize
+        # must be 192
+        GCM_COMPLETE GHASH_MUL_AVX, 11, arg3, arg4
+        FUNC_RESTORE
+        ret
+key_128_finalize:
+        GCM_COMPLETE GHASH_MUL_AVX, 9, arg3, arg4
+        FUNC_RESTORE
+        ret
+key_256_finalize:
+        GCM_COMPLETE GHASH_MUL_AVX, 13, arg3, arg4
+        FUNC_RESTORE
+        ret
+ENDPROC(aesni_gcm_finalize_avx_gen2)
+
 #endif /* CONFIG_AS_AVX */
=20
 #ifdef CONFIG_AS_AVX2
@@ -2724,24 +2735,23 @@ _initial_blocks_done\@:
=20
=20
 #############################################################
-#void   aesni_gcm_precomp_avx_gen4
+#void   aesni_gcm_init_avx_gen4
 #        (gcm_data     *my_ctx_data,
 #         gcm_context_data *data,
-#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on=
 a 16-byte boundary. */
 #        u8      *iv, /* Pre-counter block j0: 4 byte salt
 #			(from Security Association) concatenated with 8 byte
 #			Initialisation Vector (from IPSec ESP Payload)
 #			concatenated with 0x00000001. 16-byte aligned pointer. */
+#        u8     *hash_subkey# /* H, the Hash sub key input. Data starts on=
 a 16-byte boundary. */
 #        const   u8 *aad, /* Additional Authentication Data (AAD)*/
 #        u64     aad_len) /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
 #############################################################
-ENTRY(aesni_gcm_precomp_avx_gen4)
+ENTRY(aesni_gcm_init_avx_gen4)
         FUNC_SAVE
         INIT GHASH_MUL_AVX2, PRECOMPUTE_AVX2
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_precomp_avx_gen4)
-
+ENDPROC(aesni_gcm_init_avx_gen4)
=20
 ##########################################################################=
#####
 #void   aesni_gcm_enc_avx_gen4(
@@ -2749,74 +2759,85 @@ ENDPROC(aesni_gcm_precomp_avx_gen4)
 #        gcm_context_data *data,
 #        u8      *out, /* Ciphertext output. Encrypt in-place is allowed. =
 */
 #        const   u8 *in, /* Plaintext input */
-#        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			 Initialisation Vector (from IPSec ESP Payload)
-#			 concatenated with 0x00000001. 16-byte aligned pointer. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len, /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#				Valid values are 16 (most likely), 12 or 8. */
+#        u64     plaintext_len) /* Length of data in Bytes for encryption.=
 */
 ##########################################################################=
#####
-ENTRY(aesni_gcm_enc_avx_gen4)
+ENTRY(aesni_gcm_enc_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
-        je      key_256_enc4
+        je      key_256_enc_update4
         cmp     $16, %eax
-        je      key_128_enc4
+        je      key_128_enc_update4
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 11
         FUNC_RESTORE
 	ret
-key_128_enc4:
+key_128_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 9
         FUNC_RESTORE
 	ret
-key_256_enc4:
+key_256_enc_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, ENC, 13
         FUNC_RESTORE
 	ret
-ENDPROC(aesni_gcm_enc_avx_gen4)
+ENDPROC(aesni_gcm_enc_update_avx_gen4)
=20
 ##########################################################################=
#####
-#void   aesni_gcm_dec_avx_gen4(
+#void   aesni_gcm_dec_update_avx_gen4(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
 #        gcm_context_data *data,
 #        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  =
*/
 #        const   u8 *in, /* Ciphertext input */
-#        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
-#        u8      *iv, /* Pre-counter block j0: 4 byte salt
-#			(from Security Association) concatenated with 8 byte
-#			Initialisation Vector (from IPSec ESP Payload)
-#			concatenated with 0x00000001. 16-byte aligned pointer. */
-#        const   u8 *aad, /* Additional Authentication Data (AAD)*/
-#        u64     aad_len, /* Length of AAD in bytes. With RFC4106 this is =
going to be 8 or 12 Bytes */
-#        u8      *auth_tag, /* Authenticated Tag output. */
-#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
-#				Valid values are 16 (most likely), 12 or 8. */
+#        u64     plaintext_len) /* Length of data in Bytes for encryption.=
 */
 ##########################################################################=
#####
-ENTRY(aesni_gcm_dec_avx_gen4)
+ENTRY(aesni_gcm_dec_update_avx_gen4)
         FUNC_SAVE
         mov     keysize,%eax
         cmp     $32, %eax
-        je      key_256_dec4
+        je      key_256_dec_update4
         cmp     $16, %eax
-        je      key_128_dec4
+        je      key_128_dec_update4
         # must be 192
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 11
         FUNC_RESTORE
         ret
-key_128_dec4:
+key_128_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 9
         FUNC_RESTORE
         ret
-key_256_dec4:
+key_256_dec_update4:
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2, GHASH_8_ENCRYPT_8_PARALLEL_AVX2, =
GHASH_LAST_8_AVX2, GHASH_MUL_AVX2, DEC, 13
         FUNC_RESTORE
         ret
-ENDPROC(aesni_gcm_dec_avx_gen4)
+ENDPROC(aesni_gcm_dec_update_avx_gen4)
+
+##########################################################################=
#####
+#void   aesni_gcm_finalize_avx_gen4(
+#        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
+#        u8      *auth_tag, /* Authenticated Tag output. */
+#        u64     auth_tag_len)# /* Authenticated Tag Length in bytes.
+#                              Valid values are 16 (most likely), 12 or 8.=
 */
+##########################################################################=
#####
+ENTRY(aesni_gcm_finalize_avx_gen4)
+        FUNC_SAVE
+        mov	keysize,%eax
+        cmp     $32, %eax
+        je      key_256_finalize4
+        cmp     $16, %eax
+        je      key_128_finalize4
+        # must be 192
+        GCM_COMPLETE GHASH_MUL_AVX2, 11, arg3, arg4
+        FUNC_RESTORE
+        ret
+key_128_finalize4:
+        GCM_COMPLETE GHASH_MUL_AVX2, 9, arg3, arg4
+        FUNC_RESTORE
+        ret
+key_256_finalize4:
+        GCM_COMPLETE GHASH_MUL_AVX2, 13, arg3, arg4
+        FUNC_RESTORE
+        ret
+ENDPROC(aesni_gcm_finalize_avx_gen4)
=20
 #endif /* CONFIG_AS_AVX2 */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-int=
el_glue.c
index 2648842f1c3f..1321700d6647 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -175,6 +175,32 @@ asmlinkage void aesni_gcm_finalize(void *ctx,
 				   struct gcm_context_data *gdata,
 				   u8 *auth_tag, unsigned long auth_tag_len);
=20
+static struct aesni_gcm_tfm_s {
+void (*init)(void *ctx,
+				struct gcm_context_data *gdata,
+				u8 *iv,
+				u8 *hash_subkey, const u8 *aad,
+				unsigned long aad_len);
+void (*enc_update)(void *ctx,
+					struct gcm_context_data *gdata, u8 *out,
+					const u8 *in,
+					unsigned long plaintext_len);
+void (*dec_update)(void *ctx,
+					struct gcm_context_data *gdata, u8 *out,
+					const u8 *in,
+					unsigned long ciphertext_len);
+void (*finalize)(void *ctx,
+				struct gcm_context_data *gdata,
+				u8 *auth_tag, unsigned long auth_tag_len);
+} *aesni_gcm_tfm;
+
+struct aesni_gcm_tfm_s aesni_gcm_tfm_sse =3D {
+	.init =3D &aesni_gcm_init,
+	.enc_update =3D &aesni_gcm_enc_update,
+	.dec_update =3D &aesni_gcm_dec_update,
+	.finalize =3D &aesni_gcm_finalize,
+};
+
 #ifdef CONFIG_AS_AVX
 asmlinkage void aes_ctr_enc_128_avx_by8(const u8 *in, u8 *iv,
 		void *keys, u8 *out, unsigned int num_bytes);
@@ -183,16 +209,27 @@ asmlinkage void aes_ctr_enc_192_avx_by8(const u8 *in,=
 u8 *iv,
 asmlinkage void aes_ctr_enc_256_avx_by8(const u8 *in, u8 *iv,
 		void *keys, u8 *out, unsigned int num_bytes);
 /*
- * asmlinkage void aesni_gcm_precomp_avx_gen2()
+ * asmlinkage void aesni_gcm_init_avx_gen2()
  * gcm_data *my_ctx_data, context data
  * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boun=
dary.
  */
-asmlinkage void aesni_gcm_precomp_avx_gen2(void *my_ctx_data,
-					   struct gcm_context_data *gdata,
-					   u8 *hash_subkey,
-					   u8 *iv,
-					   const u8 *aad,
-					   unsigned long aad_len);
+asmlinkage void aesni_gcm_init_avx_gen2(void *my_ctx_data,
+					struct gcm_context_data *gdata,
+					u8 *iv,
+					u8 *hash_subkey,
+					const u8 *aad,
+					unsigned long aad_len);
+
+asmlinkage void aesni_gcm_enc_update_avx_gen2(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in, unsigned long plaintext_len);
+asmlinkage void aesni_gcm_dec_update_avx_gen2(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in,
+				     unsigned long ciphertext_len);
+asmlinkage void aesni_gcm_finalize_avx_gen2(void *ctx,
+				   struct gcm_context_data *gdata,
+				   u8 *auth_tag, unsigned long auth_tag_len);
=20
 asmlinkage void aesni_gcm_enc_avx_gen2(void *ctx,
 				struct gcm_context_data *gdata, u8 *out,
@@ -206,55 +243,38 @@ asmlinkage void aesni_gcm_dec_avx_gen2(void *ctx,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
=20
-static void aesni_gcm_enc_avx(void *ctx,
-			struct gcm_context_data *data, u8 *out,
-			const u8 *in, unsigned long plaintext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len)
-{
-	if (plaintext_len < AVX_GEN2_OPTSIZE) {
-		aesni_gcm_enc(ctx, data, out, in,
-			plaintext_len, iv, hash_subkey, aad,
-			aad_len, auth_tag, auth_tag_len);
-	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	}
-}
+struct aesni_gcm_tfm_s aesni_gcm_tfm_avx_gen2 =3D {
+	.init =3D &aesni_gcm_init_avx_gen2,
+	.enc_update =3D &aesni_gcm_enc_update_avx_gen2,
+	.dec_update =3D &aesni_gcm_dec_update_avx_gen2,
+	.finalize =3D &aesni_gcm_finalize_avx_gen2,
+};
=20
-static void aesni_gcm_dec_avx(void *ctx,
-			struct gcm_context_data *data, u8 *out,
-			const u8 *in, unsigned long ciphertext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len)
-{
-	if (ciphertext_len < AVX_GEN2_OPTSIZE) {
-		aesni_gcm_dec(ctx, data, out, in,
-			ciphertext_len, iv, hash_subkey, aad,
-			aad_len, auth_tag, auth_tag_len);
-	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	}
-}
 #endif
=20
 #ifdef CONFIG_AS_AVX2
 /*
- * asmlinkage void aesni_gcm_precomp_avx_gen4()
+ * asmlinkage void aesni_gcm_init_avx_gen4()
  * gcm_data *my_ctx_data, context data
  * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boun=
dary.
  */
-asmlinkage void aesni_gcm_precomp_avx_gen4(void *my_ctx_data,
-					   struct gcm_context_data *gdata,
-					   u8 *hash_subkey,
-					   u8 *iv,
-					   const u8 *aad,
-					   unsigned long aad_len);
+asmlinkage void aesni_gcm_init_avx_gen4(void *my_ctx_data,
+					struct gcm_context_data *gdata,
+					u8 *iv,
+					u8 *hash_subkey,
+					const u8 *aad,
+					unsigned long aad_len);
+
+asmlinkage void aesni_gcm_enc_update_avx_gen4(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in, unsigned long plaintext_len);
+asmlinkage void aesni_gcm_dec_update_avx_gen4(void *ctx,
+				     struct gcm_context_data *gdata, u8 *out,
+				     const u8 *in,
+				     unsigned long ciphertext_len);
+asmlinkage void aesni_gcm_finalize_avx_gen4(void *ctx,
+				   struct gcm_context_data *gdata,
+				   u8 *auth_tag, unsigned long auth_tag_len);
=20
 asmlinkage void aesni_gcm_enc_avx_gen4(void *ctx,
 				struct gcm_context_data *gdata, u8 *out,
@@ -268,67 +288,15 @@ asmlinkage void aesni_gcm_dec_avx_gen4(void *ctx,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
=20
-static void aesni_gcm_enc_avx2(void *ctx,
-			struct gcm_context_data *data, u8 *out,
-			const u8 *in, unsigned long plaintext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len)
-{
-	if (plaintext_len < AVX_GEN2_OPTSIZE) {
-		aesni_gcm_enc(ctx, data, out, in,
-			      plaintext_len, iv, hash_subkey, aad,
-			      aad_len, auth_tag, auth_tag_len);
-	} else if (plaintext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_enc_avx_gen4(ctx, data, out, in, plaintext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	}
-}
+struct aesni_gcm_tfm_s aesni_gcm_tfm_avx_gen4 =3D {
+	.init =3D &aesni_gcm_init_avx_gen4,
+	.enc_update =3D &aesni_gcm_enc_update_avx_gen4,
+	.dec_update =3D &aesni_gcm_dec_update_avx_gen4,
+	.finalize =3D &aesni_gcm_finalize_avx_gen4,
+};
=20
-static void aesni_gcm_dec_avx2(void *ctx,
-	struct gcm_context_data *data, u8 *out,
-			const u8 *in, unsigned long ciphertext_len, u8 *iv,
-			u8 *hash_subkey, const u8 *aad, unsigned long aad_len,
-			u8 *auth_tag, unsigned long auth_tag_len)
-{
-	if (ciphertext_len < AVX_GEN2_OPTSIZE) {
-		aesni_gcm_dec(ctx, data, out, in,
-			      ciphertext_len, iv, hash_subkey,
-			      aad, aad_len, auth_tag, auth_tag_len);
-	} else if (ciphertext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey, iv,
-					   aad, aad_len);
-		aesni_gcm_dec_avx_gen4(ctx, data, out, in, ciphertext_len, iv,
-				       aad, aad_len, auth_tag, auth_tag_len);
-	}
-}
 #endif
=20
-static void (*aesni_gcm_enc_tfm)(void *ctx,
-				 struct gcm_context_data *data, u8 *out,
-				 const u8 *in, unsigned long plaintext_len,
-				 u8 *iv, u8 *hash_subkey, const u8 *aad,
-				 unsigned long aad_len, u8 *auth_tag,
-				 unsigned long auth_tag_len);
-
-static void (*aesni_gcm_dec_tfm)(void *ctx,
-				 struct gcm_context_data *data, u8 *out,
-				 const u8 *in, unsigned long ciphertext_len,
-				 u8 *iv, u8 *hash_subkey, const u8 *aad,
-				 unsigned long aad_len, u8 *auth_tag,
-				 unsigned long auth_tag_len);
-
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
 {
@@ -810,6 +778,7 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_req=
uest *req,
 {
 	struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
 	unsigned long auth_tag_len =3D crypto_aead_authsize(tfm);
+	struct aesni_gcm_tfm_s *gcm_tfm =3D aesni_gcm_tfm;
 	struct gcm_context_data data AESNI_ALIGN_ATTR;
 	struct scatter_walk dst_sg_walk =3D {};
 	unsigned long left =3D req->cryptlen;
@@ -827,6 +796,15 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_re=
quest *req,
 	if (!enc)
 		left -=3D auth_tag_len;
=20
+#ifdef CONFIG_AS_AVX2
+	if (left < AVX_GEN4_OPTSIZE && gcm_tfm =3D=3D &aesni_gcm_tfm_avx_gen4)
+		gcm_tfm =3D &aesni_gcm_tfm_avx_gen2;
+#endif
+#ifdef CONFIG_AS_AVX
+	if (left < AVX_GEN2_OPTSIZE && gcm_tfm =3D=3D &aesni_gcm_tfm_avx_gen2)
+		gcm_tfm =3D &aesni_gcm_tfm_sse;
+#endif
+
 	/* Linearize assoc, if not already linear */
 	if (req->src->length >=3D assoclen && req->src->length &&
 		(!PageHighMem(sg_page(req->src)) ||
@@ -851,7 +829,7 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_req=
uest *req,
 	}
=20
 	kernel_fpu_begin();
-	aesni_gcm_init(aes_ctx, &data, iv,
+	gcm_tfm->init(aes_ctx, &data, iv,
 		hash_subkey, assoc, assoclen);
 	if (req->src !=3D req->dst) {
 		while (left) {
@@ -862,10 +840,10 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_r=
equest *req,
 			len =3D min(srclen, dstlen);
 			if (len) {
 				if (enc)
-					aesni_gcm_enc_update(aes_ctx, &data,
+					gcm_tfm->enc_update(aes_ctx, &data,
 							     dst, src, len);
 				else
-					aesni_gcm_dec_update(aes_ctx, &data,
+					gcm_tfm->dec_update(aes_ctx, &data,
 							     dst, src, len);
 			}
 			left -=3D len;
@@ -883,10 +861,10 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_r=
equest *req,
 			len =3D scatterwalk_clamp(&src_sg_walk, left);
 			if (len) {
 				if (enc)
-					aesni_gcm_enc_update(aes_ctx, &data,
+					gcm_tfm->enc_update(aes_ctx, &data,
 							     src, src, len);
 				else
-					aesni_gcm_dec_update(aes_ctx, &data,
+					gcm_tfm->dec_update(aes_ctx, &data,
 							     src, src, len);
 			}
 			left -=3D len;
@@ -895,7 +873,7 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_req=
uest *req,
 			scatterwalk_done(&src_sg_walk, 1, left);
 		}
 	}
-	aesni_gcm_finalize(aes_ctx, &data, authTag, auth_tag_len);
+	gcm_tfm->finalize(aes_ctx, &data, authTag, auth_tag_len);
 	kernel_fpu_end();
=20
 	if (!assocmem)
@@ -928,145 +906,15 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_=
request *req,
 static int gcmaes_encrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
-	u8 one_entry_in_sg =3D 0;
-	u8 *src, *dst, *assoc;
-	struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len =3D crypto_aead_authsize(tfm);
-	struct scatter_walk src_sg_walk;
-	struct scatter_walk dst_sg_walk =3D {};
-	struct gcm_context_data data AESNI_ALIGN_ATTR;
-
-	if (aesni_gcm_enc_tfm =3D=3D aesni_gcm_enc ||
-		req->cryptlen < AVX_GEN2_OPTSIZE) {
-		return gcmaes_crypt_by_sg(true, req, assoclen, hash_subkey, iv,
-					  aes_ctx);
-	}
-	if (sg_is_last(req->src) &&
-	    (!PageHighMem(sg_page(req->src)) ||
-	    req->src->offset + req->src->length <=3D PAGE_SIZE) &&
-	    sg_is_last(req->dst) &&
-	    (!PageHighMem(sg_page(req->dst)) ||
-	    req->dst->offset + req->dst->length <=3D PAGE_SIZE)) {
-		one_entry_in_sg =3D 1;
-		scatterwalk_start(&src_sg_walk, req->src);
-		assoc =3D scatterwalk_map(&src_sg_walk);
-		src =3D assoc + req->assoclen;
-		dst =3D src;
-		if (unlikely(req->src !=3D req->dst)) {
-			scatterwalk_start(&dst_sg_walk, req->dst);
-			dst =3D scatterwalk_map(&dst_sg_walk) + req->assoclen;
-		}
-	} else {
-		/* Allocate memory for src, dst, assoc */
-		assoc =3D kmalloc(req->cryptlen + auth_tag_len + req->assoclen,
-			GFP_ATOMIC);
-		if (unlikely(!assoc))
-			return -ENOMEM;
-		scatterwalk_map_and_copy(assoc, req->src, 0,
-					 req->assoclen + req->cryptlen, 0);
-		src =3D assoc + req->assoclen;
-		dst =3D src;
-	}
-
-	kernel_fpu_begin();
-	aesni_gcm_enc_tfm(aes_ctx, &data, dst, src, req->cryptlen, iv,
-			  hash_subkey, assoc, assoclen,
-			  dst + req->cryptlen, auth_tag_len);
-	kernel_fpu_end();
-
-	/* The authTag (aka the Integrity Check Value) needs to be written
-	 * back to the packet. */
-	if (one_entry_in_sg) {
-		if (unlikely(req->src !=3D req->dst)) {
-			scatterwalk_unmap(dst - req->assoclen);
-			scatterwalk_advance(&dst_sg_walk, req->dst->length);
-			scatterwalk_done(&dst_sg_walk, 1, 0);
-		}
-		scatterwalk_unmap(assoc);
-		scatterwalk_advance(&src_sg_walk, req->src->length);
-		scatterwalk_done(&src_sg_walk, req->src =3D=3D req->dst, 0);
-	} else {
-		scatterwalk_map_and_copy(dst, req->dst, req->assoclen,
-					 req->cryptlen + auth_tag_len, 1);
-		kfree(assoc);
-	}
-	return 0;
+	return gcmaes_crypt_by_sg(true, req, assoclen, hash_subkey, iv,
+				aes_ctx);
 }
=20
 static int gcmaes_decrypt(struct aead_request *req, unsigned int assoclen,
 			  u8 *hash_subkey, u8 *iv, void *aes_ctx)
 {
-	u8 one_entry_in_sg =3D 0;
-	u8 *src, *dst, *assoc;
-	unsigned long tempCipherLen =3D 0;
-	struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
-	unsigned long auth_tag_len =3D crypto_aead_authsize(tfm);
-	u8 authTag[16];
-	struct scatter_walk src_sg_walk;
-	struct scatter_walk dst_sg_walk =3D {};
-	struct gcm_context_data data AESNI_ALIGN_ATTR;
-	int retval =3D 0;
-
-	if (aesni_gcm_enc_tfm =3D=3D aesni_gcm_enc ||
-		req->cryptlen < AVX_GEN2_OPTSIZE) {
-		return gcmaes_crypt_by_sg(false, req, assoclen, hash_subkey, iv,
-					  aes_ctx);
-	}
-	tempCipherLen =3D (unsigned long)(req->cryptlen - auth_tag_len);
-
-	if (sg_is_last(req->src) &&
-	    (!PageHighMem(sg_page(req->src)) ||
-	    req->src->offset + req->src->length <=3D PAGE_SIZE) &&
-	    sg_is_last(req->dst) && req->dst->length &&
-	    (!PageHighMem(sg_page(req->dst)) ||
-	    req->dst->offset + req->dst->length <=3D PAGE_SIZE)) {
-		one_entry_in_sg =3D 1;
-		scatterwalk_start(&src_sg_walk, req->src);
-		assoc =3D scatterwalk_map(&src_sg_walk);
-		src =3D assoc + req->assoclen;
-		dst =3D src;
-		if (unlikely(req->src !=3D req->dst)) {
-			scatterwalk_start(&dst_sg_walk, req->dst);
-			dst =3D scatterwalk_map(&dst_sg_walk) + req->assoclen;
-		}
-	} else {
-		/* Allocate memory for src, dst, assoc */
-		assoc =3D kmalloc(req->cryptlen + req->assoclen, GFP_ATOMIC);
-		if (!assoc)
-			return -ENOMEM;
-		scatterwalk_map_and_copy(assoc, req->src, 0,
-					 req->assoclen + req->cryptlen, 0);
-		src =3D assoc + req->assoclen;
-		dst =3D src;
-	}
-
-
-	kernel_fpu_begin();
-	aesni_gcm_dec_tfm(aes_ctx, &data, dst, src, tempCipherLen, iv,
-			  hash_subkey, assoc, assoclen,
-			  authTag, auth_tag_len);
-	kernel_fpu_end();
-
-	/* Compare generated tag with passed in tag. */
-	retval =3D crypto_memneq(src + tempCipherLen, authTag, auth_tag_len) ?
-		-EBADMSG : 0;
-
-	if (one_entry_in_sg) {
-		if (unlikely(req->src !=3D req->dst)) {
-			scatterwalk_unmap(dst - req->assoclen);
-			scatterwalk_advance(&dst_sg_walk, req->dst->length);
-			scatterwalk_done(&dst_sg_walk, 1, 0);
-		}
-		scatterwalk_unmap(assoc);
-		scatterwalk_advance(&src_sg_walk, req->src->length);
-		scatterwalk_done(&src_sg_walk, req->src =3D=3D req->dst, 0);
-	} else {
-		scatterwalk_map_and_copy(dst, req->dst, req->assoclen,
-					 tempCipherLen, 1);
-		kfree(assoc);
-	}
-	return retval;
-
+	return gcmaes_crypt_by_sg(false, req, assoclen, hash_subkey, iv,
+				aes_ctx);
 }
=20
 static int helper_rfc4106_encrypt(struct aead_request *req)
@@ -1434,21 +1282,18 @@ static int __init aesni_init(void)
 #ifdef CONFIG_AS_AVX2
 	if (boot_cpu_has(X86_FEATURE_AVX2)) {
 		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
-		aesni_gcm_enc_tfm =3D aesni_gcm_enc_avx2;
-		aesni_gcm_dec_tfm =3D aesni_gcm_dec_avx2;
+		aesni_gcm_tfm =3D &aesni_gcm_tfm_avx_gen4;
 	} else
 #endif
 #ifdef CONFIG_AS_AVX
 	if (boot_cpu_has(X86_FEATURE_AVX)) {
 		pr_info("AVX version of gcm_enc/dec engaged.\n");
-		aesni_gcm_enc_tfm =3D aesni_gcm_enc_avx;
-		aesni_gcm_dec_tfm =3D aesni_gcm_dec_avx;
+		aesni_gcm_tfm =3D &aesni_gcm_tfm_avx_gen2;
 	} else
 #endif
 	{
 		pr_info("SSE version of gcm_enc/dec engaged.\n");
-		aesni_gcm_enc_tfm =3D aesni_gcm_enc;
-		aesni_gcm_dec_tfm =3D aesni_gcm_dec;
+		aesni_gcm_tfm =3D &aesni_gcm_tfm_sse;
 	}
 	aesni_ctr_enc_tfm =3D aesni_ctr_enc;
 #ifdef CONFIG_AS_AVX
--=20
2.17.1

