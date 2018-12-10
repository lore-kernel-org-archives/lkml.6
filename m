Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0788FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31F920821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fNEyS9Xv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Xrgijmc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31F920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbeLJUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:00:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727424AbeLJUAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:00:05 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBAJwlmG026908;
        Mon, 10 Dec 2018 11:59:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=MU2NCc8O9NURtvN8cXqEVC3W1vTXvCg5QaM1d2mMcVQ=;
 b=fNEyS9XvKT+evAo18EViZuQeHhy1lXTFwOhxM3FB6dTR6dyleo6Ee4qIkrk6tJ5A4nId
 HT1ucZvp/4cP1vT+ZvLsVCfVSHyKYuubAmwG5N4lGKgGVAZvucfT2Z7iaKisgObaM3pu
 yjr4s99nDX9q/lqk3BRnB5/2dqXikrnlDl8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2p9xfd82eb-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 11:59:54 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:59:28 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 10 Dec 2018 11:59:27 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Mon, 10 Dec 2018 11:59:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU2NCc8O9NURtvN8cXqEVC3W1vTXvCg5QaM1d2mMcVQ=;
 b=Xrgijmc/Co3X06YEyS+aP+kd6oMYZM3HOHgqIosu2fo/ARHascE+3feOw1V0gEtwp7sq9d1/MQxb6Ioguhweqqzwzq9DQVbTpCHQLtrmlr+djJa/Bgx27NRAyMROl7EZC7o/8JFdp/2RI40jljtkL9dlBqPJnQfv6bAzFIQipqQ=
Received: from MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) by
 MWHPR15MB1166.namprd15.prod.outlook.com (10.175.2.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Mon, 10 Dec 2018 19:59:12 +0000
Received: from MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434]) by MWHPR15MB1134.namprd15.prod.outlook.com
 ([fe80::911d:ed1a:7e45:6434%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 19:59:12 +0000
From:   Dave Watson <davejwatson@fb.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC:     Doron Roberts-Kedes <doronrk@fb.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH 09/12] x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
Thread-Topic: [PATCH 09/12] x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
Thread-Index: AQHUkMLR5ZjXLrqvCU2pFXjCchOxsA==
Date:   Mon, 10 Dec 2018 19:59:11 +0000
Message-ID: <5869181e33afd1310767c838514a6aa0d255d542.1544471415.git.davejwatson@fb.com>
References: <cover.1544471415.git.davejwatson@fb.com>
In-Reply-To: <cover.1544471415.git.davejwatson@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: NeoMutt/20180716
x-clientproxiedby: MWHPR1601CA0014.namprd16.prod.outlook.com
 (2603:10b6:300:da::24) To MWHPR15MB1134.namprd15.prod.outlook.com
 (2603:10b6:320:22::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:2261]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1166;20:fi3aXqiuFPkUQINlAmFGw3kwN0OSrae394winFiokBZdapyZKVIS39/ZmG27Q5FSx6N2VvMtkxxxD6CTnuVtqMcpzmA8vgFJIbOnrGiOs8mJW2qm+6Rd9p2ln3/47mIATf7knMQfACiv3k69Tw5+WvARmMWc8hK0wJhz7gJGlVQ=
x-ms-office365-filtering-correlation-id: 4336e48c-ab0d-4371-bccd-08d65ed9f417
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1166;
x-ms-traffictypediagnostic: MWHPR15MB1166:
x-microsoft-antispam-prvs: <MWHPR15MB1166B24A1477AC287CB115BDDDA50@MWHPR15MB1166.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1166;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1166;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(7736002)(256004)(8936002)(14444005)(486006)(386003)(76176011)(316002)(54906003)(58126008)(110136005)(99286004)(4326008)(2616005)(446003)(11346002)(52116002)(102836004)(305945005)(6506007)(46003)(476003)(186003)(5660300001)(36756003)(71190400001)(71200400001)(106356001)(105586002)(97736004)(118296001)(2501003)(53936002)(8676002)(68736007)(81166006)(81156014)(478600001)(14454004)(2906002)(25786009)(86362001)(6486002)(6512007)(6116002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1166;H:MWHPR15MB1134.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tcOeyKqqrlsW+pdBIWbNo9quNYnhLLv/I5IPdaLG6OPzLkhkaQuT/yOt3Sib/GsMgsDaDDaSETgM6wzn5u37VyFtFwHudeHiKuu1gSXhJ9TMgqNrzMsiDdnFbbxhlM6HRpPapGzeOw/pnJIiqb4KgFYS943SW8nYg3cg8xuD9UIKS9t6/PUkgI0xJjgp1zvTUimtdSykkVGY7OU3oq06fxUn+BPafAdf9t642Rvrt/IY1jsjU7aBMFDWqYfHKmJcZCI/F/3UyvaJ5MI86rV3mvqjAvyIFF3T94m8fzRLOUllNx9XM9BLKX3ADIs5idsz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C3F153B808E4845BE48C6D99EBD5742@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4336e48c-ab0d-4371-bccd-08d65ed9f417
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 19:59:11.8767
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

Prepare to handle partial blocks between scatter/gather calls.
For the last partial block, we only want to calculate the aadhash
in GCM_COMPLETE, and a new partial block macro will handle both
aadhash update and encrypting partial blocks between calls.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aes=
ni-intel_avx-x86_64.S
index 0a9cdcfdd987..44a4a8b43ca4 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -488,8 +488,7 @@ _final_ghash_mul\@:
         vpand   %xmm1, %xmm2, %xmm2
         vpshufb SHUF_MASK(%rip), %xmm2, %xmm2
         vpxor   %xmm2, %xmm14, %xmm14
-	#GHASH computation for the last <16 Byte block
-        \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6
+
         vmovdqu %xmm14, AadHash(arg2)
         sub     %r13, %r11
         add     $16, %r11
@@ -500,8 +499,7 @@ _final_ghash_mul\@:
         vpand   %xmm1, %xmm9, %xmm9                  # mask out top 16-r13=
 bytes of xmm9
         vpshufb SHUF_MASK(%rip), %xmm9, %xmm9
         vpxor   %xmm9, %xmm14, %xmm14
-	#GHASH computation for the last <16 Byte block
-        \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6
+
         vmovdqu %xmm14, AadHash(arg2)
         sub     %r13, %r11
         add     $16, %r11
@@ -541,6 +539,14 @@ _multiple_of_16_bytes\@:
         vmovdqu AadHash(arg2), %xmm14
         vmovdqu HashKey(arg2), %xmm13
=20
+        mov PBlockLen(arg2), %r12
+        cmp $0, %r12
+        je _partial_done\@
+
+	#GHASH computation for the last <16 Byte block
+        \GHASH_MUL       %xmm14, %xmm13, %xmm0, %xmm10, %xmm11, %xmm5, %xm=
m6
+
+_partial_done\@:
         mov AadLen(arg2), %r12                          # r12 =3D aadLen (=
number of bytes)
         shl     $3, %r12                             # convert into number=
 of bits
         vmovd   %r12d, %xmm15                        # len(A) in xmm15
--=20
2.17.1

