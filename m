Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683609-2-530470734701921424
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
    t=1517683608; b=VUXdleTLkYDzGE07L5uOxmjI5Pa5aEKOvPFmVxeWv1DRheQ
    79nEfc/25C7tuiMdhe0TH74oz01UukB/vww18831P+e5e6DKO8wWzrlwanL0yrJf
    sqZxw8tFFunsmmDFgaY0fcA8TtB+cCIZoAz3ODOQduJkxcHViA1aTzxylqRMdZ8W
    BFTL0me/RXlNfavMH8i49BF02BXhwwHaSHk/ENYbWHiJY/76JN1eUc8Onm8StPSM
    eTz9va7yfePx3p3mbRlV472Ws26z01tR/H+lCW/WbGn0CCPd0rSDdj5xJEuRRymp
    jwfRzBQLdnfKZn/Ln0fUy3qHWa46cw3C66YuPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683608; bh=6njxDI
    PcFziSstrzVBdN6ej4VdumDKtniU3N6nlgk7M=; b=BqY7qXKCji4stWEZsPG8z0
    10eOYTprDixBHtI02ln9jMdxmxuTZbx/wXF5zNBMc7rlt4DGTCUzVEE/tkKRwu/g
    hL7YAB4pNOxXvemdUXYdHElqKvZoyIjUzpQAGpxn+KWLq7t5IpzJnd4Ox05MNNMO
    vW3IlCWUUuv5viGLEE/tjd7UvjM/NlaK5qdZE8iCVT9YS+xqhNdU7pX4gevMRkNs
    jAd8PYtg0N9XNn2Lyz8gX87j0cHS7bEr+YHAJnj2suSVsHQx6+1S73cQnAXCXt6O
    0Hr9BRUPoLshZJ0IBM8hXZ/iYVyp+upy1cu/cOuODOKOpLc3K5YSFT8Lnvgbr3Ig
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R5QK4GIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R5QK4GIl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeBCSqi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:46:38 -0500
Received: from mail-bn3nam01on0138.outbound.protection.outlook.com ([104.47.33.138]:24890
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752910AbeBCSBa (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:01:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chunyan Zhang <zhang.lyra@gmail.com>,
        Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 017/110] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Topic: [PATCH AUTOSEL for 4.14 017/110] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Index: AQHTnRjjTbkAdJrzLEmc1dyOk2NAug==
Date: Sat, 3 Feb 2018 18:00:34 +0000
Message-ID: <20180203180015.29073-17-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1043;7:Zf+RGXWafjSWKvVstWhYEtlQUuQYS2DG2+V3LY3Jt1IEwuspfPiDrko6th/E9V83hWzN03rJovMSlSiqERUzzcMOCydzMwDed/X11jRSxi6fqZbb6wJKWhRUInkwFBGvh5eMON1HaAM6r/PqkmN1EuJ1uKMl1949q5peWtO2Yuy7H394KEMUPEXew9/LSd94XGj9cWW9JRcitcOVDHuOttYYVoT/IqJ8VNujfTlk0SZBy82FJlP1LzgEiyIbm+zY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4999b8dc-70b6-4548-49e6-08d56b3007a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1043;
x-ms-traffictypediagnostic: BL0PR2101MB1043:
x-microsoft-antispam-prvs: <BL0PR2101MB104382E181699D5469C17CB9FBF80@BL0PR2101MB1043.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1043;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1043;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(59450400001)(10290500003)(186003)(6486002)(14454004)(1076002)(102836004)(6506007)(76176011)(26005)(6346003)(66066001)(10090500001)(5250100002)(36756003)(6512007)(2501003)(110136005)(99286004)(54906003)(478600001)(53936002)(72206003)(6436002)(316002)(305945005)(7736002)(6666003)(2950100002)(2906002)(5660300001)(4326008)(106356001)(575784001)(86362001)(97736004)(25786009)(22452003)(39060400002)(2900100001)(3846002)(107886003)(8676002)(8936002)(6116002)(3280700002)(105586002)(81156014)(81166006)(3660700001)(86612001)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1043;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: KwjSuhvJ1V5t3tGR/o4XXKMJ8d+OygZ2nXun+daUu3JYjrLa9qwzqyGeNoJIjZJKS9CLtbjdmtyIFJ3M2JixJw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4999b8dc-70b6-4548-49e6-08d56b3007a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:34.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
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
