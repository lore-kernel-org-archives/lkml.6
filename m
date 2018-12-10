Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4916AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="csfMLcTO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MeOZNW0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B6120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbeLJT5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:57:41 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54176 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727515AbeLJT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:57:40 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAJuvcw005692;
        Mon, 10 Dec 2018 11:57:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/uSVf3dCndvB1WDf5irePoX0FKJTZ3XefRQ5eBe99NA=;
 b=csfMLcTOsgxmBCo5liNCTV2AiSok/JbjtxYM155IVo6VwcaI/PElreL6g91wNlUvC+yQ
 U2a02bbsJIk0ybyLUA9gncPEggbDqDsBbsQPSBpo0a/at1xBmdVXKDDKnKAxyEqOWSet
 +WbtP5Gk34EQOy3aDgbzcibTaHSNBWvRKqc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2p9wbygcuv-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:57:29 -0800
Received: from frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:57:28 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx07.TheFacebook.com (2620:10d:c0a1:f82::31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:57:28 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:57:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uSVf3dCndvB1WDf5irePoX0FKJTZ3XefRQ5eBe99NA=;
 b=MeOZNW0zdUWrPelcidF3ElEpxqRDIZ3ssXO9QDi1a07zQsBq0FOQ4XMeTELcYlYXJElaZnAETmrnSINqaVE0TwKwVsRAuMk5relZ6tlEGNQc0H7oWn/TxOmbn0iwGDmfhGv3XcKB4xggplycUaZHPrkMHLwpha7FOZD6jcN0u9Q=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1710.namprd15.prod.outlook.com (10.174.254.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 19:57:12 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:57:12 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 03/12] x86/crypto: aesni: Macro-ify func save/restore
Thread-Topic: [PATCH 03/12] x86/crypto: aesni: Macro-ify func save/restore
Thread-Index: AQHUkMKKH/SUntRynE2MQmdZiZ64Vw==
Date:   Mon, 10 Dec 2018 19:57:12 +0000
Message-ID: <08b21e5705b45fe799463d4fa708c7b73fa24625.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR0201CA0026.namprd02.prod.outlook.com
 (2603:10b6:301:74::39) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1710;20:KPjxfjSL8hWPTasyC3LiP56A2T1Xw+kQfy67mzl1+mCsmHAKbYXht0ZbG+QLNO6nSRzmDTIJZIvUNknJYLCCGeJ0TCfEN2GtfKaIwp0jHMU9cWqa/2aQlh8CEV1k68hDZtwFXoDznD8a2CWGZm3oUQVkgryQ5ARZSHlWwlj3Dlk=
x-ms-office365-filtering-correlation-id: 4c7a64f5-4100-48cb-7d12-08d65ed9acef
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1710;
x-ms-traffictypediagnostic: MWHPR15MB1710:
x-microsoft-antispam-prvs: <MWHPR15MB17108989BEAC11C8EFD8C510DDA50@MWHPR15MB1710.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1710;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1710;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(386003)(5660300001)(25786009)(11346002)(46003)(446003)(68736007)(2616005)(478600001)(7736002)(105586002)(305945005)(6436002)(476003)(186003)(71190400001)(71200400001)(6506007)(8936002)(81156014)(14454004)(81166006)(86362001)(6486002)(52116002)(8676002)(102836004)(316002)(14444005)(256004)(54906003)(2501003)(6512007)(58126008)(76176011)(118296001)(99286004)(110136005)(2906002)(36756003)(97736004)(6116002)(486006)(53936002)(106356001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1710;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rJk8B7MMbpgg0aORIeeY2PyWHSAonQRY6fI5FOQYAWmleq9CRccsS+IzSMQ9rQ1wkSaJG9uQZO8XkydISAnyRdPkg19tq9LIVy2lLxTE0i0cDc0mvHTMMmau1FvkuL6g+aj1ghqnoZ9qpfJMm5XQsql6mcItXEbf30kVUODX1FulT+Es7fuKg92FMMUtvmIfMPRm5LOxVIC4v4guWXO8aRoUNAIeyObjVt70dsXQkDFIVUjdVi3hmJDMsFqRhOc9ehswppfyMjMTjC2Kq2mRopjg/bHluLayG2MwGhSwxoT7HPUaisrgs9N76tgz0bMm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2071F740F9B0A45A8419830921FF4EC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a64f5-4100-48cb-7d12-08d65ed9acef
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:57:12.5067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1710
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro-ify function save and restore.  These will be used in new functions
added for scatter/gather update operations.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 94 +++++++++---------------
 1 file changed, 36 insertions(+), 58 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 284f1b8b88fc..dd895f69399b 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -247,6 +247,30 @@ VARIABLE_OFFSET =3D 16*8
 # Utility Macros
 ################################
=20
+.macro FUNC_SAVE
+        #the number of pushes must equal STACK_OFFSET
+        push    %r12
+        push    %r13
+        push    %r14
+        push    %r15
+
+        mov     %rsp, %r14
+
+
+
+        sub     $VARIABLE_OFFSET, %rsp
+        and     $~63, %rsp                    # align rsp to 64 bytes
+.endm
+
+.macro FUNC_RESTORE
+        mov     %r14, %rsp
+
+        pop     %r15
+        pop     %r14
+        pop     %r13
+        pop     %r12
+.endm
+
 # Encryption of a single block
 .macro ENCRYPT_SINGLE_BLOCK XMM0
                 vpxor    (arg1), \XMM0, \XMM0
@@ -264,22 +288,6 @@ VARIABLE_OFFSET =3D 16*8
 # clobbering all xmm registers
 # clobbering r10, r11, r12, r13, r14, r15
 .macro  GCM_ENC_DEC INITIAL_BLOCKS GHASH_8_ENCRYPT_8_PARALLEL GHASH_LAST_8=
 GHASH_MUL ENC_DEC
-
-        #the number of pushes must equal STACK_OFFSET
-        push    %r12
-        push    %r13
-        push    %r14
-        push    %r15
-
-        mov     %rsp, %r14
-
-
-
-
-        sub     $VARIABLE_OFFSET, %rsp
-        and     $~63, %rsp                  # align rsp to 64 bytes
-
-
         vmovdqu  HashKey(arg2), %xmm13      # xmm13 =3D HashKey
=20
         mov     arg5, %r13                  # save the number of bytes of =
plaintext/ciphertext
@@ -566,12 +574,6 @@ _T_16\@:
         vmovdqu %xmm9, (%r10)
=20
 _return_T_done\@:
-        mov     %r14, %rsp
-
-        pop     %r15
-        pop     %r14
-        pop     %r13
-        pop     %r12
 .endm
=20
 #ifdef CONFIG_AS_AVX
@@ -1511,18 +1513,7 @@ _initial_blocks_done\@:
 #        u8     *hash_subkey)# /* H, the Hash sub key input. Data starts o=
n a 16-byte boundary. */
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen2)
-        #the number of pushes must equal STACK_OFFSET
-        push    %r12
-        push    %r13
-        push    %r14
-        push    %r15
-
-        mov     %rsp, %r14
-
-
-
-        sub     $VARIABLE_OFFSET, %rsp
-        and     $~63, %rsp                  # align rsp to 64 bytes
+        FUNC_SAVE
=20
         vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
=20
@@ -1546,12 +1537,7 @@ ENTRY(aesni_gcm_precomp_avx_gen2)
=20
         PRECOMPUTE_AVX  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
=20
-        mov     %r14, %rsp
-
-        pop     %r15
-        pop     %r14
-        pop     %r13
-        pop     %r12
+        FUNC_RESTORE
         ret
 ENDPROC(aesni_gcm_precomp_avx_gen2)
=20
@@ -1573,7 +1559,9 @@ ENDPROC(aesni_gcm_precomp_avx_gen2)
 #				Valid values are 16 (most likely), 12 or 8. */
 ##########################################################################=
#####
 ENTRY(aesni_gcm_enc_avx_gen2)
+        FUNC_SAVE
         GCM_ENC_DEC INITIAL_BLOCKS_AVX GHASH_8_ENCRYPT_8_PARALLEL_AVX GHAS=
H_LAST_8_AVX GHASH_MUL_AVX ENC
+        FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc_avx_gen2)
=20
@@ -1595,7 +1583,9 @@ ENDPROC(aesni_gcm_enc_avx_gen2)
 #				Valid values are 16 (most likely), 12 or 8. */
 ##########################################################################=
#####
 ENTRY(aesni_gcm_dec_avx_gen2)
+        FUNC_SAVE
         GCM_ENC_DEC INITIAL_BLOCKS_AVX GHASH_8_ENCRYPT_8_PARALLEL_AVX GHAS=
H_LAST_8_AVX GHASH_MUL_AVX DEC
+        FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec_avx_gen2)
 #endif /* CONFIG_AS_AVX */
@@ -2525,18 +2515,7 @@ _initial_blocks_done\@:
 #				Data starts on a 16-byte boundary. */
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen4)
-        #the number of pushes must equal STACK_OFFSET
-        push    %r12
-        push    %r13
-        push    %r14
-        push    %r15
-
-        mov     %rsp, %r14
-
-
-
-        sub     $VARIABLE_OFFSET, %rsp
-        and     $~63, %rsp                    # align rsp to 64 bytes
+        FUNC_SAVE
=20
         vmovdqu  (arg3), %xmm6                # xmm6 =3D HashKey
=20
@@ -2560,12 +2539,7 @@ ENTRY(aesni_gcm_precomp_avx_gen4)
=20
         PRECOMPUTE_AVX2  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
=20
-        mov     %r14, %rsp
-
-        pop     %r15
-        pop     %r14
-        pop     %r13
-        pop     %r12
+        FUNC_RESTORE
         ret
 ENDPROC(aesni_gcm_precomp_avx_gen4)
=20
@@ -2588,7 +2562,9 @@ ENDPROC(aesni_gcm_precomp_avx_gen4)
 #				Valid values are 16 (most likely), 12 or 8. */
 ##########################################################################=
#####
 ENTRY(aesni_gcm_enc_avx_gen4)
+        FUNC_SAVE
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2 GHASH_8_ENCRYPT_8_PARALLEL_AVX2 GH=
ASH_LAST_8_AVX2 GHASH_MUL_AVX2 ENC
+        FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc_avx_gen4)
=20
@@ -2610,7 +2586,9 @@ ENDPROC(aesni_gcm_enc_avx_gen4)
 #				Valid values are 16 (most likely), 12 or 8. */
 ##########################################################################=
#####
 ENTRY(aesni_gcm_dec_avx_gen4)
+        FUNC_SAVE
         GCM_ENC_DEC INITIAL_BLOCKS_AVX2 GHASH_8_ENCRYPT_8_PARALLEL_AVX2 GH=
ASH_LAST_8_AVX2 GHASH_MUL_AVX2 DEC
+        FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec_avx_gen4)
=20
--=20
2.17.1

