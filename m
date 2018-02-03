Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517682259-2-15223111933212199936
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
    t=1517682258; b=Uf1ZiXGQW0rnoAWPcVwgafzlcRlFP84nZ6vAYstb4RNwzeV
    3zOHzW7RfSxJUsfsmpLDwPIIPG84cg6Z6nPAVALtIaBbP8F9DYJG9xqr7gHxU152
    97FUBJN8jB/qopaAFqrBF53psWJI7t6bypFR8yG/KObPk6tMIMiI3JOar25cBHZ9
    Lf4SWuA4GRT1Onm2WBOE5MtA2bpLVzWHwbRXzMR0G3/UO+GXC1o1zsXjiYHIfk7q
    LvnYwro7P70B728XODl58DjCB7i5SBmaM1zWpOyPDyh3kc9o0Bb/GPrXtl/seDgF
    O32i9A8nr6cyJQwFE3bmMVJ3QwAW9yfN/65Udlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682258; bh=6njxDI
    PcFziSstrzVBdN6ej4VdumDKtniU3N6nlgk7M=; b=eOLZpq0SXDrq9zelXo0G9J
    nWhkeYWTNl9Dp5G7l+NMfap9nz+XUc1xtBpjVCBXlvGgpaACT/b7urrR6NKOKeia
    Rhh+999TNc2NH4BYYteItv0idf/ZgNKDB+yYhbx7f1FNY5tlSATwj7wb2a18WkcV
    M+plSVeDHqUMeGqlFCcycF80RYM9DpRR16kyT/iZvUYMG2b7v02n3HbYjHRwq21G
    kQCG7hNF/kqr6G+8aZIeW1qJnBN4swRmsbUvKV9M/yq6TXmg+Z3C4573+STbKMPR
    TmbiuYkUwBux85nm4G8ZGxFmVgNhdhQya8Nzo1fIncde3rQt1O2AIdZFq4pTpNhA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aErNQ1G8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aErNQ1G8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeBCSYJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:24:09 -0500
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:52828
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753430AbeBCSGK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Chunyan Zhang <zhang.lyra@gmail.com>,
        Lvqiang Huang <Lvqiang.Huang@spreadtrum.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 03/32] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Topic: [PATCH AUTOSEL for 4.4 03/32] ARM: 8731/1: Fix
 csum_partial_copy_from_user() stack mismatch
Thread-Index: AQHTnRltwc4iniZgHUintuL/WOZ1Fg==
Date: Sat, 3 Feb 2018 18:04:25 +0000
Message-ID: <20180203180413.7438-3-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:rLe88+j/hDbGyHuJBUeWbMwwHJlY4dqULdqRLAaztEVsTmR18FjoHR5+loQuwfqgIVABxxra3gweEVP6Yi4JF7XGixZUBhS0Uw6w2ik9Abdd5KZXBBCts2DK/DcqmfncnOZruE1lVRaPdCfRWfzPYJ5uH/pPJJosyVXlGUnze3jOATtuU4ArnGtF+PXXbC49dG5lD6Tj1aATLc9Yex6Z+Tm/+2SsRnaUhEKM694eUO0XMAkdl2qDZLg7clSSh8Lo
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce392e4e-c324-47fb-9835-08d56b30a593
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB108966F13742EE7E3D24D941FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(6666003)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(39060400002)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: U3Je8t8HDhmYL+CewZmNBZv/sXRNPM35tyBfgOlzHUmTvLQPOKXsqoyjAfqKnfs9nEMt2vOL+Knypmf7flNYLg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce392e4e-c324-47fb-9835-08d56b30a593
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:25.4402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
