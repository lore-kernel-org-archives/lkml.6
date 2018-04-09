Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523235298-2-17894772332457603689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523235297; b=rmg+Qxnc1ZmA/wIXl8rPwo8j0uj1coS/ombOvJ5rTc+onwGzAI
    4jsQivK/U7Ya1CNA2viyAdm237W/silzoEgsHxXs9XyudlQCNRA1QMW2AWYlfCRP
    2CKZxYBkcULZN6Vuxmo5JDkgVRiFefKr27fdyTzgHY8/SB703JMENbqG6qi9kQT0
    UQC1u+/q3b5JYGmQYZjtPCsE2u3p54/LQVpz5vHz6Oi3yc1DqMuR106jqNM/nb4K
    Vkeb+NMCopL/ek4DpsSi2Crmx1Oz8Z2F0VWKZdMOAkOckDzc1WuikEJTlHQVtAMt
    ZPDXc1jOwQq09xOztnwpD9cehUZFhqDNOQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235297; bh=2EhaSeVlfg
    vSiCjF97WLCYilcfKGUvyEp3Ozlak6ZbE=; b=a+ETftNs6Xf0ImZAqdUk8Hffle
    yJr1UmzgGrfo1lyl84nRrpJY3sL/kYT3R9TBY6NgzjqAy5cw8B3+/1LpkIZLItY8
    23Gu3cgr4kthk5Zva5hlo3Glv3Tz3EtV+6WkY3msu6oB6P63bGysH71JcOLLChyO
    YNYVOwypXrYjqO++iJu7hFtfM6QvpS5LmvX1zm59DLNhWhNigGeM3W+WQo7YwupH
    pVRQoOTi0qYCS1PydqYrwapJLx003tOvaZjqpQvuofyzQdrSjw6WeqtJsUEV+5Y/
    cCNVsWrpvjGUYysWmr1QnwAhCL4l5Lmms4ZY+/AIRwb9TOiiRsIaKiSBKQRA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=keCzzTjc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=keCzzTjc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL//Qqs2a3giNoeyIF4uNKgr7nD2RQGRygciAyhoQjYVmZ4kZCI1YOAk3KMpRBOGeMprC4AtUxSsfOgmn2phnQLe2sJ9/LExhWjxskShXWGULQtKsN8t
    +V5eXh3/dlFsR3iYFYHutiry63DQQh2jVJomvUw6eGWJrFP1NNcWFQnPm1siELcoGo60psww1UZyfIqJ9bkxL5Phh6+tGei0so1Cbgi0cvgutu/RT0ntpat7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=pt_rnBhcAV2n6HQ7sq8A:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754671AbeDIAy1 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:54:27 -0400
Received: from mail-sn1nam02on0130.outbound.protection.outlook.com ([104.47.36.130]:38544
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933315AbeDIAk2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:40:28 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 047/101] arm64: pass endianness info to
 sparse
Thread-Topic: [PATCH AUTOSEL for 3.18 047/101] arm64: pass endianness info to
 sparse
Thread-Index: AQHTz5q5AttoKY1ljUiafR1c2NqYtw==
Date: Mon, 9 Apr 2018 00:35:57 +0000
Message-ID: <20180409003505.164715-47-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:q1bibtJtnyuV5d4cn8we1Lk3LRLL7k6dl5UXtSr6F8kxjRLNb7OB7BRrUUIAdEv1CAO6rZ9sGSiZ3VbMFSFy/2ueqfJP09Tx7tFEbhSJJWrW8Fb2R3Q09rZL0U44m+hejgdG2aBbsc0mc2iyXtVVBgzcqmoN2IdPXIIlYtLv7fSnXe13R0xOaVNU89SFPn0/5i2ZjKt1WULB2f6DSBoQPdJFVlEQWDsa9h4d78Kks09Q2tTotDTUPLglEtZxDOU8;20:BAhy9zcXz2Y+UnMCMfptdMlbq/3g3T5Yf19CXREuIVk8hzJUCZmVNt88Xwe7luGr55KSlCPQN2ZiTc6MwNPjrPWm+pqoexOsZ8O6uwzDasYEhlSNFJhxgeYOYGpdOqmB5FU+8jM3LYt2Pw5/JzxZ31Rec91/M91TY9gPylTYWWs=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f21caead-5977-4216-31f5-08d59db27b53
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08705D66F3DA6AA726E73C44FBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(376002)(39860400002)(346002)(199004)(189003)(5250100002)(5660300001)(26005)(10290500003)(2501003)(478600001)(68736007)(8676002)(8936002)(81156014)(81166006)(22452003)(3846002)(86362001)(36756003)(1076002)(305945005)(54906003)(72206003)(186003)(316002)(4326008)(25786009)(6486002)(110136005)(7736002)(446003)(10090500001)(76176011)(14454004)(11346002)(476003)(2900100001)(97736004)(107886003)(39060400002)(486006)(2906002)(6512007)(53936002)(102836004)(2616005)(86612001)(6116002)(3280700002)(6666003)(6506007)(66066001)(6436002)(3660700001)(105586002)(99286004)(106356001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vwFfseV2cRuNJTSxlvpGZiWEFeqC+09NMUPLunAJbITtC0tqtoy12ujB7KsFHew9ca7UJyeFaYZEz1qpYFVFP5V4sEUJPSYS44QnuB031Rh3RHDwPbCUP7LlUjX44LOZkWS5PKYgEQzI+RRBVGJveOKBWIhVnOsltLOc5wmTY2JaIdwNsqkyRR2VIO+fdXEAGV4v440aRABDOEpOwuoQpqP23XhUm9Qh84aH+Xz0+cXgYpUyslEIZgT6ZHxQ9G0gV3SnOnffKddy17KB6ir0DwGMPU5FoWjMWya4rYdAu3FAOtCwf1++CTawBBsp8RJ+x7F07giVV8rEMmrXr6pmrI1u2duDUZyPyAOuEuY5iRQ0y3zwwXR2URXYHTbD5CSu7DVkF6vGuQS8egUKyJRZbw3lDu3MabVHAQaCP7vN3lQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21caead-5977-4216-31f5-08d59db27b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:57.5015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit bcde519e8c325f3cc1fcf443eb6466e6bb3a3aca ]

ARM64 depends on the macro __AARCH64EB__ being defined or not
to correctly select or define endian-specific macros, structures
or pieces of code.

This macro is predefined by the compiler but sparse knows nothing
about it and thus may pre-process files differently from what
gcc would.

Fix this by passing '-D__AARCH64EL__' or '-D__AARCH64EB__' to
sparse depending of the endianness of the kernel, like defined
by GCC.

Note: In most case it won't change anything since most arm64 use
      little-endian (but an allyesconfig would use big-endian!).

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 3e2f6590666a..203d87177172 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -24,10 +24,12 @@ KBUILD_CFLAGS	+=3D $(call cc-option, -mpc-relative-lite=
ral-loads)
=20
 ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+=3D -mbig-endian
+CHECKFLAGS	+=3D -D__AARCH64EB__
 AS		+=3D -EB
 LD		+=3D -EB
 else
 KBUILD_CPPFLAGS	+=3D -mlittle-endian
+CHECKFLAGS	+=3D -D__AARCH64EL__
 AS		+=3D -EL
 LD		+=3D -EL
 endif
--=20
2.15.1
