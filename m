Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238011-2-689534636224287796
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238011; b=rlpgKoD8yo2Z6VvPI6XwOSIQRu4pB9pEqVYj2y0XXeBI4y+QYo
    7L33RqZbcjWRZm4ifvvCFmVqeKOnb4t+Z/CkUs+gHFK2d2py4f+uYph4QCx3GI4E
    iAW3J5JkDJpHHPLG9L4s2CdEw4tzvJsLnIG4ughv3u+JIProyRylc+5UH8n8058e
    uy37uarIrIjfTg5c6ZqMYjIx72wfP/o8ZAEvw1kVYOazI2LxUcupJRdQaTbZrlwf
    J/GtToJmXudc1kSi9+s/AZd07NvkDrOPKUTv9nzlJtqU/sLscEIOnTmOGMLJDW0v
    stSAI5fYHzFqU7007CAvt5oYVGMvvF+TZo8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238011; bh=fO5hYRPcF3
    Gc7qg+DmbRLNDSUBftWJoCoPGykGQY4MY=; b=k7b+K6av7avbpKe7wZT5wjizXf
    Tv3icbcZ2A6jJWkofuff7C0YNx06NEnVglbsS6AR8e8UegsgFs/24dJQrG2nkrqx
    MQikE881HwLGBcjVQDWskvgDzazBx4zKD2DnjSs0agyv4UmKnWnOE9XbWZ0V2dBX
    Hkbq+LphXc5RwVj4u//yu68/xCeS3ux2PPp/0FI26920gI7MH0AC/J2sVUstmiJZ
    gBnUPOMcHnHTbWY/jkQ707qbaXUfGu1CKh1TGwuIbMcOWc4RhJ/edeaQ4X/9Qfh+
    uXvPWMtd+ATn0LjwJdv5mwelt/OJ+UI1kl6v9j+HTBxrKUxrkugN5FheLDpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fFxKXZ0n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fFxKXZ0n x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDjMzmncnhvvQ88SBJWsmg9jc4zEHm3ypKE9YHWmN1WVd4bKs38wezZImq1kdo0HD0w9SnU/9rYFJOFKz8SeK/1QZE39Yh4wJSEwBjw4LHIaojHdxSVj
    tsvf+el7Tgp4PaABEnubu3XpL6L9gvE1HnL+9E36xWclR6QfP2isYY5cOSWxZr/Gb+ky07vGMSopLkN4XqTaMTR7GxZ/FNUPOKg7yIwbpPedcTwU0QGk16PC
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=r_1tXGB3AAAA:8 a=WPyIoOwQAAAA:8 a=yMhMjlubAAAA:8
    a=m57dygxWIdCukqG92xcA:9 a=wPNLvfGTeEIA:10 a=t8nPyN_e6usw4ciXM-Pk:22
    a=S-HzPIwwDS8t1QcwSuWs:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeDIBjm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:39:42 -0400
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:2593
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932547AbeDIAfA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 005/162] MIPS: kprobes: flush_insn_slot should
 flush only if probe initialised
Thread-Topic: [PATCH AUTOSEL for 4.4 005/162] MIPS: kprobes: flush_insn_slot
 should flush only if probe initialised
Thread-Index: AQHTz5mVq/s529bU5Eev+r5672+hQg==
Date: Mon, 9 Apr 2018 00:27:46 +0000
Message-ID: <20180409002738.163941-5-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:SDvTOsWQwwHiA51LazWc/hKpi66oKnJDU81S4nMxRfYXBraQNKdhO39NOw6P8iz8VpHMx0dok5Gl7BW1sqeKFxfPWknooD9hYosOVC6gJORqsu+nolo1KDBkQZiaFfZvO6p1pWbq74FIONpKcAENZ4KKXvb42BlNodK166hjeVM2PTogVyk1NfVCybAvpi9hATCE9VeBaWtzNgzNKSRgC8bG3/I+MClmszOJYgDe7if2AMDAUBhBfj9cR3ynrxQv;20:nXBkO5k6yitRUj3Y4rj2BzCPTjKAdnsC0LRhG+B2SKVYzEd+UBjmoRVkCfU4FFiMKE9u+o3mO/Nwec/+6JXbI1i4tPG9D+xg2b7hHjhlbeMwA3uyxA8WSuXDgnb2m823YGXG92CDUfTB1w6kmYWaqRTHNltpaEP3Sx7Y0oZtMSE=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d674a07-a22d-42f4-d2b1-08d59db1b5c5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0806D07A4E2F24FC9AB1F3BCFBBF0@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(39380400002)(199004)(189003)(2906002)(25786009)(2501003)(10290500003)(476003)(11346002)(446003)(97736004)(5250100002)(68736007)(2616005)(102836004)(6506007)(59450400001)(3846002)(3660700001)(486006)(3280700002)(305945005)(6666003)(99286004)(5660300001)(76176011)(1076002)(186003)(26005)(7736002)(6116002)(81156014)(81166006)(86612001)(4326008)(105586002)(10090500001)(2900100001)(54906003)(22452003)(316002)(36756003)(110136005)(107886003)(8676002)(6436002)(478600001)(53936002)(66066001)(6486002)(6512007)(6306002)(86362001)(966005)(14454004)(72206003)(8936002)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: bWLRexXteMuhyW55zB+mExA2NTZngTSm+9kYudwjAkNX6Ik9MugOuj0LCcDDTPQiEpNQasLHX+rvU6UZWdo8bm6UAuHTvReh/FciAmwYuob7u0A2mezKdH9Ri9mvOb08Qd3mT/X/3g7Y7yMjVnXLRZpi4afJOJ3E/iGrbrRDgcKZSB5MRkTD7UvI3AHpeZRoDwHcte2V0QYajmLfCsi+dXxA4Yt9N0GTVUg2r+aye7NMcohHijQXFGZ/LmbwimKeeTgEbZzbEHH808vf/QbPJ5xcJpSM6dFdMuiO+PPqFF6dxP5Migrzy37SAHh2hEyNLUyibKyzt3WJ1gfeYFg0LWnIX6N/UPEpV1Eq/WbMxKSJ76D0n6puDPaGBk2pPIe8QswcPnMgj613nmJJb3V+3n8npVQ9NtehhjYccJQk+xk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d674a07-a22d-42f4-d2b1-08d59db1b5c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:27:46.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marcin Nowakowski <marcin.nowakowski@imgtec.com>

[ Upstream commit 698b851073ddf5a894910d63ca04605e0473414e ]

When ftrace is used with kprobes, it is possible for a kprobe to contain
an invalid location (ie. only initialised to 0 and not to a specific
location in the code). Trying to perform a cache flush on such location
leads to a crash r4k_flush_icache_range().

Fixes: c1bf207d6ee1 ("MIPS: kprobe: Add support.")
Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16296/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/mips/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobe=
s.h
index daba1f9a4f79..174aedce3167 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -40,7 +40,8 @@ typedef union mips_instruction kprobe_opcode_t;
=20
 #define flush_insn_slot(p)						\
 do {									\
-	flush_icache_range((unsigned long)p->addr,			\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
 			   (unsigned long)p->addr +			\
 			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
 } while (0)
--=20
2.15.1
