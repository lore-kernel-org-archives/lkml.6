Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2883EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86F720821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="k3YeNWKG";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Scnz2BOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86F720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeLJT52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:57:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727515AbeLJT51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:57:27 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBAJn7gj017825;
        Mon, 10 Dec 2018 11:57:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YxSmw+T3pXXu2PdVPBo3gjgJNMApdHbNATa0agIRohc=;
 b=k3YeNWKGda2MuupvYrPAsBc3Gx2LCePz0XtZsJ+VnwhdI3raDQ+Xt5e57zNgEALQ+hzt
 4XtfpGHQpqnYWJuAVWRFc/04+bXRlKy8KuSWLCq3bExNgO7sfItgIFJKZxXXn5nOO0Ew
 NI8zKrLJ29Wetmj9Ai3bg3LUZYJgi8Va/Z0= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2p9xfd8240-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:57:07 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:57:02 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxSmw+T3pXXu2PdVPBo3gjgJNMApdHbNATa0agIRohc=;
 b=Scnz2BOGU6gNC6cwWcr4QW3ppLsvZHr+awrMErrTNo2OJz2R0wfImLO9gmA4wVqKjeeF469YmQNXjAIqyVZItyphzPKUiYhzTww5yNqA9z7yqcRKAbPiEQpvUOS0Y14AvbYJ/OrItJ5e2S74yL7RO1gYJBt0evm8M1eD57wo4Zk=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1695.namprd15.prod.outlook.com (10.175.142.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 19:57:00 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:57:00 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 02/12] x86/crypto: aesni: Introduce gcm_context_data
Thread-Topic: [PATCH 02/12] x86/crypto: aesni: Introduce gcm_context_data
Thread-Index: AQHUkMKDkRv7w0o7Wk++JwUvrc+NMw==
Date:   Mon, 10 Dec 2018 19:57:00 +0000
Message-ID: <cb6d2e70e49056ba7de8f94de36ea4d394f52133.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: CO2PR18CA0062.namprd18.prod.outlook.com
 (2603:10b6:104:2::30) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1695;20:uIkyPUnvYNUU/6XPxi+i93pfQfZtV01pbf9q3b6GOmlRb9T+Jj2U2UkEQz5mzeQzGsD3AXRrlyguPacZkpyjqoSpLBnMlUjZ8x/aXj6qV3ljyEEhkkvyk2/nCiSJx2zBJARSuOyZpGYQKq6doAmzi70CIfpZdhrwCYA3cp9iS8E=
x-ms-office365-filtering-correlation-id: ec968536-60bd-40dd-8368-08d65ed9a59d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1695;
x-ms-traffictypediagnostic: MWHPR15MB1695:
x-microsoft-antispam-prvs: <MWHPR15MB1695A25EA1D512D01E8A0405DDA50@MWHPR15MB1695.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(11241501185)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1695;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1695;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(136003)(396003)(189003)(199004)(6486002)(52116002)(2501003)(6436002)(76176011)(68736007)(7736002)(186003)(118296001)(102836004)(14454004)(8936002)(6506007)(46003)(386003)(8676002)(97736004)(106356001)(54906003)(58126008)(81166006)(316002)(86362001)(5660300001)(110136005)(105586002)(81156014)(478600001)(71200400001)(256004)(305945005)(6116002)(486006)(71190400001)(4326008)(53946003)(25786009)(36756003)(6512007)(2906002)(11346002)(476003)(53936002)(99286004)(4744004)(2616005)(446003)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1695;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rokmfNrlB3VU3+9AmQa7xViufMxUbAfMVSXSWaIpFW4qzP/KK9fS3Tlirj9devXM5LQKq3WqJazOMg/0netidjqDcGfr8paHAsdNpZNdOOccUv29QEbAanonb/9nE/o0sw83YAPXKhz9XENBaQRxJqlS9sP1Tp1BUfz7A4sjAw8mL/8zcXg3fUusKnLt1PcHU7OwEkwp7tHq973cmiCN/tLFI529g1UZf6bkKOQsT92ZiwyA7mOMEmSck6Anezcd6zHugjzHj9LXH0w4530zOUMW4lig//QGB3W/cdzHmcTRTlCgsi2gnv8QbOlaqRTg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A791D7E28452C540945D8C01A440AA26@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec968536-60bd-40dd-8368-08d65ed9a59d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:57:00.4285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gcm_context_data structure to the avx asm routines.
This will be necessary to support both 256 bit keys and
scatter/gather.

The pre-computed HashKeys are now stored in the gcm_context_data
struct, which is expanded to hold the greater number of hashkeys
necessary for avx.

Loads and stores to the new struct are always done unlaligned to
avoid compiler issues, see e5b954e8 "Use unaligned loads from
gcm_context_data"

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 378 +++++++++++------------
 arch/x86/crypto/aesni-intel_glue.c       |  58 ++--
 2 files changed, 215 insertions(+), 221 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 318135a77975..284f1b8b88fc 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -182,43 +182,22 @@ aad_shift_arr:
 .text
=20
=20
-##define the fields of the gcm aes context
-#{
-#        u8 expanded_keys[16*11] store expanded keys
-#        u8 shifted_hkey_1[16]   store HashKey <<1 mod poly here
-#        u8 shifted_hkey_2[16]   store HashKey^2 <<1 mod poly here
-#        u8 shifted_hkey_3[16]   store HashKey^3 <<1 mod poly here
-#        u8 shifted_hkey_4[16]   store HashKey^4 <<1 mod poly here
-#        u8 shifted_hkey_5[16]   store HashKey^5 <<1 mod poly here
-#        u8 shifted_hkey_6[16]   store HashKey^6 <<1 mod poly here
-#        u8 shifted_hkey_7[16]   store HashKey^7 <<1 mod poly here
-#        u8 shifted_hkey_8[16]   store HashKey^8 <<1 mod poly here
-#        u8 shifted_hkey_1_k[16] store XOR HashKey <<1 mod poly here (for =
Karatsuba purposes)
-#        u8 shifted_hkey_2_k[16] store XOR HashKey^2 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_3_k[16] store XOR HashKey^3 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_4_k[16] store XOR HashKey^4 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_5_k[16] store XOR HashKey^5 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_6_k[16] store XOR HashKey^6 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_7_k[16] store XOR HashKey^7 <<1 mod poly here (fo=
r Karatsuba purposes)
-#        u8 shifted_hkey_8_k[16] store XOR HashKey^8 <<1 mod poly here (fo=
r Karatsuba purposes)
-#} gcm_ctx#
-
-HashKey        =3D 16*11   # store HashKey <<1 mod poly here
-HashKey_2      =3D 16*12   # store HashKey^2 <<1 mod poly here
-HashKey_3      =3D 16*13   # store HashKey^3 <<1 mod poly here
-HashKey_4      =3D 16*14   # store HashKey^4 <<1 mod poly here
-HashKey_5      =3D 16*15   # store HashKey^5 <<1 mod poly here
-HashKey_6      =3D 16*16   # store HashKey^6 <<1 mod poly here
-HashKey_7      =3D 16*17   # store HashKey^7 <<1 mod poly here
-HashKey_8      =3D 16*18   # store HashKey^8 <<1 mod poly here
-HashKey_k      =3D 16*19   # store XOR of HashKey <<1 mod poly here (for K=
aratsuba purposes)
-HashKey_2_k    =3D 16*20   # store XOR of HashKey^2 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_3_k    =3D 16*21   # store XOR of HashKey^3 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_4_k    =3D 16*22   # store XOR of HashKey^4 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_5_k    =3D 16*23   # store XOR of HashKey^5 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_6_k    =3D 16*24   # store XOR of HashKey^6 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_7_k    =3D 16*25   # store XOR of HashKey^7 <<1 mod poly here (for=
 Karatsuba purposes)
-HashKey_8_k    =3D 16*26   # store XOR of HashKey^8 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey        =3D 16*6   # store HashKey <<1 mod poly here
+HashKey_2      =3D 16*7   # store HashKey^2 <<1 mod poly here
+HashKey_3      =3D 16*8   # store HashKey^3 <<1 mod poly here
+HashKey_4      =3D 16*9   # store HashKey^4 <<1 mod poly here
+HashKey_5      =3D 16*10   # store HashKey^5 <<1 mod poly here
+HashKey_6      =3D 16*11   # store HashKey^6 <<1 mod poly here
+HashKey_7      =3D 16*12   # store HashKey^7 <<1 mod poly here
+HashKey_8      =3D 16*13   # store HashKey^8 <<1 mod poly here
+HashKey_k      =3D 16*14   # store XOR of HashKey <<1 mod poly here (for K=
aratsuba purposes)
+HashKey_2_k    =3D 16*15   # store XOR of HashKey^2 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_3_k    =3D 16*16   # store XOR of HashKey^3 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_4_k    =3D 16*17   # store XOR of HashKey^4 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_5_k    =3D 16*18   # store XOR of HashKey^5 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_6_k    =3D 16*19   # store XOR of HashKey^6 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_7_k    =3D 16*20   # store XOR of HashKey^7 <<1 mod poly here (for=
 Karatsuba purposes)
+HashKey_8_k    =3D 16*21   # store XOR of HashKey^8 <<1 mod poly here (for=
 Karatsuba purposes)
=20
 #define arg1 %rdi
 #define arg2 %rsi
@@ -229,6 +208,7 @@ HashKey_8_k    =3D 16*26   # store XOR of HashKey^8 <<1=
 mod poly here (for Karatsu
 #define arg7 STACK_OFFSET+8*1(%r14)
 #define arg8 STACK_OFFSET+8*2(%r14)
 #define arg9 STACK_OFFSET+8*3(%r14)
+#define arg10 STACK_OFFSET+8*4(%r14)
=20
 i =3D 0
 j =3D 0
@@ -300,9 +280,9 @@ VARIABLE_OFFSET =3D 16*8
         and     $~63, %rsp                  # align rsp to 64 bytes
=20
=20
-        vmovdqu  HashKey(arg1), %xmm13      # xmm13 =3D HashKey
+        vmovdqu  HashKey(arg2), %xmm13      # xmm13 =3D HashKey
=20
-        mov     arg4, %r13                  # save the number of bytes of =
plaintext/ciphertext
+        mov     arg5, %r13                  # save the number of bytes of =
plaintext/ciphertext
         and     $-16, %r13                  # r13 =3D r13 - (r13 mod 16)
=20
         mov     %r13, %r12
@@ -413,11 +393,11 @@ _eight_cipher_left\@:
=20
=20
 _zero_cipher_left\@:
-        cmp     $16, arg4
+        cmp     $16, arg5
         jl      _only_less_than_16\@
=20
-        mov     arg4, %r13
-        and     $15, %r13                            # r13 =3D (arg4 mod 1=
6)
+        mov     arg5, %r13
+        and     $15, %r13                            # r13 =3D (arg5 mod 1=
6)
=20
         je      _multiple_of_16_bytes\@
=20
@@ -430,7 +410,7 @@ _zero_cipher_left\@:
=20
         sub     $16, %r11
         add     %r13, %r11
-        vmovdqu (arg3, %r11), %xmm1                  # receive the last <1=
6 Byte block
+        vmovdqu (arg4, %r11), %xmm1                  # receive the last <1=
6 Byte block
=20
         lea     SHIFT_MASK+16(%rip), %r12
         sub     %r13, %r12                           # adjust the shuffle =
mask pointer to be
@@ -442,8 +422,8 @@ _zero_cipher_left\@:
=20
 _only_less_than_16\@:
         # check for 0 length
-        mov     arg4, %r13
-        and     $15, %r13                            # r13 =3D (arg4 mod 1=
6)
+        mov     arg5, %r13
+        and     $15, %r13                            # r13 =3D (arg5 mod 1=
6)
=20
         je      _multiple_of_16_bytes\@
=20
@@ -461,7 +441,7 @@ _only_less_than_16\@:
 						     # number of bytes in plaintext mod 16)
=20
 _get_last_16_byte_loop\@:
-        movb    (arg3, %r11),  %al
+        movb    (arg4, %r11),  %al
         movb    %al,  TMP1 (%rsp , %r11)
         add     $1, %r11
         cmp     %r13,  %r11
@@ -506,14 +486,14 @@ _final_ghash_mul\@:
         cmp     $8, %r13
         jle     _less_than_8_bytes_left\@
=20
-        mov     %rax, (arg2 , %r11)
+        mov     %rax, (arg3 , %r11)
         add     $8, %r11
         vpsrldq $8, %xmm9, %xmm9
         vmovq   %xmm9, %rax
         sub     $8, %r13
=20
 _less_than_8_bytes_left\@:
-        movb    %al, (arg2 , %r11)
+        movb    %al, (arg3 , %r11)
         add     $1, %r11
         shr     $8, %rax
         sub     $1, %r13
@@ -521,12 +501,12 @@ _less_than_8_bytes_left\@:
         #############################
=20
 _multiple_of_16_bytes\@:
-        mov     arg7, %r12                           # r12 =3D aadLen (num=
ber of bytes)
+        mov     arg8, %r12                           # r12 =3D aadLen (num=
ber of bytes)
         shl     $3, %r12                             # convert into number=
 of bits
         vmovd   %r12d, %xmm15                        # len(A) in xmm15
=20
-        shl     $3, arg4                             # len(C) in bits  (*1=
28)
-        vmovq   arg4, %xmm1
+        shl     $3, arg5                             # len(C) in bits  (*1=
28)
+        vmovq   arg5, %xmm1
         vpslldq $8, %xmm15, %xmm15                   # xmm15 =3D len(A)|| =
0x0000000000000000
         vpxor   %xmm1, %xmm15, %xmm15                # xmm15 =3D len(A)||l=
en(C)
=20
@@ -534,7 +514,7 @@ _multiple_of_16_bytes\@:
         \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6    # final GHASH computation
         vpshufb SHUF_MASK(%rip), %xmm14, %xmm14      # perform a 16Byte sw=
ap
=20
-        mov     arg5, %rax                           # rax =3D *Y0
+        mov     arg6, %rax                           # rax =3D *Y0
         vmovdqu (%rax), %xmm9                        # xmm9 =3D Y0
=20
         ENCRYPT_SINGLE_BLOCK    %xmm9                # E(K, Y0)
@@ -544,8 +524,8 @@ _multiple_of_16_bytes\@:
=20
=20
 _return_T\@:
-        mov     arg8, %r10              # r10 =3D authTag
-        mov     arg9, %r11              # r11 =3D auth_tag_len
+        mov     arg9, %r10              # r10 =3D authTag
+        mov     arg10, %r11              # r11 =3D auth_tag_len
=20
         cmp     $16, %r11
         je      _T_16\@
@@ -655,49 +635,49 @@ _return_T_done\@:
=20
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_k(arg1)
+        vmovdqu  \T1, HashKey_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^2<<1 mod poly
-        vmovdqa  \T5, HashKey_2(arg1)                    #  [HashKey_2] =
=3D HashKey^2<<1 mod poly
+        vmovdqu  \T5, HashKey_2(arg2)                    #  [HashKey_2] =
=3D HashKey^2<<1 mod poly
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_2_k(arg1)
+        vmovdqu  \T1, HashKey_2_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^3<<1 mod poly
-        vmovdqa  \T5, HashKey_3(arg1)
+        vmovdqu  \T5, HashKey_3(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_3_k(arg1)
+        vmovdqu  \T1, HashKey_3_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^4<<1 mod poly
-        vmovdqa  \T5, HashKey_4(arg1)
+        vmovdqu  \T5, HashKey_4(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_4_k(arg1)
+        vmovdqu  \T1, HashKey_4_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^5<<1 mod poly
-        vmovdqa  \T5, HashKey_5(arg1)
+        vmovdqu  \T5, HashKey_5(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_5_k(arg1)
+        vmovdqu  \T1, HashKey_5_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^6<<1 mod poly
-        vmovdqa  \T5, HashKey_6(arg1)
+        vmovdqu  \T5, HashKey_6(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_6_k(arg1)
+        vmovdqu  \T1, HashKey_6_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^7<<1 mod poly
-        vmovdqa  \T5, HashKey_7(arg1)
+        vmovdqu  \T5, HashKey_7(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_7_k(arg1)
+        vmovdqu  \T1, HashKey_7_k(arg2)
=20
         GHASH_MUL_AVX \T5, \HK, \T1, \T3, \T4, \T6, \T2  #  T5 =3D HashKey=
^8<<1 mod poly
-        vmovdqa  \T5, HashKey_8(arg1)
+        vmovdqu  \T5, HashKey_8(arg2)
         vpshufd  $0b01001110, \T5, \T1
         vpxor    \T5, \T1, \T1
-        vmovdqa  \T1, HashKey_8_k(arg1)
+        vmovdqu  \T1, HashKey_8_k(arg2)
=20
 .endm
=20
@@ -706,15 +686,15 @@ _return_T_done\@:
 ## num_initial_blocks =3D b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ci=
phertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg2, arg3, r14 are used as a pointer only, not modified
+## arg1, arg3, arg4, r14 are used as a pointer only, not modified
=20
 .macro INITIAL_BLOCKS_AVX num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2 =
XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC
 	i =3D (8-\num_initial_blocks)
 	j =3D 0
 	setreg
=20
-	mov     arg6, %r10                      # r10 =3D AAD
-	mov     arg7, %r12                      # r12 =3D aadLen
+	mov     arg7, %r10                      # r10 =3D AAD
+	mov     arg8, %r12                      # r12 =3D aadLen
=20
=20
 	mov     %r12, %r11
@@ -780,7 +760,7 @@ _get_AAD_done\@:
 	xor     %r11d, %r11d
=20
 	# start AES for num_initial_blocks blocks
-	mov     arg5, %rax                     # rax =3D *Y0
+	mov     arg6, %rax                     # rax =3D *Y0
 	vmovdqu (%rax), \CTR                   # CTR =3D Y0
 	vpshufb SHUF_MASK(%rip), \CTR, \CTR
=20
@@ -833,9 +813,9 @@ _get_AAD_done\@:
 	i =3D (9-\num_initial_blocks)
 	setreg
 .rep \num_initial_blocks
-                vmovdqu (arg3, %r11), \T1
+                vmovdqu (arg4, %r11), \T1
                 vpxor   \T1, reg_i, reg_i
-                vmovdqu reg_i, (arg2 , %r11)           # write back cipher=
text for num_initial_blocks blocks
+                vmovdqu reg_i, (arg3 , %r11)           # write back cipher=
text for num_initial_blocks blocks
                 add     $16, %r11
 .if  \ENC_DEC =3D=3D DEC
                 vmovdqa \T1, reg_i
@@ -936,58 +916,58 @@ _get_AAD_done\@:
                 vaesenclast  \T_key, \XMM7, \XMM7
                 vaesenclast  \T_key, \XMM8, \XMM8
=20
-                vmovdqu  (arg3, %r11), \T1
+                vmovdqu  (arg4, %r11), \T1
                 vpxor    \T1, \XMM1, \XMM1
-                vmovdqu  \XMM1, (arg2 , %r11)
+                vmovdqu  \XMM1, (arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM1
                 .endif
=20
-                vmovdqu  16*1(arg3, %r11), \T1
+                vmovdqu  16*1(arg4, %r11), \T1
                 vpxor    \T1, \XMM2, \XMM2
-                vmovdqu  \XMM2, 16*1(arg2 , %r11)
+                vmovdqu  \XMM2, 16*1(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM2
                 .endif
=20
-                vmovdqu  16*2(arg3, %r11), \T1
+                vmovdqu  16*2(arg4, %r11), \T1
                 vpxor    \T1, \XMM3, \XMM3
-                vmovdqu  \XMM3, 16*2(arg2 , %r11)
+                vmovdqu  \XMM3, 16*2(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM3
                 .endif
=20
-                vmovdqu  16*3(arg3, %r11), \T1
+                vmovdqu  16*3(arg4, %r11), \T1
                 vpxor    \T1, \XMM4, \XMM4
-                vmovdqu  \XMM4, 16*3(arg2 , %r11)
+                vmovdqu  \XMM4, 16*3(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM4
                 .endif
=20
-                vmovdqu  16*4(arg3, %r11), \T1
+                vmovdqu  16*4(arg4, %r11), \T1
                 vpxor    \T1, \XMM5, \XMM5
-                vmovdqu  \XMM5, 16*4(arg2 , %r11)
+                vmovdqu  \XMM5, 16*4(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM5
                 .endif
=20
-                vmovdqu  16*5(arg3, %r11), \T1
+                vmovdqu  16*5(arg4, %r11), \T1
                 vpxor    \T1, \XMM6, \XMM6
-                vmovdqu  \XMM6, 16*5(arg2 , %r11)
+                vmovdqu  \XMM6, 16*5(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM6
                 .endif
=20
-                vmovdqu  16*6(arg3, %r11), \T1
+                vmovdqu  16*6(arg4, %r11), \T1
                 vpxor    \T1, \XMM7, \XMM7
-                vmovdqu  \XMM7, 16*6(arg2 , %r11)
+                vmovdqu  \XMM7, 16*6(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM7
                 .endif
=20
-                vmovdqu  16*7(arg3, %r11), \T1
+                vmovdqu  16*7(arg4, %r11), \T1
                 vpxor    \T1, \XMM8, \XMM8
-                vmovdqu  \XMM8, 16*7(arg2 , %r11)
+                vmovdqu  \XMM8, 16*7(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM8
                 .endif
@@ -1012,7 +992,7 @@ _initial_blocks_done\@:
=20
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg2, arg3 are used as pointers only, not modified
+# arg1, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM3=
 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
=20
@@ -1098,14 +1078,14 @@ _initial_blocks_done\@:
=20
         ##################################################################=
#####
=20
-        vmovdqa         HashKey_8(arg1), \T5
+        vmovdqu         HashKey_8(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T2, \T4             # T4 =3D a1*b1
         vpclmulqdq      $0x00, \T5, \T2, \T7             # T7 =3D a0*b0
=20
         vpshufd         $0b01001110, \T2, \T6
         vpxor           \T2, \T6, \T6
=20
-        vmovdqa         HashKey_8_k(arg1), \T5
+        vmovdqu         HashKey_8_k(arg2), \T5
         vpclmulqdq      $0x00, \T5, \T6, \T6
=20
                 vmovdqu 16*3(arg1), \T1
@@ -1119,7 +1099,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP2(%rsp), \T1
-        vmovdqa         HashKey_7(arg1), \T5
+        vmovdqu         HashKey_7(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1127,7 +1107,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_7_k(arg1), \T5
+        vmovdqu         HashKey_7_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1144,7 +1124,7 @@ _initial_blocks_done\@:
         ##################################################################=
#####
=20
         vmovdqa         TMP3(%rsp), \T1
-        vmovdqa         HashKey_6(arg1), \T5
+        vmovdqu         HashKey_6(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1152,7 +1132,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_6_k(arg1), \T5
+        vmovdqu         HashKey_6_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1167,7 +1147,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP4(%rsp), \T1
-        vmovdqa         HashKey_5(arg1), \T5
+        vmovdqu         HashKey_5(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1175,7 +1155,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_5_k(arg1), \T5
+        vmovdqu         HashKey_5_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1191,7 +1171,7 @@ _initial_blocks_done\@:
=20
=20
         vmovdqa         TMP5(%rsp), \T1
-        vmovdqa         HashKey_4(arg1), \T5
+        vmovdqu         HashKey_4(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1199,7 +1179,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_4_k(arg1), \T5
+        vmovdqu         HashKey_4_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1214,7 +1194,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP6(%rsp), \T1
-        vmovdqa         HashKey_3(arg1), \T5
+        vmovdqu         HashKey_3(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1222,7 +1202,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_3_k(arg1), \T5
+        vmovdqu         HashKey_3_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1238,7 +1218,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP7(%rsp), \T1
-        vmovdqa         HashKey_2(arg1), \T5
+        vmovdqu         HashKey_2(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1246,7 +1226,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_2_k(arg1), \T5
+        vmovdqu         HashKey_2_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1263,7 +1243,7 @@ _initial_blocks_done\@:
                 vaesenc \T5, \XMM8, \XMM8
=20
         vmovdqa         TMP8(%rsp), \T1
-        vmovdqa         HashKey(arg1), \T5
+        vmovdqu         HashKey(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
         vpclmulqdq      $0x00, \T5, \T1, \T3
@@ -1271,7 +1251,7 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \T1, \T3
         vpxor           \T1, \T3, \T3
-        vmovdqa         HashKey_k(arg1), \T5
+        vmovdqu         HashKey_k(arg2), \T5
         vpclmulqdq      $0x10, \T5, \T3, \T3
         vpxor           \T3, \T6, \T6
=20
@@ -1284,13 +1264,13 @@ _initial_blocks_done\@:
 	j =3D 1
 	setreg
 .rep 8
-		vpxor	16*i(arg3, %r11), \T5, \T2
+		vpxor	16*i(arg4, %r11), \T5, \T2
                 .if \ENC_DEC =3D=3D ENC
                 vaesenclast     \T2, reg_j, reg_j
                 .else
                 vaesenclast     \T2, reg_j, \T3
-                vmovdqu 16*i(arg3, %r11), reg_j
-                vmovdqu \T3, 16*i(arg2, %r11)
+                vmovdqu 16*i(arg4, %r11), reg_j
+                vmovdqu \T3, 16*i(arg3, %r11)
                 .endif
 	i =3D (i+1)
 	j =3D (j+1)
@@ -1322,14 +1302,14 @@ _initial_blocks_done\@:
         vpxor   \T2, \T7, \T7                           # first phase of t=
he reduction complete
 	#######################################################################
                 .if \ENC_DEC =3D=3D ENC
-		vmovdqu	 \XMM1,	16*0(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM2,	16*1(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM3,	16*2(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM4,	16*3(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM5,	16*4(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM6,	16*5(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM7,	16*6(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM8,	16*7(arg2,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM1,	16*0(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM2,	16*1(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM3,	16*2(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM4,	16*3(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM5,	16*4(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM6,	16*5(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM7,	16*6(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM8,	16*7(arg3,%r11)		# Write to the Ciphertext buffer
                 .endif
=20
 	#######################################################################
@@ -1370,25 +1350,25 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM1, \T2
         vpxor           \XMM1, \T2, \T2
-        vmovdqa         HashKey_8(arg1), \T5
+        vmovdqu         HashKey_8(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM1, \T6
         vpclmulqdq      $0x00, \T5, \XMM1, \T7
=20
-        vmovdqa         HashKey_8_k(arg1), \T3
+        vmovdqu         HashKey_8_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \XMM1
=20
         ######################
=20
         vpshufd         $0b01001110, \XMM2, \T2
         vpxor           \XMM2, \T2, \T2
-        vmovdqa         HashKey_7(arg1), \T5
+        vmovdqu         HashKey_7(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM2, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM2, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_7_k(arg1), \T3
+        vmovdqu         HashKey_7_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1396,14 +1376,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM3, \T2
         vpxor           \XMM3, \T2, \T2
-        vmovdqa         HashKey_6(arg1), \T5
+        vmovdqu         HashKey_6(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM3, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM3, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_6_k(arg1), \T3
+        vmovdqu         HashKey_6_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1411,14 +1391,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM4, \T2
         vpxor           \XMM4, \T2, \T2
-        vmovdqa         HashKey_5(arg1), \T5
+        vmovdqu         HashKey_5(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM4, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM4, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_5_k(arg1), \T3
+        vmovdqu         HashKey_5_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1426,14 +1406,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM5, \T2
         vpxor           \XMM5, \T2, \T2
-        vmovdqa         HashKey_4(arg1), \T5
+        vmovdqu         HashKey_4(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM5, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM5, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_4_k(arg1), \T3
+        vmovdqu         HashKey_4_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1441,14 +1421,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM6, \T2
         vpxor           \XMM6, \T2, \T2
-        vmovdqa         HashKey_3(arg1), \T5
+        vmovdqu         HashKey_3(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM6, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM6, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_3_k(arg1), \T3
+        vmovdqu         HashKey_3_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1456,14 +1436,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM7, \T2
         vpxor           \XMM7, \T2, \T2
-        vmovdqa         HashKey_2(arg1), \T5
+        vmovdqu         HashKey_2(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM7, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM7, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_2_k(arg1), \T3
+        vmovdqu         HashKey_2_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
         vpxor           \T2, \XMM1, \XMM1
=20
@@ -1471,14 +1451,14 @@ _initial_blocks_done\@:
=20
         vpshufd         $0b01001110, \XMM8, \T2
         vpxor           \XMM8, \T2, \T2
-        vmovdqa         HashKey(arg1), \T5
+        vmovdqu         HashKey(arg2), \T5
         vpclmulqdq      $0x11, \T5, \XMM8, \T4
         vpxor           \T4, \T6, \T6
=20
         vpclmulqdq      $0x00, \T5, \XMM8, \T4
         vpxor           \T4, \T7, \T7
=20
-        vmovdqa         HashKey_k(arg1), \T3
+        vmovdqu         HashKey_k(arg2), \T3
         vpclmulqdq      $0x00, \T3, \T2, \T2
=20
         vpxor           \T2, \XMM1, \XMM1
@@ -1527,6 +1507,7 @@ _initial_blocks_done\@:
 #############################################################
 #void   aesni_gcm_precomp_avx_gen2
 #        (gcm_data     *my_ctx_data,
+#         gcm_context_data *data,
 #        u8     *hash_subkey)# /* H, the Hash sub key input. Data starts o=
n a 16-byte boundary. */
 #############################################################
 ENTRY(aesni_gcm_precomp_avx_gen2)
@@ -1543,7 +1524,7 @@ ENTRY(aesni_gcm_precomp_avx_gen2)
         sub     $VARIABLE_OFFSET, %rsp
         and     $~63, %rsp                  # align rsp to 64 bytes
=20
-        vmovdqu  (arg2), %xmm6              # xmm6 =3D HashKey
+        vmovdqu  (arg3), %xmm6              # xmm6 =3D HashKey
=20
         vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
         ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
@@ -1560,7 +1541,7 @@ ENTRY(aesni_gcm_precomp_avx_gen2)
         vpand    POLY(%rip), %xmm2, %xmm2
         vpxor    %xmm2, %xmm6, %xmm6        # xmm6 holds the HashKey<<1 mo=
d poly
         ##################################################################=
#####
-        vmovdqa  %xmm6, HashKey(arg1)       # store HashKey<<1 mod poly
+        vmovdqu  %xmm6, HashKey(arg2)       # store HashKey<<1 mod poly
=20
=20
         PRECOMPUTE_AVX  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
@@ -1577,6 +1558,7 @@ ENDPROC(aesni_gcm_precomp_avx_gen2)
 ##########################################################################=
#####
 #void   aesni_gcm_enc_avx_gen2(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
 #        u8      *out, /* Ciphertext output. Encrypt in-place is allowed. =
 */
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
@@ -1598,6 +1580,7 @@ ENDPROC(aesni_gcm_enc_avx_gen2)
 ##########################################################################=
#####
 #void   aesni_gcm_dec_avx_gen2(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
 #        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  =
*/
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
@@ -1668,25 +1651,25 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
         # Haskey_i_k holds XORed values of the low and high parts of the H=
askey_i
         vmovdqa  \HK, \T5
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^2<<1 mod poly
-        vmovdqa  \T5, HashKey_2(arg1)                       #  [HashKey_2]=
 =3D HashKey^2<<1 mod poly
+        vmovdqu  \T5, HashKey_2(arg2)                       #  [HashKey_2]=
 =3D HashKey^2<<1 mod poly
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^3<<1 mod poly
-        vmovdqa  \T5, HashKey_3(arg1)
+        vmovdqu  \T5, HashKey_3(arg2)
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^4<<1 mod poly
-        vmovdqa  \T5, HashKey_4(arg1)
+        vmovdqu  \T5, HashKey_4(arg2)
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^5<<1 mod poly
-        vmovdqa  \T5, HashKey_5(arg1)
+        vmovdqu  \T5, HashKey_5(arg2)
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^6<<1 mod poly
-        vmovdqa  \T5, HashKey_6(arg1)
+        vmovdqu  \T5, HashKey_6(arg2)
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^7<<1 mod poly
-        vmovdqa  \T5, HashKey_7(arg1)
+        vmovdqu  \T5, HashKey_7(arg2)
=20
         GHASH_MUL_AVX2 \T5, \HK, \T1, \T3, \T4, \T6, \T2    #  T5 =3D Hash=
Key^8<<1 mod poly
-        vmovdqa  \T5, HashKey_8(arg1)
+        vmovdqu  \T5, HashKey_8(arg2)
=20
 .endm
=20
@@ -1696,15 +1679,15 @@ ENDPROC(aesni_gcm_dec_avx_gen2)
 ## num_initial_blocks =3D b mod 4#
 ## encrypt the initial num_initial_blocks blocks and apply ghash on the ci=
phertext
 ## r10, r11, r12, rax are clobbered
-## arg1, arg2, arg3, r14 are used as a pointer only, not modified
+## arg1, arg3, arg4, r14 are used as a pointer only, not modified
=20
 .macro INITIAL_BLOCKS_AVX2 num_initial_blocks T1 T2 T3 T4 T5 CTR XMM1 XMM2=
 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 T6 T_key ENC_DEC VER
 	i =3D (8-\num_initial_blocks)
 	j =3D 0
 	setreg
=20
-	mov     arg6, %r10                       # r10 =3D AAD
-	mov     arg7, %r12                       # r12 =3D aadLen
+	mov     arg7, %r10                       # r10 =3D AAD
+	mov     arg8, %r12                       # r12 =3D aadLen
=20
=20
 	mov     %r12, %r11
@@ -1771,7 +1754,7 @@ _get_AAD_done\@:
 	xor     %r11d, %r11d
=20
 	# start AES for num_initial_blocks blocks
-	mov     arg5, %rax                     # rax =3D *Y0
+	mov     arg6, %rax                     # rax =3D *Y0
 	vmovdqu (%rax), \CTR                   # CTR =3D Y0
 	vpshufb SHUF_MASK(%rip), \CTR, \CTR
=20
@@ -1824,9 +1807,9 @@ _get_AAD_done\@:
 	i =3D (9-\num_initial_blocks)
 	setreg
 .rep \num_initial_blocks
-                vmovdqu (arg3, %r11), \T1
+                vmovdqu (arg4, %r11), \T1
                 vpxor   \T1, reg_i, reg_i
-                vmovdqu reg_i, (arg2 , %r11)           # write back cipher=
text for
+                vmovdqu reg_i, (arg3 , %r11)           # write back cipher=
text for
 						       # num_initial_blocks blocks
                 add     $16, %r11
 .if  \ENC_DEC =3D=3D DEC
@@ -1928,58 +1911,58 @@ _get_AAD_done\@:
                 vaesenclast  \T_key, \XMM7, \XMM7
                 vaesenclast  \T_key, \XMM8, \XMM8
=20
-                vmovdqu  (arg3, %r11), \T1
+                vmovdqu  (arg4, %r11), \T1
                 vpxor    \T1, \XMM1, \XMM1
-                vmovdqu  \XMM1, (arg2 , %r11)
+                vmovdqu  \XMM1, (arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM1
                 .endif
=20
-                vmovdqu  16*1(arg3, %r11), \T1
+                vmovdqu  16*1(arg4, %r11), \T1
                 vpxor    \T1, \XMM2, \XMM2
-                vmovdqu  \XMM2, 16*1(arg2 , %r11)
+                vmovdqu  \XMM2, 16*1(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM2
                 .endif
=20
-                vmovdqu  16*2(arg3, %r11), \T1
+                vmovdqu  16*2(arg4, %r11), \T1
                 vpxor    \T1, \XMM3, \XMM3
-                vmovdqu  \XMM3, 16*2(arg2 , %r11)
+                vmovdqu  \XMM3, 16*2(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM3
                 .endif
=20
-                vmovdqu  16*3(arg3, %r11), \T1
+                vmovdqu  16*3(arg4, %r11), \T1
                 vpxor    \T1, \XMM4, \XMM4
-                vmovdqu  \XMM4, 16*3(arg2 , %r11)
+                vmovdqu  \XMM4, 16*3(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM4
                 .endif
=20
-                vmovdqu  16*4(arg3, %r11), \T1
+                vmovdqu  16*4(arg4, %r11), \T1
                 vpxor    \T1, \XMM5, \XMM5
-                vmovdqu  \XMM5, 16*4(arg2 , %r11)
+                vmovdqu  \XMM5, 16*4(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM5
                 .endif
=20
-                vmovdqu  16*5(arg3, %r11), \T1
+                vmovdqu  16*5(arg4, %r11), \T1
                 vpxor    \T1, \XMM6, \XMM6
-                vmovdqu  \XMM6, 16*5(arg2 , %r11)
+                vmovdqu  \XMM6, 16*5(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM6
                 .endif
=20
-                vmovdqu  16*6(arg3, %r11), \T1
+                vmovdqu  16*6(arg4, %r11), \T1
                 vpxor    \T1, \XMM7, \XMM7
-                vmovdqu  \XMM7, 16*6(arg2 , %r11)
+                vmovdqu  \XMM7, 16*6(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM7
                 .endif
=20
-                vmovdqu  16*7(arg3, %r11), \T1
+                vmovdqu  16*7(arg4, %r11), \T1
                 vpxor    \T1, \XMM8, \XMM8
-                vmovdqu  \XMM8, 16*7(arg2 , %r11)
+                vmovdqu  \XMM8, 16*7(arg3 , %r11)
                 .if   \ENC_DEC =3D=3D DEC
                 vmovdqa  \T1, \XMM8
                 .endif
@@ -2008,7 +1991,7 @@ _initial_blocks_done\@:
=20
 # encrypt 8 blocks at a time
 # ghash the 8 previously encrypted ciphertext blocks
-# arg1, arg2, arg3 are used as pointers only, not modified
+# arg1, arg3, arg4 are used as pointers only, not modified
 # r11 is the data offset value
 .macro GHASH_8_ENCRYPT_8_PARALLEL_AVX2 T1 T2 T3 T4 T5 T6 CTR XMM1 XMM2 XMM=
3 XMM4 XMM5 XMM6 XMM7 XMM8 T7 loop_idx ENC_DEC
=20
@@ -2094,7 +2077,7 @@ _initial_blocks_done\@:
=20
         ##################################################################=
#####
=20
-        vmovdqa         HashKey_8(arg1), \T5
+        vmovdqu         HashKey_8(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T2, \T4              # T4 =3D a1*b1
         vpclmulqdq      $0x00, \T5, \T2, \T7              # T7 =3D a0*b0
         vpclmulqdq      $0x01, \T5, \T2, \T6              # T6 =3D a1*b0
@@ -2112,7 +2095,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP2(%rsp), \T1
-        vmovdqa         HashKey_7(arg1), \T5
+        vmovdqu         HashKey_7(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2138,7 +2121,7 @@ _initial_blocks_done\@:
         ##################################################################=
#####
=20
         vmovdqa         TMP3(%rsp), \T1
-        vmovdqa         HashKey_6(arg1), \T5
+        vmovdqu         HashKey_6(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2162,7 +2145,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP4(%rsp), \T1
-        vmovdqa         HashKey_5(arg1), \T5
+        vmovdqu         HashKey_5(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2187,7 +2170,7 @@ _initial_blocks_done\@:
=20
=20
         vmovdqa         TMP5(%rsp), \T1
-        vmovdqa         HashKey_4(arg1), \T5
+        vmovdqu         HashKey_4(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2211,7 +2194,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP6(%rsp), \T1
-        vmovdqa         HashKey_3(arg1), \T5
+        vmovdqu         HashKey_3(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2235,7 +2218,7 @@ _initial_blocks_done\@:
                 vaesenc \T1, \XMM8, \XMM8
=20
         vmovdqa         TMP7(%rsp), \T1
-        vmovdqa         HashKey_2(arg1), \T5
+        vmovdqu         HashKey_2(arg2), \T5
         vpclmulqdq      $0x11, \T5, \T1, \T3
         vpxor           \T3, \T4, \T4
=20
@@ -2262,7 +2245,7 @@ _initial_blocks_done\@:
                 vaesenc \T5, \XMM8, \XMM8
=20
         vmovdqa         TMP8(%rsp), \T1
-        vmovdqa         HashKey(arg1), \T5
+        vmovdqu         HashKey(arg2), \T5
=20
         vpclmulqdq      $0x00, \T5, \T1, \T3
         vpxor           \T3, \T7, \T7
@@ -2283,13 +2266,13 @@ _initial_blocks_done\@:
 	j =3D 1
 	setreg
 .rep 8
-		vpxor	16*i(arg3, %r11), \T5, \T2
+		vpxor	16*i(arg4, %r11), \T5, \T2
                 .if \ENC_DEC =3D=3D ENC
                 vaesenclast     \T2, reg_j, reg_j
                 .else
                 vaesenclast     \T2, reg_j, \T3
-                vmovdqu 16*i(arg3, %r11), reg_j
-                vmovdqu \T3, 16*i(arg2, %r11)
+                vmovdqu 16*i(arg4, %r11), reg_j
+                vmovdqu \T3, 16*i(arg3, %r11)
                 .endif
 	i =3D (i+1)
 	j =3D (j+1)
@@ -2315,14 +2298,14 @@ _initial_blocks_done\@:
 	vpxor		\T2, \T7, \T7			# first phase of the reduction complete
 	#######################################################################
                 .if \ENC_DEC =3D=3D ENC
-		vmovdqu	 \XMM1,	16*0(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM2,	16*1(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM3,	16*2(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM4,	16*3(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM5,	16*4(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM6,	16*5(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM7,	16*6(arg2,%r11)		# Write to the Ciphertext buffer
-		vmovdqu	 \XMM8,	16*7(arg2,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM1,	16*0(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM2,	16*1(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM3,	16*2(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM4,	16*3(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM5,	16*4(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM6,	16*5(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM7,	16*6(arg3,%r11)		# Write to the Ciphertext buffer
+		vmovdqu	 \XMM8,	16*7(arg3,%r11)		# Write to the Ciphertext buffer
                 .endif
=20
 	#######################################################################
@@ -2359,7 +2342,7 @@ _initial_blocks_done\@:
=20
         ## Karatsuba Method
=20
-        vmovdqa         HashKey_8(arg1), \T5
+        vmovdqu         HashKey_8(arg2), \T5
=20
         vpshufd         $0b01001110, \XMM1, \T2
         vpshufd         $0b01001110, \T5, \T3
@@ -2373,7 +2356,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_7(arg1), \T5
+        vmovdqu         HashKey_7(arg2), \T5
         vpshufd         $0b01001110, \XMM2, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM2, \T2, \T2
@@ -2391,7 +2374,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_6(arg1), \T5
+        vmovdqu         HashKey_6(arg2), \T5
         vpshufd         $0b01001110, \XMM3, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM3, \T2, \T2
@@ -2409,7 +2392,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_5(arg1), \T5
+        vmovdqu         HashKey_5(arg2), \T5
         vpshufd         $0b01001110, \XMM4, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM4, \T2, \T2
@@ -2427,7 +2410,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_4(arg1), \T5
+        vmovdqu         HashKey_4(arg2), \T5
         vpshufd         $0b01001110, \XMM5, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM5, \T2, \T2
@@ -2445,7 +2428,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_3(arg1), \T5
+        vmovdqu         HashKey_3(arg2), \T5
         vpshufd         $0b01001110, \XMM6, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM6, \T2, \T2
@@ -2463,7 +2446,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey_2(arg1), \T5
+        vmovdqu         HashKey_2(arg2), \T5
         vpshufd         $0b01001110, \XMM7, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM7, \T2, \T2
@@ -2481,7 +2464,7 @@ _initial_blocks_done\@:
=20
         ######################
=20
-        vmovdqa         HashKey(arg1), \T5
+        vmovdqu         HashKey(arg2), \T5
         vpshufd         $0b01001110, \XMM8, \T2
         vpshufd         $0b01001110, \T5, \T3
         vpxor           \XMM8, \T2, \T2
@@ -2537,6 +2520,7 @@ _initial_blocks_done\@:
 #############################################################
 #void   aesni_gcm_precomp_avx_gen4
 #        (gcm_data     *my_ctx_data,
+#         gcm_context_data *data,
 #        u8     *hash_subkey)# /* H, the Hash sub key input.
 #				Data starts on a 16-byte boundary. */
 #############################################################
@@ -2554,7 +2538,7 @@ ENTRY(aesni_gcm_precomp_avx_gen4)
         sub     $VARIABLE_OFFSET, %rsp
         and     $~63, %rsp                    # align rsp to 64 bytes
=20
-        vmovdqu  (arg2), %xmm6                # xmm6 =3D HashKey
+        vmovdqu  (arg3), %xmm6                # xmm6 =3D HashKey
=20
         vpshufb  SHUF_MASK(%rip), %xmm6, %xmm6
         ###############  PRECOMPUTATION of HashKey<<1 mod poly from the Ha=
shKey
@@ -2571,7 +2555,7 @@ ENTRY(aesni_gcm_precomp_avx_gen4)
         vpand    POLY(%rip), %xmm2, %xmm2
         vpxor    %xmm2, %xmm6, %xmm6          # xmm6 holds the HashKey<<1 =
mod poly
         ##################################################################=
#####
-        vmovdqa  %xmm6, HashKey(arg1)         # store HashKey<<1 mod poly
+        vmovdqu  %xmm6, HashKey(arg2)         # store HashKey<<1 mod poly
=20
=20
         PRECOMPUTE_AVX2  %xmm6, %xmm0, %xmm1, %xmm2, %xmm3, %xmm4, %xmm5
@@ -2589,6 +2573,7 @@ ENDPROC(aesni_gcm_precomp_avx_gen4)
 ##########################################################################=
#####
 #void   aesni_gcm_enc_avx_gen4(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
 #        u8      *out, /* Ciphertext output. Encrypt in-place is allowed. =
 */
 #        const   u8 *in, /* Plaintext input */
 #        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
@@ -2610,6 +2595,7 @@ ENDPROC(aesni_gcm_enc_avx_gen4)
 ##########################################################################=
#####
 #void   aesni_gcm_dec_avx_gen4(
 #        gcm_data        *my_ctx_data,     /* aligned to 16 Bytes */
+#        gcm_context_data *data,
 #        u8      *out, /* Plaintext output. Decrypt in-place is allowed.  =
*/
 #        const   u8 *in, /* Ciphertext input */
 #        u64     plaintext_len, /* Length of data in Bytes for encryption.=
 */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-int=
el_glue.c
index 661f7daf43da..d8b8cb33f608 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -84,7 +84,7 @@ struct gcm_context_data {
 	u8 current_counter[GCM_BLOCK_LEN];
 	u64 partial_block_len;
 	u64 unused;
-	u8 hash_keys[GCM_BLOCK_LEN * 8];
+	u8 hash_keys[GCM_BLOCK_LEN * 16];
 };
=20
 asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
@@ -187,14 +187,18 @@ asmlinkage void aes_ctr_enc_256_avx_by8(const u8 *in,=
 u8 *iv,
  * gcm_data *my_ctx_data, context data
  * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boun=
dary.
  */
-asmlinkage void aesni_gcm_precomp_avx_gen2(void *my_ctx_data, u8 *hash_sub=
key);
+asmlinkage void aesni_gcm_precomp_avx_gen2(void *my_ctx_data,
+					   struct gcm_context_data *gdata,
+					   u8 *hash_subkey);
=20
-asmlinkage void aesni_gcm_enc_avx_gen2(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_enc_avx_gen2(void *ctx,
+				struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long plaintext_len, u8 *iv,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
=20
-asmlinkage void aesni_gcm_dec_avx_gen2(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_dec_avx_gen2(void *ctx,
+				struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long ciphertext_len, u8 *iv,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
@@ -211,9 +215,9 @@ static void aesni_gcm_enc_avx(void *ctx,
 			plaintext_len, iv, hash_subkey, aad,
 			aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
-		aesni_gcm_enc_avx_gen2(ctx, out, in, plaintext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	}
 }
=20
@@ -229,9 +233,9 @@ static void aesni_gcm_dec_avx(void *ctx,
 			ciphertext_len, iv, hash_subkey, aad,
 			aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
-		aesni_gcm_dec_avx_gen2(ctx, out, in, ciphertext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	}
 }
 #endif
@@ -242,14 +246,18 @@ static void aesni_gcm_dec_avx(void *ctx,
  * gcm_data *my_ctx_data, context data
  * u8 *hash_subkey,  the Hash sub key input. Data starts on a 16-byte boun=
dary.
  */
-asmlinkage void aesni_gcm_precomp_avx_gen4(void *my_ctx_data, u8 *hash_sub=
key);
+asmlinkage void aesni_gcm_precomp_avx_gen4(void *my_ctx_data,
+					   struct gcm_context_data *gdata,
+					   u8 *hash_subkey);
=20
-asmlinkage void aesni_gcm_enc_avx_gen4(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_enc_avx_gen4(void *ctx,
+				struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long plaintext_len, u8 *iv,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
=20
-asmlinkage void aesni_gcm_dec_avx_gen4(void *ctx, u8 *out,
+asmlinkage void aesni_gcm_dec_avx_gen4(void *ctx,
+				struct gcm_context_data *gdata, u8 *out,
 			const u8 *in, unsigned long ciphertext_len, u8 *iv,
 			const u8 *aad, unsigned long aad_len,
 			u8 *auth_tag, unsigned long auth_tag_len);
@@ -266,13 +274,13 @@ static void aesni_gcm_enc_avx2(void *ctx,
 			      plaintext_len, iv, hash_subkey, aad,
 			      aad_len, auth_tag, auth_tag_len);
 	} else if (plaintext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
-		aesni_gcm_enc_avx_gen2(ctx, out, in, plaintext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_enc_avx_gen2(ctx, data, out, in, plaintext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, hash_subkey);
-		aesni_gcm_enc_avx_gen4(ctx, out, in, plaintext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey);
+		aesni_gcm_enc_avx_gen4(ctx, data, out, in, plaintext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	}
 }
=20
@@ -288,13 +296,13 @@ static void aesni_gcm_dec_avx2(void *ctx,
 			      ciphertext_len, iv, hash_subkey,
 			      aad, aad_len, auth_tag, auth_tag_len);
 	} else if (ciphertext_len < AVX_GEN4_OPTSIZE) {
-		aesni_gcm_precomp_avx_gen2(ctx, hash_subkey);
-		aesni_gcm_dec_avx_gen2(ctx, out, in, ciphertext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen2(ctx, data, hash_subkey);
+		aesni_gcm_dec_avx_gen2(ctx, data, out, in, ciphertext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	} else {
-		aesni_gcm_precomp_avx_gen4(ctx, hash_subkey);
-		aesni_gcm_dec_avx_gen4(ctx, out, in, ciphertext_len, iv, aad,
-					aad_len, auth_tag, auth_tag_len);
+		aesni_gcm_precomp_avx_gen4(ctx, data, hash_subkey);
+		aesni_gcm_dec_avx_gen4(ctx, data, out, in, ciphertext_len, iv,
+				       aad, aad_len, auth_tag, auth_tag_len);
 	}
 }
 #endif
--=20
2.17.1

