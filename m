Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683145-2-9223130415730227646
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683145; b=atvxh+ydXRs7sDgcs2hTEuTqW47vF5mfMNXn2rStWpAoBGB
    YZfxzkFrZKtD0os9kk7A/M9yJaBSdmWGWh/0OWM7vGMbWJ0xWMrw7Rv840eMrbLF
    ebw9auESUWbIJTDIREzsbkD1/vdopeIsKb7MQlAeAytCrcfTqMi0ue+OGVsoh+64
    Smz0OQTONKGxCent5MoHg0duGEy5/sebTE4xd0SM9Fe1eNAOjc9Dn8SRbth5pvFx
    E09EFzd5OqKURfLU3dywVFh1H1whQTwu2FJFPPMVUZjNCRlwrT7y479HW3XOE4am
    RecMftESLG2RhQrqj3N11HAPwoxArJjGMxi4RXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683145; bh=6njxDI
    PcFziSstrzVBdN6ej4VdumDKtniU3N6nlgk7M=; b=CAAZ+ufeB7y6qPhFInBnLa
    IxWPRW6QzZOu5UPHfbhIubcda6XrFRx8ddlA86MLvaFxlIy/srpFGXEfr20AV3xE
    CdOkwAwjXjz3s1ankYsviJtnMGYoI7zUoB8omXLSLvmYwUpA6iNLRtRU0tWjkCFK
    Z+nMMEk+ucE4J1CLxMTkHpgULslF7gL3LLk4JP9TD8f9XY07yR5u0l5LipAj58uB
    IhaEdR31yy8EzSrgsRI2Mtkv6RAQt3raQA8X5tRrhcSjIHMi/0o2Tg2WIW0lO+Hb
    WUV1SDKMae8x5a2NX2OHD5sVAXb4yYZnHFZ7Y2oH7kGQM+6oLDJEiaRLs7NdTFPg
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oc+V1EGH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oc+V1EGH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbeBCSiz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:38:55 -0500
Received: from mail-bl2nam02on0122.outbound.protection.outlook.com ([104.47.38.122]:14996
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752795AbeBCSDi (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:38 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chunyan Zhang <zhang.lyra@gmail.com>,
        Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 07/52] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Topic: [PATCH AUTOSEL for 4.9 07/52] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Index: AQHTnRlPKCZyzZ52U0C81ei66K5liw==
Date: Sat, 3 Feb 2018 18:03:36 +0000
Message-ID: <20180203180303.8490-7-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;7:rkHW50JmJFNAsabOJj1q0+vIALDafNCogoHchyyNKA7dZ7y21gwwtn0BK0Xg2cHTPpOPiMj/8iiB5+NQfmJ8YIJ+r0dgjU+9dG+qrf6EQrTs2mBND9+BbCPQlq0VeRof4KYwq+8qO0b6YwQKkeLOAWbGIqQW67Bzfw/h2o1IpCdQ9hf0bgoXm9emnvNEPGtKy5LRk87eoofXSjC/Qe5r4kINVTNpaeSQokmkVwkvaGaHNk+nDAkMyt6+JD1o5kpx
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd4ec4ef-05b1-4685-6896-08d56b307253
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB10913B792FD5DC4BB8449EB9FBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(39060400002)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 9aEte6MwJ6lqU/RxPCKGTtBpKQONHJWrePj5HdSCkl+Q/xKbBZYBdO4GWzPAZ7maAwd/b13AmS9sCZIdF5tFoQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4ec4ef-05b1-4685-6896-08d56b307253
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:36.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chunyan Zhang <zhang.lyra@gmail.com>

[ Upstream commit 36b0cb84ee858f02c256d26f0cb4229c78e3399e ]

An additional 'ip' will be pushed to the stack, for restoring the
DACR later, if CONFIG_CPU_SW_DOMAIN_PAN defined.

However, the fixup still get the err_ptr by add #8*4 to sp, which
results in the fact that the code area pointed by the LR will be
overwritten, or the kernel will crash if CONFIG_DEBUG_RODATA is enabled.

This patch fixes the stack mismatch.

Fixes: a5e090acbf54 ("ARM: software-based priviledged-no-access support")
Signed-off-by: Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/lib/csumpartialcopyuser.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialc=
opyuser.S
index 1712f132b80d..b83fdc06286a 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -85,7 +85,11 @@
 		.pushsection .text.fixup,"ax"
 		.align	4
 9001:		mov	r4, #-EFAULT
+#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+		ldr	r5, [sp, #9*4]		@ *err_ptr
+#else
 		ldr	r5, [sp, #8*4]		@ *err_ptr
+#endif
 		str	r4, [r5]
 		ldmia	sp, {r1, r2}		@ retrieve dst, len
 		add	r2, r2, r1
--=20
2.11.0
